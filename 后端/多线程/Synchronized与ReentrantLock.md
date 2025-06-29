## synchronized 关键字

### 一、重量级锁阶段
1. 为什么称之为重量级？难道仅是因为创建了ObjectMonitor 对象吗?
    ```
    // 核心原因：涉及操作系统内核态操作
    轻量级锁：依赖 CAS（用户态自旋），不涉及系统调用，速度快。【仅在用户态】
    重量级锁：竞争失败时，线程会通过 pthread_mutex_lock 等系统调用进入 内核态阻塞（如 Linux 的 futex），涉及上下文切换，开销大。
    ```
2. ObjectMonitor 对象是在 synchronized 锁升级为重量级锁时创建的，JVM 会在堆外内存中创建一个 ObjectMonitor C++对象
    ```
    // 升级为重量级锁的时机：
    1. 多个线程竞争同一锁（锁竞争激烈）
    2. 调用 wait()、notify() 等方法（这些方法需要重量级锁支持）
    3. 线程自旋获取轻量级锁失败（超过阈值次数）

    // ObjectMonitor 是重量级锁的载体
    在轻量级锁阶段，锁信息直接存储在 对象的Mark Word中，无需 ObjectMonitor
    升级为重量级锁后，Java 对象的 Mark Word 会被替换为一个指向 ObjectMonitor 的指针（存储的是 C++ 对象的地址）
    ```
3. 将synchronized(this){}块反编译后，第一句指令是`ObjectMonitor.enter`，最后一句指令是`ObjectMonitor.exit`。
4. ObjectMonitor.enter指令在C++中的  ObjectMonitor.cpp 文件中，对应着 `ObjectMonitor::enter()`方法
    ```
    +-------------------------------+
    |        ObjectMonitor           |
    +-------------------------------+
    | _header        : markOop      |  -> 存储对象的Mark Word（锁状态、哈希码等）
    | _owner         : void*        |  -> 持有锁的线程（NULL表示未锁定）
    | _WaitSet       : ObjectWaiter*|  -> 等待队列（调用了wait()的线程）
    | _cxq           : ObjectWaiter*|  -> 竞争队列（未获取锁的线程临时存放）
    | _EntryList     : ObjectWaiter*|  -> 就绪队列（即将被唤醒的线程）
    | _recursions    : int          |  -> 重入次数（可重入锁计数）
    | _count         : int          |  -> 等待锁的线程数（近似值）
    | _waiters       : int          |  -> 等待条件的线程数（wait()调用次数）
    | _Responsible   : void*        |  -> 责任线程（避免长时间持有锁）
    +-------------------------------+


    // 在重量级锁状态下，线程尝试获取锁过程中，【会多次自旋方式尝试获取锁】，尽量避免进行系统调用陷入阻塞
    1. CAS去改_owner为当前线程，改成功则表示拿到锁成功！【PS：AQS更改的是state】
    2. 拿锁成功后，依然判断下是否是重入
    3. 自旋尝试获取锁 -> 失败后再次tryLock()尝试获取一次 -> 再次自旋trySpin()尝试获取锁 -> 封装成ObjectWaiter循环尝试CAS入队Cxq，每失败一次再次挣扎自旋尝试获取锁 -> 直到入队Cxq成功进行阻塞
    ```
3. 

### 二、wait、notify线程通信机制的缺点   
1. synchronized的wait方法是让线程进入一个队列WaitSet(休息室)，不管是因为条件A、或条件B，都会进入WaitSet队列。[synchronized只有一个休息室]
2. notify、notifyAll的唤醒规则，不能控制唤醒具体阻塞在某一个条件上的线程。即：即使条件A满足了，也不能控制一定唤醒阻塞在条件A上的线程。
    ```
    // 条件A
    static boolean isWoman = false;
    // 条件B
    static boolean isMoney = false;
    synchronized (this) {
        // 1. 用while不用if，使阻塞在wait处的线程被唤醒后，可以重新判断条件是否满足，避免虚假唤醒
        // 2. 确切的表示线程会阻塞在`isWoman`这个条件上，但是没什么用，通知时会通知所有节点
        while (!isWoman){
            try {
                // 线程进入阻塞，但是释放了锁
                object.wait();
            } catch (InterruptedException e) {}
        }
        log.debug("开始工作啪啪啪啪");
    }

    // 但是notify的叫醒规则，却不能精确的控制，去唤醒`等待在某一条件上`的阻塞线程
    synchronized (this) {
        isWoman = true;
        // 阻塞在条件A、B上的线程均会被唤醒..
        object.notifyAll();
    }
    ```     
