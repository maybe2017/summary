
### RocketMQ【高可用、高吞吐、动态扩展】

#### 服务端角色
1. NameServer：存储Broker的地址和 Topic路由信息 【服务发现能力】
    ```
    // 客户端通过 NameServer 动态发现 Broker
    // 支持 Broker动态扩缩容（Broker 注册到 NameServer）
    // 心跳超时机制（默认120秒）判断Broker是否存活


    // NameServer节点之间无数据同步，彼此独立，客户端会轮询多个NameServer获取最新的路由信息，容忍短暂的数据不一致【最终一致性】
    // 与Kafka的ZooKeeper区别：仅负责路由管理，不参与Leader选举或事务协调（由Broker自身处理）
    ```

2. Broker
    ```
    // Topic路由注册
    启动时，会向所有NameServer注册自己负责的Topic信息（如队列数量、所在Broker等）
    Broker会定期（默认30秒）向所有NameServer发送心跳

    // 消息的持久化
    1. Topic、MessageQueue仅仅是逻辑层面的概念，一个Topic下有多个MessageQueue，一个MessageQueue对应一个ConsumeQueue文件。
    1. 物理层面的CommitLog文件，所有消息都顺序写入该文件，彻底避免随机写入。（PS: Kafka中每个Partition 都需维护一个独立文件，可能引发磁盘竞争）【默认1GB/文件】
    2. 保存逻辑索引的ConsumeQueue文件，存储对应逻辑上的MessageQueue中所有消息在CommitLog文件中的索引（CommitLog偏移量、消息大小、Tag哈希值），每条记录固定 20 字节。【默认每文件30万条索引，5.72MB】
    
    ## ConsumeQueue文件内容示例
    Offset: 0, Size: 130, TagHash: 0x0450D27E  # Tag="Order" 
    Offset: 130, Size: 150, TagHash: 0x7A3B1C8D # Tag="Payment"
    // TagHash的作用
    1. 生产者生产消息时，指定了Tag，Broker端存储的时，在逻辑索引的ConsumeQueue文件中，仅仅保留了tag.hashCode()的前8个字节。（如果Tag很长情况下，可能不完整）
    2. 消费端可以 指定Tag 进行消费一部分队列中的消息，Broker端会先遍历ConsumeQueue，检查每条记录的 TagHash 是否匹配订阅的 TagHash，匹配则发送给消费者。
    3. 由于可能存在hash冲突，Broker端还需要从CommitLog读取完整Tag后进行二次确认。
    4. Broker对多个匹配的Offset排序后合并读取。【频繁不同Tag过滤，会导致PageCache缓存命中率下降 => 避免过多细粒度Tag】

    // TagHash 用于快速初筛
    // SQL92 用于精细过滤（还可以对Tag、或消息Header中的自定义属性（消息体中），进行SQL式的筛选）
    
    // 消息消费位点offset
    集群模式下，Broker会持久化每个消费者组（Consumer Group）对每个 MessageQueue 的消费进度（Offset）
    定时上报：消费者默认每 5秒 向 Broker 上报一次消费进度
    消费完成时：若消费者配置 consumeMessageBatchMaxSize=1（单条消费），可能每条消息消费后立即上报


    // 消费者消费，通过TCP+Netty长轮询机制。=> 【消费者可自主管理 Offset，支持重试、顺序消费】
    Consumer 从本地缓存或 Broker 查询当前 Queue 的 Offset。
    Consumer 拉取消息时（隐含携带Offset），Broker通过ConsumeQueue找到CommitLog位置，直接通过 mmap 或 sendfile 传输，减少数据拷贝。

    1. 用mmap将CommitLog文件映射到进程虚拟地址空间，来进行读写，多个连续的写入可合并进行批量写入。【高吞吐写入】
    2. Broker通过sendfile将CommitLog中的数据，由网卡DMA从pageCache直接发送到socket buffer，无需经用户态拷贝。【高吞吐读取】

    ```
3. offset【消息消费位点】
    ```
    // 集群模式下，同一消费者组的多个实例共享 Offset，确保每条消息仅被消费一次。
    Broker会持久化每个消费者组（Consumer Group）对每个 MessageQueue 的消费进度（Offset）
    定时上报：消费者默认每 5秒 向 Broker 上报一次消费进度。【客户端需处理重复消费】
    消费完成时：若消费者配置 consumeMessageBatchMaxSize=1（单条消费），可能每条消息消费后立即上报

    // 广播模式下
    Offset 由消费者本地维护。
    ```    
