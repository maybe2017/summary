## 登录虚拟机后 node1
systemctl status mysqld
### hdfs一键启动(hdfs、)
cd /export/server/hadoop/sbin
start-dfs.sh

### hive元数据服务
cd /export/server/hive
`nohup bin/hive --service metastore >> logs/metastore.log 2>&1 &` 
### hive hiveserver2服务
`nohup bin/hive --service hiveserver2 >> logs/hiveserver2.log 2>&1 &` 