### 一些背景知识
#### IO的分类
1. 普通文件IO：是对磁盘文件上的数据进行读写，
2. 网络IO：是对网络数据进行读写，即从网卡NCI缓冲区读取数据
    ```
    // 先读取、再发送，实际经过1~4四次copy。
    1. 第一次：将磁盘文件，读取到操作系统内核缓冲区；
    2. 第二次：将内核缓冲区的数据，copy到应用程序的buffer；
    3. 第三步：将应用程序buffer中的数据，copy到socket网络发送缓冲区(属于操作系统内核的缓冲区)；
    4. 第四次：将socket buffer的数据，copy到网卡，由网卡进行网络传输。

    // 很明显，第二次和第三次数据copy没什么意义，应用程序如果不对磁盘数据处理的话。
    sendfile机制可以免去第二次和第三次数据copy

    // 一般的，写入磁盘用mmap系统调用，非实时，需要等操作系统调用flush
    // 从磁盘读取到网卡，用sendfile系统调用
    ```
#### 减少拷贝次数
1. DMA控制器(一块独立芯片)，可以用来在一个从外设和一个存储器之间连续地传输数据
2. sendfile机制可以免去 用户空间这层的来回拷贝与写入。
3. mmap开辟一块直接内存空间，用户空间和内核都可访问；操作系统flush后才能真正落盘。[非实时]

#### IO多路复用 - 操作系统提供的特性
1. 多个socketChannel可以注册到一个selector上，同时针对每一个socket还可以指明感兴趣的事件。这是Java层面Nio对io多路复用的实现。
2. 操作系统层面，本质是select poll epoll 系统调用函数
    ```
    1. select 与poll 要来回拷贝fdset，遍历寻找已经准备就绪的fd。
    2. epoll 通过回调机制将就绪的fd 放入双向链表，用户进程不需要再遍历。
    ```

### Reactor线程模型 - 基于IO多路复用实现
1. 是什么？是一种高效的网络编程模式，异步非阻塞编码风格。利用了操作系统提供的异步IO机制，将网络IO事件交给操作系统内核处理，避免用户态线程直接阻塞在IO事件上。
2. Reactor线程模型中的核心元素：
    ```
    1、多路复用器：由操作系统提供，在 linux 上一般是 select, poll, epoll等系统调用。
    2、事件分发器：将多路复用器中返回的就绪事件分到对应的处理函数中。
    3、事件处理器：负责处理特定事件的处理函数。

    Handler：Handler与Event组队出现，它携带着用于处理一个已经触发的事件的具体逻辑（或者说代码）。Handler所携带的逻辑必须是非阻塞的。
    Event Queue：一个存储着所有待处理Event（以及其Handler）的队列。
    Event Loop：Reactor的核心loop，持续从Event Queue中消费Event并执行其关联的Handler，当Handler中包含I/O操作时，向Event Demultiplexer注册监听。

    ```
3. 单selector单线程，连接及读者事件均自己处理。Redis采用的NIO Reactor模型就是单线程的Reactor模型，优点是实现起来简单且可控性强。
4. 单selector多线程，读写事件用线程池处理。![单selector多线程](https://qn.mayu1024.com/hexo%E5%8D%9A%E5%AE%A2/%E5%A4%9A%E7%BA%BF%E7%A8%8B/netty-single-selector.png)
5. 多selector多线程，处理客户端的连接用一个selector，处理读写事件用线程池，每一个线程分配一个selector。![多selector多线程](https://qn.mayu1024.com/hexo%E5%8D%9A%E5%AE%A2/%E5%A4%9A%E7%BA%BF%E7%A8%8B/netty-multi-selector.png)
    ```
    // 适用场景
    主要是处理高并发场景下的网络IO，使用户程序不是真正阻塞在IO操作上，仅是阻塞在等待内核准备好数据等待信号的select、poll、epool系统调用上。待数据准备好之后，用户程序再通过 `recvfrom系统调用` 从内核向用户空间拷贝数据。

    // 缺点
    如果客户端数量不多，并发量不大，可能效率不如直接使用阻塞IO，即直接阻塞在recvfrom系统调用上。
    ```


### mmap
1. IO过程分两阶段：i. 等待内核有数据准备好的信号， ii.从内核空间复制到用户空间；即数据会先被拷贝到操作系统内核的缓冲区中，然后才会从操作系统内核的缓冲区拷贝到应用程序的地址空间。
2. mmap是将物理内存映射到虚拟内存，用户进程操作虚拟内存即可。从磁盘读的时候，少了从内核复制到用户空间步骤，写入磁盘的时候，少了从用户空间拷贝到内核空间的步骤（但是内核空间还是会拷贝一次）。