## 下划线转驼峰引发的惨案
1. 不配置全局下划线转驼峰，在xml文件中自定义映射关系，如下图：
   
   ![[Alt text](image.png)](https://qn.mayu1024.com/mybatis%E5%9D%91/%E8%87%AA%E5%AE%9A%E4%B9%89%E6%98%A0%E5%B0%84.jpg)

2. 不用自定义映射关系，在application.xml文件中要增加全局配置:
   ```
    mybatis:
      mapper-locations: classpath:mapper/**/*Mapper.xml
      configuration:
        map-underscore-to-camel-case: true
   ```   
   
3. 在mybatis-plus中，默认开启了下滑线-驼峰转换；此时要注意，Java实体类就不能存在带下划线的字段，因为数据表的字段映射不到该对象字段！即使用了@TableField()注解去指定映射关系，也不行！此时则需要关闭驼峰转化，去自定义映射关系。
   
    ```
    <!-- 在mybatis-plus中，默认开启了下滑线-驼峰转换，所以此处不用resultMap，而用resultType也是对的 -->
    <select id="listAll" resultType="com.company.app.model.po.IntentionTagConfig">
        SELECT
        <include refid="Base_Column_List" />
        FROM intention_tag_config WHERE delete_flag = 0
    </select>
    
    ```

   ```
   mybatis-plus:
     configuration:
       map-underscore-to-camel-case: false
   ```

4. tk.mybatis也会默认将实体类中驼峰式命名的字段转换为_再进行映射(即camelhump的方式)