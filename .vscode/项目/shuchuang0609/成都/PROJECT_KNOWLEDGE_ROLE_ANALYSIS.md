# 项目认知沉淀：角色、部门、菜单与职责分析

最后更新：2026-06-24

## 1. 这份文档的用途

这份文档是为后续前后端需求开发准备的项目认知沉淀，重点回答四个问题：

- 系统里“谁”是通过哪套数据模型定义的
- 不同角色大致“能做什么”
- 这些角色分别属于哪些组织层级
- 后续开发时，哪些权限边界和历史包袱需要特别注意

## 2. 本次分析依据

### 2.1 代码依据

- 前端登录后菜单来源：
  - [dyh-lbzbzllzxt-front/src/store/modules/user.js](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/store/modules/user.js:167)
- 旧值班表“我的值班”查询逻辑：
  - [dyh-lbzbzllzxt-api/jeecg-boot-module-system/src/main/java/org/jeecg/modules/cn/dyh/dsystem/controller/DyhDutyController.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-system/src/main/java/org/jeecg/modules/cn/dyh/dsystem/controller/DyhDutyController.java:259)
- 旧值班表实体：
  - [DyhDuty.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-system/src/main/java/org/jeecg/modules/cn/dyh/dsystem/entity/DyhDuty.java:25)
- 旧业务角色实体：
  - [DyhRole.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-system/src/main/java/org/jeecg/modules/cn/dyh/dsystem/entity/DyhRole.java:23)

### 2.2 数据依据

本次直接连接本地 Docker 开发环境中的 `zbzs` 数据库，对以下表做了交叉分析：

- 主权限体系：
  - `sys_user`
  - `sys_depart`
  - `sys_role`
  - `sys_permission`
  - `sys_user_role`
  - `sys_role_permission`
  - `sys_user_depart`
- 旧值班体系：
  - `dyh_user`
  - `dyh_role`
  - `dyh_user_role`
  - `dyh_system`
  - `dyh_duty`
  - `dyh_business_duty`
  - `dyh_management_units`

## 3. 核心结论

## 3.1 当前主用的是 `sys_*` 权限体系

系统真实在用的人岗与菜单权限，主要由 Jeecg 标准权限表控制：

- 用户：`sys_user`
- 部门：`sys_depart`
- 角色：`sys_role`
- 菜单/按钮权限：`sys_permission`
- 用户角色关系：`sys_user_role`
- 角色菜单关系：`sys_role_permission`

前端登录后也是直接读取后端返回的 `menu` 列表构建界面菜单，因此后续新需求如果涉及：

- 某类人能否看到一个页面
- 某个按钮是否可操作
- 某个角色是否能进入某个业务模块

默认应先看 `sys_role -> sys_role_permission -> sys_permission` 这条链，而不是先看 `dyh_*`。

## 3.2 `dyh_*` 更像早期或局部保留模型

`dyh_role` 里只有很少几类业务角色：

- `领导`
- `指挥长`
- `值班长`
- `xxx`

`dyh_duty` 也不是通过用户 ID 关联，而是直接存姓名字段：

- `sld`
- `zhz`
- `zbz`

`getMyDuty` 也是拿登录人 `realname` 去匹配这三个字段。

这说明 `dyh_*` 更像一套偏早期、偏静态的值班排班模型，仍有功能保留，但不是整个平台权限设计的主轴。

## 3.3 这个系统本质上是一个多层级值班值守协同平台

从角色、部门、菜单看，平台覆盖了以下组织层级：

- 市领导层
- 市委/市政府总值班室
- 市级委办局
- 区县总值班室
- 街道/镇级值班室
- 市属国企值班岗
- 城运中心专项人员
- 系统管理员/平台支撑人员

它不是单一部门内部系统，而是一个多组织协同的值班、接报、上报、审核、批示、报告与排班平台。

## 4. 角色体系拆解

下面这部分是后续做需求时最有用的内容。

## 4.1 平台治理层

### 管理员 `admin`

角色特征：

- 平台级全局权限
- 可见菜单最多
- 负责系统和业务基础配置

主要可做的事：

- 用户、部门、角色、菜单管理
- 值班管理基础配置
- 值班表管理、报告模板管理
- 信息上报、信息接报、事件审核、事件批示
- 流程、任务、定时任务、字典、公告
- 市级/区县城运排班

开发提示：

- 后续做后台管理、配置类、字典类需求，默认需要考虑管理员权限路径。
- 不要把管理员路径误当成普通业务用户路径。

