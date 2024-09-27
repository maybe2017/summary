## Mysql数据迁移

### 一、基本信息
1. DM客户端工具: https://www.dameng.com/list_103.html
2. 数据库默认端⼝：5236
3. 数据库默认端⼝用户：SYSDBA
4. 达梦数据库组成：`实例` 和 `数据库`，默认数据库⽂件存放路径：/dm8/data/DAMENG/，其中`DAMENG`是默认生成的库名；
5. 一个登录用户 对应多个模式schema，⽤户创建完成后，默认会生成⼀个同名的模式，访问自己模式下的表、视图等，不需要加模式名，访问其他模式下的对象需要拥有访问权限，访问时还需加上模式名。
6. 达梦服务器与客户端的安装，官⽅均 `不⽀持MAC操作系统`。

### 二、MySQL数据库迁移至达梦(DM8)数据库
1. 数据库迁移工具：DTS自动化数据迁移⼯具（达梦数据库官⽅提供）；
2. 建议先迁移表结构(不包含索引、约束)，再迁移表数据，最后迁移索引和约束；
3. 数据量大的表单独进行迁移；
4. 对于大字段较多的表，需要修改批量的行数，以免造成迁移工具内存溢出


### 三、DM8安装后-初始化参数设置(重要)
1. 在安装好达梦数据库后，还需要初始化 `实例` 用于对数据的管理，在初始实例时 `初始化参数 ` 尤为重要。
    ```
    // 查看当前数据库实力的初始化参数
    SELECT * FROM V$DM_INI;

    // 查看当前数据库实例的 大小写敏感 配置
    SELECT CASE_SENSITIVE;
    SELECT * FROM V$DM_INI WHERE PARA_NAME LIKE '%CASE_SENSITIVE';
    ```
2. 页大小 `PAGE_SIZE`，达梦默认是8k，如果数据库中表存在较多大字段，建议设置成16k或者32k，否则导入数据时会报错;
3. MYSQL建表默认的字符编码是 `UTF8_GENERAL_CI`，迁移到达梦端将大小写不敏感参数 `CASE_SENSITIVE` 设置成0；
    | 参数名称             |           解释 |                  默认值及建议值                   |
    | :------------------- | -------------: | :-----------------------------------------------: |
    | EXTENT_SIZE          |         簇大小 |              默认值16；建议值16或32               |
    | PAGE_SIZE            |         页大小 |               默认值8；建议值16或32               |
    | CASE_SENSITIVE       |     大小写敏感 | 默认值Y、y、1，表示敏感；建议值N、n、0 表示不敏感 |
    | CHARSET/UNICODE_FLAG |         字符集 |    默认值0，代表 GB18030；建议值1，代表 UTF-8     |
    | DB_NAME              |     数据库名称 |                   默认值DAMENG                    |
    | INSTANCE_NAME        | 数据库实例名称 |                  默认值DMSERVER                   |
    | TIME_ZONE            |           时区 |               默认为东八区(+08:00)                |

4. linux上创建新数据库示例：
    ```
    // 1. 进入bin目录
    cd dmdbms/bin

    // 2. 利用dminit工具进行初始化
    ./dminit  PATH=/data/dm8/data DB_NAME=PRODA instance_name=PRODA SYSDBA_PWD=Dameng123 PORT_NUM=5237 CASE_SENSITIVE=N PAGE_SIZE=16

    // 3. 注册服务
    cd /home/dmdba/dmdbms/script/root
    ./dm_service_installer.sh -t dmserver -p PRODA -dm_ini /data/dm8/data/PRODA/dm.ini

    // 4. 切换用户？
    su - dmdba
    cd dmdbms/bin
    ll |grep Dm

    // 5. 启动实例
    ./DmServicePRODA status
    ./DmServicePRODA start 
    ```
5. 在 `dm.ini` 中将 `COMPATIBLE_MODE` 参数设置成4，表示兼容mysql；
6. 在 `dm.ini` 中将 `CALC_AS_DECIMAL` 修改为1，表示整数相除保留小数；
7. 修改 `dm.ini` 文件后，需要重启dm数据库实例服务生效；


