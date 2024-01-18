show databases ;
use mayu;
show tables ;
desc ods_sop_call_gdsw_hdh_d;
show create table `ods_sop_call_gdsw_hdh_d`;
drop table  `ods_sop_call_gdsw_hdh_d`;
drop table  `ODS_SOP_CALL_YDYW_HDH_D`;

// 固定上网
CREATE TABLE `ODS_SOP_CALL_GDSW_HDH_D` (
 file_name VARCHAR(100) COMMENT "录音文件名",
 executor VARCHAR(100) COMMENT "执行方",
 evaluation_time VARCHAR(100) COMMENT "测评时间(几期)",
 evaluation_specific_time VARCHAR(100) COMMENT "测评具体时间(具体到分)",
 call_duration VARCHAR(100) COMMENT "通话时长(具体到秒)",
 outbound_job_number VARCHAR(100) COMMENT "外呼工号",
 evaluation_number VARCHAR(100) COMMENT "测评号码(外呼号码)",
 city VARCHAR(100) COMMENT "城市",
 county VARCHAR(100) COMMENT "区县",
 middle_number VARCHAR(100) COMMENT "中间号码",
 middle_task_name VARCHAR(100) COMMENT "中间号码任务名称",
 operator VARCHAR(100) COMMENT "运营商",
 feild1 VARCHAR(100),
 feild2 VARCHAR(100),
 feild3 VARCHAR(100),
 feild4 VARCHAR(100),
 feild5 VARCHAR(100),
 feild6 VARCHAR(100),
 feild7 VARCHAR(100),
 feild8 VARCHAR(100),
 feild9 VARCHAR(100),
 feild10 VARCHAR(100),
 feild11 VARCHAR(100),
 feild12 VARCHAR(100),
 feild13 VARCHAR(100),
 feild14 VARCHAR(100),
 feild15 VARCHAR(100),
 feild16 VARCHAR(100),
 feild17 VARCHAR(100),
 feild18 VARCHAR(100),
 feild19 VARCHAR(100),
 feild20 VARCHAR(100),
 feild21 VARCHAR(100),
 feild22 VARCHAR(100),
 feild23 VARCHAR(100),
 feild24 VARCHAR(100),
 feild25 VARCHAR(100),
 feild26 VARCHAR(100),
 feild27 VARCHAR(100),
 feild28 VARCHAR(100),
 feild29 VARCHAR(100),
 feild30 VARCHAR(100),
 feild31 VARCHAR(100),
 feild32 VARCHAR(100),
 feild33 VARCHAR(100),
 feild34 VARCHAR(100),
 feild35 VARCHAR(100),
 feild36 VARCHAR(100),
 feild37 VARCHAR(100),
 feild38 VARCHAR(100),
 feild39 VARCHAR(100),
 feild40 VARCHAR(100),
 feild41 VARCHAR(100),
 feild42 VARCHAR(100),
 feild43 VARCHAR(100),
 feild44 VARCHAR(100),
 type VARCHAR(100) COMMENT "质检结果",
  customer_number VARCHAR(100) COMMENT "客户号码"
) PARTITIONED BY (stat_date string)
row format delimited fields terminated by ','
 LINES TERMINATED BY '\n';
// 数据导入 /Users/mayu/Desktop/74hive/gdsw10-06.csv 【1006-15条】
// 先将csv上传到74 docker 的/home/mayu/目录下，然后返回此执行代码的导出命令
LOAD DATA LOCAL INPATH '/home/mayu/gdsw10-06_nohead.csv' INTO TABLE ODS_SOP_CALL_GDSW_HDH_D partition(stat_date='20231006');
LOAD DATA LOCAL INPATH '/home/mayu/1007.csv' INTO TABLE ODS_SOP_CALL_GDSW_HDH_D partition(stat_date='20231007');
select * from mayu.ODS_SOP_CALL_GDSW_HDH_D where stat_date="20231007";
select count(1) from mayu.ODS_SOP_CALL_GDSW_HDH_D where stat_date="20231007";

// 移动业务
CREATE TABLE `ODS_SOP_CALL_YDYW_HDH_D` (
 file_name VARCHAR(100) COMMENT "录音文件名",
 executor VARCHAR(100) COMMENT "执行方",
 evaluation_time VARCHAR(100) COMMENT "测评时间(几期)",
 evaluation_specific_time VARCHAR(100) COMMENT "测评具体时间(具体到分)",
 call_duration VARCHAR(100) COMMENT "通话时长(具体到秒)",
 outbound_job_number VARCHAR(100) COMMENT "外呼工号",
 evaluation_number VARCHAR(100) COMMENT "测评号码(外呼号码)",
 city VARCHAR(100) COMMENT "城市",
 county VARCHAR(100) COMMENT "区县",
 middle_number VARCHAR(100) COMMENT "中间号码",
 middle_task_name VARCHAR(100) COMMENT "中间号码任务名称",
 operator VARCHAR(100) COMMENT "运营商",
 feild1 VARCHAR(100),
 feild2 VARCHAR(100),
 feild3 VARCHAR(100),
 feild4 VARCHAR(100),
 feild5 VARCHAR(100),
 feild6 VARCHAR(100),
 feild7 VARCHAR(100),
 feild8 VARCHAR(100),
 feild9 VARCHAR(100),
 feild10 VARCHAR(100),
 feild11 VARCHAR(100),
 feild12 VARCHAR(100),
 feild13 VARCHAR(100),
 feild14 VARCHAR(100),
 feild15 VARCHAR(100),
 feild16 VARCHAR(100),
 feild17 VARCHAR(100),
 feild18 VARCHAR(100),
 feild19 VARCHAR(100),
 feild20 VARCHAR(100),
 feild21 VARCHAR(100),
 feild22 VARCHAR(100),
 feild23 VARCHAR(100),
 feild24 VARCHAR(100),
 feild25 VARCHAR(100),
 feild26 VARCHAR(100),
 feild27 VARCHAR(100),
 feild28 VARCHAR(100),
 feild29 VARCHAR(100),
 feild30 VARCHAR(100),
 feild31 VARCHAR(100),
 feild32 VARCHAR(100),
 feild33 VARCHAR(100),
 feild34 VARCHAR(100),
 feild35 VARCHAR(100),
 feild36 VARCHAR(100),
 feild37 VARCHAR(100),
 feild38 VARCHAR(100),
 feild39 VARCHAR(100),
 feild40 VARCHAR(100),
 feild41 VARCHAR(100),
 feild42 VARCHAR(100),
 type VARCHAR(100) COMMENT "质检结果",
 customer_number VARCHAR(100) COMMENT "客户号码"
) PARTITIONED BY (stat_date string)
row format delimited fields terminated by ','
 LINES TERMINATED BY '\n';

LOAD DATA LOCAL INPATH '/home/mayu/ydyw1004_nohead.csv' INTO TABLE ODS_SOP_CALL_YDYW_HDH_D partition(stat_date='20231004');
select * from mayu.ODS_SOP_CALL_YDYW_HDH_D where stat_date="20231004";