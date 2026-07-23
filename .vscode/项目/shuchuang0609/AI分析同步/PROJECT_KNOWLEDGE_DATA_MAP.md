# 项目认知沉淀：核心数据域与代码映射

最后更新：2026-06-24

## 1. 文档目的

这份文档专门服务后续开发，回答三个问题：

- 主要业务数据分成哪几个域
- 每个域的核心表有哪些
- 每个域大致由哪些前端页面、控制器、ServiceImpl、Mapper 承接

和角色分析文档的区别是：

- 角色分析文档偏“谁做什么”
- 本文偏“数据和代码落在哪里”

## 2. 项目核心业务域总览

这个项目大致可以拆成 6 个主要业务域：

1. 权限与组织域
2. 信息报送域
3. 事件处置域
4. 文件交换域
5. 值班排班与报告域
6. 旧 `dyh_*` 值班模型域

---

## 3. 权限与组织域

### 3.1 核心表

- `sys_user`
- `sys_depart`
- `sys_role`
- `sys_permission`
- `sys_user_role`
- `sys_role_permission`
- `sys_user_depart`

### 3.2 作用

- 定义登录用户
- 定义部门树
- 定义角色
- 定义菜单、页面、按钮权限
- 定义用户与角色、角色与权限的关系

### 3.3 关键代码

- 菜单权限加载：
  - [dyh-lbzbzllzxt-front/src/store/modules/user.js](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/store/modules/user.js:162)
- 用户看到什么菜单，主要由：
  - `/sys/permission/getUserPermissionByToken`

### 3.4 开发要点

- 新增菜单、按钮权限、页面准入，优先操作这组表和相应后台权限逻辑。
- 绝大多数“看不到页面/能不能操作”的问题，先查这组表。

---

## 4. 信息报送域

### 4.1 核心表

- `report_info`
- `report_dept`
- `report_info_dept_rel`
- `report_info_file`
- `report_info_record`
- `report_event_continue_info`
- `report_event_continue_person`
- `report_info_street`
- `report_info_street_file`

### 4.2 直觉理解

- `report_info`：一条上报信息的主记录
- `report_dept`：这条信息涉及到哪些承办/接收对象
- `report_info_dept_rel`：信息与部门的处理关系
- `report_info_file`：信息附件
- `report_info_record`：信息续报、过程记录、时间轴
- `report_info_street`：街道/下级上报分支
- `report_info_street_file`：下级上报附件

### 4.3 主要前端页面

- [ReportInfoList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/info/ReportInfoList.vue)
- [ReportReceiveList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/info/ReportReceiveList.vue)
- [ReportSignList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/info/ReportSignList.vue)
- [TraceEvent.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/info/TraceEvent.vue)
- [ReportStreet.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/info/ReportStreet.vue)
- [ReportReceiveListStreet.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/info/ReportReceiveListStreet.vue)
- [ReportSignListStreet.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/info/ReportSignListStreet.vue)

### 4.4 主要控制器

- [ReportInfoController.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-operation/src/main/java/org/jeecg/operation/controller/ReportInfoController.java:45)
- [ReportInfoStreetController.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-operation/src/main/java/org/jeecg/operation/controller/ReportInfoStreetController.java:42)
- [ReportInfoFileController.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-operation/src/main/java/org/jeecg/operation/controller/ReportInfoFileController.java)
- [ReportInfoRecordController.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-operation/src/main/java/org/jeecg/operation/controller/ReportInfoRecordController.java)

### 4.5 主要 ServiceImpl

- `ReportInfoServiceImpl`
- `ReportInfoFileServiceImpl`
- `ReportInfoRecordServiceImpl`
- `ReportInfoStreetServiceImpl`
- `ReportInfoStreetFileServiceImpl`
- `ReportEventContinueInfoServiceImpl`
- `ReportEventContinuePersonServiceImpl`

### 4.6 主要 Mapper

- `ReportInfoMapper.xml`
- `ReportDeptMapper.xml`
- `ReportInfoDeptRelMapper.xml`
- `ReportInfoFileMapper.xml`
- `ReportInfoRecordMapper.xml`
- `ReportInfoStreetMapper.xml`
- `ReportInfoStreetFileMapper.xml`
- `ReportEventContinueInfoMapper.xml`
- `ReportEventContinuePersonMapper.xml`

### 4.7 开发要点

- “信息上报”“信息接报”“信息签收”不是三套完全分离的数据，它们共享同一信息主域。
- 很多状态变化其实落在关系表或过程表里，不一定是主表字段变化。

---

## 5. 事件处置域

### 5.1 核心表

- `event_info`
- `event_info_file`
- `event_audit_record`
- `event_audit_person`
- `event_audit_count`
- `event_instruction`
- `event_tag`
- `event_tags_res`
- `event_district`

### 5.2 直觉理解

