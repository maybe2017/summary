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
2. 页大小 `page_size`，在达梦中，页大小默认是8k，如果数据库中表存在较多大字段，建议设置成16k或者32k，否则导入数据时会报错;
3. MYSQL建表默认的字符编码是 `UTF8_GENERAL_CI`，迁移到达梦端将大小写不敏感参数 `CASE_SENSITIVE` 设置成0；
4. 在 `dm.ini` 中将COMPATIBLE_MODE参数设置成4，表示兼容mysql；
5. 在 `dm.ini` 中将CALC_AS_DECIMAL修改为1，表示整数相除保留小数


### 四、迁移前提
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
### 五、迁移过程
1. https://blog.csdn.net/qq961573863/article/details/141725290
2. https://blog.csdn.net/qq_42563471/article/details/133671704?utm_medium=distribute.pc_relevant.none-task-blog-2~default~baidujs_baidulandingword~default-0-133671704-blog-137150953.235^v43^pc_blog_bottom_relevance_base4&spm=1001.2101.3001.4242.1&utm_relevant_index=3
3. 迁移时候注意勾选 `保持对象大小写` 不然的话，迁移过去之后查询的字段全都是大写；

### 六、一些DM数据库基本信息查询命令
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