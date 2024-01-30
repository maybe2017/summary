## 一、持久化
### RDB(默认开启-服务停止时 )【可能丢数据、耗大量cpu及内存资源】
1. fork出子进程 复制页表(只是复制了页表的指针?)：虚拟内存->页表->物理内存；（与主进程共享内存空间）
2. 主进程写时复制：copy-on-write
3. LSM

### AOF(命令日志文件)【主要消耗磁盘io，重写的时候耗cpu及内存资源】
#### 1. 刷盘频率(主进程)
	appendfsync always ：写内存后立即写磁盘
	appendfsync everysec ：先写到AOF缓冲区，然后每隔一秒写到AOF文件【最坏丢1s】
	appendfsync no ： 先写到AOF缓冲区，由操作系统决定刷盘时机

#### 2. AOF重写、压缩(精简命令，fork出子进程后台执行)



## 二、主从集群【读写分离，提高并发读能力】
1. slave会向master进行请求数据同步【带上自己的replicationID及offset】，如果是第一次请求同步(replicationID是否一致)，master会先返回自己的replicationID及repl_baklog的offset
2. master进行bgsave生成rdb文件，然后发送rdb文件给slave，slave会清空本地数据，加载rdb文件
3. master持续发送缓冲区`repl_baklog`保存的命令，slave执行接受到的命令

### 数据同步【首次全量同步，后面增量同步】
1. 每一个节点都有一个唯一的`replicationID`，用以标识数据集版本；offset标识`repl_baklog`的进度
2. slave先发送请求尝试进行增量同步(partial sync)，如果master判断replicationID不一致，会进行bgsave生成rdb文件，发送给slave进行`全量同步`。

### 数据同步的理解【环形文件】
1. repl_baklog文件理解为一个环形。master的进度offset >= slave的offset，两个offset的差距就是slave待进行同步的命令集。
2. 如果slave断开太久，导致master中的`repl_baklog`文件写满后已经覆盖了slave未进行同步的数据，那么slave重启连上后，只能重新进行全量数据同步。

### 数据同步的优化【尽量避免进行全量同步】
1. 配置`repl-diskless-sync yes`启用：不进行磁盘复制(生成rdb文件)，直接发送网络io请求【前提网络要好】
2. 适当提高`repl_baklog`文件的大小，发现slave宕机后尽快恢复重连，避免`repl_baklog`文件写满后覆盖slave未进行同步的数据！
3. 限制一个master上slave的数量，可以采用 `master -> slave -> slave`的链式集群配置，减少master压力。

### 特殊问题
1. 主从架构中，分布式锁key复制延迟问题？master写入锁后，还未进行同步就宕机，slave没有锁信息，成为新主后，会被写入重复的锁key
解决:【redisson的联锁multiLock，要从每一个节点中都获取到锁，才返回获取锁成功】
2. redLock是什么？

## 三、哨兵机制【主从集群 - 故障自动恢复】
1. 监控：sentinel会不断发心跳，检测master与slave是否按预期工作【1s一次，未回复=主观下线sdown】
2. 故障自动恢复：master宕机后(半数sentinel认为下线)，会重新从slave选主【断开时间 >> 优先级配置 >> offset值 >> 节点运行ID 】
3. 通知：Java客户端连接sentinel进行通信，集群发生故障转移(选主)后，会通知给Java客户端【sentinel相当于服务发现注册中心】

### 选主后，故障转移流程
1. sentinel给备选的slave发送 `slave on one`，让新节点成为master
2. sentinel广播给其他slave， 发送 `slaveof newMasterIp`，让其他slave成为新master的从节点，开始从新master同步数据
3. sentinel将故障节点标记为slave(会修改配置文件，添加一行slaveof newMasterIp)，当故障节点重连后，自动成为slave节点


## 四、分片集群【解决单个master节点内存上限问题】
1. 数据分散存储到`多个master`上，实现了海量存储、提高并发写能力，也可为每个master加slave提高整个系统的并发读能力【读写分离】
2. 不需要sentinel了，多个master之间会互相发送心跳，且客户端的请求会被路由到正确的节点

### 散列插槽(16384个`hash slot`)
1. 为什么存储的数据与 插槽slot绑定，而不是与节点绑定？因为任意master节点可能挂掉(集群伸缩)，挂掉时可以将节点上插槽范围的数据转移到其他存活节点上
2. redis会根据key的有效部分计算插槽值，利用CRC16算法计算出一个hash值，然后对16384取余，得到slot值
3. 每个插槽可以存储多个kv，所以不会有hash冲突的问题。
4. 如果将同一类数据存储在同一个master节点呢？将key相同部分做前缀，那么形如`{typeId}_xxx`的kv都会存储在同一个插槽内。

### 故障转移
1. 自动故障转移：master宕机后(心跳失去回应)，会自动提升该master下的某一个slave为新的master
2. 手动故障转移：在需要宕机的master对应的slave节点上，执行 `cluster failover` 命令，可以让slave替换master【机器升级场景】