4. IndexFile【加速消息检索】
    ```
    // 消息唯一标识
    发送消息时，Header中可以传一个keys属性，通常用来传业务上的唯一标识。【RocketMQ内部会为每条消息生成一个唯一的msgId，但是在一些事务消息情形下，这个msgId可能会改变。】
    基于消息 Key 或时间戳的哈希索引，帮助快速定位消息在 CommitLog 中的位置。    
    ```
5. 长轮询机制（无消息时默认挂起等待15s）
    ```
    // 复用同一个TCP连接
    一个消费者实例与同一Broker的所有通信（包括长轮询、心跳、提交Offset）均复用同一个 TCP 连接（通过 Netty 的 Channel 实现）
    
    客户端使用Netty管理 TCP 连接，维护了一个 ConcurrentHashMap<String /* BrokerAddr */, Channel /* Netty Channel */> channelTable; 按Broker地址缓存连接。
    Netty 的 Channel 是线程安全的，支持多线程并发发送请求，无需为每个 Queue 创建独立连接。


    // Broker端无消息时，会将PullRequest阻塞到该读取队列
    ConcurrentHashMap<MessageQueue, List<PullRequest>> pullRequestTable;
    然后会将该队列关联监听器，Broker写入新消息时，触发回调，从 pullRequestTable 中找到挂起的请求并响应。
    ```
6. PS Kafka
    ```
    // RocketMQ支持海量Topic，Kafka当Topic过多时，会产生多个与Partition一一对应的文件，写入消息时，可能引发磁盘竞争。


    ```

#### 传统集群（多 Master 多 Slave）【无法自动选主】
1. 集群角色：Master，Slave，Slave仅做冷备。
2. Broker支持多个主节点（多Master模式），客户端根据NameServer提供的路由，自己实现负载均衡（该选择哪一个Master）。
3. 通过部署多个 Master Broker，可以将不同的 Topic 或 Queue 分散到不同的 Master 节点上，实现写负载均衡。【横向扩展写入能力】
    ```
    // 与RabbitMQ集群区别：RabbitMQ中的Broker也可以集群部署，但是它是以 `队列` 层级区分主备，即每一个节点中分散存储了主队列，备份队列。
    // RocketMQ是以Broker层级区分的主备，即主Broker中，存储的均是主队列，没有存储副本，副本由专门的 Slave节点存储。


    // Master组
    每个Topic的Queue会被分配到多个Master上，类似Kafka的Topic数据分片，但是RocketMQ中是静态绑定效果，即当前Master和存储在其上的Queue是绑定的，不可变的。【RocketMQ.MessageQueue PS Kafka.Partition】

    RocketMQ中的主Master，仅存一部分自己的数据，不同 Master 之间的数据完全独立。
    每一个主Master下，可配置多个Slave，同步数据也仅仅是该Master拥有的部分。
    ```
4. 数据同步方式：异步复制（ASYNC） 或 同步复制（SYNC）。【不依赖强一致性】

#### Deleger集群【高可用】
1. 集群角色：Leader，Follower。一般节点总数为奇数。（自动选主）
2. 保证了CommitLog文件在集群中的强一致性。【Raft强一致集群】
3. 数据同步方式：Leader 必须将数据同步到多数节点（N/2 +1）才返回成功。【强一致性】


#### 多组DLedger集群
1. 每个 DLedger Group 是一个独立的 Raft 集群
    ```
    // 不同 Group 之间数据完全独立（类似于多个 Master 组）
    Group1：Broker-a1, Broker-a2, Broker-a3（组成一个 Raft 集群）。
    Group2：Broker-b1, Broker-b2, Broker-b3（另一个 Raft 集群）。
    ```
2. NameServer会管理多个 Group 的路由信息，Producer 可以写入不同的 Group（类似多 Master 模式）。    


#### RocketMQ如何保证消息有序？【业务Id取模分散到不同队列 - 局部有序】
1. 需要生产者与消费者配合。
    ```
    // orderA_1、orderA_2、orderA_2
    生产者发送消息时，在MessageQueueSeletor中，对业务字段orderA取模，queue_index = hash(order_id) % queue_count，可保证同一业务ID的消息在同一个队列中有序。【局部有序】

    // 消费者消费时，需要实现 MessageListenerOrderly 监听器，对每个队列单线程顺序消费。【内部是锁MessageQueue队列，只能让一个线程进行消费】
    // 每个队列内部的消息严格按顺序处理，每个队列都可以有一个线程进行消费。
    // 如果有消息消费异常，直接阻塞一会该MessageQueue队列，不影响其他队列消费。【与并发消费机制不一样，并发消费机制下，失败会将消息挪到重试队列】
    ```