## 4.2 决策与批示层

### 市领导 `sld`

角色特征：

- 权限很少
- 高度聚焦于“看事件、下批示”

主要可做的事：

- 事件批示

典型人员分布：

- 市政府领导
- 市政府副秘书长
- 市政府办公厅领导
- 市政府办公厅秘书处工作人员
- 少量涉疫信息领导

职责判断：

- 这是决策层，不做具体接报录入，不做系统配置，不承担基层流转操作。

开发提示：

- 面向该角色做需求时，界面应尽量简洁，偏查阅、批示、确认，而非复杂表单。

## 4.3 市级总值班室主链路

### 市政府总值班室领导 `test02`

主要可做的事：

- 信息上报
- 信息接报
- 上报审核
- 交办跟踪
- 事件批示
- 值班台账
- 值班报告
- 领导批示信息
- 外出报备
- 公文校对

职责判断：

- 属于业务审核与统筹层，负责把关、推进和调度。

### 市政府总值班室带班干部 `test03`

主要可做的事：

- 信息接报
- 上报审核
- 交办跟踪
- 值班台账
- 值班报告
- 领导批示信息
- 交接班记录
- 外出报备

职责判断：

- 偏班次管理和过程协调，是总值班室的一线管理岗。

### 市政府总值班室工作人员 `test04`

主要可做的事：

- 信息上报、接报、签收
- 上报事件、跟踪事件
- 上报审核、事件批示
- 文件交换
- 值班台账、值班考核、值班报告
- 城运日报模板、填报、查阅
- 相关部门维护
- 临时分组、申请记录、公文校对

职责判断：

- 这是最典型的一线业务承办岗。
- 如果说谁在系统里“真正干活最多”，这一组就是核心人群之一。

## 4.4 市委总值班室主链路

### 市委总值班室领导 `test05`

主要可做的事：

- 信息接报
- 上报审核
- 跟踪事件
- 领导批示信息
- 值班台账
- 市两办排班
- 区县城运排班
- 用户、菜单、部门、角色等部分管理功能

职责判断：

- 属于市委侧的业务统筹层，且带有一定平台治理权限。

### 市委总值班室带班干部 `test06`

主要可做的事：

- 信息接报
- 上报审核
- 值班台账
- 值班考核
- 值班报告
- 文件交换
- 城运日报查阅

职责判断：

- 和市政府带班干部相似，偏执行管理与班次协同。

### 市委总值班室工作人员 `test07`

主要可做的事：

- 信息上报、接报
- 交办跟踪
- 上报事件、跟踪事件
- 上报审核、事件批示
- 文件交换
- 批示抄清台账
- 城运日报模板/查阅
- 值班考核、值班报告
- 市级城运排班
- 临时分组、公文校对

职责判断：

- 这是市委侧的核心承办岗。

## 4.5 横向协同单位

### 市各委办局 `test08`

用户规模：

- 78 人，是当前数据里人数最多的实用角色之一

典型部门：

- 市公安局
- 市卫健委
- 市应急局
- 市交通运输局
- 市水务局
- 市消防队
- 市市场监管局
- 市教育局
- 市发改委
- 市城市运行和政务服务管理办公室

主要可做的事：

- 信息上报
- 排班管理
- 文件交换
- 应急指挥
- 信息签收
- 领导外出报备

职责判断：

- 属于条线单位协同报送岗。
- 他们通常不是总值班室的审核方，而是信息提供方、协同单位和本单位值班维护方。

## 4.6 区县与街道层

### 区总值班室工作人员 `test09`

用户规模：

- 71 人

典型部门：

- 高新区总值班室
- 武侯区总值班室
- 成华区总值班室
- 崇州市总值班室
- 双流区总值班室
- 龙泉驿区总值班室
- 新都区总值班室

主要可做的事：

- 信息上报
- 上报信息
- 接报信息
- 信息签收
- 排班管理
- 文件交换/资料交换
- 领导外出报备
- 公文校对

职责判断：

- 这是区县层级的一线值守承办岗。
- 负责本区域的信息报送、签收、协同流转和基础排班。

### 街道总值班室工作人员 `test10`

主要可做的事：

- 上报信息
- 签收信息
- 排班管理
- 资料交换
- 公文校对

职责判断：

- 相比区县层更基层，功能更收敛，偏执行和回传。

### 部门总值班室(街道) `2`

主要可做的事：

- 上报信息
- 签收信息
- 排班管理
- 资料交换
- 公文校对

职责判断：

