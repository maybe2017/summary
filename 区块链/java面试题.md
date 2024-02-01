1、ThreadLocal。答：ThreadLocal.Map，环形数组，线性探测、弱引用、内存泄漏等。
2、JVM内存划分及各个区域作用。答：年轻代、老年代、永久代等，最好是按照jdk7和jdk8分版本说，如果说出TLAB这类细节，印象会好很多。
3、sychronized的原理。答：jdk6之前是重量级锁，1.6之后进行了优化，引入偏向锁、轻量级锁、重量级锁，锁消除等等。偏向锁、轻量级锁、重量级锁加锁以及锁的升级（LockRecord等以及对象头信息中的MarkWord）过程，底层实现。（之前看过这一块的源码，所以都没什么问题）
4、AQS。CountDownLatch、CyclicBarrier等如何实现的。答：。。。
5、HashMap原理：答：分版本说。实现方式、底层数据结构、扰动处理、扩容方式、rehash方式
6、CMS过程。我是结合G1说的。CMS：7个过程过程，并发回收三色标记有什么问题，CMS如何解决的：基于强三色不变式的增量更新，卡表、写屏障及其工作工程。G1：过程，基于弱三色不变式的SATB，SATB和G1的写屏障。CMS和G1的写屏障的异同。
7、ZGC？答：不会。
8、算法题。
9、HashMap不安全，用什么？ConcurrentHashMap怎么实现的？答：分版本说。
10、说一下zookeeper的zab。答：。。。
11、Redis跳表、Map的rehash。常规问题。
12、聚簇索引和非聚簇索引。
13、mysql事务、索引什么的。
14、volatile。答：可见性和有序性。可见性实现原理：CPU的lock，JMM。。。高速缓存。。。有序性实现原理：内存屏障（注意区别CMS和G1的写屏障）种类及各自作用。
15、IO多路复用。答：有三种，select、poll、epoll分别是怎么实现的，select：fdset，... poll：pollfd... epoll：eventpoll（红黑树和就绪链表）以及发生调用时操作系统的执行过程。
16、线程池相关。各参数含义，不同线程池区别，开发一般怎么构建线程池之类的。
