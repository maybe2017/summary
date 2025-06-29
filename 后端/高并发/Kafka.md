
#### 与RocketMQ相似之处
1. RocketMQ中有Topic，Kafka也有Topic
2. RocketMQ中有MessageQueue，Kafka也有Partition
    ```
    MessageQueue是逻辑上的队列概念，一一对应了一个ConsumeQueue索引文件（Offset: 0, Size: 130, TagHash: 0x0450D27E）
    Partition不仅仅逻辑上存在，而且物理上也对应一个文件。
    ```
3. 消费者组，两者都是 `一条消息只被组内一个消费者消费` 的特性；而且 `消费并行度` 都是由队列（Partition）数量决定！！
    ```
    // 怎么理解消费者组？
    把它理解为单独的一个个下游系统


    // 消费位点的存储
    RocketMQ是存储在Broker端，客户端也有缓存
    Kafka是默认存储在__consumer_offsets主题中，也可以让客户端存在Redis中（放置重复消费）

    ```
4. Kafka的集群模式，有点类似RocketMQ的（多 Master 多 Slave）集群模式
    ```
    1. 都是可以对Topic下的数据，进行分片存储
    2. 每个分片都维护了多个备份

    // 不同点
    Kafka集群中，可以依赖ZK进行自动选主；RocketMQ需要人工干预。
    Kafka集群中，分片(主及副本)的Leader是动态选举的，且读写会自动路由到当前Leader；
    RocketMQ中，分片（Queue）的归属是静态绑定的（固定属于某个Master），需人工干预故障转移。
    ```
5. 

#### 不同之处
1. Kafka只支持主动拉取的模型，
2. 消息路由机制（消息分配策略）
    ```
    Kafka：
    // 生产者
    粘性策略（默认）：即客户端发送消息会默认发送至同一个Partition，直到达到16K。（如果发送时传了key，会根据key计算hash来选择Partition）
    轮询策略
    自定义实现

    // 消费者
    按范围分配分区（默认）：如有10个Partition，一个消费者组内有3个consumer，那么它会将0-3分配给consumer1，将4-6分配给consumer2，将7-9分配给consumer3
    粘性策略：尽量保证consumer消费数据的稳定性，减少Rebalance开销。
    轮询策略
    自定义实现

    RocketMQ：
    尽可能均匀分配、轮询分配、手动指定固定映射关系

    ```

#### 生产者发送应答机制【生产者端-提高安全性，并不一定保证消息不丢失】
1. Leader Partition：队列的主节点    
2. Follower Partition 副本节点  
3. acks 配置参数
    ```
    0: 生产者不关心Broken端有没有成功写入，只管发送完事。吞吐量最高，最不安全。
    1: 仅需等待Leader Partition写入成功后。
    -1或ALL: 等所有Partition都写入成功。吞吐量最低，最安全。 【具体写入多少个节点数可配置 min.insync.replicas】
    ```
4. 消息真正安全，还得与客户端配合，客户端根据服务端的响应，做一些容错。    