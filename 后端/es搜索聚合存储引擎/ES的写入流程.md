
#### 写入流程【wait_for_active_shards】
1. doc写入的请求可能在集群中的任何节点，但是会被hash路由并转发到相应的`主分片`上
    ```
    1. 客户端发起写入请求到Node4
    2. Node4通过docId在路由表中确定当前文档的位置在分片0，而 `分片0的主分片` 在Node5上，那么该请求会被转发到Node5。
    3. Node5上的 `分片0的主分片` 写入成功后，会发生请求`异步复制`数据到 `分片0的副本分片` 所在节点Node4、Node6上，此时不必等待所有副本分片写入数据成功，而是仅确认主分片写入成功后，Node4就立刻返回写入成功到客户端。

    // 计算分片的公式
    shard_index = hash(_docId) % num_of_primary_shards
    ```
2. wait_for_active_shards 是写入前的分片 `可用性检查`，不表示要等待数据成功持久化到副本分片后，才进行下一步操作。
    ```
    // ES 默认偏向 AP
    1. ES默认优先保证写入性能，副本同步是异步进行的。
        写入请求必须等待至少 N 个分片（主分片 + 副本分片）可用，才会执行写入操作。
        如果可用分片数不足，写入请求会阻塞或失败（取决于超时设置-默认30s）。

    2. 核心目标：
        防止数据丢失：确保数据写入足够多的分片副本，避免主分片宕机导致数据不可用。
        控制一致性级别：在 高可用 和 低延迟 之间权衡。

    3. 在写入前检查分片可用性，可以快速失败（如返回 503），避免发送数据后部分分片不可用导致的复杂回滚。    
    ```
3. 写入流程图示：
    ```mermaid

    sequenceDiagram
        Client->>Coordinating Node: 发送写入请求（wait_for_active_shards=2）
        Coordinating Node->>Cluster State: 检查分片可用性
        alt 活跃分片数 ≥ 2
            Cluster State-->>Coordinating Node: 允许写入
            Coordinating Node->>Primary Shard: 转发数据
            Primary Shard->>Replica Shard: 异步复制数据
            Primary Shard-->>Coordinating Node: 确认主分片写入
            Coordinating Node-->>Client: 返回成功（可能副本尚未写入）
        else 活跃分片数 < 2
            Coordinating Node-->>Client: 返回错误（如 503）
        end
    ```
4. 如果需要实现 `等待 N 个分片写入成功`后才返回客户端，即同步写入，这会显著降低写入吞吐量，仅适合关键数据。
    ```json
    PUT /my_index/_settings
    {
        "index.write.wait_for_active_shards": "all",  # 等待所有分片可用
        "index.translog.durability": "request"        # 每次写入必须持久化 Translog
    }
    ```

#### 结语
1. 这个参数实在是颠覆了我的认知，看过不少教程及博客，都表示该参数的含义是：写入请求必须等待至少 N 个分片（主分片 + 副本分片）`写入成功`后，才会返回客户端。
2. 我也一直认为上述结论是对的，直到今晚才知，该参数顾名思义，是等待活跃分片数，而不是写入成功的分片数。再次加深了我对ES默认支持AP的理解！