## HDFS集群的部署(中心化的主从架构)


### 一、节点部署HDFS角色详细
1. NameNode: 主节点管理者，发号施令
2. SecondaryNameNode: 主节点辅助，秘书
3. DataNode: 从节点工作者
| 节点  |               ip |            部署角色(服务)             |
| :---- | ---------------: | :-----------------------------------: |
| node1 |  192.168.159.101 | NameNode、DataNode、SecondaryNameNode |
| node2 | 192.168.159.1012 |               DataNode                |
| node3 |  192.168.159.103 |               DataNode                |

### 部署
1. node1节点中，准备, `cd /export/server` 文件夹，并上传Hadoop二进制包至其中
2. 解压并创建软链接
    ```
    tar -zxvf jdk-8u361-linux-x64.tar.gz -C /export/server
    ln -s /export/server/hadoop-3.3.4  hadoop
    软链接后，cd hadoop也能直接进入 /export/server/hadoop-3.3.4目录
    ```
3. `cd hadoop`, 其中bin和sbin目录存放是一些内置的可执行命令；etc存放的是配置文件
4. 修改4个配置文件如下，路径均在 `$HADOOP_HOME/etc/hadoop`
    ```
    workers: 配置从节点DataNode有哪些
    hadoop-env.sh: 配置hadoop的相关环境变量
    core.site.xml: hadoop的核心配置文件
    hdfs-site.xml: hdfs的核心配置文件
    ```   
    vim workers ; 表明集群有三个从节点DataNode  
    ```
    node1
    node2
    node3
    ```      
    vim hadoop-env.sh ; 配置hadoop运行时会使用到的 jdk环境及一些运行目录位置  
    ```
    export JAVA_HOME=/export/server/jdk
    export HADOOP_HOME=/export/server/hadoop
    export HADOOP_CONFIG_DIR=$HADOOP_HOME/etc/hadoop
    export HADOOP_LOG_DIR=$HADOOP_HOME/logs
    ```  
    vim core.site.xml ; 配置hadoop文件系统hdfs网络通讯协议, 配置后, NameNode必须为node1且通讯端口为8020  
    ```
    <configuration>
        <property>
            <name>fs.defaultFS</name>
            <value>hdfs://node1:8020</value>
        </property>
        <property>
            <name>io.file.buffer.size</name>
            <value>131072</value>
        </property>    
    </configuration>
    ```
    vim hdfs-site.xml ; 配置 新文件的初始权限、namenode及datanode元数据存储位置、白名单节点、hdfs默认块大小256M、namenode处理并发数
    ```
<configuration>
    <property>
        <name>dfs.datanode.data.dir.perm</name>
        <value>700</value>
    </property>
    <property>
        <name>dfs.namenode.name.dir</name>
        <value>/data/nn</value>
    </property>    
    <property>
        <name>dfs.namenode.hosts</name>
        <value>node1,node2,node3</value>
    </property>

    <property>
        <name>dfs.blocksize</name>
        <value>268435456</value>
    </property>
    <property>
        <name>dfs.namenode.handler.count</name>
        <value>100</value>
    </property>    
    <property>
        <name>dfs.datanode.data.dir</name>
        <value>/data/dn</value>
    </property>    
</configuration>
    ```
5. node1 上要创建 `mkdir -p /data/nn`  `mkdir -p /data/dn`; 其余节点要创建 `mkdir -p /data/dn`
6. node2、node3也需要安装hadoop，直接从node1复制，并创建软连接（非常重要，这一步相当于给node2 node3也配置了上面的内容）
    ```
    ## node2 node3不要单独安装，避免配置出错
    scp -r hadoop-3.3.4 node2:`pwd`/
    ln -s /export/server/hadoop-3.3.4  hadoop  
    ```
7. 为每一台虚拟机`vim /etc/profile` 追加hadoop的环境变量              
    ```
    软链接后，hadoop 可直接代表 /export/server/hadoop-3.3.4目录
	export HADOOP_HOME=/export/server/hadoop
	export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
    source /etc/profile
    ```
8. 为每一台虚拟机，授权必要的目录给普通用户hadoop
    ```
    chown -R hadoop:hadoop /data
    chown -R hadoop:hadoop /export
    ```      
