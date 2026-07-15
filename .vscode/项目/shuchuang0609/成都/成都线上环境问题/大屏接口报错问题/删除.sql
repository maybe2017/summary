SET @report_info_id = '2064554747473502210';  -- <<< 改成你的 ID

START TRANSACTION;

-- ---------- 收集关联 ID（临时表，便于后续批量更新）----------
DROP TEMPORARY TABLE IF EXISTS tmp_report_dept_ids;
CREATE TEMPORARY TABLE tmp_report_dept_ids (id BIGINT PRIMARY KEY);
INSERT INTO tmp_report_dept_ids (id)
SELECT id FROM report_dept
WHERE report_info_id = @report_info_id AND is_deleted = 0;

DROP TEMPORARY TABLE IF EXISTS tmp_event_ids;
CREATE TEMPORARY TABLE tmp_event_ids (event_info_id BIGINT PRIMARY KEY);

INSERT INTO tmp_event_ids (event_info_id)
SELECT DISTINCT event_info_id
FROM report_dept
WHERE report_info_id = @report_info_id
  AND event_info_id IS NOT NULL
  AND is_deleted = 0;

-- 兜底：时间轴里直接挂了 event_info_id 的情况
INSERT IGNORE INTO tmp_event_ids (event_info_id)
SELECT DISTINCT event_info_id
FROM report_info_record
WHERE report_info_id = @report_info_id
  AND event_info_id IS NOT NULL
  AND is_deleted = 0;

DROP TEMPORARY TABLE IF EXISTS tmp_report_info_record_ids;
CREATE TEMPORARY TABLE tmp_report_info_record_ids (id BIGINT PRIMARY KEY);
INSERT INTO tmp_report_info_record_ids (id)
SELECT id FROM report_info_record
WHERE is_deleted = 0
  AND (
      report_info_id = @report_info_id
      OR report_dept_id IN (SELECT id FROM tmp_report_dept_ids)
      OR event_info_id IN (SELECT event_info_id FROM tmp_event_ids)
  );

DROP TEMPORARY TABLE IF EXISTS tmp_inform_record_ids;
CREATE TEMPORARY TABLE tmp_inform_record_ids (id BIGINT PRIMARY KEY);
INSERT INTO tmp_inform_record_ids (id)
SELECT id FROM inform_record
WHERE is_deleted = 0
  AND event_info_id IN (SELECT event_info_id FROM tmp_event_ids);

DROP TEMPORARY TABLE IF EXISTS tmp_instruction_audit_ids;
CREATE TEMPORARY TABLE tmp_instruction_audit_ids (id BIGINT PRIMARY KEY);
INSERT INTO tmp_instruction_audit_ids (id)
SELECT id FROM instruction_audit_record
WHERE is_deleted = 0
  AND event_info_id IN (SELECT event_info_id FROM tmp_event_ids);

DROP TEMPORARY TABLE IF EXISTS tmp_event_audit_ids;
CREATE TEMPORARY TABLE tmp_event_audit_ids (id BIGINT PRIMARY KEY);
INSERT INTO tmp_event_audit_ids (id)
SELECT id FROM event_audit_record
WHERE is_deleted = 0
  AND event_info_id IN (SELECT event_info_id FROM tmp_event_ids);

DROP TEMPORARY TABLE IF EXISTS tmp_report_event_record_ids;
CREATE TEMPORARY TABLE tmp_report_event_record_ids (id BIGINT PRIMARY KEY);
INSERT INTO tmp_report_event_record_ids (id)
SELECT id FROM report_event_record
WHERE is_deleted = 0
  AND event_info_id IN (SELECT event_info_id FROM tmp_event_ids);

DROP TEMPORARY TABLE IF EXISTS tmp_recording_account_ids;
CREATE TEMPORARY TABLE tmp_recording_account_ids (id BIGINT PRIMARY KEY);
INSERT INTO tmp_recording_account_ids (id)
SELECT id FROM recording_account
WHERE is_deleted = 0
  AND event_info_id IN (SELECT event_info_id FROM tmp_event_ids);

DROP TEMPORARY TABLE IF EXISTS tmp_report_info_street_ids;
CREATE TEMPORARY TABLE tmp_report_info_street_ids (id BIGINT PRIMARY KEY);
INSERT INTO tmp_report_info_street_ids (id)
SELECT id FROM report_info_street
WHERE is_deleted = 0 AND report_info_id = @report_info_id;

-- ==================== A. 信息链路 ====================

-- 信息附件（含续报附件）
UPDATE report_info_file
SET is_deleted = 1, update_time = NOW()
WHERE is_deleted = 0
  AND (
      report_info_id = @report_info_id
      OR report_info_record_id IN (SELECT id FROM tmp_report_info_record_ids)
  );

-- 街道上报附件（若有）
UPDATE report_info_street_file
SET is_deleted = 1, update_time = NOW()
WHERE is_deleted = 0
  AND report_info_street_id IN (SELECT id FROM tmp_report_info_street_ids);

-- 街道上报主表（若有）
UPDATE report_info_street
SET is_deleted = 1, update_time = NOW()
WHERE is_deleted = 0 AND report_info_id = @report_info_id;

-- 时间轴
UPDATE report_info_record
SET is_deleted = 1, update_time = NOW()
WHERE is_deleted = 0 AND id IN (SELECT id FROM tmp_report_info_record_ids);

-- 部门关联（信息上报 / 抄告核实 / 信息签收）
UPDATE report_info_dept_rel
SET is_deleted = 1, update_time = NOW()
WHERE is_deleted = 0
  AND (
      report_info_id = @report_info_id
      OR report_dept_id IN (SELECT id FROM tmp_report_dept_ids)
  );

