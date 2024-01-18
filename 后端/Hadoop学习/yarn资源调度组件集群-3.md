### 是什么
1. yarn是hadoop分布式框架中的一个组件，分布式资源统一调度(容器技术-资源隔离)
2. mapReduce程序需要运行在yarn容器内

### 一、节点部署yarn角色详细
1. ResourceManager: 集群资源管理者(发号施令)
2. NodeManager: 单机上的资源管理者(执行者)
3. ProxyServer: 代理服务器 提供安全保障
4. JobHistoryServer: 记录历史信息及日志(因为日志最初产生在容器中，不能直接在界面统一展示，故需要一个服务)
| 节点  |               ip |                       部署角色(服务)                        |
| :---- | ---------------: | :---------------------------------------------------------: |
| node1 |  192.168.159.101 | ResourceManager、NodeManager、ProxyServer、JobHistoryServer |
| node2 | 192.168.159.1012 |                         NodeManager                         |
| node3 |  192.168.159.103 |                         NodeManager                         |

### 二、需要修改mapReduce程序的配置文件
1. vim mapred-env.sh
    ```
    export JAVA_HOME=/export/server/jdk
    export HADOOP_JOB_HISTORYSERVER_HEAPSIZE=1000
    export HADOOP_MAPRED_ROOT_LOGGER=INFO,RFA 

    ```
2. vim mapred-site.xml, 添加配置信息
    ```
    <configuration>
        <property>
            <name>mapreduce.framework.name</name>
            <value>yarn</value>
            <description></description>
        </property>
        <property>
            <name>mapreduce.jobhistory.address</name>
            <value>node1:10020</value>
            <description></description>
        </property>
        <property>
            <name>mapreduce.jobhistory.webapp.address</name>
            <value>node1:19888</value>
            <description></description>
        </property>
        <property>
            <name>mapreduce.jobhistory.intermediate-done-dir</name>
            <value>/data/mr-history/tmp</value>
            <description></description>
        </property>
        <property>
            <name>mapreduce.jobhistory.done-dir</name>
            <value>/data/mr-history/done</value>
            <description></description>
        </property>
        <property>
            <name>yarn.app.mapreduce.am.env</name>
            <value>HADOOP_MAPRED_HOME=$HADOOP_HOME</value>
        </property>
        <property>
            <name>mapreduce.map.env</name>
            <value>HADOOP_MAPRED_HOME=$HADOOP_HOME</value>
        </property>
        <property>
            <name>mapreduce.reduce.env</name>
            <value>HADOOP_MAPRED_HOME=$HADOOP_HOME</value>
        </property>
    </configuration>
    ```
### 三、需要修改yarn相关的配置文件
1. vim yarn-env.sh
    ```
    export JAVA_HOME=/export/server/jdk
    export HADOOP_HOME=/export/server/hadoop
    export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
    export HADOOP_LOG_DIR=$HADOOP_HOME/logs
    ```
2. vim yarn-site.xml
    ```
    <configuration>
        <property>
            <name>yarn.log.server.url</name>
            <value>http://node1:19888/jobhistory/logs</value>
            <description>历史服务器配置</description>
        </property>
        <property>
            <name>yarn.web-proxy.address</name>
            <value>node1:8089</value>
            <description>代理服务器主机端口</description>
        </property>
        <property>
            <name>yarn.log-aggregation-enable</name>
            <value>true</value>
            <description>开启日志聚合</description>
        </property>
        <property>
            <name>yarn.nodemanager.remote-app-log-dir</name>
            <value>/tmp/logs</value>
            <description>程序日志HDFS的存储路径</description>
        </property>
        <property>
            <name>yarn.resourcemanager.hostname</name>
            <value>node1</value>
            <description>resourcemanager设置在node1节点运行</description>
        </property>
        <property>
            <name>yarn.resourcemanager.scheduler.class</name>
            <value>org.apache.hadoop.yarn.server.resourcemanager.scheduler.fair.FairScheduler</value>
            <description>选择公平调度器</description>
        </property>
        <property>
            <name>yarn.nodemanager.local-dirs</name>
            <value>/data/nm-local</value>
            <description>nodemanger中间数据本地存储路径</description>
        </property>
        <property>
            <name>yarn.nodemanager.log-dirs</name>
            <value>/data/nm-log</value>
            <description>nodemanger日志数据本地存储路径</description>
        </property>
        <property>
            <name>yarn.nodemanager.log.retain-seconds</name>
            <value>10800</value>
            <description>NodeManager日志持续保存的时间</description>
        </property>
        <property>
            <name>yarn.nodemanager.aux-services</name>
            <value>mapreduce_shuffle</value>
            <description>为MapReduce程序开启Shuffle服务</description>
        </property>
    </configuration>

    ```
### 四、要把mapReduce及yarn相关的配置文件都分发到node2,node3上面!!
1. scp mapred-env.sh mapred-site.xml yarn-env.sh yarn-site.xml node2:`pwd`/
2. scp mapred-env.sh mapred-site.xml yarn-env.sh yarn-site.xml node3:`pwd`/
   
### 五、一键启停命令
1. ./sbin/start-yarn.sh， 先读取yarn-site.xml启动ResourceManager，再启动NodeManager，最后启动ProxyServer
2. 其次执行 `./bin/mapred --daemon start historyserver` 启动历史服务器
3. http://node1:8088 查看yarn集群的监控web页面
