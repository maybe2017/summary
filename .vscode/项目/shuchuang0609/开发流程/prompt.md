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
    这里需要改字典，我自己去在界面上改字典项DUTYUSERTYPE，DUTYUSERTYPEVALID的值
    ```
2. 现有功能"导出原始数据"是默认导出30天的排班数据，需要改为：在点击导出按钮后，弹出窗口支持时间选择（必填）
    ```
    // 背景
    值班人员常用操作逻辑: 会先点击'导出原始数据'导出一份空的数据，填写排班数据后，在界面上进行数据的导入。
    后端接口使用的是'/duty/dutyRoster/downLoadInMonth'，且代码逻辑里面用到excel模版文件"duty/排班管理导出模板.xlsx"
    ```
#### 需求：部门为市委市政府值班室的用户点击进入“县区城运排班”和“市级城运排班”菜单页面后，页面默认展示这两个单位对应排班数据，而非其他部门的排班数据

### 注意点
1. 前后端代码你都帮我改，如果要新生成前端页面的话，风格尽量与已有页面保持一致，组件尽量复用。如果需要执行脚本，你仅输出脚本，我自己来执行。
2. 如果你实在不能理解需求或者很模糊，你先别动代码，先向我确定。



###
1. 市级城运排班中，对某一天排班时，对于带班市领导上传照片是必须的吗？
2. 市级城运排班中，对某一天排班时，上传照片接口没有报错，但是页面却没有渲染出来图片，这是我本地环境，你能帮忙查下是什么问题吗？我看了浏览器http://localhost:8088/dyh/lbzb/oss/file/upload上传接口响应为"{"success":true,"message":"操作成功！","code":0,"result":{"key":"image/jpeg","value":"/oss-zhibanzhishou/cat.jpeg"},"timestamp":1782283432857}"

###
信息接报模块中，选择了一条信息创建值班事件，进入编辑窗口，对'事件描述'字段，目前是可以点击右下角的AI生成按钮来自动填充内容的(实际上是调用dify的接口)，但目前是由前端代码调用生成接口，为避免后续可能的网络跨域等问题，现在想要改为生成接口由后端代码调用，但是前端渲染的时候还是需要按这种流式渲染，你先分析下先告诉我怎么做，不要先修改代码；有问题可以问我

请求地址：https://10.1.248.17/v1/chat-messages

app-kvHUbbdwq8RRzQzyGPmBdZZj


curl -X POST 'http://10.1.248.17/v1/chat-messages' \
--header 'Authorization: Bearer app-kvHUbbdwq8RRzQzyGPmBdZZj' \
--header 'Content-Type: application/json' \
--data-raw '{
    "inputs": {},
    "query": "What are the specs of the iPhone 13 Pro Max?",
    "response_mode": "streaming",
    "conversation_id": "",
    "user": "abc-123",
    "files": [
      {
        "type": "image",
        "transfer_method": "remote_url",
        "url": "https://cloud.dify.ai/logo/logo-site.png"
      }
    ]
}'

1. 你查下是否可能存在如下问题：点击AI生成前端请求报错或阻塞的情况下(网络问题（失败）net::ERR_CERT_AUTHORITY_INVALID或者dify接口问题导致没有内容去填充'事件描述'字段)，输入框上方有个组件一直在转圈，关闭掉整个编辑窗口后，重新选择另一条消息进行值班事件的创建时，输入框上方仍然还有个组件一直在转圈

把 DIFY_CHAT_MESSAGES_URL 与 DEFAULT_INFO_DIFY_API_KEY 这两个变量放在java代码中是不是有点不合适，你能给出建议吗，怎么处理合适呢？放在字典里面吗？现在已有的字典数据中是否有可以配置dify地址的配置呢？



