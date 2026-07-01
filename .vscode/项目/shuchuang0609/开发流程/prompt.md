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


### 测试环境
我前后端打包发布到测试环境后，在值班值守->信息接报->创建值班事件->AI生成事件描述这条链路中，AI生成前端渲染的时候却没有流式渲染的效果，但是本地环境是有的，这可能是什么原因，我要怎么排查？

2069372320476119042

eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3ODI4NzAwNTgsInVzZXJuYW1lIjoiYWRtaW4ifQ.zvVkSg3kxGMV0ljdMoNKGw13jz-eW1wa3Z8bTbJ5KqI


echo "=== B. 同机 HTTPS 10.1.53.77 ==="
curl -sSNk --no-buffer \
  -H "X-Access-Token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3ODI4ODI0NjYsInVzZXJuYW1lIjoiYWRtaW4ifQ.v8fID2HP1fSEjw2h1wFuTVMNXbMn40Ice03wmIJRecI" \
  -H "Accept: text/event-stream" \
  "https://10.1.53.77:9030/dyh/lbzb/report/reportInfoRecord/aiInfo/eventDescription/stream?id=2069372320476119042" \
  2>/dev/null | while IFS= read -r line; do
    echo "$(date +%H:%M:%S.%3N) $line"
  done | head -30


# 走https =》不正常的流式返回，内容集中在1s左右
curl -sSNk --no-buffer \
  -H "Accept: text/event-stream" \
  "https://10.1.53.77:9030/dyh/lbzb/report/reportInfoRecord/aiInfo/eventDescription/stream?id=2071883071203917825" \
| while IFS= read -r line; do
    echo "$(date +%H:%M:%S) $line"
  done

# 跳过https =》正常的流式返回
curl -sSN --no-buffer \
  -H "Accept: text/event-stream" \
  "http://10.1.53.77:8080/dyh/lbzb/report/reportInfoRecord/aiInfo/eventDescription/stream?id=2071883071203917825" \
| while IFS= read -r line; do echo "$(date +%H:%M:%S.%3N) $line"; done


### 从发起请求到第一条 data: 等了多久：【若 TTFB_SEC ≈ 3 秒，而后面 0.33 秒收完 → 等整段 + 瞬间下发，就是网关缓冲】

start=$(date +%s.%3N)
curl -sSNk --no-buffer \
  -H "Accept: text/event-stream" \
  "https://10.1.53.77:9030/dyh/lbzb/report/reportInfoRecord/aiInfo/eventDescription/stream?id=2071883071203917825" \
| while IFS= read -r line; do
    now=$(date +%s.%3N)
    case "$line" in
      data:*)
        echo "TTFB_SEC=$(echo "$now - $start" | bc) FIRST=$now"
        echo "$line"
        break
        ;;
    esac
  done



# A. 直连后端（绕过 Nginx）—— 判断后端/Dify 是否正常流式
docker exec -it app-front sh
cat /etc/nginx/conf.d/default.conf   # 按上面修改
nginx -t && nginx -s reload

### 正式环境
正式环境中，值班值守->签收信息，角标存在数值，但是列表行中却没有红色背景填充的行，就是说是角标数量和红色背景数量对不上； 可能是什么问题，我要怎么排查？


区县「签收信息」里，角标表示 还有几条没签收；红行却只在 待抄告核实（isVerify=1） 时出现。
常见业务路径：
信息下发到区县 → status=0，isVerify=0 → 进角标，不标红
市级发起抄告核实 → isVerify=1 → 角标仍在，开始标红
区县签收 → status 变为已签收 → 角标减 1
所以：角标有数、无红行 = 有未签收项，但还没有待核实项，在当前代码下是「符合实现、不符合直觉」的行为

SELECT
  SUM(CASE WHEN a.status = '0' THEN 1 ELSE 0 END) AS badge_count,
  SUM(CASE WHEN a.is_verify = 1 THEN 1 ELSE 0 END) AS red_row_count,
  SUM(CASE WHEN a.status = '0' AND IFNULL(a.is_verify,0) != 1 THEN 1 ELSE 0 END) AS badge_only_no_red
FROM town_report_info_dept_rel a
WHERE a.is_deleted = 0
  AND a.org_code = 'A01A03A02A06A07A01'
  AND a.distribute_type IN (1, 2);
	
	
	SELECT
  a.id,
  a.report_info_id,
  a.status,
  a.is_verify,
  a.distribute_type,
  a.create_time,
  a.update_time
FROM town_report_info_dept_rel a
WHERE a.is_deleted = 0
  AND a.org_code = 'A01A03A02A06A07A01'
  AND a.status = '0'
  AND a.distribute_type IN (1, 2)
  AND IFNULL(a.is_verify, 0) != 1;
	
SELECT
  id,
  record_type,
  content,
  record_content,
  create_org_code,
  create_time
FROM town_report_info_record
WHERE report_info_id = 2053291023123165186
  AND is_deleted = 0
ORDER BY create_time DESC;
（值班值守->签收信息链路中，签收信息未读角标数与列表未核实数量不一致问题）


#### 角标数与红色背景行呈现逻辑
1. 区县「签收信息」里，角标 = 未签收，红行 = 待核实；
2. 区县「签收信息」列表中，需要点击信息详情，才会同时把 消息状态改为 "已签收"、"已核实"。
3. 上报信息模块中点详情 → 只核实、不签收 【这里导致了问题】

