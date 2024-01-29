### 核心属性
1. 阻塞的线程会封装成Node对象，进入CLH双向队列。[相当于synchronized关键字当中的EntryList双向链表队列]
    ```
    // 队头，第一个阻塞的线程
    Node head;
    // 队尾，最后一个阻塞的线程
    Node tail;
    // 锁的重入次数	
    int state;
    // 当前持有锁的线程
    Thread exclusiveOwnerThread;
    ```
### 为什么CLH队列中，队头Node节点中的Thread为null？
