-- 时间轴
UPDATE report_info_record SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND id IN (SELECT id FROM tmp_report_info_record_ids);

-- 部门关联（信息上报 / 抄告核实 / 信息签收）
UPDATE report_info_dept_rel SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND (
      report_info_id = @report_info_id
      OR report_dept_id IN (SELECT id FROM tmp_report_dept_ids)
  );

-- 抄告核实关系表（历史表名拼写为 verfiy，若不存在可忽略报错）
UPDATE report_info_verfiy_rel SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND report_info_id = '2064554747473502210';


##### 线上仅仅执行了下面两句

-- 各部门信息接报（关键：让所有部门列表都看不到）
UPDATE report_dept SET is_deleted = 1, update_time = NOW()WHERE is_deleted = 0 AND report_info_id = '2064554747473502210';

-- 原始信息
UPDATE report_info SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND id = '2064554747473502210';