### 切换到hadoop用户, 初始化后再启动 (只需在node1执行)
1. 启动前, 需要格式化整个文件系统(初始化一些文件、目录) ` hadoop namenode -format `
2. sbin下的一键启停hdfs集群脚本: ` start-dfs.sh `  ` stop-dfs.sh ` (用./启动，不要用sh 启动)
3. 启动后jps验证是否启动了相应的服务，先SecondaryNameNode 后NameNode、再DataNode
4. http://node1:9870 , 可查看hdfs文件系统管理的页面(匿名者权限)

### 单独控制每个虚拟机上服务的启停，两种方式
1. 用bin目录下的: `hdfs --daemon(start|status|stop) (namenode|datanode|secondaryNameNode) ` 
2. 用sbin目录下的: `hadoop-daemon.sh  (start|status|stop) (namenode|datanode|secondaryNameNode) ` 

### 操作文件系统命令
1. 协议: file:///usr/local/xxx.txt; hdfs://node1:8020/usr/local/xxx.txt; 路径中可省略不写，会根据路径在命令的位置自动识别出来。
2. 旧版本hadoop fs -x ; 新版本: hdfs dfs -x
   ```
    创建目录(hdfs系统中)
    hdfs dfs -mkdir -p /home/mayu

    查询目录(-R递归查看)
    hdfs dfs -ls -h /home/mayu

    上传本地文件到hdfs系统指定目录下(-f覆盖; -p保留所有权及权限、访问及修改时间等)
    hdfs dfs -put -f /export/server/test.txt  /home/mayu/

    查看hdfs系统中文件内容(文件内容大时，可以用上管道 | more, 然后空格翻页)
    hdfs dfs -cat /home/mayu/test.txt ｜ more

    拷贝或者移动: hdfs -> hdfs
    hdfs dfs -cp -f /export/server/test.txt  /export/server/test-new.txt

    下载hdfs系统中的文件到本地系统指定目录下(-f覆盖; -p保留所有权及权限、访问及修改时间等)
    hdfs dfs -get -f /home/mayu/test-new.txt  /export/server/

    将本地文件，追加到hdfs系统中的文件内容(更新操作只有删除、追加)
    hdfs dfs -appendToFile /export/server/test-append.txt  /home/mayu/test-new.txt

    删除: hdfs dfs -rm -r /home/mayu/*
   ```

### 权限问题
1. hdfs系统中，超级用户就是启动namenode的用户，一定需要用hadoop用户启动! 如果是root启动的，root只会被认定是hdfs集群中的普通用户
2. 修改文件或文件夹所属的用户和组: hdfs dfs -chown [-R] root:root /xxx.txt
3. 修改文件权限: hdfs dfs -chmod [-R] 777 /xxx.txt


### fsck命令检查文件的副本数
1. hdfs fsck $path -files -blocks -locations
2. 默认3个副本数，dfs.replication = 3
3. 文件被分成block存储，一个block块大小256M，每一个block在node2 node3都有备份，即一个block存储了3份。

### nameNode管理文件与block的映射关系
1. nameNode会不停的写edits流水账文件，记录hdfs每一次操作影响的文件、及其对应的block信息；在生成多个后，被secondaryNameNode合并形成fsimage文件。
2. fsimage文件，一堆流水账文件合并后的(不断合并)最终结果，只有一个。客户端查看或读取文件时，就会从fsiamge文件去查询文件信息。

### 客户端读写hdfs系统文件的过程(写入)
1. 客户端发请求，nameNode判断客户端请求的权限、及hdfs剩余空间，满足条件后允许写入，告知客户端写入DataNode的地址
2. 客户端向指定的DataNode发送数据包(一般是距客户端网络距离最近的一个节点)
3. 被写入数据的DataNode同时会完成数据副本的复制工作（内部构建一个pipLine管道，分发完成复制）
4. 写入完成后，会通知NameNode，NameNode会做元数据记录(edits流水账文件)

### 客户端读写hdfs系统文件的过程(读取)
1. 客户端发请求，nameNode检查权限，去fsimage文件中查询，并返回要读取文件的blocks信息列表
2. 客户端拿到列表后，自行寻找对应的DataNode进行block的读取