#### RocketMQ如何实现延迟消息的？
1. 方案一：固定有18个默认延迟级别，分别对应了RocketMQ系统预设的18个队列。【】【最大延迟2小时】  
    ```
    1. Broker 会将其原始 Topic 临时改为内部 Topic（SCHEDULE_TOPIC_XXXX），原始 Topic 和 QueueId 保存在消息属性中。
    2. Broker 会立即将消息写入 CommitLog（主存储文件）
    3. ScheduleMessageService定时扫描，每隔100ms执行一次检查（扫描MessageQueue <-> ConsumeQueue文件）
    4. 到达指定时间后，Broker 才会将消息的 Topic 改回原始 Topic，此时消费者才能看到这条消息

    ```
2. 方案二：如果延迟是指定时间点，则用时间轮实现。
    ```
    // 分层时间轮
    小时时间轮（24个solt）
    分钟时间轮（60个solt）
    秒级时间轮（60个solt）

    // 秒级时间轮中，【有一个独立的定时线程每秒执行一次，用以推进指针到下一个solt】【高层指针的移动由低层轮触发（类似现实中的钟表）】
    1. 执行当前solt的所有到期任务
    2. 触发分钟轮检查（见下文）

    // 分钟时间轮
    每当秒轮完成一整圈（60秒）时，分钟轮指针前进1格到新solt，将新solt中的任务降级到秒轮
    // 小时时间轮
    每当分钟时间轮完成一整圈（60分钟）时，小时轮指针前进1格到新solt，将新solt中的任务降级到分钟轮


    假设有一个 3小时25分10秒后 才执行的 TimerTask
    初始添加：存入小时轮的 "当前小时指针 + 3" 的槽位
    3小时后，小时轮的指针移动到存储任务的槽位，此时将该任务移动到分钟轮中 "当前分钟指针 + 25" 的槽位
    25分钟后，分钟轮的指针移动到存储任务的槽位，此时将该任务移动到秒级轮中 "当前秒指针 + 10" 的槽位
    3秒后，秒轮的指针移动到存储任务的槽位，任务最终被执行
    ```
3. PS JAVA中的Timer（小根堆实现优先队列）
    ```
    小根堆：每个节点比其所有子节点更小，根节点是最小的。【不保证次小节点第2执行】

    延迟任务被放到小根堆中，插入删除logN，堆排序NlogN，每次定时线程取堆顶元素执行

    缺点：在大量延迟任务的环境下，可能有除堆顶元素外的节点外，已经有节点的定时任务到执行时间点了，但却因为不是堆顶元素，无法执行。【造成推迟执行】

    ```    

#### RocketMQ中的事务消息？【类2阶段提交，half半消息机制】
1. 目的是什么？为啥用它？
    ```
    目的：确保 `本地事务执行与消息发送` 的原子性。（即这两步要么都执行成功，要么都执行失败）【本地事务@Transaction解决不了消息的回滚】
    解决`生产者端` "事务执行成功，但消息未发送或发送失败" 或 "消息发送后 事务失败" 的问题。
    ```
    ```mermaid
        graph TD
            A[发送半消息 Broker写入内部Topic但不可见] --> B[执行本地事务]
            B --> C{事务状态?}
            C -->|成功| D[提交消息 Broker更改消息到真实Topic 消费者可见]
            C -->|失败| E[回滚消息 消息被标记为删除]
            C -->|未知| G[Broker后续通过定时任务回查]


    // 生产者 需要设置一个事务监听器
    TransactionMQProducer producer = new TransactionMQProducer("group");
    Message msg = new Message("topic", "body".getBytes());
    // 发送半消息（对消费者不可见）
    SendResult sendResult = producer.sendMessageInTransaction(msg, null);
    // 事务监听器实现
    producer.setTransactionListener(new TransactionListener() {
        @Override
        public LocalTransactionState executeLocalTransaction(Message msg, Object arg) {
            // 执行本地数据库事务
            return someDBTransaction() ? 
                LocalTransactionState.COMMIT_MESSAGE : 
                LocalTransactionState.ROLLBACK_MESSAGE;
        }
        
        // Broker每隔1分钟扫描半消息，对未决状态（UNKNOWN）的消息发起本地事务状态的回查（15次后丢弃）
        // 为什么需要Broker进行回查？因为考虑到一种情况，生产者执行本地事务成功后，崩溃了，此时Broker也可以通过主动回查去别的存活实例查询事务状态。
        @Override
        public LocalTransactionState checkLocalTransaction(MessageExt msg) {
            // 检查本地事务状态（通过msg中的transactionId查询DB）
            return queryTransactionStatus(msg.getTransactionId());
        }
    });
    ```    
