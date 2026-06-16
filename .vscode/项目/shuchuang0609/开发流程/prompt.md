

### 注意点
1. 如果需要的话，你可以连接本机环境的数据库及redis服务，但是仅给你读权限，如果需要写的话，你输出脚本即可。
    ```
    // mysql
    本机是docker启动的一个mysql容器服务，ip地址：127.0.0.1，密码：rootroot
    # Datasource Configuration
    spring.sharding-sphere.datasource.names=master
    spring.sharding-sphere.datasource.master.url=jdbc:mysql://127.0.0.1:3306/zbzs_bz?characterEncoding=UTF-8&useUnicode=true&useSSL=false&allowPublicKeyRetrieval=true
    spring.sharding-sphere.datasource.master.username=root
    spring.sharding-sphere.datasource.master.password=rootroot
    spring.sharding-sphere.datasource.master.driver-class-name=com.mysql.cj.jdbc.Driver
    spring.sharding-sphere.datasource.master.type=com.alibaba.druid.pool.DruidDataSource
    ```
2. 前后端代码你都帮我改，如果要新生成前端页面的话，风格尽量与已有页面保持一致，组件尽量复用。如果需要执行脚本，你仅输出脚本，我自己来执行。
3. 如果你实在不能理解需求或者很模糊，你先别动代码，先向我确定。

### 新需求

#### 首页
1. 首页上方4卡片数据统计均调整为以信息中的"事发时间"（事件中应该也记录了信息的事发时间）进行统计
    ```
    // 已知
    首页4卡片的数据均来自接口"/statistics/attention"，展示字段值与接口响应字段对应如下：
    接报信息数量: todayInfoCount
    上报事件数量: submitEventCount
    跟踪事件数量: trackEventCount
    完结事件数量: endEventCount
    ```
2. 首页中事件类型饼图统计，改为信息类型饼图统计，统计的数据来源改为"信息接报"表。
    ```
    // 已知
    首页事件类型饼图统计的接口是"/statistics/eventType",
    ```    

#### 值班室排班模块
1. 统一所有单位的值班带班人员类型为：驻守主要领导、带班领导、县级值班领导、值班领导、值班员。
    ```
    这是是不是意味着之前的需求'在值班室排班，带班领导改为驻守领导，二级带班领导改为二级值班领导'的修改需要回滚？
    这里需要改字典，我自己去在界面上改字典项DUTYUSERTYPE，DUTYUSERTYPEVALID的值
    ```
2. 现有功能"导出原始数据"是默认导出30天的排班数据，需要改为：在点击导出按钮后，弹出窗口支持时间选择（必填）
    ```
    // 背景
    值班人员常用操作逻辑: 会先点击'导出原始数据'导出一份空的数据，填写排班数据后，在界面上进行数据的导入。
    后端接口使用的是'/duty/dutyRoster/downLoadInMonth'，且代码逻辑里面用到了导出excel模版文件"duty/排班管理导出模板.xlsx"
    你不方便直接在原始逻辑上修改的话，可以重新写一个接口，如果需要修改模版内容，你可以直接生成一个新模版，或者告诉我怎么去改

    ```
#### 政策文件模块

1. 在值班管理菜单下新增`政策文件`子菜单新开页面，菜单页面仅对权限拥有'市委市政府总值班室'的用户开放，页面中支持文件上传，上传后列表中展示文件名称、上传时间、操作，操作支持删除、下载。在首页，上方右侧'用户反馈'按钮之前增加一个'政策文件'按钮，所有用户都有权限点击，弹出窗口，展示最近一周内文件列表(文件名称)，并支持点击文件名称进行预览，和下载操作。文件支持excel、word、pdf格式。    



#### 问题
#### 需求：值班室排班页面，报省表导出功能更新
1. 导出弹出窗口中，角色选择默认全选，目前没有自动勾选'驻守主要领导';
2. 部门选择多选后，需要支持在结果框内拖拽移动已选择组织部门的顺序，导出excel中的组织部门顺序会按该顺序来。
3. 你参考新的样例文件，在后端项目路径dyh-lbzbzllzxt-api/jeecg-boot-module-operation/src/main/resources/duty/报省表导出模版样例.xlsx，如果可以，你可以基于此样例文件，生成一个报省表导出文件模版,你后续可以使用，当然你也可以不使用模版；现在最新需求是生成一个excel，而不是之前的word格式了。
    ```
    // 注意点
    导出时，选择的角色中是否包含有'驻守主要领导'角色，如果有，导出的excel中，不要忘记添加'驻守主要领导'角色的数据展示；
    如果真实排班数据中，没有导出时选择的角色，excel中保留该角色，排班数据为空即可。
    
    ```

#### 排班原始数据导出模板问题
#### TODO 每7天为一个组
1. 导出数据中，
2. 如果选择的时间范围超过7天，第二个7天的数据，不要再横着放，相当于放在第一个7天数据的下方，相当于横着最多放置7天的数据，你懂我意思吧？


#### 需求：部门为市委市政府值班室的用户点击进入“县区城运排班”和“市级城运排班”菜单页面后，页面默认展示这两个单位对应排班数据，而非其他部门的排班数据

### 注意点
1. 如果需要的话，你可以连接本机环境的数据库及redis服务，但是仅给你读权限，如果需要写的话，你输出脚本即可。
    ```
    // mysql
    本机是docker启动的一个mysql容器服务，ip地址：127.0.0.1，密码：rootroot
    # Datasource Configuration
    spring.sharding-sphere.datasource.names=master
    spring.sharding-sphere.datasource.master.url=jdbc:mysql://127.0.0.1:3306/zbzs_bz?characterEncoding=UTF-8&useUnicode=true&useSSL=false&allowPublicKeyRetrieval=true
    spring.sharding-sphere.datasource.master.username=root
    spring.sharding-sphere.datasource.master.password=rootroot
    spring.sharding-sphere.datasource.master.driver-class-name=com.mysql.cj.jdbc.Driver
    spring.sharding-sphere.datasource.master.type=com.alibaba.druid.pool.DruidDataSource
    ```
2. 前后端代码你都帮我改，如果要新生成前端页面的话，风格尽量与已有页面保持一致，组件尽量复用。如果需要执行脚本，你仅输出脚本，我自己来执行。
3. 如果你实在不能理解需求或者很模糊，你先别动代码，先向我确定。


1. 我已经在字典GOV_DUTY_ROOM中添加上了'市委市政府总值班室:A01A02A52'，你用名称'市委市政府值班室'过滤就行，因为编码随环境是可变的，本地环境和线上真实环境不一致。
2. 进入「市级城运排班」→ 默认展示名称为'市城运中心'的排班数据。
3. 进入「县区城运排班」→ 默认展示第一个县区子机构的排班数据即可。