#### 复现问题步骤
1. 龙泉驿区龙泉街道值班室上报信息，上报给龙泉驿区值班室，区值班室对该条信息进行抄告核实，并指定核实部门为龙泉街道值班室；
2. 街道值班室在上报信息模块下的列表中，点击刚才上报的消息并进入详情。（这里仅会将消息状态改为"已核实"，不会改签收状态）
   => 导致出现问题：在「签收信息」列表中，不再出现红色背景行，但是角标数还在。

#### 问题链路
1. 龙泉驿区龙泉街道值班室上报信息，上报给龙泉驿区值班室，区值班室对该条信息进行抄告核实，并指定核实部门为龙泉街道值班室；
2. 街道值班室在上报信息模块下的列表中，点击刚才上报的消息并进入详情。（这里仅会将消息状态改为"已核实"，不会改签收状态）
   => 导致出现问题：在「签收信息」列表中，不再出现红色背景行，但是角标数还在。
#### 
我考虑这样改，用户在上报信息模块下的列表中点击进入详情，将消息状态改为"已核实"的时候，查一下是否在签收信息也存在（这里是不是用消息id关联？），如果存在，就把对应的签收信息状态改为已签收，这样就可以保持数据一致了。你先梳理下逻辑，看看这样改是否有问题，会影响其他链路吗？ 

为保留字段与字段值的映射关系，我把sql语句的查询结果在navicat中复制为了insert语句，希望你能理解。
第一条sql的查询结果：
INSERT INTO `zbzs`.`report_dept` (`id`, `org_code`, `event_info_id`, `create_time`) VALUES (2059424378478735361, 'A01A01A02', 2059456563860606976, '2026-05-27 08:00:09');

第二条sql的查询结果：
INSERT INTO `zbzs`.`report_info_record` (`id`, `record_type`, `create_org_code`, `create_by`, `create_time`) VALUES (2059822501902495745, '2', 'A01A03A02A09', '1539799646900142082', '2026-05-28 10:22:09');
INSERT INTO `zbzs`.`report_info_record` (`id`, `record_type`, `create_org_code`, `create_by`, `create_time`) VALUES (2059604210919485441, '2', 'A01A03A02A09', '1539799646900142082', '2026-05-27 19:54:44');
INSERT INTO `zbzs`.`report_info_record` (`id`, `record_type`, `create_org_code`, `create_by`, `create_time`) VALUES (2059556260914737153, '2', 'A01A06A02A13', '1537450414184677377', '2026-05-27 16:44:12');
INSERT INTO `zbzs`.`report_info_record` (`id`, `record_type`, `create_org_code`, `create_by`, `create_time`) VALUES (2059522309298925569, '2', 'A01A03A02A09', '1539799646900142082', '2026-05-27 14:29:17');
INSERT INTO `zbzs`.`report_info_record` (`id`, `record_type`, `create_org_code`, `create_by`, `create_time`) VALUES (2059502062500130818, '2', 'A01A03A02A09', '1539799646900142082', '2026-05-27 13:08:50');
INSERT INTO `zbzs`.`report_info_record` (`id`, `record_type`, `create_org_code`, `create_by`, `create_time`) VALUES (2059485504063221761, '2', 'A01A03A02A09', '1539799646900142082', '2026-05-27 12:03:02');
INSERT INTO `zbzs`.`report_info_record` (`id`, `record_type`, `create_org_code`, `create_by`, `create_time`) VALUES (2059458865157713922, '2', 'A01A06A02A23', '1539147378328682498', '2026-05-27 10:17:11');
INSERT INTO `zbzs`.`report_info_record` (`id`, `record_type`, `create_org_code`, `create_by`, `create_time`) VALUES (2059453452890746881, '2', 'A01A06A02A20', '1537628077083934722', '2026-05-27 09:55:41');
INSERT INTO `zbzs`.`report_info_record` (`id`, `record_type`, `create_org_code`, `create_by`, `create_time`) VALUES (2059451486261293058, '2', 'A01A03A02A09', '1539799646900142082', '2026-05-27 09:47:52');
INSERT INTO `zbzs`.`report_info_record` (`id`, `record_type`, `create_org_code`, `create_by`, `create_time`) VALUES (2059446732978204673, '2', 'A01A06A02A23', '1539147378328682498', '2026-05-27 09:28:58');
INSERT INTO `zbzs`.`report_info_record` (`id`, `record_type`, `create_org_code`, `create_by`, `create_time`) VALUES (2059434563519721474, '2', 'A01A06A02A14', '1537450668443385858', '2026-05-27 08:40:37');
INSERT INTO `zbzs`.`report_info_record` (`id`, `record_type`, `create_org_code`, `create_by`, `create_time`) VALUES (2059429381075447810, '2', 'A01A03A02A09', '1539799646900142082', '2026-05-27 08:20:01');
INSERT INTO `zbzs`.`report_info_record` (`id`, `record_type`, `create_org_code`, `create_by`, `create_time`) VALUES (2059426852539281410, '2', 'A01A02A02', '1537651666596216834', '2026-05-27 08:09:59');

第三条sql的查询结果：
INSERT INTO `` (`bad_cnt`) VALUES (84);