### 四、大小写敏感参数
1. 数据层面：设置为大小写不敏感时，库中数据查询比较时，`select * from Test where c2 = 'a';` 就能查出A和a的记录；
2. 表名、字段名层面：大小写敏感时，sql语句中如果不加上双引号""，会被默认转为大写，那么`mapper文件`中小写的表名与字段名会被自动转为大写。(双引号会固定住大小写)
    ```
    1. DM数据库在默认情况下是大小写敏感的;
    2. 大小写不敏感的情况下，对表名称加不加双引号都可以，对查询没有影响；
    3. 大小写敏感的情况下，创建表名称不建议加上双引号，因为实际存储在字典中已全部转大写了。但是如果表名称里存在小写则必须加上双引号；
    4. 在大小写敏感情况下，是严格区分大小写的，在插入存在字母大小写的数据后，查询结果不受影响；在大小写不敏感情况下，是不区分大小写的，在插入存在字母大小写的数据后查询结果会受到影响。
    5. 因此建议使用达梦数据库时候一定要选大小写敏感？
    ```
### 五、迁移前提
1. 迁移之前⼀定要先创建所迁移的 `模式对应的⽤户`（⽤户名需要与所迁移的模式相同），登录的用户要有表空间的权限；
2. 创建⽤户及表空间
    ```
    // df -h查看磁盘，在剩余空间大的目录下创建实例数据目录
    mkdir -p /data/dmdb/xzspkp5555
    chown -R dmdba:dinstall /data/dmdb/xzspkp5555
    
    // 图形化创建实例
    /data/dmdbms/tool
    ./dbca.sh
    
    // 更改兼容模式为mysql
    vi /opt/dmdb/xzspkp5555/xzspkp/dm.ini
    COMPATIBLE_MODE                 = 4               #Server compatible mode, 0:none, 1:SQL92, 2:Oracle, 3:MS SQL Server, 4:MySQL, 5:DM6, 6:Teradata, 7:PG
    
    // 重启库
    systemctl restart DmServicexzspkp.service
    
    // 创建表空间dbtest，数据文件为DBTEST.DBF。
    create tablespace "xzspkp" datafile '/opt/dmdb/xzspkp5555/xzspkp/xzspkp.DBF' size 2048 ;
    
    // 更改密码策略
    sp_set_para_value(1,'PWD_POLICY',0); 
    
    // 创建用户指定默认表空间  授予常规权限
    create user "xzspkp" identified by "xzspkp" default tablespace "xzspkp" default index tablespace "xzspkp";
    grant "PUBLIC","RESOURCE","SOI","SVI","VTI" to "xzspkp";

    ```
### 六、迁移过程（重点）
1. 参考：https://blog.csdn.net/qq961573863/article/details/141725290
2. dm.ini文件中，更新参数`COMPATIBLE_MODE=4`，更改兼容模式为mysql，需要重启dm数据库实例服务生效
3. dm的dts工具进行迁移时候注意勾选 `保持对象大小写` 不然的话，迁移过去之后查询的字段全都是大写；
4. 迁移过程中，对一部分的数据类型转换，进行自定义：
    ```
    // mysql  ->   dm8
    DECIMAL   ->   NUMBER
    LONGTEXT  ->   CLOB
    DATETIME  ->   TIMESTAMP
    VARCHAR   ->   VARCHAR2
    ```

### 七、一些DM数据库基本信息查询命令
1. 查看版本信息：`SELECT banner as 版本信息 FROM v$version;`
2. 创建普通用户、并授权：
    ```
    // 创建 DM 用户，登录密码为 "dameng123"
    CREATE USER DM IDENTIFIED BY "dameng123";

    // 使用 GRANT 语句给 DM 用户授予 RESOURCE 角色
    GRANT RESOURCE TO DM;

    // 查看用户信息
    SELECT * FROM dba_users;

    // 查看当前登录用户
    SELECT user FROM DUAL;

    // 使用 conn 命令切换到DM用户
    conn DM/dameng123;
    ```