- 本质上和街道层类似，服务于基层部门值守体系。

## 4.7 国企线

### 市属国企 `ssgq`

主要可做的事：

- 信息上报
- 排班管理
- 应急指挥
- 信息签收
- 抄清抄告
- 公文校对

### 国企总值班室工作人员 `3`

主要可做的事：

- 上报信息
- 签收信息
- 排班管理
- 资料交换
- 公文校对

职责判断：

- 国企也被纳入这套值班协同体系，和区县/街道层有些类似，但主体换成国企组织。

## 4.8 专项岗位

### 信息接报人 `receiv_report`

主要可做的事：

- 信息接报

职责判断：

- 这是极窄权限的专岗，负责接收信息，不负责更广的流转链路。

### 区县城运排班工作人员 `qxcy`

主要可做的事：

- 区县城运排班

职责判断：

- 专用排班账号，只负责城运排班，不负责主业务流。

### 城运中心工作人员 `cyzx`

主要可做的事：

- 文件交换
- 临时分组

职责判断：

- 更像平台协同支撑岗或专项业务岗。

## 5. 菜单视角下的业务主链路

从 `sys_permission` 菜单结构看，平台的核心业务不是单点功能，而是一条连续链路：

1. 信息上报
2. 信息接报
3. 信息签收
4. 上报审核
5. 交办跟踪
6. 事件批示
7. 领导批示信息
8. 值班台账
9. 值班报告 / 每日值班综报 / 城运日报
10. 文件交换 / 资料交换
11. 市级 / 区县城运排班

这意味着后续需求设计时，最好把模块理解成同一条业务链的不同节点，而不是完全孤立的菜单页面。

## 6. 当前数据里的组织分层

这套系统的数据分布非常清楚地体现出组织层级：

- 决策层：市领导、市政府领导、副秘书长、办公厅领导
- 中枢值班层：市委总值班室、市政府总值班室
- 横向协同层：市各委办局、市属国企
- 区域承办层：区县总值班室
- 基层执行层：街道、镇、基层部门值班室
- 专项支撑层：城运中心、排班专用账号、接报专岗

## 7. 对后续开发最有用的判断

## 7.1 权限开发优先从 `sys_*` 设计

如果后续要新增：

- 菜单
- 页面
- 按钮权限
- 角色可见范围

默认应走：

- `sys_permission`
- `sys_role_permission`
- `sys_user_role`

不要优先依赖 `dyh_role` 这类旧业务表来做新的功能授权。

## 7.2 业务查询要注意“角色即组织层级”

这个项目里角色不只是权限标签，很多时候直接代表组织层级：

- 市领导
- 市委/市政府总值班室
- 市各委办局
- 区县总值班室
- 街道总值班室

所以做列表、统计、流程流转时，经常不能只看“用户”，还要结合：

- 角色
- 部门
- 所属层级

## 7.3 相同菜单在不同角色上代表不同语义

例如：

- “信息上报”对市级委办局，可能是报送入口
- 对总值班室工作人员，可能同时兼具补录、汇总、审核前整理意义
- 对区县/街道，可能是本级上报入口

所以后续需求如果写“某页面给某类人加个字段”，一定要先确认这页面是不是多角色共用页。

## 7.4 旧值班体系改造要格外谨慎

`dyh_duty` 直接按姓名存 `sld/zhz/zbz`，这意味着：

- 改名会影响历史匹配
- 同名人员可能有歧义
- 和 `sys_user.id` 没有稳定外键关系

如果以后要做值班排班增强、人员替换、历史追溯、统计归属，建议逐步评估是否要把姓名字段升级为用户 ID 绑定。

## 8. 一个便于记忆的总图

可以把这个项目粗略记成：

- `管理员` 维护平台
- `市领导` 看事件和批示
- `市委/市政府总值班室领导` 做统筹把关
- `带班干部` 做班次管理和过程推进
- `工作人员` 做接报、审核、流转、台账、报告
- `委办局/区县/街道/国企` 做本单位上报、签收、协同和排班
- `专项账号` 做接报或排班等单点工作

## 9. 后续建议

后续如果继续在该项目上开发，建议优先再沉淀三份知识：

1. 页面菜单到前端组件路径的映射表
2. 核心业务表之间的关系图，尤其是 `report_*`、`event_*`、`inform_*`
3. 各角色对应的接口访问边界和数据过滤规则

这样后面做需求时，基本就能形成一套稳定的项目认知底座，而不是每次重新从菜单和表里摸索。

## 10. 开发索引：菜单 -> 前端页面 -> 后端入口

