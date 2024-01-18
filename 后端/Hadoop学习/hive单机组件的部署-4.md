### 为什么是单机部署？
1. hive基于mapReduce模式运行，会把hql转为mapReduce程序
2. 虽然是单机工具，但是可以提交分布式运行的mapReduce程序

### 部署
1. hive本体及元数据服务均安装到一个节点即可，node1
2. hive的运行依赖于hadoop(hdfs、yarn、mapreduce)【重要!】
3. hive的元数据管理服务需要依赖mysql，所以得给hive一个mysql驱动jar

### mysql部署（root用户安装）
1. 更新密钥: `rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022`
2. 安装Mysql yum库: `rpm -Uvh http://repo.mysql.com//mysql57-community-release-el7-7.noarch.rpm`
3. yum安装Mysql: `yum -y install mysql-community-server`
4. 启动Mysql设置开机启动: `systemctl start mysqld`, `systemctl enable mysqld`
5. 检查Mysql服务状态: `systemctl status mysqld`
6. 第一次启动mysql，会在日志文件【/var/log/mysqld.log】中生成root用户的一个随机密码，使用下面命令查看该密码: `grep 'temporary password' /var/log/mysqld.log` 
7. 修改root用户密码: `mysql -u root -p -h localhost` => `ALTER USER 'root'@'localhost' IDENTIFIED BY '811903'`;
 
8. 如果你想设置简单密码，需要降低Mysql的密码安全级别
    ```
    set global validate_password_policy=LOW; # 密码安全级别低
    set global validate_password_length=4;	 # 密码长度最低4位即可
    ```

9. 然后就可以用简单密码了（课程中使用简单密码，为了方便，生产中不要这样）
    ```
    ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
    /usr/bin/mysqladmin -u root password 'root'

    // 授权root用户从任意主机远程登录 并设置密码811903
    grant all privileges on *.* to root@"%" identified by '811903' with grant option;
    // 刷新权限  
    flush privileges;
    ```
### hive相关的配置文件修改【配置后需要重启hdfs集群!!】（hadoop用户）
1. vim core-site.xml (需要分发到其他node节点), 允许hadoop这个用户代理任何主机、任何组
   ```
    <property>
        <name>hadoop.proxyuser.hadoop.hosts</name>
        <value>*</value>
    </property>
        <property>
        <name>hadoop.proxyuser.hadoop.groups</name>
        <value>*</value>
    </property>

    scp /export/server/hadoop/etc/hadoop/core-site.xml node2:`pwd`/
    scp /export/server/hadoop/etc/hadoop/core-site.xml node3:`pwd`/
   ```
2. 解压hive包，创建软链接hive   
3. /hive/lib下放入mysql的驱动jar，`cp mysql-connector-java-5.1.34.jar ./hive/lib/`
4. vim hive-env.sh
   ```
    export HADOOP_HOME=/export/server/hadoop
    export HIVE_CONF_DIR=/export/server/hive/conf
    export HIVE_AUX_JARS_PATH=/export/server/hive/lib

   ```
5. vim hive-site.xml, 会自动创建`hive`这个存储元数据的数据库
   ```
    <configuration>
        <property>
            <name>javax.jdo.option.ConnectionURL</name>
            <value>jdbc:mysql://node1:3306/hive?createDatabaseIfNotExist=true&useSSL=false&useUnicode=true&characterEncoding=UTF-8</value>
        </property>
        <property>
            <name>javax.jdo.option.ConnectionDriverName</name>
            <value>com.mysql.jdbc.Driver</value>
        </property>
        <property>
            <name>javax.jdo.option.ConnectionUserName</name>
            <value>root</value>
        </property>
        <property>
            <name>javax.jdo.option.ConnectionPassword</name>
            <value>811903</value>
        </property>
        <property>
            <name>hive.server2.thrift.bind.host</name>
            <value>node1</value>
        </property>
        <property>
            <name>hive.metastore.uris</name>
            <value>thrift://node1:9083</value>
        </property>
        <property>
            <name>hive.metastore.event.db.notification.api.auth</name>
            <value>false</value>
        </property>
    </configuration>

   ```   
2. 注意点，xml里面不能直接认识&，需要将数据库地址中的 & 符号调整为 &amp;【重要】  
3. 重启hdfs集群! 不然没权限连接! `/export/server/hadoop/sbin/stop.sh` `/export/server/hadoop/sbin/start.sh `
  
### 初始化元数据库，并启动元数据服务 （hadoop用户）
1. cd /export/server/hive/bin, `./cd schematool -initSchema -dbType mysql -verbos`
2. 登录mysql，进入hive库检查存储元数据的表是否生成了, 没有则需要 CREATE DATABASE hive CHARSET UTF8;
3. 在/export/server/hive下，`mkdir logs`,
4. 后台启动元数据服务 `nohup /export/server/hive/bin/hive --service metastore >> logs/metastore.log 2>&1 &` 
5. 后台启动hiveserver2服务 `nohup /export/server/hive/bin/hive --service hiveserver2 >> logs/hiveserver2.log 2>&1 &` 

### 客户端
1. hive shell方式(可以直接写sql): 直接执行 `sh /export/server/hive/bin/hive` 命令行(此方式不用输入密码，直接连上就用)
2. beeline客户端，先执行 `sh /export/server/hive/bin/beeline`，再执行 `!!connect jdbc:hive2://ip地址:10000[/test]`, 会要求输入账号密码，账号就用hadoop，密码忽略。(该客户端是先连接到hiveServer2 服务)
3. hiveServer2方式: 是内置的一个基于thrift协议的thriftServer服务，提供thrift协议的端口用来供其他客户端链接。
4. 在启动hiveserver2服务的基础上，可以使用第三方的工具如`DataGrip`进行hive的连接与操作
