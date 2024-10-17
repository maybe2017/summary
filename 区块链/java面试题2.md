2、ArrayList和LinkedList异同。ArrayList会一直扩容吗？答：最大Integer.MAX_VALUE，但是在达到这个值之前会在Integer.MAX_VALUE-8的时候卡一下。为什么卡一下？答：。。。（划重点，ArrayList如果能说出Integer.MAX_VALUE-8及其原因，是个不小的加分项）。
3、PBFT。
4、DPOS是什么？哪个公链用？
5、HTTP1.0/1.1/2.0啥区别？说了1.0和1.1,。
6、docker虚拟化原理：答：namespace、cgroups。docker镜像结构：一层一层的。为什么这种结构？
7、k8s有什么组件？有哪些资源？各种资源之间关系？Deployment和StatefulSet有什么区别？这种区别是怎么实现的？（怎么实现的没答上来。）
8、Prometheus在项目中是怎么用的？答：...
9、Ethereum的MPT。看过：忘了，知道MerkleTree...。以太坊还记得多少？答：还记得一些简单的概念，平时不用基本上都忘记了。
10、Mysql聚簇/非聚簇索引。为什么B+ Tree？B Tree太高？可以压缩啊，为什么不用B Tree？MyISAM和InnoDB索引区别。InnoDB怎么存储数据？（16K，主键、顺序存）
11、HTTP和WebSocket？HTTPS如何保证安全？不会websocket。
12、TCP四次挥手过程。描述的过程中也有提问。
13、项目介绍。k8s在里面怎么用的？有几个节点？区块数据怎么存储？是什么类型的PV？答：hostPath。你用hostPath的话，节点挂了怎么恢复？一定落到原来的node上吗？答：本地开发环境，挂了就挂了，这个项目就是用来当节点挂了以后在本地快速搭建的开发环境的。生产也是hostPath吗？答：生产是挂网盘。
14、Redis的string底层怎么实现的？一组SDS，SDS具体有什么内容？说了一两个字段。其他的不知道。
15、Pod挂了，在同一台机器上调度还是在另一台机器上调度？如果当前及其没资源了怎么办？
16、GRPC用了哪些技术？基本没答上来。