这一节的目标不是穷举所有页面，而是先把后续开发最常碰到的主业务链串起来。

### 10.1 权限菜单加载入口

- 前端权限菜单加载：
  - [dyh-lbzbzllzxt-front/src/store/modules/user.js](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/store/modules/user.js:162)
- 接口：
  - `/sys/permission/getUserPermissionByToken`
- 作用：
  - 登录后返回 `menu/auth/allAuth`
  - 前端基于 `menu` 决定用户可见页面

开发提示：

- 新页面如果要进入菜单体系，核心还是要加 `sys_permission` 记录。
- 仅仅新增前端路由或页面文件，不会自动出现在业务菜单里。

### 10.2 信息上报

- 菜单：
  - `/information/report`
- 前端页面：
  - [ReportInfoList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/info/ReportInfoList.vue)
- 后端控制器：
  - [ReportInfoController.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-operation/src/main/java/org/jeecg/operation/controller/ReportInfoController.java:45)
- 控制器根路径：
  - `/report/reportInfo`
- 常见接口：
  - `/list`
  - `/add`
  - `/detail`
  - `/addInfo`
  - `/delivery`
  - `/deptOptions`
  - `/getFiles`
  - `/closeInfo`
- 核心表：
  - `report_info`
  - `report_dept`
  - `report_info_dept_rel`
  - `report_info_file`
  - `report_info_record`

职责说明：

- 这是市级信息上报主入口。
- 不只是“填报”，也承接续报、交办跟踪、信息关闭、附件查看等操作。

### 10.3 街道/下级上报

- 菜单：
  - `/information/reportStreet`
- 前端页面：
  - [ReportStreet.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/info/ReportStreet.vue)
- 后端控制器：
  - [ReportInfoStreetController.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-operation/src/main/java/org/jeecg/operation/controller/ReportInfoStreetController.java:42)
- 控制器根路径：
  - `/report/reportInfoStreet`
- 常见接口：
  - `/getReportOrg`
  - `/addOne`
  - `/list`
  - `/lowerList`
  - `/detail`
  - `/infoDetail`
  - `/delivery`
  - `/closeInfo`
  - `/report`
  - `/getFiles`
- 核心表：
  - `report_info_street`
  - `report_info_street_file`

职责说明：

- 这是街道/基层向上报送的入口。
- 同时支持“下级上报 -> 转市级上报”的桥接。

### 10.4 信息接报

- 菜单：
  - `/information/receive`
- 前端页面：
  - [ReportReceiveList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/info/ReportReceiveList.vue)
- 实际后端主入口：
  - 仍主要落在 [ReportInfoController.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-operation/src/main/java/org/jeecg/operation/controller/ReportInfoController.java:45)
- 相关能力接口：
  - `/report/reportInfo/list`
  - `/report/reportInfo/detail`
  - `/report/reportInfo/link`
  - `/report/reportInfo/deptOptions`
  - `/report/reportInfo/waitHandleCount`
  - `/report/reportInfo/delivery`

职责说明：

- “信息接报”在业务上是独立环节，但数据底座仍然主要围绕 `report_*` 表。
- 它和“上报信息”不是两套完全独立的数据模型。

### 10.5 信息签收

- 菜单：
  - `/information/reportSignList`
  - `/information/ReportSignListStreet`
- 前端页面：
  - [ReportSignList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/info/ReportSignList.vue)
  - [ReportSignListStreet.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/info/ReportSignListStreet.vue)
- 数据关联：
  - 仍主要依赖 `report_dept`、`report_info_dept_rel`、街道上报相关表

职责说明：

- 签收更像报送链路上的状态节点，不是一套独立主数据。

### 10.6 交办跟踪

- 菜单：
  - `/information/traceEvent`
- 前端页面：
  - [TraceEvent.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/info/TraceEvent.vue)
- 关联后端：
  - `ReportInfoController.delivery(...)`
  - 事件侧 service / mapper
- 关联表：
  - `report_event_continue_info`
  - `report_event_continue_person`

职责说明：

- 它是“报送信息处理后继续推进”的链路节点。

### 10.7 上报事件

- 菜单：
  - `/event/EventInfoList`
- 前端页面：
  - [EventInfoList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/event/EventInfoList.vue)
- 后端控制器：
  - [EventInfoController.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-operation/src/main/java/org/jeecg/operation/controller/EventInfoController.java:42)
- 控制器根路径：
  - `/report/eventInfo`