2. 执行顺序
    ```
    1. 生产者向Broker发送半消息，Broker将消息存入RMQ_SYS_TRANS_HALF_TOPIC这个内部Topic，标记消息状态为PREPARED，对消费者不可见。
    2. 生产者的工作线程，开始执行本地事务（监听器中的executeLocalTransaction()），Broker根据本地事务结果，决定怎么处理这条半消息。
    3. 如果第二步返回的是UNKOWN，Broker端将启用回查线程，定时执行本地事务状态回查。（监听器中的checkLocalTransaction()）

    ```

#### RocketMQ中的重试队列、死信队列
1. 当消费者消费消息时，若返回的状态为 RECONSUM_LATER 时，该消息就会被放置到 `当前消费者组对应的重试队列`【Topic：%RETRY%消费者组名称】
    ```
    如果系统出现了重试队列，那么说明当前系统中消费者开始有隐患了..
    ```
2. 当重试队列中的消息，被消费最大次数16后仍失败，该消息将不会再被投递，被转置到 `当前消费者组对应的死信队列`。【Topic：%DLQ%消费者组名称】
    ```
    如果系统出现了死信队列，那么说明当前系统中消费者出现了很大问题！
    
    // 需要人工处理
    死信队列默认权限为禁读禁写！默认3天就会被删掉！【可以修改权限，然后写个新的消费者来处理..】
    ```

#### RocketMQ怎么保证消息不丢失的？【保证强安全性，那么就会降低性能，要取舍】
1. 生产者确认机制
2. 事务消息机制
3. Broker刷盘策略【RocketMQ即使配置为同步刷盘，其实现方式还是以10ms间隔去调用sync刷盘操作的】
4. 集群模式下主从同步
    ```
    传统集群（多 Master 多 Slave）下，Master宕机后，不自动恢复的原因也包括，Master上的消息可能比slave多，贸然切换Master会导致消息丢失。【kafka则直接换主，旧Master上的消息会丢失】

    Deliger集群，因为采用了Raft协议，即使出现网络分区，也不会出现多Leader。
    极端情形：消息已写入Leader本地但未复制到任何Follower，Leader永久性宕机且磁盘损坏。但是对于客户端来说，因为集群没有达到半数节点同步，是拿不到响应的。【客户端需要自行重试】
    ```
5. 消费者消费消息成功之后，才ACK。    

#### 怎么保证消息幂等性？【MQ会维护消息至少被投递一次的语义：即不保证不重复】
1. 生产者端，Broker通过唯一msgId做幂等性控制
   ```
   // PS kafka
   为每个Producer分配一个PID，而PID会为每个Partition维护一个递增的seqNo
   Broken端，会维护一个Map<PID_Partition, sn>，每次会检查客户端发送消息的seqNo，满足Broker端的sn=seqNo+1时，才接受消息。否则说明重复了。差值过大，说明数据可能di就要抛异常。

   启用幂等检查，acks必须设置为all。
   ```
2. 消费者端，通过业务唯一id，做幂等性控制。

#### 怎么处理大量的积压消息？【重要】
1. 对于RocketMQ，一个Topic下可以配置多个队列MessageQueue分散存储数据，但是，一个MessageQueue至多被一个Customer消费（同一个消费者组中）！！
    ```
    如果Topic配置了4个队列，那么 这个Topic的数据也至多被 4个Customer消费！！！【并不是能无限增多消费者实例】
    // RocketMQ的消息分配策略：尽可能均匀分配、轮询分配、手动指定固定映射关系


    // 解决方案
    1. 先在当前消费者组中，增加消费者实例，到队列数阈值。
    2. 增加一个新的Topic，将老Topic下的数据进行转移（中间件或自己写程序），再针对新Topic启动最大个数消费者进行消费！
    ```