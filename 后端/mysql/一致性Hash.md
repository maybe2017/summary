### 一、图解
![一致性Hash](https://qn.mayu1024.com/hexo%E5%8D%9A%E5%AE%A2/%E5%88%86%E5%B8%83%E5%BC%8F%E5%AD%98%E5%82%A8/%E4%B8%80%E8%87%B4%E6%80%A7hash.png)

### 二、水平分片[将单机存储的数据分摊到不同的实例上]
1. 范围分片：水平划分其实就是按照数据的一个范围进行划分，比如说存储中国所有人的身份证信息，就是按照省市区级别，分别存储到对应的户籍所在地。这样的方式比较好管理，也方便查询。但是缺点就是数据分布不会平均，比如北京的密度和山西的密度就不是一个数量级。一个是直辖市2000多W的人口，一个是省级3000多W的人口。
    ```
    优点：可以按照范围快速查找数据。
    缺点：数据分布不均匀，数据的存储和访问不均匀。
    ```

2. 哈希分片：Hash分片其实比较简单，比如用身份证的或者手机号进行Hash取模 `hash(key) % nodeNum`，将数据存储到固定的服务器下，这样数据比较分散，但是 `不支持范围查询`，因为 `只能通过关键字key进行查询`。
    ```
    优点：数据分布存储和查询比较均匀。
    缺点：不支持范围查询。其实哈希分片这里还有一个隐藏的问题，如果存储的节点是不固定的话，可能存在删除或者添加节点的情况，那么就会导致整体数据的key需要重新计算。而这个计算和存储是非常耗费性能和资源。那么如何解决的呢？使用一致性哈希。


### 三、一致性哈希算法[节点动态伸缩，避免大规模数据访问和迁移]
1. 分布式系统每个节点都有可能失效，并且动态增加新的节点，即系统的节点数目发生变化的时候，需要系统仍然能够对外提供良好的服务！
2. 一致性Hash算法也是使用取模的方法，只是，刚才描述的取模法是对 `服务器的数量` 进行取模，而一致性Hash算法是 `对2^32取模`，什么意思呢？简单来说，一致性Hash算法将整个哈希值空间组织成一个虚拟的圆环。
    ```
    
    // 用非加密HASH算法对Node取模，节点的NodeInfo如：ip，port，name，password..
    MurMurHash(NodeInfo) % 2^32，那么结果必然在[0，2^32 - 1]环上。

    // 真实Node数较少，Hash环上可能不是均匀的，为避免数据倾斜，可为每一个真实Node维护多个虚拟Node
    MurMurHash(NodeInfo#1) % 2^32；MurMurHash(NodeInfo#2) % 2^32；

    // 数据key，也采用同样的hash算法
    MurMurHash(data) % 2^32
    ```
3. 数据的存储：计算出hash后，存储在Hash环的 `顺时针方向` 找到第一个(虚拟)节点上即可。 
4. 节点的动态伸缩，影响的数据只占整体数据一小部分，对整体系统的影响不大，对于`数据准确性要求多`的场景则不适用一致性哈希。  
    ```
    // 容错性
    如果一台服务器不可用，则受影响的数据仅仅是此服务器到其环空间中前一台服务器(逆时针方向)；

    // 可扩展性
    如果增加一台服务器，受影响的数据仅仅是新服务器到其环空间中前一台服务器(逆时针方向)之间数据
    ```

5. 分片存储在Node上的实现[把每个真实节点(及其虚拟节点)理解为一个分片]
    ```
    // S表示分片，封装了机器节点的信息，如：ip，port，name，password
    public class Sharded<S> {

        /**每个机器节点关联的虚拟节点*/
        private TreeMap<Long,S> nodes;
        /**机器节点*/
        private List<S> shards;
        /**每个机器节点关联的虚拟节点的个数*/
        private final int NODE_NUM = 160;

        public Sharded(TreeMap<Long, S> nodes, List<S> shards) {
            super();
            this.nodes = nodes;
            this.shards = shards;
            init();
        }

        /**
        * 初始化，主要为机器节点关联的虚拟节点
        */
        private void init(){
            nodes = new TreeMap<Long, S>();
            for(int i=0; i<shards.size(); i++ ){
                for(int n=0; n<NODE_NUM; n++){
                    nodes.put(hash("SHARD-"+i+"-NODE-"+n), shards.get(i));
                }
            }
        }

        public S getShardInfo(String key){
            SortedMap<Long, S> tail = nodes.tailMap(hash(key));
            if(tail.size()==0){
                return nodes.get(nodes.firstKey());
            }
            return tail.get(tail.firstKey());
        }

        /**
        * MurMurHash算法，是非加密HASH算法，性能很高
        * 比传统的CRC32,MD5，SHA-1(这两个算法都是加密HASH算法，复杂度本身就很高，带来的性能上的损害也不可避免)等HASH算法要快很多，而且据说这个算法的碰撞率很低.
        * @param key
        * @return
        */
        private Long hash(String key){
            ByteBuffer buf = ByteBuffer.wrap(key.getBytes());  
            int seed = 0x1234ABCD;  
            ByteOrder byteOrder = buf.order();  
            buf.order(ByteOrder.LITTLE_ENDIAN);  
            long m = 0xc6a4a7935bd1e995L;  
            int r = 47;  
            long h = seed ^ (buf.remaining() * m);  
            long k;  
            while (buf.remaining() >= 8) {  
                k = buf.getLong();  
                k *= m;  
                k ^= k >>> r;  
                k *= m;  
                h ^= k;  
                h *= m;  
            }  
            if (buf.remaining() > 0) {  
                ByteBuffer finish = ByteBuffer.allocate(8).order(  
                        ByteOrder.LITTLE_ENDIAN);  
                finish.put(buf).rewind();  
                h ^= finish.getLong();  
                h *= m;  
            }  
            h ^= h >>> r;
            h *= m;
            h ^= h >>> r;
            buf.order(byteOrder);
            return h;
        }
    }
    ```

### 四、TreeMap
1. 红黑树主要的作用是用于 `存储有序的数据`，TreeMap和TreeSet都是基于其实现。

2. TreeMap本身提供了一个tailMap(K fromKey)方法，支持从红黑树中查找比fromKey大的值的集合，但并不需要遍历整个数据结构。

3. 查找的时间复杂度降低为O(logN)

### 五、实际应用
1. Mysql、Redis、Kafka都有对应的分片机制
    ```
    // Redis切片集群 - 解决单机存储容量问题
    Redis中为保证可以存储更多的数据，通过使用不同的slot存储数据。

    // kafka中为了保证消息写入Broker的存储高性能，也采用分片机制存储数据。比如将一个消息ABC，会进行存储到不同的broker节点上，保证数据的高性能。Kafka topic分区机制原理。

    // Mysql的分库分表 - 解决写操作性能提升问题
    ```

### 六、总结
1. 常见的哈希算法，先计算出哈希值，再根据服务数量取模(hash%N)，将数据存储到固定的服务器下。
    ```
    // 缺点
    当节点增加或者减少，N发生了变化，原来hash%N方式都失效了，数据也无法正常的获取了。
    ```
2. 一致性哈希算法就是为了解决节点数量发生变化时，数据一致性的问题。
    ```
    1. 在一个环上有2^32节点，新增一个数据，先算出来哈希值，然后取模，算出来在环上的位置，往顺时针找到第一个服务节点，就是存储的服务节点。
    2. 如果添加或者减少服务，比如服务挂了，或者服务扩容了，仅影响从新的服务节点到`逆时针方向`的第一个服务节点，而其他数据不受影响。
    ```
3. 哈希环数据分布不均匀时，出现数据倾斜，就需要引入虚拟节点，一个服务节点对应多个虚拟节点，访问数据请求到虚拟节点，再找到对应的真实服务节点。虚拟节点越多，数据的分布就越均衡。同时，新增或者减少节点，会有不同的服务节点分摊压力，使服务更加稳定。