- 典型业务：
  - 事件列表
  - 批示传达
  - 分类转换
  - 标签查询
  - 应急小程序列表/时间轴
- 核心表：
  - `event_info`
  - `event_info_file`
  - `event_audit_record`
  - `event_instruction`
  - `event_tag`
  - `event_tags_res`

职责说明：

- 这是从“信息”提升到“事件”的核心域模型。
- 事件链路比信息链路更偏研判、审核、批示、跟踪。

### 10.8 跟踪事件

- 菜单：
  - `/event/TrackEventInfoList`
- 前端页面：
  - [TrackEventInfoList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/event/TrackEventInfoList.vue)
- 后端主域：
  - `EventInfoController`
  - `EventInfoServiceImpl`

职责说明：

- 这部分通常是已入库事件的持续跟进，不是首次接报。

### 10.9 上报审核

- 菜单：
  - `/event/EventAuditList`
- 前端页面：
  - [EventAuditList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/event/EventAuditList.vue)
- 核心表：
  - `event_audit_record`
  - `event_audit_person`
  - `event_audit_count`

职责说明：

- 审核是事件链路的重要控制点。
- 前端通知角标里也会专门统计这类待办。

### 10.10 事件批示

- 菜单：
  - `/event/EventInstructionList`
- 前端页面：
  - [EventInstructionList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/event/EventInstructionList.vue)
- 主要后端域：
  - `EventInfoController.addPs / beforePs / updatePs`
  - `EventInstructionServiceImpl`
- 核心表：
  - `event_instruction`
  - `instruction_audit_*`
  - `instruction_distr_record`

职责说明：

- 这是领导批示、传达批示、抄清抄告的关键入口。

### 10.11 文件交换

- 菜单：
  - `/filesChange`
- 前端页面：
  - [file_exchange_recordList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/filesChange/file_exchange_recordList.vue)
- 后端控制器：
  - [FileExchangeRecordController.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-operation/src/main/java/org/jeecg/operation/controller/FileExchangeRecordController.java:35)
- 控制器根路径：
  - `/operation/fileExchange`
- 常见接口：
  - `/list`
  - `/add`
  - `/rollBack`
  - `/queryById`
- 核心表：
  - `file_exchange_record`
  - `file_record`
  - `file_record_org_rel`

职责说明：

- 这是跨部门文件交换主通道。
- 使用了 Redis 缓存和未读提醒机制。

### 10.12 资料交换（镇街）

- 菜单：
  - `/town/filesChange`
- 前端页面：
  - [townFileChange.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/filesChange/townFileChange.vue)
- 后端控制器：
  - `TownFileExchangeRecordController`
- 核心表：
  - `town_file_exchange_record`
  - `town_file_record`
  - `town_file_record_org_rel`

职责说明：

- 这是镇街/区县线的资料交换支线，和市级文件交换类似，但表结构单独分开。

### 10.13 值班管理

- 菜单：
  - `/duty/DutyManagement`
- 前端页面：
  - [DutyManagementCard.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/duty/DutyManagement/DutyManagementCard.vue)
- 后端控制器：
  - [DutyRosterController.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-operation/src/main/java/org/jeecg/duty/controller/DutyRosterController.java:29)
- 控制器根路径：
  - `/duty/dutyRoster`
- 常见接口：
  - `/list`
  - `/add`
  - `/queryById`
  - `/queryByOrgCode`
  - `/downLoad`
  - `/downLoadTp`
  - `/importExcel`
- 核心表：
  - `duty_roster`
  - `duty_roster_user_rel`

职责说明：

- 这是现行值班排班主功能之一，不等同于旧 `dyh_duty`。

### 10.14 市两办排班

- 菜单：
  - `/duty/leaderDuty`
- 前端页面：
  - [LeaderDutyCard.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/duty/leaderDuty/LeaderDutyCard.vue)
- 后端控制器：
  - `LeaderDutyController`
- 核心表：
  - `leader_duty`
  - `leader_duty_user_rel`

职责说明：

- 偏市领导/两办排班域，是比普通值班管理更高层的一类排班。

### 10.15 区县城运排班

- 菜单：
  - `/duty/workingScheduleCounty/workingScheduleCounty`
- 前端页面：
  - [workingScheduleCounty.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/duty/workingScheduleCounty/workingScheduleCounty.vue)
- 后端主域：
  - `CountyRosterController`
  - `CountyRosterServiceImpl`
- 核心表：
  - `county_roster`
  - `county_roster_user_rel`

职责说明：

- 专门给区县城运排班岗使用。