- `event_info`：进入事件处置域后的主事件
- `event_audit_record`：审核过程记录
- `event_audit_person`：审核人维度
- `event_audit_count`：审核统计
- `event_instruction`：领导批示/指令
- `event_tag` / `event_tags_res`：事件标签及其关系
- `event_district`：事件所属区域、区域映射等

### 5.3 主要前端页面

- [EventInfoList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/event/EventInfoList.vue)
- [TrackEventInfoList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/event/TrackEventInfoList.vue)
- [EventAuditList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/event/EventAuditList.vue)
- [EventInstructionList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/event/EventInstructionList.vue)

### 5.4 主要控制器

- [EventInfoController.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-operation/src/main/java/org/jeecg/operation/controller/EventInfoController.java:42)
- [EventInfoFileController.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-operation/src/main/java/org/jeecg/operation/controller/EventInfoFileController.java)
- [InstructionAuditRecordController.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-operation/src/main/java/org/jeecg/operation/controller/InstructionAuditRecordController.java)
- [InstructionDistrRecordController.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-operation/src/main/java/org/jeecg/operation/controller/InstructionDistrRecordController.java)
- [EventDistrictController.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-operation/src/main/java/org/jeecg/operation/controller/EventDistrictController.java)

### 5.5 主要 ServiceImpl

- `EventInfoServiceImpl`
- `EventInfoFileServiceImpl`
- `EventInstructionServiceImpl`
- `EventAuditRecordServiceImpl`
- `EventAuditPersonServiceImpl`
- `EventAuditCountServiceImpl`
- `EventDistrictServiceImpl`

### 5.6 主要 Mapper

- `EventInfoMapper.xml`
- `EventInfoFileMapper.xml`
- `EventInstructionMapper.xml`
- `EventAuditRecordMapper.xml`
- `EventAuditPersonMapper.xml`
- `EventAuditCountMapper.xml`
- `EventDistrictMapper.xml`

### 5.7 开发要点

- 事件域往往承接信息域的升级结果，所以很多需求会横跨 `report_*` 和 `event_*`。
- 做“时间轴”“批示传达”“审核流”时，别只盯一个表。

---

## 6. 文件交换域

### 6.1 市级文件交换核心表

- `file_exchange_record`
- `file_record`
- `file_record_org_rel`

### 6.2 镇街文件交换核心表

- `town_file_exchange_record`
- `town_file_record`
- `town_file_record_org_rel`

### 6.3 主要前端页面

- [file_exchange_recordList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/filesChange/file_exchange_recordList.vue)
- [townFileChange.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/filesChange/townFileChange.vue)

### 6.4 主要控制器

- [FileExchangeRecordController.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-operation/src/main/java/org/jeecg/operation/controller/FileExchangeRecordController.java:35)
- [TownFileExchangeRecordController.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-operation/src/main/java/org/jeecg/operation/controller/TownFileExchangeRecordController.java)

### 6.5 主要 ServiceImpl

- `FileExchangeRecordServiceImpl`
- `TownFileExchangeRecordServiceImpl`
- `FileRecordServiceImpl`
- `FileRecordOrgRelServiceImpl`
- `TownFileRecordServiceImpl`
- `TownFileRecordOrgRelServiceImpl`

### 6.6 主要 Mapper

- `FileExchangeRecordMapper.xml`
- `FileRecordMapper.xml`
- `FileRecordOrgRelMapper.xml`
- `TownFileExchangeRecordMapper.xml`
- `TownFileRecordMapper.xml`
- `TownFileRecordOrgRelMapper.xml`

### 6.7 开发要点

- 文件交换是少数明确用了 Redis 缓存与未读提醒的域。
- 做列表、未读数、撤回等需求时，别忘了缓存失效和消息提醒联动。

---

## 7. 值班排班与报告域

这一域实际又分成几条支线。

### 7.1 普通值班排班

核心表：

- `duty_roster`
- `duty_roster_user_rel`

前端页面：

- [DutyManagementCard.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/duty/DutyManagement/DutyManagementCard.vue)
- [shiftScheduling.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/duty/DutyManagement/shiftScheduling.vue)

控制器：

- [DutyRosterController.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-operation/src/main/java/org/jeecg/duty/controller/DutyRosterController.java:29)

代码主线：

- `DutyRosterServiceImpl`
- `DutyRosterMapper.xml`
- `DutyRosterUserRelServiceImpl`
- `DutyRosterUserRelMapper.xml`

### 7.2 市级城运排班

核心表：

- `city_duty`
- `city_duty_user_rel`

前端页面：

- [workingSchedule.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/duty/workingSchedule/workingSchedule.vue)

控制器/服务：

- `CityDutyController`
- `CityDutyServiceImpl`
- `CityDutyMapper.xml`
- `CityDutyUserRelServiceImpl`
- `CityDutyUserRelMapper.xml`

### 7.3 区县城运排班

核心表：

- `county_roster`
- `county_roster_user_rel`

