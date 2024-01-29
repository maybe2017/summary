### Java对象头
1. 运行时元数据（Mark Word）和类型指针（Klass Word）; 数组对象还会有额外32bit记录数组长度。
2. 类型指针：指向类元数据InstanceKlass，确定该对象所属的类型。指向的其实是 `方法区中存放的类元信息`。
3. 每个Java对象都可以关联一个C++对象ObjectMonitor，如果使用`synchronized`给对象上锁(重量级)之后，该对象头的MarkWord 中就被设置指向 `Monitor对象` 的指针（将对象与Monitor对象关联）。

### 唤醒与释放锁
1. 特别注意`唤醒与释放锁`是两个不同的概念。
2. notify()唤醒后，并不代表立刻释放锁。真正释放锁的时机，是当临界区代码块执行结束时。

### Monitor中的`EntryList`与`WaitSet`
1. EntryList双向链表：`因为拿不到锁而阻塞的当前线程`会进入该链表。[blocking状态]；
   ```
   1. 当前`锁对象`关联的 `Monitor的Owner属性` 指向其他线程。
   2. JVM实现中，线程是通过ParkEvent.park()进行阻塞，底层使用的是操作系统的mutex。
   ```
2. WaitSet等待集：获取到锁进入临界区后，因为某个条件不满足，从而执行wait()后的线程会进入WaitSet队列阻塞。[waiting状态]
3. 被其他线程释放锁后，会从EntryList链表以 `倒序顺序唤醒` 阻塞状态的节点。[ReentrantLock先进先出，synchronized先进后出]

### 为什么JVM要设计出来一个WaitSet的队列出来专门存放wait的线程？
1. 为使JVM区分这些线程是因为什么原因而被阻塞，那么唤醒时就可以确定该唤醒哪一个队列中的线程。
    ```
    1. 其他线程释放锁后，那么应该是唤醒 `拿不到锁而阻塞` 进入EntryList队列的线程。
    2. 条件满足后，那么应该是用notify()去唤醒 `条件不满足而等待` 进入WaitSet队列的线程。
    ```
2. 所有waiting状态的线程必须经过blocking状态才能进入runing状态，waiting状态的线程是无法直接到runing状态的。
    ```
    1. 调用notifyAll()其实仅是把WaitSet当中所有阻塞线程转移到 `EntryList队列的末尾`。
    2. 当持有锁的线程释放锁之后，再去EntryList队列的末尾唤醒一个线程执行。
    ```