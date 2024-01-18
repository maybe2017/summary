#### GC现象及可能原因

线上状态: 不停产生FullGc， 原因可能是Yong区容量已经不够分配新对象 新对象可能直接被分配担保至老年代 老年代一直填充对象 频繁gc

```bash
# 以前的  采用Jdk8默认垃圾回收 暂时解决方案: 需要提高堆内存至8G，或修改代码
nohup java -Xmx2g -Xms2g -Xloggc:gc.log -XX:NewRatio=1 -XX:+PrintGCDetails -XX:+PrintGCCause -XX:+UseParallelGC -XX:+UseParallelOldGC GCLogAnalysis -jar ./neptune-parent-1.2.1-release.jar   --spring.config.location=/home/sas-multi/neptune-parent/application.yml  -Duser.timezone=GMT+8 -Dproject.name=neptune-parent -DLOG_DIR=/home/sas-multi/neptune-parent/logs -DLOG_NAME=node_0 2>&1 &
```



#### 在线上程序运行时查看运行信息

```bash
# 导出进程此刻的堆状态
jmap -dump:format=b,file=./heap.hprof 22222

# 查看进程此刻的堆状态 
jmap -heap 22222

# 动态查看gc fullgc的运行情况 
jstat -gcutil 22222 1000 1000
```



#### 采用G1垃圾回收器

```bash
# 程序崩溃时导出.hprof堆文件
−XX:+HeapDumpOnOutOfMemoryError
# 默认目录为java进程的工作目录，文件名为java_pidxxx.hprof
-XX:HeapDumpPath

# 用G1试试
nohup java -Xmx2g -Xms2g -XX:+PrintGCDetails -XX:NewRatio=1 -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/home/sas-multi/neptune-parent -XX:+UseG1GC  -jar ./neptune-parent-1.2.1-release.jar   --spring.config.location=/home/sas-multi/neptune-parent/application.yml  -Duser.timezone=GMT+8 -Dproject.name=neptune-parent -DLOG_DIR=/home/sas-multi/neptune-parent/logs -DLOG_NAME=node_0 2>&1 &
```



#### Mac上对.hprof文件的分析

1. cd /Library/Java/JavaVirtualMachines/jdk1.8.0_261.jdk/Contents/Home/bin
2. ./jvisualvm
3. 导入hprof文件
4. 分析...
