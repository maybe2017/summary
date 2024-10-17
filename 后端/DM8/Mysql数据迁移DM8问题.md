## 遇到的问题
https://www.cnblogs.com/SuperChaos/p/17480196.html

### 一、乱码问题
1. 不要用工具提供的默认驱动；
2. 迁移工具为Mysql指定驱动时，使用自定义url：
    ```
    // 追加:&characterEncoding=UTF-8
    jdbc:mysql://127.0.0.1:3306/user?tinyInt1isBit=false&transformedBit1sBoolean=false&characterEncoding=UTF-8

    // 自定义URL 官方示例：
    驱动路径：mysql-connector-java-8.0.11.jar
    驱动类名：com.mysql.cj.jdbc.Driver
    URL：jdbc:mysql://localhost:3306/<database_name>?characterEncoding=utf8&useSSL=false&serverTimezone=UTC&rewriteBatchedStatements=true
    ```
### 二、char类型会自动空格补齐问题（重要：影响业务）
1. DM8的 `CHAR类型` 如果设置了长度，但是插入时的值没有达到设置的长度，那就会在末尾补空格，直到达到设置的长度
1. 在DTS工具进行迁移时，需要手动指定类型映射，Mysql中的 `char`类型 映射为 DM8中的 `varchar2`类型；（推荐）
2. 生成批量修改char为varchar2，新的VARCHAR2长度为原来char的长度，然后手动执行这些语句就可以；
    ```
    // 生成指定用户下，所有表中的CHAR类型列 修改为VARCHAR2类型的语句
    select 'alter table '||a.TABLE_NAME||' modify '||a.COLUMN_NAME||' VARCHAR2('||data_length||');'
    from all_tab_columns a where a.data_type='CHAR' AND OWNER='用户名';

    ```
3. 通过rtrim函数把数据右边的空格清除掉：`update 表名 set 列名1=rtrim(列名1);`
### 三、Group by 问题
1. MySQL在未开启严格模式下，允许group by模式下可以允许查询中group by 子句中不包含所有查询列，而达梦数据库默认是不可以的，如果之前的SQL语句写的不是很规范的话，这里会带来很多修改工作量。
2. 达梦数据库在开启MySQL兼容模式后可以达到同样效果：`配置文件dm.ini中找到COMPATIBLE_MODE参数修改为4`；


### 三、数据类型映射
1. 在Mysql中 `decimal` 与DM中的 `DEC` 对应；`decimal(6, 3)` 对应 `DEC(6, 3)`。
2. 在Mysql中 `varchar(300)` 与DM中的 `varchar(900)`对应。[utf-8编码：一个汉字三个字节]
3. 在Mysql中 `bigint(20)` 与DM中的 `bigint(19)` 对应。
4. 在Mysql中 `smallint(6)` 与DM中的 `smallint(5)` 对应。

### 四、DM数据类型与Mysql的差别
1. DM8中的 `varchar(N)`，这里的N是指字节数，而不是像Mysql一样，N为字符数。
2. DM8中的 `VARCHAR、VARCHAR2` 都是用来存储变长字符串的数据类型，推荐使用 `VARCHAR2`；
3. 从MySQL迁移到DM8，应当将所有的 `VARCHAR` 替换为 `VARCHAR2`;                     