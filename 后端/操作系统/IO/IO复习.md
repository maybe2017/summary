
####

#### 为什么用Buffer流比不用buffer快？
1. 不用buffer写入文件时，每次写入都会调用 `系统调用`，涉及到内核态与用户态的切换，所以很慢。
2. 当用户态程序使用buffer，假如buffer为8M，即需要在用户态装填满8M的字节后，才会去调用一次 `系统调用`，即使用buffer减少了`系统调用`的次数，所以提高了性能。

#### mmap【核心要求：随机访问】
1. mmap 的本质是将一个 `支持随机访问` 的存储对象（如文件、共享内存）映射到进程的虚拟地址空间，允许通过指针 `直接读写`。
2. Socket的数据是瞬态的、不可回溯的。【通信端点，非物理设备，属于字符设备】
3. 普通磁盘文件是静态的、可随机访问的数据集合。所以其通过mmap直接映射到进程虚拟地址空间，是具有实际意义的。【块设备：如磁盘，其特点是支持随机访问】

#### NIO
1. ByteBuffer
    ```
    // DirectByteBuffer
    // 从操作系统层面来看，Java进程也分为代码段，数据段，Heap，Stack。【JVM堆 ≠ 进程的整个Heap】
    // Java进程的虚拟地址空间包含多个独立区域，JVM堆和DirectByteBuffer是其中的两个非重叠部分【JVM堆的地址范围不会与DirectByteBuffer重叠】
    // 虽然DirectByteBuffer不在JVM堆里，但是它属于JVM自己malloc出的内存，分配大小也受限于JVM分配的Native Memory。【只是不受GC控制，只能通过Cleaner机制回收】
    // 但是MappedByteBuffer，在Java进程中仅是一组虚拟地址，其指向数据是在pageCache中。【mmap返回的指针属于进程的内存映射段，是独立于堆和栈的虚拟地址区域】


    // DirectByteBuffer 操作文件，还是会存在 read/write 系统调用，才能到pageCache


    # 两者区别
    // ByteBuffer heapBuffer = ByteBuffer.allocate(1024); // 数据在 JVM 堆
    // ByteBuffer directBuffer = ByteBuffer.allocateDirect(1024); // 数据在堆外
    当进行 IO 操作（如读写文件或 Socket） 时：
        1. JVM 堆内存无法直接用于系统调用：
            操作系统（如 Linux）的 read()/write() 等系统调用要求数据存放在 连续的物理内存（或内核可访问的虚拟内存）。   
            但 JVM 堆内存可能由于 GC 移动对象（如 CMS、G1 等垃圾回收器）导致`虚拟内存地址`不固定，无法直接传递给内核。【虚拟地址失效，可能指向错误数据或释放的内存】
        2. 数据必须拷贝到“内核可访问”的内存：    
            如果使用 HeapByteBuffer，JVM 会隐式将数据拷贝到一个临时堆外缓冲区（称为 "中间缓冲区"），再交给系统调用。【避免虚拟地址变动】
            JVM Heap → 临时堆外缓冲区 → 内核缓冲区 → 设备（磁盘/网卡）

    DirectByteBuffer其数据存储在 JVM 堆外的本地内存（通过 malloc 或 mmap 分配）。
        1. 堆外内存是“内核友好”的：
            DirectByteBuffer 的内存是 连续的、固定的虚拟地址，可以直接传递给系统调用（如 read()/write()）。
            操作系统内核可以直接访问这块内存，无需额外拷贝。
        2. DirectByteBuffer（堆外） → 内核缓冲区 → 设备    【减少了一次额外的 JVM 堆内到堆外的拷贝】【但是仍然需要一次 用户态 到 内核态的拷贝】
          
    ```
2. RandomAccessFile
3. FileChannel
    ```
    FileChannel channel = new RandomAccessFile("test.txt", "rw").getChannel();
    
    // 通过Channel进行mmap系统调用，映射文件到进程虚拟地址空间

    // 返回的这个buffer，虽然是一个Java对象，但是其引用的数据，却是一组虚拟地址空间，实际上是指向内核层pageCache缓存的文件页指针【不属于JVM堆，不受GC管理】
    // 对 buffer 的读写操作会直接作用于文件的 Page Cache，无需通过用户态缓冲区（如普通的 read/write 系统调用）
    MappedByteBuffer buffer = channel.map(FileChannel.MapMode.READ_WRITE, 0, 4096);


    ## sendFile
    FileChannel.transferTo/From
    ```