### 10.16 市级城运排班

- 菜单：
  - `/duty/workingSchedule/workingSchedule`
- 前端页面：
  - [workingSchedule.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/duty/workingSchedule/workingSchedule.vue)
- 后端主域：
  - `CityDutyController`
  - `CityDutyServiceImpl`

职责说明：

- 服务市级城运排班。

### 10.17 值班报告

- 菜单：
  - `/duty/report`
- 前端页面：
  - [dutyReport.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/duty/report/dutyReport.vue)
- 后端控制器：
  - [DutyReportController.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-operation/src/main/java/org/jeecg/duty/controller/DutyReportController.java:22)
- 控制器根路径：
  - `/duty/dutyReport`
- 常见接口：
  - `/list`
  - `/dailyReport`
  - `/save`
  - `/download`
  - `/eventOptions`
- 核心表：
  - `duty_report`

职责说明：

- 这是值班报告生成、保存、下载的主要入口。

### 10.18 每日值班综报

- 菜单：
  - `/duty/EveryDayReport`
- 前端页面：
  - [EveryDayList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/duty/EveryDayReport/EveryDayList.vue)
- 后端主域：
  - `EveryReportController`
  - `EveryReportServiceImpl`
- 核心表：
  - `every_report`
  - `every_report_user`

职责说明：

- 更像值班综报/日报汇总域，和普通值班报告不同。

### 10.19 相关部门

- 菜单：
  - `/dept/RelevantDepartList`
- 前端页面：
  - [RelevantDepartList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/dept/RelevantDepartList.vue)
- 后端控制器：
  - [RelevantDepartController.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-operation/src/main/java/org/jeecg/operation/controller/RelevantDepartController.java:28)
- 控制器根路径：
  - `/relevantDepart`
- 核心表：
  - `dept_org_code_rel`
  - 关联 `sys_depart`

职责说明：

- 用来维护“部门之间谁跟谁相关”的协同关系，后续可能影响交办、关联推送、通知对象等。

### 10.20 公文校对

- 菜单：
  - `/cyDaily/officia`
- 前端页面：
  - [Officia.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/cyDaily/officia/Officia.vue)
- 后端代码线索：
  - `OfficialDataUtil`
  - `LoginController` 中有调用

职责说明：

- 看起来更像一个专项工具页，和日常值班/事件域并行存在。

## 11. 核心业务表关系速记

这一节先给后续开发一个够用的“脑内地图”。

### 11.1 信息报送域

- 主信息：`report_info`
- 信息接收/分发对象：`report_dept`
- 信息与部门分发关系：`report_info_dept_rel`
- 信息附件：`report_info_file`
- 信息续报/过程记录：`report_info_record`
- 街道上报：`report_info_street`
- 街道附件：`report_info_street_file`

可以理解为：

- `report_info` 是市级信息主表
- `report_dept` / `report_info_dept_rel` 负责“发给谁、谁签收、谁处理”
- `report_info_record` 负责过程追踪
- `report_info_street` 是基层上报分支

### 11.2 事件域

- 主事件：`event_info`
- 事件附件：`event_info_file`
- 事件审核：`event_audit_record`
- 审核人/审核统计：`event_audit_person` / `event_audit_count`
- 事件批示：`event_instruction`
- 事件标签：`event_tag` / `event_tags_res`

可以理解为：

- 信息经过处理后，会上升为事件
- 事件比信息更强调审核、批示、标签、跟踪

### 11.3 文件交换域

- 市级文件交换：
  - `file_exchange_record`
  - `file_record`
  - `file_record_org_rel`
- 镇街文件交换：
  - `town_file_exchange_record`
  - `town_file_record`
  - `town_file_record_org_rel`

### 11.4 排班和值班域

- 普通值班排班：
  - `duty_roster`
  - `duty_roster_user_rel`
- 市级城运排班：
  - `city_duty`
  - `city_duty_user_rel`
- 区县排班：
  - `county_roster`
  - `county_roster_user_rel`
- 市两办/领导排班：
  - `leader_duty`
  - `leader_duty_user_rel`
- 值班报告：
  - `duty_report`
- 每日综报：
  - `every_report`
  - `every_report_user`
- 旧排班模型：
  - `dyh_duty`
  - `dyh_role`
  - `dyh_user`
  - `dyh_user_role`

开发提示：

- 现行业务排班应优先看 `duty_* / city_* / county_* / leader_*`
- 不要先入为主把 `dyh_duty` 当成现在唯一的排班真相
