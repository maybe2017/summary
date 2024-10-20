### 一、ConcurrentModificationException
1. 迭代器是依赖于集合而存在的，使用`集合迭代器`时，若中途有别的线程对容器[modCount版本号]修改，而迭代器[expectedModCount]却不知道，则会抛该异常。
2. 迭代器遍历元素的时候，通过集合是不能修改元素的，必须通过迭代器修改元素。
2. fast-fail快速失败机制，提前预料遍历失败情况，防止数组越界异常。

### 二、CopyOnWriteArrayList [读多写少]
1. 利用 `volatile + 写时加锁拷贝` 关键字保证了容器的线程安全。
2. 底层数组被 `volatile` 关键字修饰，一旦数组被修改，其它线程立马能够感知到。
3. 写时复制: 进行写操作时，会创建一个新的数组，仅复制旧容器里的存储的元素引用，只是在写的时候会创建新对象添加到新容器里。
   ```
   1. 加锁 => 从原数组中拷贝出新数组 => 在新数组上进行操作，并把新数组赋值给数组容器 => 解锁
   2. 每次执行写操作都要将原容器拷贝一份。数据量大时，对内存压力较大，可能会引起频繁GC。
   ```
4. 弱一致性，无法保证实时性。如返回迭代器后，其他线程对容器的增删改查对已返回的迭代器是不可见的。   

### 三、Copy-on-write
1. 如果有多个调用者（callers）同时要求相同资源（如内存或磁盘上的数据存储），他们会共同获取相同的指针指向相同的资源，直到某个调用者试图修改资源的内容时，系统才会真正复制一份专用副本（private copy）给该调用者。
2. 主要的优点是如果调用者没有修改该资源，就不会有副本（private copy）被创建，因此多个调用者只是读取操作时可以共享同一份资源。

### 四、Linux下的COW
1. fork()会产生一个和父进程完全相同的子进程(除了pid)，复制的是页表，直接引用父进程的物理空间。
2. 子进程可以通过exec()函数，装载一个新的程序（可执行映像）覆盖内存空间中的映像，从而执行不同的任务。
3. 父子进程中有更改相应 `段` 的行为发生时，再为子进程相应的段分配物理空间。
    ```
    1. fork()之后，kernel把父进程中所有的内存页的权限都设为`read-only`，意味着 `父子进程都只能读`。
    2. 父子任意进程进行写内存时，CPU硬件检测到内存页是read-only的，于是触发页异常中断`page-fault`，陷入kernel的一个中断例程。
    3. 中断例程中，kernel就会[仅仅]把`触发的异常的页`复制一份，于是父子进程各自持有独立的一份。
    
    ```
4. 优点：减少分配和复制大量资源时带来的瞬间延时；
5. 缺点：如果在fork()之后，父子进程都还需要继续进行写操作，那么会产生大量的分页错误（页异常中断page-fault）。


### 五、Redis的COW
1. 执行`bgsave`或`bgRewriteAof`命令时，会提高`rehash阶段负载因子`的阈值，避免哈希表进行扩容。
    ```
    执行`bgsave`或`bgRewriteAof`命令的过程中，Redis需要创建当前服务器进程的子进程，而大多数操作系统都采用写时复制来优化子进程的使用效率，所以在子进程存在期间，服务器会 `提高负载因子的阈值`，从而避免在子进程存在期间进行哈希表扩展操作，避免不必要的内存写入操作，最大限度地节约内存。
    ```
2. 总体来看，Redis还是读操作比较多。如果子进程复制时发生了大量的写操作，就会出现很多的分页错误，耗费性能。    