前端页面：

- [workingScheduleCounty.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/duty/workingScheduleCounty/workingScheduleCounty.vue)

控制器/服务：

- `CountyRosterController`
- `CountyRosterServiceImpl`
- `CountyRosterMapper.xml`
- `CountyRosterUserRelServiceImpl`
- `CountyRosterUserRelMapper.xml`

### 7.4 市两办/领导排班

核心表：

- `leader_duty`
- `leader_duty_user_rel`
- `leader_roster`
- `leader_roster_user_rel`

前端页面：

- [LeaderDutyCard.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/duty/leaderDuty/LeaderDutyCard.vue)
- [leaderWorkforce.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/duty/leaderWorkforce/leaderWorkforce.vue)

控制器/服务：

- `LeaderDutyController`
- `LeaderDutyServiceImpl`
- `LeaderDutyMapper.xml`
- `LeaderDutyUserRelServiceImpl`
- `LeaderRosterController`
- `LeaderRosterServiceImpl`
- `LeaderRosterMapper.xml`

### 7.5 值班报告与综报

核心表：

- `duty_report`
- `every_report`
- `every_report_user`

前端页面：

- [dutyReport.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/duty/report/dutyReport.vue)
- [EveryDayList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/duty/EveryDayReport/EveryDayList.vue)

控制器/服务：

- [DutyReportController.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-operation/src/main/java/org/jeecg/duty/controller/DutyReportController.java:22)
- `DutyReportServiceImpl`
- `DutyReportMapper.xml`
- `EveryReportController`
- `EveryReportServiceImpl`
- `EveryReportMapper.xml`

### 7.6 台账、交接班、考核、外出报备

相关页面：

- [StandingBookList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/duty/StandingBook/StandingBookList.vue)
- [ShiftRecordList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/duty/ShiftRecord/ShiftRecordList.vue)
- [SpotCheckRecordList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/duty/dutyCheck/SpotCheckRecordList.vue)
- [FilingRecordList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/duty/FilingRecord/FilingRecordList.vue)
- [instructionAccountList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/duty/instructionAccountList/instructionAccountList.vue)

代码主线：

- `StandingBookController` / `StandingBookServiceImpl` / `StandingBookMapper.xml`
- `DutyCheckController` / `DutyCheckServiceImpl`
- `InstructionAccountController` / `InstructionAccountServiceImpl` / `InstructionAccountMapper.xml`

### 7.7 开发要点

- “排班”不是一张表管全系统，而是多条线并存。
- 提需求时要先确认是：
  - 普通值班排班
  - 市级城运排班
  - 区县排班
  - 市两办/领导排班

---

## 8. 相关部门与协同关系域

### 8.1 核心表

- `dept_org_code_rel`
- 关联 `sys_depart`

### 8.2 页面与控制器

- [RelevantDepartList.vue](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-front/src/views/modules/dept/RelevantDepartList.vue)
- [RelevantDepartController.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-operation/src/main/java/org/jeecg/operation/controller/RelevantDepartController.java:28)
- `RelevantDepartServiceImpl`
- `RelevantDepartMapper.xml`

### 8.3 开发要点

- 这部分可能影响关联部门推荐、通知对象范围、交办对象筛选。
- 不是简单的字典表，属于协同关系配置。

---

## 9. 旧 `dyh_*` 值班模型域

### 9.1 核心表

- `dyh_user`
- `dyh_role`
- `dyh_user_role`
- `dyh_system`
- `dyh_duty`
- `dyh_business_duty`
- `dyh_management_units`

### 9.2 现状判断

- 这套表仍然有代码和页面，但更像早期/局部保留模型。
- 当前主权限和主菜单准入并不依赖它。
- `dyh_duty` 直接按姓名字段存 `sld/zhz/zbz`，不够稳定。

### 9.3 相关代码

- [DyhDutyController.java](/Users/mayu/Documents/workspace/chengdu_zb/dyh-lbzbzllzxt-api/jeecg-boot-module-system/src/main/java/org/jeecg/modules/cn/dyh/dsystem/controller/DyhDutyController.java)
- `DyhDutyServiceImpl`
- `DyhDutyMapper.xml`

### 9.4 开发要点

- 新需求不要默认落在 `dyh_*` 上。
- 如果必须改这套模型，先确认它是否只是历史兼容功能。

---

## 10. 一句话记忆法

如果后面要快速判断一个需求该去哪里找代码，可以先这样想：

- 和“谁能看到什么”有关：先看 `sys_*`
- 和“信息报送/接报/签收”有关：先看 `report_*`
- 和“事件审核/批示/跟踪”有关：先看 `event_*`
- 和“资料传递”有关：先看 `file_*` 或 `town_file_*`
- 和“排班/值班报告”有关：先看 `duty_* / city_* / county_* / leader_*`
- 和“老排班页”有关：再考虑 `dyh_*`
