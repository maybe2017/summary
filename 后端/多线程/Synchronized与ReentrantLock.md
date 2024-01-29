## synchronized 关键字

### 一、基本概念
1. 它可以用来创建一个区块，称为临界区，在这个区块中，每次只有一个线程可以执行。
2. Java中没有正式的`入口区`和`退出区`概念，但是可以通过`synchronized(this){}块`来实现类似的控制，其中synchronized块的`入口和退出是由JVM来管理`的。
3. synchronized `等待获取锁阻塞时` 不可被中断，进入wait/time_wait拿到锁之后可被中断，没获取到锁的情况下，中断操作一直不会生效。

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
2. EntryList对应是ReentrantLock当中公平锁或者非公平锁中的CLH队列。[先进先出]
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
2. 


### 二、不同点
| 客户          |           获取、释放锁途径 |       等待、通知[通信]        |               等待条件               |
| :------------ | -------------------------: | :---------------------------: | :----------------------------------: |
| synchronized  | synchronized块,JVM隐式获取 | wait()、notify()、notifyAll() | 未精确指明,表示一概堵塞在当前对象上  |
| ReentrantLock |               代码编写控制 | Condition的 await()、signal() | 每一个Condition对象,都可表示一个条件 |

1. synchronized自动释放锁，ReentrantLock需手动。
2. synchronized不支持获取锁最大等待时间，ReentrantLock支持等待时间内获取锁。
3. synchronized`等待获取锁的时候` 不可中断，ReentrantLock支持等待获取锁时可中断。
4. 可轮询锁`tryLock()`；定时锁` tryLock(long , TimeUnit)`，中断等待`awaitUnInterruptibly`。


                