-- 抄告核实关系表（历史表名拼写为 verfiy，若不存在可忽略报错）
UPDATE report_info_verfiy_rel
SET is_deleted = 1, update_time = NOW()
WHERE is_deleted = 0 AND report_info_id = @report_info_id;

-- 各部门信息接报（关键：让所有部门列表都看不到）
UPDATE report_dept SET is_deleted = 1, update_time = NOW()WHERE is_deleted = 0 AND report_info_id = @report_info_id;

-- 原始信息
UPDATE report_info SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND id = @report_info_id;

-- ==================== B. 事件链路（若已创建事件）====================

-- 无事件则以下 UPDATE 影响 0 行，安全跳过

-- 子表（无 is_deleted 的用 DELETE，避免孤儿数据）
DELETE FROM instruction_audit_person
WHERE audit_id IN (SELECT id FROM tmp_instruction_audit_ids);

DELETE FROM instruction_audit_org
WHERE audit_id IN (SELECT id FROM tmp_instruction_audit_ids);

DELETE FROM instruction_audit_only_file_org
WHERE audit_id IN (SELECT id FROM tmp_instruction_audit_ids);

DELETE FROM event_audit_person
WHERE audit_id IN (SELECT id FROM tmp_event_audit_ids);

DELETE FROM event_hub
WHERE event_id IN (SELECT event_info_id FROM tmp_event_ids);

-- 软删除：事件附属表
UPDATE instruction_audit_file       SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND event_info_id IN (SELECT event_info_id FROM tmp_event_ids);
UPDATE instruction_audit_record   SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND event_info_id IN (SELECT event_info_id FROM tmp_event_ids);
UPDATE instruction_distr_record   SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND event_info_id IN (SELECT event_info_id FROM tmp_event_ids);

UPDATE event_audit_record         SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND event_info_id IN (SELECT event_info_id FROM tmp_event_ids);
UPDATE event_audit_count          SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND event_id IN (SELECT event_info_id FROM tmp_event_ids);
UPDATE event_instruction          SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND event_id IN (SELECT event_info_id FROM tmp_event_ids);
UPDATE event_tags_res             SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND event_id IN (SELECT event_info_id FROM tmp_event_ids);
UPDATE event_info_file            SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND event_info_id IN (SELECT event_info_id FROM tmp_event_ids);

UPDATE report_event_record        SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND event_info_id IN (SELECT event_info_id FROM tmp_event_ids);
UPDATE report_event_record_rel_person SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND event_info_id IN (SELECT event_info_id FROM tmp_event_ids);
UPDATE report_event_continue_info SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND event_id IN (SELECT event_info_id FROM tmp_event_ids);
UPDATE report_event_continue_person SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND event_id IN (SELECT event_info_id FROM tmp_event_ids);
UPDATE report_event_flow          SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND event_id IN (SELECT event_info_id FROM tmp_event_ids);

UPDATE inform_record_det          SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND (event_info_id IN (SELECT event_info_id FROM tmp_event_ids) OR inform_record_id IN (SELECT id FROM tmp_inform_record_ids));
UPDATE inform_record_file         SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND (event_info_id IN (SELECT event_info_id FROM tmp_event_ids) OR inform_record_id IN (SELECT id FROM tmp_inform_record_ids));
UPDATE inform_record              SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND event_info_id IN (SELECT event_info_id FROM tmp_event_ids);

UPDATE sms_record                 SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND event_info_id IN (SELECT event_info_id FROM tmp_event_ids);
UPDATE phone_event_res            SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND event_id IN (SELECT event_info_id FROM tmp_event_ids);
UPDATE emergency_duty_report      SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND event_id IN (SELECT event_info_id FROM tmp_event_ids);

UPDATE recording_account_text     SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND ra_id IN (SELECT id FROM tmp_recording_account_ids);
UPDATE recording_account          SET is_deleted = 1, update_time = NOW() WHERE is_deleted = 0 AND event_info_id IN (SELECT event_info_id FROM tmp_event_ids);

-- 台账（创建事件时写入）
UPDATE standing_book
SET is_deleted = 1, update_time = NOW()
WHERE is_deleted = 0
  AND event_info_id IN (SELECT event_info_id FROM tmp_event_ids);

-- 事件主表（放最后）
UPDATE event_info
SET is_deleted = 1, update_time = NOW()
WHERE is_deleted = 0
  AND id IN (SELECT event_info_id FROM tmp_event_ids);

-- 清理临时表
DROP TEMPORARY TABLE IF EXISTS tmp_report_dept_ids;
DROP TEMPORARY TABLE IF EXISTS tmp_event_ids;
DROP TEMPORARY TABLE IF EXISTS tmp_report_info_record_ids;
DROP TEMPORARY TABLE IF EXISTS tmp_inform_record_ids;
DROP TEMPORARY TABLE IF EXISTS tmp_instruction_audit_ids;
DROP TEMPORARY TABLE IF EXISTS tmp_event_audit_ids;
DROP TEMPORARY TABLE IF EXISTS tmp_report_event_record_ids;
DROP TEMPORARY TABLE IF EXISTS tmp_recording_account_ids;
DROP TEMPORARY TABLE IF EXISTS tmp_report_info_street_ids;

-- 确认无误后提交；有问题则 ROLLBACK;
COMMIT;
-- ROLLBACK;