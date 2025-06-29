
#### 作用
1. 使每个线程都可以拥有独立的变量副本，实现线程间的数据隔离【资源隔离】
2. 线程执行上下文传递参数，深层次传递参数 【上下文传递】
    

#### 原理
1. 线程Thread对象中持有一个`ThreadLocalMap`字段，其中键值对以 ThreadLocal 实例作为 key，以用户变量数据为 value
    ```
    1. 当执行threadLocal.set(value)时，实际上是向执行线程中的ThreadLocalMap添加了一个键值对
    2. 当执行threadLocal.get()时，实际上是向执行线程中的ThreadLocalMap取出当前threadLocal实例对象对应的value
    ```

2. 键值对中，key为ThreadLocal对象实例，但是却是一个弱引用 `WeakReference<ThreadLocal<?>>`，为什么要这样？
    ```
    // 假设一种情况 【通常是线程对象被复用的场景下 - 线程池】
    在方法栈中，创建了ThreadLocal实例对象并使用，那么当方法结束后，按理说ThreadLocal实例对象会被GC回收，当当前线程未结束时，
    因为线程中ThreadLocalMap中仍然持有ThreadLocal实例对象的引用，所以ThreadLocal对象不会被回收。

    如果设置key为弱引用，那么在下一次GC时key就会被清理掉 【解决key-ThreadLocal实例 GC的问题】
    ```
3. 可能造成内存泄漏的原因？
    ```
    // 我们期望通过 ThreadLocal 设置的变量参数，在业务流程执行结束就被GC回收，但是往往业务上都采用了 线程池，导致线程对象一直持有
    ThreadLocalMap，所以其中的键值对也不会被释放

    1. 当使用ThreadLocal在方法栈时，方法结束后，加上key是弱引用，那么ThreadLocal对象实例会被GC掉。null -> value
    2. value呢？需要及时调用 remove() 方法清理 （set()、get()也会清理掉key 为 null 的记录）
    ```


### 使用场景
1. 每个线程需要有自己单独参数变量（配置），如用户Session、数据库连接Connection（多线程事务）、SimpleDateFormat等等
    ```
    // Spring
    1. TransactionSynchronizationManager：管理事务资源 （其中ThreadLocal中存储的是一个Map<DataSource, ConnectionHolder>）
        一个事务的所有数据库操作必须通过同一个数据库连接执行（ACID）
        每个执行线程，通过 ThreadLocal 保证执行的同一事务中的所有操作获取到的是同一个连接

    2. RequestContextHolder：存储当前 HTTP 请求的上下文信息

    // MyBatis
    1. SqlSessionManager：管理 SqlSession
    
    // 分布式追踪系统 SkyWalking、Pinpoint
    1. 使用 ThreadLocal 传递 TraceID 和 SpanID
    ```

2. ThreadLocal 在框架中的主要应用模式
    ```
    上下文传递：如请求上下文、事务上下文、安全上下文等

    资源隔离：如数据库连接、会话等需要线程隔离的资源

    跟踪信息：如日志上下文、分布式追踪ID等

    性能优化：缓存线程安全对象避免重复创建
    ```

3. 子线程不能继承父线程的 ThreadLocal 变量，如需继承可使用 InheritableThreadLocal   