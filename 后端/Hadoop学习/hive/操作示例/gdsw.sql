CREATE TABLE my_hive.`ODS_SOP_CALL_GDSW_HDH_D` (
 `file_name` VARCHAR(100) COMMENT "录音文件名",
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
 `type` VARCHAR(100) COMMENT "质检结果",
  customer_number VARCHAR(100) COMMENT "客户号码"
) PARTITIONED BY (stat_date string) 
row format delimited fields terminated by ','
 LINES TERMINATED BY '\n'

## 数据导入
LOAD DATA LOCAL INPATH '/home/mayu/gdsw10-06.csv' INTO TABLE ODS_SOP_CALL_GDSW_HDH_D partition(stat_date='20231006')



docker cp /home/mayu/gdsw10-06.csv 23682a68fe23:/home/mayu