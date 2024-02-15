#### 通过jcmd与jstat观察JVM堆使用情况
1. jcmd 1 GC.heap_info
2. jstat -gcutil 1 1000

#### 通过arthas的memory命令，查看 metaspace、direct等非堆内存占用情况
1. memory
2. 堆与非堆都正常，如果有内存泄漏，那只能是堆外的native内存部分。。

### jstak

### jstat
1. 查看进程的gc情况，1000ms内打印10次：`jstat -gc pid 1000 10`


### gcEasy网站导入gc日志
1. 导出gc日志
2. 查看Full GC等情况