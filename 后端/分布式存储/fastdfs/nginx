## sendfile指令指定nginx是否调用sendfile 函数（zero copy 方式）来输出文件，对于普通应用，必须设为on。如果用来进行下载等应用磁盘IO重负载应用，可设置为off，以平衡磁盘与网络IO处理速度(直接让网卡去读文件，不必再进过文件->nginx->网卡的过程)
http.sendfile = off

lvs dr


每次调用的时候会重新new一个StorageClient()实例，这样每次请求拿到的就是不同的StorageClient，也就意味着每个请求会获取到不同的storageServer，这样就不存在共享变量，也就避免了出现并发的空指针问题。

明天问下严复  问问lvs的事情 仅仅是分发请求，流量呢？