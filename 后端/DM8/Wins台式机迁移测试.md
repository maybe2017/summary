
### 借鉴
1. 迁移过程：https://blog.csdn.net/qq961573863/article/details/141725290
2. 可能的坑：https://www.cnblogs.com/SuperChaos/p/17480196.html
3. 常见问题：https://www.modb.pro/db/34527

### 迁移过程（重点）
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
### 迁移过程中报错
1. 索引问题
    ```
    [WARN] 2024-09-19 15:57:36.351> [TASK]{table-"sqt_m_hubei.sqt_semantic_group_label"}@CREATE_INDEX:[TASK]{table-"sqt_m_hubei.sqt_semantic_group_label"}@CREATE_INDEX:RUNNING:SUBOBJ=idx_database_code 可能名称重复，重新生成一个名字再创建一次
    ```
2. 数据问题    
    ```
    1. t_uap_grantauth_log，列[remark]长度超出定义
    2. sqt_record，不支持分区表语法？
    ```

### TODO
1. 索引重复时，会被dm重新用随机数命名，建议索引名称用 `表名_idx_字段名`
2. 需要对现在的所有非 主键 索引 重命名； `表名_索引名`
3. 修改修改 GROUP_OPT_FLAG=1支持mysql的group by语法，需要重启数据库服务生效


### 项目代码层面的改动
1. pom中mysql驱动的替换
    ```
    <!--达梦数据库驱动-->
    <dependency>
        <groupId>com.dameng</groupId>
        <artifactId>DmJdbcDriver18</artifactId>
        <version>8.1.1.193</version>
    </dependency>
    <!--jdbc驱动-->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-jdbc</artifactId>
    </dependency>
    ```
2. application.yml文件的更新：
    ```
    spring:
      datasource:
        username: SYSDBA  #模式名
        password: SYSDBA  #密码
        url: jdbc:dm://127.0.0.1:5236?schema=模式名&compatibleMode=mysql&zeroDateTimeBehavior=convertToNull&serverTimezone=Asia/Shanghai&useUnicode=true&characterEncoding=utf-8
        driver-class-name: dm.jdbc.driver.DmDriver
    ``` 
3. mapper文件中，表名与字段名之前都需要加上 模式名称(库名称)
3. GROUP BY
4. sqt-operate-server中有 `FIND_IN_SET` 函数的使用，dm8不支持，
5. 达梦不支持关键字 `CURRENT_TIMESTAMP`，想做到更新某条数据更新时间交由数据库维护，需要通过新建触发器来做适配


### 代码改造步骤 https://blog.csdn.net/qq_24577585/article/details/131303241
```
1. 首先处理列名是否包含关键字,对关键字转义处理
2. 批量搜索是否包含mysql特殊单引号`,批量替换为空；部分关键字必须使用双引号处理
3. 检查是否用到特殊的语法,例如 insert ignore,replace into, insert into ... on duplicate update
4. 检查mybatis中insert语句的表是否包含自增主键的插入,查库表ID字段看看值是否为雪花算法生成,这种情况需要特殊处理
5. 检查批量插入中返回自增主键的写法,useGeneratedKeys="true" keyProperty="id"中的keyProperty改为"list.id"
6. 检查是否用了group_concat
7. 检查group by的语句,是否有select的字段不在group by中,处理ONLY_FULL_GROUP_BY的问题
8. 其他函数检查,date_format(),CONVERT()函数,FIND_IN_SET函数,date_add函数,UNIX_TIMESTAMP函数,anyvalue()函数
9. 检查mybatis xml中jdbcType="OTHER"的字段对应达梦的类型,大部分需要改成longvarchar类型,否则会出现返回的类型为DmdbClob等内置类型,而且jackjson转换会出现栈溢出问题
10. 检查join,right join ,left join等语句是否缺失on作为匹配条件
11. 模式名和用户名不一样时，访问对象前面要加上模式名(mapper改造)，最好两者一样。
```