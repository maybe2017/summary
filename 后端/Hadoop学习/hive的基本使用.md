## 是什么
1. 数据仓库 - 用于离线数据分析 - 只适合导入查询。
2. 将存储在hdfs上的文件(结构化、半结构化)映射为一张数据库表，并提供了HQL查询语言用于访问与分析。
3. hive会将HQL转为MapReduce程序。
4. 表数据文件存储形式: `${hive.metastore.warehouse.dir}/xxx.db/t_xxx/分区目录/按字段值取hash分桶到多个文件`

## 数据存储、及元数据
1. 数据(表数据文件)都是存储在hdfs上的, 默认有一个根目录, 在`hive-site.xml`中, 由参数`hive.metastore.warehouse.dir`，默认值为`/user/hive/warehouse`
2. 但是`表相关的元数据`(hive创建的database、table、字段类型等元信息) 是存储在`关系型数据库`如Mysql中的
3. 元数据服务Metastore专为 管理metadata元数据，对外暴露服务地址，让各种客户端通过该服务去连接 msyql，而不是直接访问

## 部署（主要模式）
1. 依赖于hadoop集群，需要hdfs存储集群先启动，hive是单机部署的，底层是mapReduce分散-聚合的模式(分布式计算组件)
2. 一般采用远程模式安装: 部署mysql来存储元数据，而非hive内置的durby。
3. 最重要是访问 mysql元数据时，所有客户端都要通过统一一个入口 `metaStore服务`, 这个服务采用thrift协议与客户端通信，需要在hive.site.xml配置后，单独启动。

## 数据导入及查询
1. 通过load data [local] inpath `xxx` into table xxx partition(day=20231116); 加载数据到指定的分区表
2. select * from table xxx 查询出的列，包含数据文件中的非分区列，以及分区目录的分区列


## 分区表
1. hive存在问题：hive里面没有索引机制，每次查询的时候，hive会暴力扫描整张表。
2. 分区表的本质就是分目录，按照业务需求，把数据分成多个目录存储，然后查询的时候就可以通过`where条件指定`对应的分区   
3. 分区后，表t_xxx路径: `${hive.metastore.warehouse.dir}/t_xxx/day=20231116/`, 其中`day=20231116`文件夹就表示一个分区(分区列=分区值)
4. 创建语法
   ```
    // 用日期字段day进行分区(一级分区)，创建分区表
    // 在分区表中，分区字段属于分区表的一个伪列，数据里面并没有记录这列的值，分区字段的值体现在分区目录名上面。
    create table dept_partition(deptno int, dname string, loc string) partitioned by (day string)
    row format delimited fields terminated by '\t';

    // 创建二级分区表
    create table student_partition2(id int,name string,age int) partitioned by (month string, day string)
    row format delimited fields terminated by '\t';
   ```
5. 分隔符
   ```
   // 表示字段之间的分隔符为制表符(一般基本类型只需要这个)
    fields terminated by '\t'
   // 集合元素之间用-分割
   collection items terminated by '-';
   // kv之间用:分割
   map keys terminated by ':';
   ```   
6. 查询语法
   ```
    // 查看分区表有多少分区
    show partitions dept_partition;

    // 在单分区表中查询(注意`union`默认和distinct一样，会去除重复行；`union all`会保留)
    select * from dept_partition where day = '20200401';
    // 在多个分区表中查询
    select * from dept_partition where day = '20200401' union select * from dept_partition where day='20200402';
    // 存在
    select * from dept_partition where day = '20200401' or day = '20200402';;
   ```
7. 


## DML
1. 表名、列名不区分大小写; 用业务字段进行分区
2. 基础查询
    ```
    select count(1) from tableName;


    ```
3. 支持正则查询
   ```
    set hive.support.quoted.identifiers = none; // 反引号不再解析为其他含义 被解析为正则表达式
    select `^c.*` from tableName;

   ```

   ```  
## 排序
1. order by全局排序，那么只能有一个reduceTask执行，结果输出在一个文件中(底层使用mapReduce引擎执行)。那么如果输出的行数过多，全局排序会很慢。
2. distribute by: 根据指定字段将数据分组，算法是hash散列； sort by是在分组之后，在每个组内进行局部排序。
3. 分区排序cluster by (distribute by + sort by的结合)，但是前提是: 分区字段和排序字段是同一个的时候，才可以替换。并且排序只能是升序。
   ```
    select * from emp distribute by deptno sort by deptno;
    // 上面的sql可以简写成下面的
    select * from emp cluster by deptno;
## group与having
1. having是在分组后对数据进行过滤，where是在分组前
2. having可以使用聚合函数，where不可以