### 三、ReentrantLock#Condition
1. 每一个Condition对象就可表示一个休息室，这样当条件满足的时候可以 `根据条件叫醒` 不同休息室的人。
2. CxQ、EntryList对应是ReentrantLock当中公平锁或者非公平锁中的CLH队列。[先进先出]
3. WaitSet队列是JVM实现中C++里面的，JDK中在ReentrantLock#Condition中，是用`ConditionObject`类维护了一个类似WaitSet的队列。
    ```
    // 条件A
    static boolean isWoman = false;
    // 条件B
    static boolean isMoney = false;

    static ReentrantLock lock = new ReentrantLock();
    // 因为A不满足而进入阻塞的队列
    static Condition conditionWoman = lock.newCondition();
    // 因为B不满足而进入阻塞的队列
    static Condition conditionMoney = lock.newCondition();

    new Thread(() -> {
        lock.lock();
        while (!isWoman){
            try {
                // 阻塞并释放锁，会进入特定的A队列，ConditionObject这个对象维护的双向链表队列
                conditionWoman.await();
            } catch (InterruptedException e) {}
        }
        log.debug("开始处理A..");
        lock.unlock();
    }).start();
    
    new Thread(() -> {
        lock.lock();
        while (!isMoney){
            try {
                // 阻塞并释放锁，会进入特定的B队列
                conditionMoney.await();
            } catch (InterruptedException e) {}
        }
        log.debug("开始处理B..");
        lock.unlock();
    }).start();

    // notify的叫醒规则，能精确的控制唤醒`等待在某一条件上`的阻塞线程
    new Thread(() -> {
        lock.lock();
        isWoman=true;
        log.debug("A条件满足了，从特定的A队列当中唤醒");
        conditionWoman.signalAll();
        lock.unlock();
        }, "boss").start();
    ```     

## 总结
### 一、相同点
1. 两者必须先获得锁，再执行业务代码。否则抛出IllegalMonitorStateException异常。如等待、通知方法必须放在临界区内[synchronized块内]。
2. 释放时，也需要判断当前线程是否是`exclusiveOwnerThread`，即锁的持有者。


### 二、不同点
| 客户          |      获取、释放锁途径 |       等待、通知[通信]        |                                      等待条件                                      |
| :------------ | --------------------: | :---------------------------: | :--------------------------------------------------------------------------------: |
| synchronized  | JVM隐式自动释放锁获取 | wait()、notify()、notifyAll() | 业务层指定条件，均只能阻塞在一个队列（先到cxq队列，唤醒后可竞争时转移到entryList） |
| ReentrantLock |      手动编写代码控制 | Condition的 await()、signal() |       业务层指定条件，每一个条件对应一个Condition对象，其维护了一个等待队列        |

1. synchronized非公平锁，ReentrantLock可以公平或非公平。
2. synchronized不支持获取锁最大等待时间，ReentrantLock支持等待时间内获取锁`tryLock(long , TimeUnit)`。
3. synchronized `等待获取锁阻塞时` 不可被中断，进入wait/time_wait拿到锁之后可被中断，没获取到锁的情况下，中断操作一直不会生效。ReentrantLock支持等待获取锁时可中断`awaitUnInterruptibly`。
4. synchronized底层是CAS尝试修改线程持有者`owner`字段持有锁，而AQS中，是CAS尝试修改锁数量`state`字段

                
