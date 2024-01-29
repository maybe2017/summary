## ThreadLocalMap静态内部类[嵌套类]
1. 为什么定义在ThreadLocal中？而不是Thread中？
    ```
    1. ThreadLocalMap并不需要Thread对象来操作，所以定义在Thread类内只会增加一些不必要的开销
    2. ThreadLocal类负责 `ThreadLocalMap` 的创建，仅当线程中设置第一个ThreadLocal变量时，才为当前线程创建`ThreadLocalMap`，之后所有其他ThreadLocal变量将使用一个ThreadLocalMap。
    3. 代码功能结构上，一种内聚的组织方式。静态内部类不能被从外部直接访问，需要通过主类来创建它的实例。[封装性和安全性]
    ```
2. ThreadLocal可以理解为，用来访问ThreadLocalMap的工具类，传递了变量值而已。ThreadLocal对象仅是访问Map的入口。
    ```
    变量会封装在 `ThreadLocal对象` 中，ThreadLocal对象 又放在了当前线程的`ThreadLocalMap`中
    ```

### ThreadLocalMap
1. Entry数组, Entry是一个KV，即一个ThreadLocalMap中可以存储多个KV。K是`ThreadLocal对象`，V是真正的用户变量数据。
2. key 为 ThreadLocal 的弱引用，弱引用的特点是，如果这个对象只存在弱引用，那么在下一次垃圾回收的时候必然会被清理掉。
    ```
    1. 如果 ThreadLocal 没有被外部强引用的情况下，在垃圾回收的时候会被清理掉的，这样一来 ThreadLocalMap中使用这个 ThreadLocal 的 key 也会被清理掉。但是，value 是强引用，不会被清理，这样一来就会出现 key 为 null 的 value。
    2. ThreadLocalMap实现中已经考虑了这种情况，在调用 set()、get()、remove() 方法的时候，会清理掉 key 为 null 的记录。如果说会出现内存泄漏，那只有在出现了 key 为 null 的记录后，没有手动调用 remove() 方法，并且之后也不再调用 get()、set()、remove() 方法的情况下。
    ```


### 三、使用场景
1. 每个线程需要有自己单独的实例；实例需要在多个方法中共享，但不希望被多线程共享
2. 存储用户Session
3. 如Java7中的SimpleDateFormat不是线程安全的，可以用ThreadLocal来解决这个问题。
   ```
   Java8里的 java.time.format.DateTimeFormatter 是线程安全的，Jodatime里的DateTimeFormat也是线程安全的。
   ```
4.    