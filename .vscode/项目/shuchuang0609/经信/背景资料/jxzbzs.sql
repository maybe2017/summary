/*
 Navicat Premium Dump SQL

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 80018 (8.0.18)
 Source Host           : localhost:3306
 Source Schema         : jxzbzs

 Target Server Type    : MySQL
 Target Server Version : 80018 (8.0.18)
 File Encoding         : 65001

 Date: 15/07/2026 09:36:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for act_evt_log
-- ----------------------------
DROP TABLE IF EXISTS `act_evt_log`;
CREATE TABLE `act_evt_log`  (
  `LOG_NR_` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `USER_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `DATA_` longblob NULL,
  `LOCK_OWNER_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `IS_PROCESSED_` tinyint(4) NULL DEFAULT 0,
  PRIMARY KEY (`LOG_NR_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_evt_log
-- ----------------------------

-- ----------------------------
-- Table structure for act_ge_bytearray
-- ----------------------------
DROP TABLE IF EXISTS `act_ge_bytearray`;
CREATE TABLE `act_ge_bytearray`  (
  `ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `BYTES_` longblob NULL,
  `GENERATED_` tinyint(4) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_FK_BYTEARR_DEPL`(`DEPLOYMENT_ID_` ASC) USING BTREE,
  CONSTRAINT `act_ge_bytearray_ibfk_1` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_ge_bytearray
-- ----------------------------

-- ----------------------------
-- Table structure for act_ge_property
-- ----------------------------
DROP TABLE IF EXISTS `act_ge_property`;
CREATE TABLE `act_ge_property`  (
  `NAME_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `VALUE_` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`NAME_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_ge_property
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_actinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_actinst`;
CREATE TABLE `act_hi_actinst`  (
  `ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `ACT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `ACT_NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `ACT_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `ASSIGNEE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) NULL DEFAULT NULL,
  `DURATION_` bigint(20) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_ACT_INST_START`(`START_TIME_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_ACT_INST_END`(`END_TIME_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_ACT_INST_PROCINST`(`PROC_INST_ID_` ASC, `ACT_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_ACT_INST_EXEC`(`EXECUTION_ID_` ASC, `ACT_ID_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_hi_actinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_attachment
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_attachment`;
CREATE TABLE `act_hi_attachment`  (
  `ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `USER_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `URL_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `CONTENT_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TIME_` datetime(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_hi_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_comment
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_comment`;
CREATE TABLE `act_hi_comment`  (
  `ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `USER_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `ACTION_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `MESSAGE_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `FULL_MSG_` longblob NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_hi_comment
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_detail
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_detail`;
CREATE TABLE `act_hi_detail`  (
  `ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `VAR_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `BYTEARRAY_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `DOUBLE_` double NULL DEFAULT NULL,
  `LONG_` bigint(20) NULL DEFAULT NULL,
  `TEXT_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TEXT2_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_DETAIL_PROC_INST`(`PROC_INST_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_DETAIL_ACT_INST`(`ACT_INST_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_DETAIL_TIME`(`TIME_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_DETAIL_NAME`(`NAME_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_DETAIL_TASK_ID`(`TASK_ID_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_hi_detail
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_identitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_identitylink`;
CREATE TABLE `act_hi_identitylink`  (
  `ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `GROUP_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `USER_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_IDENT_LNK_USER`(`USER_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_IDENT_LNK_TASK`(`TASK_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_IDENT_LNK_PROCINST`(`PROC_INST_ID_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_hi_identitylink
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_procinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_procinst`;
CREATE TABLE `act_hi_procinst`  (
  `ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) NULL DEFAULT NULL,
  `DURATION_` bigint(20) NULL DEFAULT NULL,
  `START_USER_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `START_ACT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `END_ACT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '',
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  UNIQUE INDEX `PROC_INST_ID_`(`PROC_INST_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_PRO_INST_END`(`END_TIME_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_PRO_I_BUSKEY`(`BUSINESS_KEY_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_hi_procinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_taskinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_taskinst`;
CREATE TABLE `act_hi_taskinst`  (
  `ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `OWNER_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `ASSIGNEE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `CLAIM_TIME_` datetime(3) NULL DEFAULT NULL,
  `END_TIME_` datetime(3) NULL DEFAULT NULL,
  `DURATION_` bigint(20) NULL DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `PRIORITY_` int(11) NULL DEFAULT NULL,
  `DUE_DATE_` datetime(3) NULL DEFAULT NULL,
  `FORM_KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_TASK_INST_PROCINST`(`PROC_INST_ID_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_hi_taskinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_hi_varinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_varinst`;
CREATE TABLE `act_hi_varinst`  (
  `ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `VAR_TYPE_` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `DOUBLE_` double NULL DEFAULT NULL,
  `LONG_` bigint(20) NULL DEFAULT NULL,
  `TEXT_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TEXT2_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `CREATE_TIME_` datetime(3) NULL DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_HI_PROCVAR_PROC_INST`(`PROC_INST_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_PROCVAR_NAME_TYPE`(`NAME_` ASC, `VAR_TYPE_` ASC) USING BTREE,
  INDEX `ACT_IDX_HI_PROCVAR_TASK_ID`(`TASK_ID_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_hi_varinst
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_group
-- ----------------------------
DROP TABLE IF EXISTS `act_id_group`;
CREATE TABLE `act_id_group`  (
  `ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_id_group
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_info
-- ----------------------------
DROP TABLE IF EXISTS `act_id_info`;
CREATE TABLE `act_id_info`  (
  `ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `USER_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TYPE_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `VALUE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `PASSWORD_` longblob NULL,
  `PARENT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_id_info
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_membership
-- ----------------------------
DROP TABLE IF EXISTS `act_id_membership`;
CREATE TABLE `act_id_membership`  (
  `USER_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `GROUP_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`USER_ID_`, `GROUP_ID_`) USING BTREE,
  INDEX `ACT_FK_MEMB_GROUP`(`GROUP_ID_` ASC) USING BTREE,
  CONSTRAINT `act_id_membership_ibfk_1` FOREIGN KEY (`GROUP_ID_`) REFERENCES `act_id_group` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `act_id_membership_ibfk_2` FOREIGN KEY (`USER_ID_`) REFERENCES `act_id_user` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_id_membership
-- ----------------------------

-- ----------------------------
-- Table structure for act_id_user
-- ----------------------------
DROP TABLE IF EXISTS `act_id_user`;
CREATE TABLE `act_id_user`  (
  `ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `FIRST_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `LAST_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `EMAIL_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `PWD_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `PICTURE_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_id_user
-- ----------------------------

-- ----------------------------
-- Table structure for act_procdef_info
-- ----------------------------
DROP TABLE IF EXISTS `act_procdef_info`;
CREATE TABLE `act_procdef_info`  (
  `ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `INFO_JSON_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  UNIQUE INDEX `ACT_UNIQ_INFO_PROCDEF`(`PROC_DEF_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_INFO_PROCDEF`(`PROC_DEF_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_INFO_JSON_BA`(`INFO_JSON_ID_` ASC) USING BTREE,
  CONSTRAINT `act_procdef_info_ibfk_1` FOREIGN KEY (`INFO_JSON_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `act_procdef_info_ibfk_2` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_procdef_info
-- ----------------------------

-- ----------------------------
-- Table structure for act_re_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_re_deployment`;
CREATE TABLE `act_re_deployment`  (
  `ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '',
  `DEPLOY_TIME_` timestamp(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_re_deployment
-- ----------------------------

-- ----------------------------
-- Table structure for act_re_model
-- ----------------------------
DROP TABLE IF EXISTS `act_re_model`;
CREATE TABLE `act_re_model`  (
  `ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `VERSION_` int(11) NULL DEFAULT NULL,
  `META_INFO_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_FK_MODEL_SOURCE`(`EDITOR_SOURCE_VALUE_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_MODEL_SOURCE_EXTRA`(`EDITOR_SOURCE_EXTRA_VALUE_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_MODEL_DEPLOYMENT`(`DEPLOYMENT_ID_` ASC) USING BTREE,
  CONSTRAINT `act_re_model_ibfk_1` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `act_re_model_ibfk_2` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `act_re_model_ibfk_3` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_re_model
-- ----------------------------

-- ----------------------------
-- Table structure for act_re_procdef
-- ----------------------------
DROP TABLE IF EXISTS `act_re_procdef`;
CREATE TABLE `act_re_procdef`  (
  `ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint(4) NULL DEFAULT NULL,
  `HAS_GRAPHICAL_NOTATION_` tinyint(4) NULL DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  UNIQUE INDEX `ACT_UNIQ_PROCDEF`(`KEY_` ASC, `VERSION_` ASC, `TENANT_ID_` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_re_procdef
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_event_subscr
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_event_subscr`;
CREATE TABLE `act_ru_event_subscr`  (
  `ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `EVENT_NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `CONFIGURATION_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `CREATED_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_EVENT_SUBSCR_CONFIG_`(`CONFIGURATION_` ASC) USING BTREE,
  INDEX `ACT_FK_EVENT_EXEC`(`EXECUTION_ID_` ASC) USING BTREE,
  CONSTRAINT `act_ru_event_subscr_ibfk_1` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_ru_event_subscr
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_execution
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_execution`;
CREATE TABLE `act_ru_execution`  (
  `ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `PARENT_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `ACT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `IS_ACTIVE_` tinyint(4) NULL DEFAULT NULL,
  `IS_CONCURRENT_` tinyint(4) NULL DEFAULT NULL,
  `IS_SCOPE_` tinyint(4) NULL DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint(4) NULL DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) NULL DEFAULT NULL,
  `CACHED_ENT_STATE_` int(11) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '',
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_EXEC_BUSKEY`(`BUSINESS_KEY_` ASC) USING BTREE,
  INDEX `ACT_FK_EXE_PROCINST`(`PROC_INST_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_EXE_PARENT`(`PARENT_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_EXE_SUPER`(`SUPER_EXEC_` ASC) USING BTREE,
  INDEX `ACT_FK_EXE_PROCDEF`(`PROC_DEF_ID_` ASC) USING BTREE,
  CONSTRAINT `act_ru_execution_ibfk_1` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `act_ru_execution_ibfk_2` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `act_ru_execution_ibfk_3` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `act_ru_execution_ibfk_4` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_ru_execution
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_identitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_identitylink`;
CREATE TABLE `act_ru_identitylink`  (
  `ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `GROUP_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `USER_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_IDENT_LNK_USER`(`USER_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_IDENT_LNK_GROUP`(`GROUP_ID_` ASC) USING BTREE,
  INDEX `ACT_IDX_ATHRZ_PROCEDEF`(`PROC_DEF_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_TSKASS_TASK`(`TASK_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_IDL_PROCINST`(`PROC_INST_ID_` ASC) USING BTREE,
  CONSTRAINT `act_ru_identitylink_ibfk_1` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `act_ru_identitylink_ibfk_2` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `act_ru_identitylink_ibfk_3` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_ru_identitylink
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_job`;
CREATE TABLE `act_ru_job`  (
  `ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `RETRIES_` int(11) NULL DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '',
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_FK_JOB_EXCEPTION`(`EXCEPTION_STACK_ID_` ASC) USING BTREE,
  CONSTRAINT `act_ru_job_ibfk_1` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_ru_job
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_task
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_task`;
CREATE TABLE `act_ru_task`  (
  `ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `OWNER_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `ASSIGNEE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `DELEGATION_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `PRIORITY_` int(11) NULL DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `DUE_DATE_` datetime(3) NULL DEFAULT NULL,
  `CATEGORY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '',
  `FORM_KEY_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_TASK_CREATE`(`CREATE_TIME_` ASC) USING BTREE,
  INDEX `ACT_FK_TASK_EXE`(`EXECUTION_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_TASK_PROCINST`(`PROC_INST_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_TASK_PROCDEF`(`PROC_DEF_ID_` ASC) USING BTREE,
  CONSTRAINT `act_ru_task_ibfk_1` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `act_ru_task_ibfk_2` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `act_ru_task_ibfk_3` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_ru_task
-- ----------------------------

-- ----------------------------
-- Table structure for act_ru_variable
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_variable`;
CREATE TABLE `act_ru_variable`  (
  `ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `REV_` int(11) NULL DEFAULT NULL,
  `TYPE_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `NAME_` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TASK_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `DOUBLE_` double NULL DEFAULT NULL,
  `LONG_` bigint(20) NULL DEFAULT NULL,
  `TEXT_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `TEXT2_` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`) USING BTREE,
  INDEX `ACT_IDX_VARIABLE_TASK_ID`(`TASK_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_VAR_EXE`(`EXECUTION_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_VAR_PROCINST`(`PROC_INST_ID_` ASC) USING BTREE,
  INDEX `ACT_FK_VAR_BYTEARRAY`(`BYTEARRAY_ID_` ASC) USING BTREE,
  CONSTRAINT `act_ru_variable_ibfk_1` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `act_ru_variable_ibfk_2` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `act_ru_variable_ibfk_3` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of act_ru_variable
-- ----------------------------

-- ----------------------------
-- Table structure for address_book
-- ----------------------------
DROP TABLE IF EXISTS `address_book`;
CREATE TABLE `address_book`  (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `group_code` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of address_book
-- ----------------------------

-- ----------------------------
-- Table structure for air_china_materiel
-- ----------------------------
DROP TABLE IF EXISTS `air_china_materiel`;
CREATE TABLE `air_china_materiel`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `wl_code` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物料编码',
  `wl_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物料名称',
  `no` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预算表序号',
  `iz_valid` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '启用状态',
  `price` double(10, 2) NULL DEFAULT NULL COMMENT '单价',
  `integral_val` int(11) NULL DEFAULT NULL COMMENT '积分值',
  `xg_shangxian` int(11) NULL DEFAULT NULL COMMENT '选购上限',
  `size_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '尺码类型',
  `wl_unit` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '计量单位',
  `supplier` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供应商',
  `bpm_status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '流程状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of air_china_materiel
-- ----------------------------

-- ----------------------------
-- Table structure for air_china_persion_config
-- ----------------------------
DROP TABLE IF EXISTS `air_china_persion_config`;
CREATE TABLE `air_china_persion_config`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `account` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户编码',
  `post` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户岗位',
  `ruz_date` datetime NULL DEFAULT NULL COMMENT '入职时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of air_china_persion_config
-- ----------------------------

-- ----------------------------
-- Table structure for air_china_post_materiel_item
-- ----------------------------
DROP TABLE IF EXISTS `air_china_post_materiel_item`;
CREATE TABLE `air_china_post_materiel_item`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `wl_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物料名字',
  `wl_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物料编码',
  `num` int(11) NULL DEFAULT NULL COMMENT '循环数量',
  `jifen` int(11) NULL DEFAULT NULL COMMENT '合计积分',
  `fk_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外键',
  `iz_valid` int(11) NULL DEFAULT NULL COMMENT '启动状态',
  `cycle_time` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发放周期(年)',
  `first_num` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '首次数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of air_china_post_materiel_item
-- ----------------------------

-- ----------------------------
-- Table structure for air_china_post_materiel_main
-- ----------------------------
DROP TABLE IF EXISTS `air_china_post_materiel_main`;
CREATE TABLE `air_china_post_materiel_main`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `post_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '岗位编码',
  `post_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '岗位名字',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of air_china_post_materiel_main
-- ----------------------------

-- ----------------------------
-- Table structure for city_duty
-- ----------------------------
DROP TABLE IF EXISTS `city_duty`;
CREATE TABLE `city_duty`  (
  `id` bigint(20) NOT NULL,
  `duty_date` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '值班日期',
  `org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '值班单位',
  `duty_type` int(11) NULL DEFAULT NULL COMMENT '(0: 市 1: 区县/街道)',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '城运排班' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of city_duty
-- ----------------------------

-- ----------------------------
-- Table structure for city_duty_user_rel
-- ----------------------------
DROP TABLE IF EXISTS `city_duty_user_rel`;
CREATE TABLE `city_duty_user_rel`  (
  `id` bigint(20) NOT NULL,
  `city_duty_id` bigint(20) NULL DEFAULT NULL,
  `duty_level` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '排班级别',
  `user_name` varchar(22) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '人员姓名',
  `user_post` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '人员职位',
  `user_phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `man_order` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '人员排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '值班人员' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of city_duty_user_rel
-- ----------------------------

-- ----------------------------
-- Table structure for county_roster
-- ----------------------------
DROP TABLE IF EXISTS `county_roster`;
CREATE TABLE `county_roster`  (
  `id` bigint(20) NOT NULL,
  `duty_date` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '值班日期',
  `duty_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '值班单位',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建部门',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '删除标识',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of county_roster
-- ----------------------------

-- ----------------------------
-- Table structure for county_roster_user_rel
-- ----------------------------
DROP TABLE IF EXISTS `county_roster_user_rel`;
CREATE TABLE `county_roster_user_rel`  (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `duty_roster_id` bigint(20) NULL DEFAULT NULL COMMENT '父级id',
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '人员id',
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '人员姓名',
  `user_url` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '人员照片url',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建机构',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '删除标识',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '当前状态',
  `duty_level` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '排班级别',
  `user_post` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务名称',
  `post_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务编码',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `user_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户角色',
  `land_line` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '座机',
  `man_order` int(11) NULL DEFAULT NULL COMMENT '人员排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of county_roster_user_rel
-- ----------------------------

-- ----------------------------
-- Table structure for daily_ques_file
-- ----------------------------
DROP TABLE IF EXISTS `daily_ques_file`;
CREATE TABLE `daily_ques_file`  (
  `id` bigint(20) NOT NULL,
  `record_ques_id` bigint(20) NULL DEFAULT NULL COMMENT '问题id',
  `file_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `file_path` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件存储路径',
  `file_type` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件类型',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of daily_ques_file
-- ----------------------------

-- ----------------------------
-- Table structure for daily_record
-- ----------------------------
DROP TABLE IF EXISTS `daily_record`;
CREATE TABLE `daily_record`  (
  `id` bigint(20) NOT NULL,
  `target_org_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接收单位编码',
  `send_org_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发送单位编码',
  `send_time` datetime NULL DEFAULT NULL COMMENT '日报发送时间',
  `submit_time` datetime NULL DEFAULT NULL COMMENT '日报提交时间',
  `check_time` datetime NULL DEFAULT NULL COMMENT '日报查收时间',
  `reject_status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '驳回状态 1-未审核  2-驳回  3-通过',
  `reject_remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '驳回意见',
  `today_third_data` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '今日体征数据是否同步 1-未同步  2-已同步',
  `sync_status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '同步状态 1-未同步  2-已同步',
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通过创建部门code判定是本部门或相关部门',
  `is_deleted` int(11) NULL DEFAULT 0,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '查收状态(0:待查收 1：已查收  3：待阅  4：已阅)',
  `third_org_name` varchar(22) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '体征组对应部门名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of daily_record
-- ----------------------------

-- ----------------------------
-- Table structure for daily_record_file
-- ----------------------------
DROP TABLE IF EXISTS `daily_record_file`;
CREATE TABLE `daily_record_file`  (
  `id` bigint(20) NOT NULL,
  `oss_file_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'oss文件url',
  `third_file_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '体征文件url',
  `dr_id` bigint(20) NULL DEFAULT NULL COMMENT '外键',
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通过创建部门code判定是本部门或相关部门',
  `is_deleted` int(11) NULL DEFAULT 0,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of daily_record_file
-- ----------------------------

-- ----------------------------
-- Table structure for daily_record_question
-- ----------------------------
DROP TABLE IF EXISTS `daily_record_question`;
CREATE TABLE `daily_record_question`  (
  `id` bigint(20) NOT NULL,
  `dr_id` bigint(20) NULL DEFAULT NULL COMMENT '外键',
  `question_order` int(11) NULL DEFAULT NULL COMMENT '问题序号',
  `question_title` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '问题描述',
  `question_temp` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '范本',
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通过创建部门code判定是本部门或相关部门',
  `is_deleted` int(11) NULL DEFAULT 0,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `filling_content` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '填报内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of daily_record_question
-- ----------------------------

-- ----------------------------
-- Table structure for daily_sign_data
-- ----------------------------
DROP TABLE IF EXISTS `daily_sign_data`;
CREATE TABLE `daily_sign_data`  (
  `id` bigint(20) NOT NULL,
  `dr_id` bigint(20) NULL DEFAULT NULL COMMENT '外键',
  `sign_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '体征数据',
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通过创建部门code判定是本部门或相关部门',
  `is_deleted` int(11) NULL DEFAULT 0,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sign_answer` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '体征数据结果',
  `sort` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '问题顺序',
  `sign_create_time` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '体征数据创建时间',
  `required_data` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of daily_sign_data
-- ----------------------------

-- ----------------------------
-- Table structure for daily_task
-- ----------------------------
DROP TABLE IF EXISTS `daily_task`;
CREATE TABLE `daily_task`  (
  `id` bigint(20) NOT NULL,
  `send_time` time NULL DEFAULT NULL COMMENT '每日发送时间',
  `last_filling_time` int(11) NULL DEFAULT NULL COMMENT '填报时效',
  `alert_time` int(11) NULL DEFAULT NULL COMMENT '发出提醒时间',
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通过创建部门code判定是本部门或相关部门',
  `is_deleted` int(11) NULL DEFAULT 0,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_send_time` datetime NULL DEFAULT NULL COMMENT '最后发送日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of daily_task
-- ----------------------------

-- ----------------------------
-- Table structure for daily_temp_question
-- ----------------------------
DROP TABLE IF EXISTS `daily_temp_question`;
CREATE TABLE `daily_temp_question`  (
  `id` bigint(20) NOT NULL,
  `tem_id` bigint(20) NULL DEFAULT NULL COMMENT '日报模板表id',
  `question_order` int(11) NULL DEFAULT NULL COMMENT '问题序号',
  `question_title` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '问题描述',
  `question_temp` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '范本',
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通过创建部门code判定是本部门或相关部门',
  `is_deleted` int(11) NULL DEFAULT 0,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of daily_temp_question
-- ----------------------------

-- ----------------------------
-- Table structure for daily_template
-- ----------------------------
DROP TABLE IF EXISTS `daily_template`;
CREATE TABLE `daily_template`  (
  `id` bigint(20) NOT NULL,
  `target_org_code` varchar(22) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '目标部门编号',
  `newest_send_time` datetime NULL DEFAULT NULL COMMENT '最近推送时间',
  `do_status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '启用状态，1:已启用  2:已禁用 ',
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通过创建部门code判定是本部门或相关部门',
  `is_deleted` int(11) NULL DEFAULT 0,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `third_org_name` varchar(22) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '体征组对应部门名称',
  `send_time` time NULL DEFAULT NULL COMMENT '每日自动发送时间',
  `last_send_time` datetime NULL DEFAULT NULL COMMENT '最后自动发送日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of daily_template
-- ----------------------------

-- ----------------------------
-- Table structure for demo
-- ----------------------------
DROP TABLE IF EXISTS `demo`;
CREATE TABLE `demo`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键ID',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `key_word` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关键词',
  `punch_time` datetime NULL DEFAULT NULL COMMENT '打卡时间',
  `salary_money` decimal(10, 3) NULL DEFAULT NULL COMMENT '工资',
  `bonus_money` double(10, 2) NULL DEFAULT NULL COMMENT '奖金',
  `sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别 {男:1,女:2}',
  `age` int(11) NULL DEFAULT NULL COMMENT '年龄',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '个人简介',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `sys_org_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of demo
-- ----------------------------

-- ----------------------------
-- Table structure for demo_copy
-- ----------------------------
DROP TABLE IF EXISTS `demo_copy`;
CREATE TABLE `demo_copy`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键ID',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `key_word` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关键词',
  `punch_time` datetime NULL DEFAULT NULL COMMENT '打卡时间',
  `salary_money` decimal(10, 3) NULL DEFAULT NULL COMMENT '工资',
  `bonus_money` double(10, 2) NULL DEFAULT NULL COMMENT '奖金',
  `sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别 {男:1,女:2}',
  `age` int(11) NULL DEFAULT NULL COMMENT '年龄',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '个人简介',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `sys_org_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of demo_copy
-- ----------------------------

-- ----------------------------
-- Table structure for demo_qingjia
-- ----------------------------
DROP TABLE IF EXISTS `demo_qingjia`;
CREATE TABLE `demo_qingjia`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ID',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请假人',
  `days` int(11) NULL DEFAULT NULL COMMENT '请假天数',
  `begin_date` datetime NULL DEFAULT NULL COMMENT '开始时间',
  `end_date` datetime NULL DEFAULT NULL COMMENT '请假结束时间',
  `conten` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请假原因'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of demo_qingjia
-- ----------------------------

-- ----------------------------
-- Table structure for demo_staff
-- ----------------------------
DROP TABLE IF EXISTS `demo_staff`;
CREATE TABLE `demo_staff`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工姓名',
  `age` int(11) NULL DEFAULT NULL COMMENT '员工年龄',
  `sex` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工性别',
  `depart` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门',
  `group_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属小组',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of demo_staff
-- ----------------------------

-- ----------------------------
-- Table structure for demo_staff_group
-- ----------------------------
DROP TABLE IF EXISTS `demo_staff_group`;
CREATE TABLE `demo_staff_group`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门',
  `group_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '小组名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of demo_staff_group
-- ----------------------------

-- ----------------------------
-- Table structure for demo_sub_flow_hq
-- ----------------------------
DROP TABLE IF EXISTS `demo_sub_flow_hq`;
CREATE TABLE `demo_sub_flow_hq`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属部门',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `remarks` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `bpm_status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '流程状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of demo_sub_flow_hq
-- ----------------------------

-- ----------------------------
-- Table structure for demo_trigger_cdc
-- ----------------------------
DROP TABLE IF EXISTS `demo_trigger_cdc`;
CREATE TABLE `demo_trigger_cdc`  (
  `CDC_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CDC_OPT` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主键ID',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `key_word` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关键词',
  `punch_time` datetime NULL DEFAULT NULL COMMENT '打卡时间',
  `salary_money` decimal(10, 3) NULL DEFAULT NULL COMMENT '工资',
  `bonus_money` double(10, 2) NULL DEFAULT NULL COMMENT '奖金',
  `sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别 {男:1,女:2}',
  `age` int(11) NULL DEFAULT NULL COMMENT '年龄',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '个人简介',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `sys_org_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门编码',
  PRIMARY KEY (`CDC_ID`, `CDC_OPT`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of demo_trigger_cdc
-- ----------------------------

-- ----------------------------
-- Table structure for demo_ybz_test
-- ----------------------------
DROP TABLE IF EXISTS `demo_ybz_test`;
CREATE TABLE `demo_ybz_test`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门',
  `dem_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `bpm_status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '流程标识',
  `location` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of demo_ybz_test
-- ----------------------------

-- ----------------------------
-- Table structure for design_form
-- ----------------------------
DROP TABLE IF EXISTS `design_form`;
CREATE TABLE `design_form`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ID',
  `desform_code` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表单编码',
  `desform_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表单名称',
  `desform_icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表单图标',
  `desform_design_json` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '表单设计JSON',
  `cgform_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '绑定的CgformCode',
  `parent_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父表单id',
  `parent_code` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父表单code',
  `desform_type` tinyint(1) NULL DEFAULT 1 COMMENT '表单类型，1=主表，2=子表',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of design_form
-- ----------------------------

-- ----------------------------
-- Table structure for design_form_auth
-- ----------------------------
DROP TABLE IF EXISTS `design_form_auth`;
CREATE TABLE `design_form_auth`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键ID',
  `desform_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表单设计ID',
  `desform_code` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表单设计编码',
  `auth_com_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件id json中的key',
  `auth_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限名称',
  `auth_field` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限字段',
  `auth_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '授权类型',
  `auth_scope_is_all` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Y' COMMENT '授权范围【Y 所有人 ,N 不是所有人】默认所有人',
  `auth_scope_users_val` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '授权范围值，保存user登录账户',
  `auth_scope_roles_val` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '授权范围值，保存授权角色编码',
  `auth_scope_departs_val` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '授权范围值，保存部门编码',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '表单设计器权限表，字段级权限' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of design_form_auth
-- ----------------------------

-- ----------------------------
-- Table structure for design_form_data
-- ----------------------------
DROP TABLE IF EXISTS `design_form_data`;
CREATE TABLE `design_form_data`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ID',
  `desform_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表单设计ID',
  `desform_code` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表单设计编码',
  `desform_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表单设计名称',
  `desform_data_json` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '表单数据JSON',
  `online_form_code` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Online表单的Code',
  `online_form_data_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Online数据表中的id，用于同步修改',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of design_form_data
-- ----------------------------

-- ----------------------------
-- Table structure for design_form_templet
-- ----------------------------
DROP TABLE IF EXISTS `design_form_templet`;
CREATE TABLE `design_form_templet`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ID',
  `templet_code` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模板编码',
  `templet_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模板名称',
  `templet_json` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '模板JSON',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '表单设计器模板表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of design_form_templet
-- ----------------------------

-- ----------------------------
-- Table structure for design_form_url_auth
-- ----------------------------
DROP TABLE IF EXISTS `design_form_url_auth`;
CREATE TABLE `design_form_url_auth`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `desform_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '表单ID',
  `desform_code` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '表单CODE',
  `url_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '链接类型',
  `url_status` tinyint(1) NULL DEFAULT 1 COMMENT '链接状态（1=有效，2=无效）',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_desformcode_urltype`(`desform_code` ASC, `url_type` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of design_form_url_auth
-- ----------------------------

-- ----------------------------
-- Table structure for dim_date
-- ----------------------------
DROP TABLE IF EXISTS `dim_date`;
CREATE TABLE `dim_date`  (
  `id` int(11) NOT NULL COMMENT '日期键 20000101',
  `date` date NULL DEFAULT NULL COMMENT '日期 2000-01-01',
  `year` smallint(6) NULL DEFAULT NULL COMMENT '年 2000',
  `month` smallint(6) NULL DEFAULT NULL COMMENT '月 01',
  `day` smallint(6) NULL DEFAULT NULL COMMENT '日 01',
  `quarter` smallint(6) NULL DEFAULT NULL COMMENT '当年所属季度',
  `year_of_week` smallint(6) NULL DEFAULT NULL COMMENT '当前周所属年份',
  `week` smallint(6) NULL DEFAULT NULL COMMENT '当年所属周',
  `day_of_week` smallint(6) NULL DEFAULT NULL COMMENT '星期几',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dim_date
-- ----------------------------

-- ----------------------------
-- Table structure for display_config
-- ----------------------------
DROP TABLE IF EXISTS `display_config`;
CREATE TABLE `display_config`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键id',
  `display_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '展示名称',
  `key_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '键名称，与展示名称对应，供前端取值用',
  `value` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '值',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of display_config
-- ----------------------------

-- ----------------------------
-- Table structure for duty_check
-- ----------------------------
DROP TABLE IF EXISTS `duty_check`;
CREATE TABLE `duty_check`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deal_time` datetime NULL DEFAULT NULL COMMENT '处理时间',
  `deal_result` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '1:通过  2：拒接',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'createBy',
  `create_time` datetime NULL DEFAULT NULL COMMENT 'createTime',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'updateBy',
  `update_time` datetime NULL DEFAULT NULL COMMENT 'updateTime',
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'createOrgCode',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT 'isDeleted',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '(0：未签收 1:已签收)',
  `want_month` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '申请的年月 ：2023-04',
  `want_org` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '想要排班的部门',
  `is_top` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '0否  1是',
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT 'is_top为0时  此字段有值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1782318413385867267 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of duty_check
-- ----------------------------

-- ----------------------------
-- Table structure for duty_other_file
-- ----------------------------
DROP TABLE IF EXISTS `duty_other_file`;
CREATE TABLE `duty_other_file`  (
  `id` bigint(20) NOT NULL,
  `relevance_id` bigint(20) NULL DEFAULT NULL COMMENT '关联id(报备或者抽查记录)',
  `category` int(11) NULL DEFAULT NULL COMMENT '类别(0：报备附件 1：录音文件)',
  `file_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `file_path` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件存储路径',
  `file_type` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件类型',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT NULL,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `duty_other_file_relevance_id_IDX`(`relevance_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '值班其他附件' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of duty_other_file
-- ----------------------------

-- ----------------------------
-- Table structure for duty_report
-- ----------------------------
DROP TABLE IF EXISTS `duty_report`;
CREATE TABLE `duty_report`  (
  `id` bigint(20) NOT NULL,
  `title` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `phase` int(11) NULL DEFAULT NULL COMMENT '期数',
  `report_dept` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报告所属部门名称',
  `target_date` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报告所属日期',
  `statistic_info` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '统计信息详情',
  `detail_info` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '其他详情',
  `target_user` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '目标用户',
  `from_dept` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报告来源部门',
  `generate_date` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报告生成日期',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人部门',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '值班报告' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of duty_report
-- ----------------------------

-- ----------------------------
-- Table structure for duty_report_file
-- ----------------------------
DROP TABLE IF EXISTS `duty_report_file`;
CREATE TABLE `duty_report_file`  (
  `id` bigint(20) NOT NULL,
  `file_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `file_path` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件存储路径',
  `file_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件类型（0：每日值班报告 1：领导批示汇总）',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT NULL,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '值班报告文件' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of duty_report_file
-- ----------------------------

-- ----------------------------
-- Table structure for duty_roster
-- ----------------------------
DROP TABLE IF EXISTS `duty_roster`;
CREATE TABLE `duty_roster`  (
  `id` bigint(20) NOT NULL,
  `duty_date` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '值班日期',
  `duty_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '值班单位',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `IDX_1`(`duty_org_code` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '值班表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of duty_roster
-- ----------------------------

-- ----------------------------
-- Table structure for duty_roster_user_rel
-- ----------------------------
DROP TABLE IF EXISTS `duty_roster_user_rel`;
CREATE TABLE `duty_roster_user_rel`  (
  `id` bigint(20) NOT NULL,
  `duty_roster_id` bigint(20) NULL DEFAULT NULL,
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '人员姓名',
  `user_url` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '人员照片url',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  `duty_level` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '排班级别',
  `user_post` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务名称',
  `post_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务编码',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '值班带班人员',
  `land_line` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '座机',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `IDX_1`(`duty_roster_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '值班人员表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of duty_roster_user_rel
-- ----------------------------

-- ----------------------------
-- Table structure for duty_tmp_data
-- ----------------------------
DROP TABLE IF EXISTS `duty_tmp_data`;
CREATE TABLE `duty_tmp_data`  (
  `id` bigint(20) NOT NULL,
  `duty_roster_id` bigint(20) NULL DEFAULT NULL,
  `check_id` bigint(20) NULL DEFAULT NULL COMMENT '关联审核记录表',
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '人员姓名',
  `user_url` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '人员照片url',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  `duty_level` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '排班级别',
  `user_post` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务名称',
  `post_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务编码',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '值班带班人员',
  `land_line` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '座机',
  `parent_check_id` bigint(20) NULL DEFAULT NULL COMMENT '修改前记录',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of duty_tmp_data
-- ----------------------------

-- ----------------------------
-- Table structure for dy_duty
-- ----------------------------
DROP TABLE IF EXISTS `dy_duty`;
CREATE TABLE `dy_duty`  (
  `id` bigint(20) NOT NULL,
  `duty_date` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '值班日期',
  `org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '值班单位',
  `duty_type` int(11) NULL DEFAULT NULL COMMENT '(0: 市 1: 区县/街道)',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dy_duty
-- ----------------------------

-- ----------------------------
-- Table structure for dy_duty_user_rel
-- ----------------------------
DROP TABLE IF EXISTS `dy_duty_user_rel`;
CREATE TABLE `dy_duty_user_rel`  (
  `id` bigint(20) NOT NULL,
  `dy_duty_id` bigint(20) NULL DEFAULT NULL,
  `duty_level` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '排班级别',
  `user_name` varchar(22) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '人员姓名',
  `user_post` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '人员职位',
  `user_phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `man_order` int(11) NULL DEFAULT NULL COMMENT '人员排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dy_duty_user_rel
-- ----------------------------

-- ----------------------------
-- Table structure for dyh_business_duty
-- ----------------------------
DROP TABLE IF EXISTS `dyh_business_duty`;
CREATE TABLE `dyh_business_duty`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `system_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '系统名称',
  `management_unit_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理单位ID',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '值班业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dyh_business_duty
-- ----------------------------

-- ----------------------------
-- Table structure for dyh_duty
-- ----------------------------
DROP TABLE IF EXISTS `dyh_duty`;
CREATE TABLE `dyh_duty`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `system_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '系统ID',
  `duty_date` date NULL DEFAULT NULL COMMENT '值班日期',
  `create_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` int(11) NULL DEFAULT 0 COMMENT '删除状态0-未删除;1-已删除',
  `sld` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `zhz` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `zbz` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '值班表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dyh_duty
-- ----------------------------

-- ----------------------------
-- Table structure for dyh_management_units
-- ----------------------------
DROP TABLE IF EXISTS `dyh_management_units`;
CREATE TABLE `dyh_management_units`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `management_unit_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理单位',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `parent_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理单位表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dyh_management_units
-- ----------------------------

-- ----------------------------
-- Table structure for dyh_personnel_type
-- ----------------------------
DROP TABLE IF EXISTS `dyh_personnel_type`;
CREATE TABLE `dyh_personnel_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `system_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '系统ID',
  `role_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色ID',
  `schedul_number` int(11) NULL DEFAULT NULL COMMENT '排班数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '工作人员类型管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dyh_personnel_type
-- ----------------------------

-- ----------------------------
-- Table structure for dyh_role
-- ----------------------------
DROP TABLE IF EXISTS `dyh_role`;
CREATE TABLE `dyh_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名',
  `sn` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色sn码',
  `state` int(11) NULL DEFAULT NULL COMMENT '角色状态',
  `create_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` int(11) NULL DEFAULT 0 COMMENT '删除状态0-未删除;1-已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dyh_role
-- ----------------------------

-- ----------------------------
-- Table structure for dyh_system
-- ----------------------------
DROP TABLE IF EXISTS `dyh_system`;
CREATE TABLE `dyh_system`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `management_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理单位ID',
  `system_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '系统名称',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '说明',
  `create_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` int(11) NULL DEFAULT 0 COMMENT '删除状态0-未删除;1-已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dyh_system
-- ----------------------------

-- ----------------------------
-- Table structure for dyh_user
-- ----------------------------
DROP TABLE IF EXISTS `dyh_user`;
CREATE TABLE `dyh_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `department_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门ID',
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录名',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录密码',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `photo_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色照片url',
  `photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色照片',
  `state` int(11) NULL DEFAULT NULL COMMENT '状态:1--有效,2--无效',
  `create_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` int(11) NULL DEFAULT 0 COMMENT '删除状态0-未删除;1-已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dyh_user
-- ----------------------------

-- ----------------------------
-- Table structure for dyh_user_role
-- ----------------------------
DROP TABLE IF EXISTS `dyh_user_role`;
CREATE TABLE `dyh_user_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户ID',
  `role_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色用户中间表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dyh_user_role
-- ----------------------------

-- ----------------------------
-- Table structure for emergency_duty_report
-- ----------------------------
DROP TABLE IF EXISTS `emergency_duty_report`;
CREATE TABLE `emergency_duty_report`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `phase` int(11) NULL DEFAULT NULL COMMENT '期数',
  `dept_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `generate_date` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成日期',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件标题',
  `event_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '事件描述（HTML格式富文本）',
  `report_user` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主送对象',
  `cc_user` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '抄送对象',
  `event_id` bigint(20) NULL DEFAULT NULL COMMENT '关联的事件id',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人部门',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '应急值班信息报告' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of emergency_duty_report
-- ----------------------------

-- ----------------------------
-- Table structure for emergency_info
-- ----------------------------
DROP TABLE IF EXISTS `emergency_info`;
CREATE TABLE `emergency_info`  (
  `id` bigint(20) NOT NULL,
  `emergency_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `send_org` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `emergency_level` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通过创建部门code判定是本部门或相关部门',
  `is_deleted` int(11) NULL DEFAULT 0,
  `is_read` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '是否已读(0:未读 1：已读)',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态(0:待上报 1：已上报)',
  `report_info` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `title` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `location` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `incident_time` datetime NULL DEFAULT NULL,
  `report_time` datetime NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of emergency_info
-- ----------------------------

-- ----------------------------
-- Table structure for emergency_info_record
-- ----------------------------
DROP TABLE IF EXISTS `emergency_info_record`;
CREATE TABLE `emergency_info_record`  (
  `id` bigint(20) NOT NULL,
  `eme_id` bigint(20) NOT NULL,
  `record_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容文本',
  `send_org` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `receive_org` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `send_man` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `receive_man` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `man_org_tag` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '0:部门  1：个人',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通过创建部门code判定是本部门或相关部门',
  `is_deleted` int(11) NULL DEFAULT 0,
  `record_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '记录内容'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of emergency_info_record
-- ----------------------------

-- ----------------------------
-- Table structure for emergency_report
-- ----------------------------
DROP TABLE IF EXISTS `emergency_report`;
CREATE TABLE `emergency_report`  (
  `id` bigint(20) NOT NULL,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通过创建部门code判定是本部门或相关部门',
  `is_deleted` int(11) NULL DEFAULT 0,
  `is_read` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '是否已读(0:未读 1：已读)',
  `report_info` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `eme_id` bigint(20) NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of emergency_report
-- ----------------------------

-- ----------------------------
-- Table structure for emergency_report_man
-- ----------------------------
DROP TABLE IF EXISTS `emergency_report_man`;
CREATE TABLE `emergency_report_man`  (
  `id` bigint(20) NOT NULL,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通过创建部门code判定是本部门或相关部门',
  `is_deleted` int(11) NULL DEFAULT 0,
  `is_read` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '是否已读(0:未读 1：已读)',
  `eme_id` bigint(20) NOT NULL,
  `eme_report_id` bigint(20) NOT NULL,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of emergency_report_man
-- ----------------------------

-- ----------------------------
-- Table structure for emergency_report_org_or_man
-- ----------------------------
DROP TABLE IF EXISTS `emergency_report_org_or_man`;
CREATE TABLE `emergency_report_org_or_man`  (
  `id` bigint(20) NOT NULL,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通过创建部门code判定是本部门或相关部门',
  `is_deleted` int(11) NULL DEFAULT 0,
  `is_read` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '是否已读(0:未读 1：已读)',
  `eme_id` bigint(20) NOT NULL,
  `is_org` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '0是 1否',
  `org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `man_id` bigint(20) NULL DEFAULT NULL,
  `content` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of emergency_report_org_or_man
-- ----------------------------

-- ----------------------------
-- Table structure for eoa_cms_article
-- ----------------------------
DROP TABLE IF EXISTS `eoa_cms_article`;
CREATE TABLE `eoa_cms_article`  (
  `ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `image_href` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片地址',
  `column_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '栏目id',
  `author` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作者',
  `summary` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '摘要',
  `is_link` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否链接，0不是，1是',
  `link_url` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '链接地址',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `is_publish` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否发布(0否 1是)',
  `publish_date` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `keywords` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关键字',
  `serial_number` int(11) NULL DEFAULT NULL COMMENT '序号',
  `create_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `sys_org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组织机构编码',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'cms文章表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of eoa_cms_article
-- ----------------------------

-- ----------------------------
-- Table structure for eoa_cms_menu
-- ----------------------------
DROP TABLE IF EXISTS `eoa_cms_menu`;
CREATE TABLE `eoa_cms_menu`  (
  `ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image_href` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片地址',
  `menu_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '栏目名称',
  `menu_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码',
  `parent_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父节点',
  `menu_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '栏目类型（1：列表 2：链接）',
  `link_url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '链接地址',
  `template_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模版编码',
  `serial_number` int(11) NULL DEFAULT NULL COMMENT '序号',
  `is_show` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否显示0显示，1显示',
  `create_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `sys_org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组织机构编码',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'cms栏目表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of eoa_cms_menu
-- ----------------------------

-- ----------------------------
-- Table structure for eoa_file
-- ----------------------------
DROP TABLE IF EXISTS `eoa_file`;
CREATE TABLE `eoa_file`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'id',
  `parent_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父ID',
  `is_folder` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否文件夹 1：是  0：否',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `doc_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文档类型（folder:文件夹 excel:excel doc:word pp:ppt image:图片  archive:其他文档 video:视频）',
  `doc_extension` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件后缀',
  `key_words` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关键字',
  `doc_size` double(13, 2) NULL DEFAULT NULL COMMENT '文件大小（kb）',
  `owner_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文档作者',
  `doc_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件路径',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `read_count` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '阅读次数',
  `down_count` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '下载次数',
  `auth_role_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '授权角色id',
  `auth_user_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '授权用户id',
  `auth_depart_ids` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '授权组织机构ID',
  `post_code` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件编号',
  `create_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `sys_org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组织机构编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文档内容表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of eoa_file
-- ----------------------------

-- ----------------------------
-- Table structure for eoa_file_log
-- ----------------------------
DROP TABLE IF EXISTS `eoa_file_log`;
CREATE TABLE `eoa_file_log`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文档日志id',
  `doc_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文档id',
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作人',
  `operate_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型（1：创建、2：编辑  3：删除 4：查看 5：下载）',
  `user_ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户端IP',
  `operate_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文档日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of eoa_file_log
-- ----------------------------

-- ----------------------------
-- Table structure for eoa_mailbox_attach
-- ----------------------------
DROP TABLE IF EXISTS `eoa_mailbox_attach`;
CREATE TABLE `eoa_mailbox_attach`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mail_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮箱id',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `sys_org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组织机构编码',
  `attachment` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件上传',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_mailid`(`mail_id` ASC) USING BTREE COMMENT '邮箱索引'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '邮箱附件' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of eoa_mailbox_attach
-- ----------------------------

-- ----------------------------
-- Table structure for eoa_mailbox_info
-- ----------------------------
DROP TABLE IF EXISTS `eoa_mailbox_info`;
CREATE TABLE `eoa_mailbox_info`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮箱标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '邮件内容',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态 0草稿箱 1垃圾箱 2发件箱 3逻辑删除',
  `sender_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发件人id',
  `send_time` datetime NULL DEFAULT NULL COMMENT '发送时间',
  `receiver_ids` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接收人ids',
  `attachment` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件',
  `create_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `sys_org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组织机构编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '内部邮箱信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of eoa_mailbox_info
-- ----------------------------

-- ----------------------------
-- Table structure for eoa_mailbox_receiver
-- ----------------------------
DROP TABLE IF EXISTS `eoa_mailbox_receiver`;
CREATE TABLE `eoa_mailbox_receiver`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mail_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮箱id',
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收件人id',
  `send_time` datetime NULL DEFAULT NULL COMMENT '发送时间',
  `read_flag` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '0未读 1已读 ',
  `is_delete` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '0未删除 1已删除',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `sys_org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组织机构编码',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_userid`(`user_id` ASC) USING BTREE COMMENT '接收人索引',
  INDEX `idx_mailid`(`mail_id` ASC) USING BTREE COMMENT '邮箱索引'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '收件人信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of eoa_mailbox_receiver
-- ----------------------------

-- ----------------------------
-- Table structure for eoa_plan
-- ----------------------------
DROP TABLE IF EXISTS `eoa_plan`;
CREATE TABLE `eoa_plan`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `start_time` datetime NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '结束时间',
  `type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型：1日常记录  2本周工作  3下周计划',
  `all_day` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否全天  0否  1是',
  `urgent_level` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '紧急程度 1一般 2重要 3紧急',
  `receiver_ids` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接收人ids',
  `remind_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '提醒类型 1邮件 2短信 3系统消息 ',
  `remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注/内容',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态 0未开始 1进行中 2已完成',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `sys_org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组织机构编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日程任务' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of eoa_plan
-- ----------------------------

-- ----------------------------
-- Table structure for event_audit_count
-- ----------------------------
DROP TABLE IF EXISTS `event_audit_count`;
CREATE TABLE `event_audit_count`  (
  `id` bigint(20) NOT NULL,
  `event_id` bigint(20) NULL DEFAULT NULL COMMENT '事件Id',
  `is_read` tinyint(1) NULL DEFAULT 0 COMMENT '是否已读',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '审核行为数量统计' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of event_audit_count
-- ----------------------------

-- ----------------------------
-- Table structure for event_audit_person
-- ----------------------------
DROP TABLE IF EXISTS `event_audit_person`;
CREATE TABLE `event_audit_person`  (
  `id` bigint(20) NOT NULL,
  `audit_id` bigint(20) NULL DEFAULT NULL COMMENT '上报审核id',
  `user_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核人员id',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `opinion` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核意见',
  `status` tinyint(4) NULL DEFAULT 0 COMMENT '审核结果  0待审核  1通过  2不通过',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '事件上报审核人员表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of event_audit_person
-- ----------------------------

-- ----------------------------
-- Table structure for event_audit_record
-- ----------------------------
DROP TABLE IF EXISTS `event_audit_record`;
CREATE TABLE `event_audit_record`  (
  `id` bigint(20) NOT NULL,
  `event_info_id` bigint(20) NULL DEFAULT NULL,
  `proc_inst_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程实例id',
  `audit_type` int(11) NULL DEFAULT NULL COMMENT '审核类型(0：首报审核 1：续报审核)',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `incident_time` datetime NULL DEFAULT NULL COMMENT '事发时间',
  `description` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `event_type` int(11) NULL DEFAULT NULL COMMENT '事件类型',
  `event_status` int(11) NULL DEFAULT NULL COMMENT '事件状态',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '0.审核中	1.通过	2.不通过',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '事件审核记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of event_audit_record
-- ----------------------------

-- ----------------------------
-- Table structure for event_district
-- ----------------------------
DROP TABLE IF EXISTS `event_district`;
CREATE TABLE `event_district`  (
  `id` bigint(20) NOT NULL,
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父id',
  `type` tinyint(4) NULL DEFAULT NULL COMMENT '类型：市，区，街道',
  `full_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区域全名',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '事件区域信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of event_district
-- ----------------------------

-- ----------------------------
-- Table structure for event_district_0623
-- ----------------------------
DROP TABLE IF EXISTS `event_district_0623`;
CREATE TABLE `event_district_0623`  (
  `id` bigint(20) NOT NULL,
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父id',
  `type` tinyint(4) NULL DEFAULT NULL COMMENT '类型：市，区，街道',
  `full_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区域全名',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '事件区域信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of event_district_0623
-- ----------------------------

-- ----------------------------
-- Table structure for event_district_20221004
-- ----------------------------
DROP TABLE IF EXISTS `event_district_20221004`;
CREATE TABLE `event_district_20221004`  (
  `id` bigint(20) NOT NULL,
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父id',
  `type` tinyint(4) NULL DEFAULT NULL COMMENT '类型：市，区，街道',
  `full_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区域全名',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '事件区域信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of event_district_20221004
-- ----------------------------

-- ----------------------------
-- Table structure for event_district_copy1
-- ----------------------------
DROP TABLE IF EXISTS `event_district_copy1`;
CREATE TABLE `event_district_copy1`  (
  `id` bigint(20) NOT NULL,
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父id',
  `type` tinyint(4) NULL DEFAULT NULL COMMENT '类型：市，区，街道',
  `full_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区域全名',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '事件区域信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of event_district_copy1
-- ----------------------------

-- ----------------------------
-- Table structure for event_district_copy2
-- ----------------------------
DROP TABLE IF EXISTS `event_district_copy2`;
CREATE TABLE `event_district_copy2`  (
  `id` bigint(20) NOT NULL,
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父id',
  `type` tinyint(4) NULL DEFAULT NULL COMMENT '类型：市，区，街道',
  `full_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区域全名',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '事件区域信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of event_district_copy2
-- ----------------------------

-- ----------------------------
-- Table structure for event_district_ext
-- ----------------------------
DROP TABLE IF EXISTS `event_district_ext`;
CREATE TABLE `event_district_ext`  (
  `id` bigint(20) NOT NULL,
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父id',
  `type` tinyint(4) NULL DEFAULT NULL COMMENT '类型：市，区，街道',
  `full_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区域全名',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '事件区域信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of event_district_ext
-- ----------------------------

-- ----------------------------
-- Table structure for event_hub
-- ----------------------------
DROP TABLE IF EXISTS `event_hub`;
CREATE TABLE `event_hub`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键id，由事件枢纽返回',
  `event_id` bigint(20) NULL DEFAULT NULL COMMENT '事件id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `event_hub_event_id_IDX`(`event_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of event_hub
-- ----------------------------

-- ----------------------------
-- Table structure for event_info
-- ----------------------------
DROP TABLE IF EXISTS `event_info`;
CREATE TABLE `event_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件标题',
  `level` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件级别',
  `info_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件类别',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '事件描述',
  `location` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事发地点',
  `lng` double(18, 15) NULL DEFAULT NULL COMMENT '经度',
  `lat` double(18, 15) NULL DEFAULT NULL COMMENT '纬度',
  `incident_time` datetime NULL DEFAULT NULL COMMENT '事发时间',
  `report_channel` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '上报渠道',
  `info_media` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '信息媒介',
  `is_hurt` int(11) NULL DEFAULT NULL COMMENT '是否伤亡',
  `injured_count` int(11) NULL DEFAULT NULL COMMENT '受伤人数',
  `death_count` int(11) NULL DEFAULT NULL COMMENT '死亡人数',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'createBy',
  `create_time` datetime NULL DEFAULT NULL COMMENT 'createTime',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'updateBy',
  `update_time` datetime NULL DEFAULT NULL COMMENT 'updateTime',
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'createOrgCode',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT 'isDeleted',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件状态',
  `is_read` int(11) NULL DEFAULT 0 COMMENT '是否已读（0：未读 1：已读）',
  `event_report_type` tinyint(1) NULL DEFAULT NULL COMMENT '事件上报类型  （0.直报  1.续报）',
  `proc_inst_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程实例Id',
  `audit_type` tinyint(1) NULL DEFAULT NULL COMMENT '审核类型（0：首报审核，1：续报审核）',
  `continue_report_audit_status` tinyint(1) NULL DEFAULT NULL COMMENT '续报审核状态 0.审核拒绝 1.审核通过  ',
  `is_instruction` int(11) NULL DEFAULT NULL COMMENT '是否有领导批示未读消息0:未读 1：已读)',
  `is_rel_event_hub` tinyint(1) NULL DEFAULT 0 COMMENT '是否关联事件枢纽(0:未关联 1：已关联)',
  `next_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '二级类型',
  `city` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '成都市' COMMENT '城市',
  `city_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '城市编码',
  `area` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区域',
  `area_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区域编码',
  `street` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '街道',
  `street_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '街道编码',
  `district_id` bigint(20) NULL DEFAULT NULL COMMENT '区域信息Id',
  `rsignature` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '加密签名',
  `event_classify` int(11) NULL DEFAULT 1 COMMENT '事件性质',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `IDX_1`(`level` ASC, `info_type` ASC, `create_time` ASC) USING BTREE,
  INDEX `IDX_2`(`is_deleted` ASC, `create_org_code` ASC, `create_time` ASC, `info_type` ASC) USING BTREE,
  INDEX `event_info_create_time_IDX`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1956622362866749441 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of event_info
-- ----------------------------

-- ----------------------------
-- Table structure for event_info_file
-- ----------------------------
DROP TABLE IF EXISTS `event_info_file`;
CREATE TABLE `event_info_file`  (
  `id` bigint(20) NOT NULL,
  `event_info_id` bigint(20) NULL DEFAULT NULL COMMENT '事件id',
  `file_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `file_path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件存储路径',
  `file_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件类型',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件原始上报单位',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '事件上传附件' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of event_info_file
-- ----------------------------

-- ----------------------------
-- Table structure for event_instruction
-- ----------------------------
DROP TABLE IF EXISTS `event_instruction`;
CREATE TABLE `event_instruction`  (
  `id` bigint(20) NOT NULL,
  `event_id` bigint(20) NULL DEFAULT NULL COMMENT '事件Id',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '批示内容',
  `is_read` tinyint(1) NULL DEFAULT NULL COMMENT '是否已读',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'createBy',
  `create_time` datetime NULL DEFAULT NULL COMMENT 'createTime',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'updateBy',
  `update_time` datetime NULL DEFAULT NULL COMMENT 'updateTime',
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'createOrgCode',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT 'isDeleted',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '事件批示记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of event_instruction
-- ----------------------------

-- ----------------------------
-- Table structure for event_tag
-- ----------------------------
DROP TABLE IF EXISTS `event_tag`;
CREATE TABLE `event_tag`  (
  `id` bigint(20) NOT NULL,
  `tag_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件标签名',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'createBy',
  `create_time` datetime NULL DEFAULT NULL COMMENT 'createTime',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'updateBy',
  `update_time` datetime NULL DEFAULT NULL COMMENT 'updateTime',
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'createOrgCode',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '删除状态',
  `tag_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '标签类型',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `IDX_1`(`tag_name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of event_tag
-- ----------------------------

-- ----------------------------
-- Table structure for event_tags_res
-- ----------------------------
DROP TABLE IF EXISTS `event_tags_res`;
CREATE TABLE `event_tags_res`  (
  `id` bigint(20) NOT NULL,
  `event_id` bigint(20) NULL DEFAULT NULL COMMENT '事件id',
  `tag_id` bigint(20) NULL DEFAULT NULL,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'createBy',
  `create_time` datetime NULL DEFAULT NULL COMMENT 'createTime',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'updateBy',
  `update_time` datetime NULL DEFAULT NULL COMMENT 'updateTime',
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'createOrgCode',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '删除状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of event_tags_res
-- ----------------------------

-- ----------------------------
-- Table structure for event_type_dict
-- ----------------------------
DROP TABLE IF EXISTS `event_type_dict`;
CREATE TABLE `event_type_dict`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件类型名称',
  `type_val` varchar(22) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型对应标识',
  `parent_id` int(11) NULL DEFAULT NULL COMMENT '父级',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `IDX_1`(`type_val` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 190 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of event_type_dict
-- ----------------------------

-- ----------------------------
-- Table structure for every_report
-- ----------------------------
DROP TABLE IF EXISTS `every_report`;
CREATE TABLE `every_report`  (
  `id` bigint(20) NOT NULL,
  `file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `file_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `file_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通过创建部门code判定是本部门或相关部门',
  `is_deleted` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of every_report
-- ----------------------------

-- ----------------------------
-- Table structure for every_report_user
-- ----------------------------
DROP TABLE IF EXISTS `every_report_user`;
CREATE TABLE `every_report_user`  (
  `id` bigint(20) NOT NULL,
  `every_report_id` bigint(20) NULL DEFAULT NULL,
  `user_id` varchar(34) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `username` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `realname` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通过创建部门code判定是本部门或相关部门',
  `is_deleted` int(11) NULL DEFAULT 0,
  `is_read` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of every_report_user
-- ----------------------------

-- ----------------------------
-- Table structure for ext_act_bpm_file
-- ----------------------------
DROP TABLE IF EXISTS `ext_act_bpm_file`;
CREATE TABLE `ext_act_bpm_file`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `bpm_log_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '审批日志id',
  `base_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '根目录',
  `file_path` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件路径',
  `file_name` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `file_size` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件大小',
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_bpmlogid`(`bpm_log_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '审批日志文件' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ext_act_bpm_file
-- ----------------------------

-- ----------------------------
-- Table structure for ext_act_bpm_log
-- ----------------------------
DROP TABLE IF EXISTS `ext_act_bpm_log`;
CREATE TABLE `ext_act_bpm_log`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `business_key` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '业务流程key',
  `proc_inst_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程实例id',
  `proc_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程名称',
  `task_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务id',
  `task_def_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务key',
  `task_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `op_user_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作人ID',
  `op_user_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作人名称',
  `op_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `op_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作类型:1普通任务;2会签任务;3驳回;4作废;5取回',
  `op_status` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作状态（自行结合业务定义）',
  `remarks` varchar(4000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '意见',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '流程审批日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ext_act_bpm_log
-- ----------------------------

-- ----------------------------
-- Table structure for ext_act_design_flow_data
-- ----------------------------
DROP TABLE IF EXISTS `ext_act_design_flow_data`;
CREATE TABLE `ext_act_design_flow_data`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `desform_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表单ID',
  `desform_code` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表单Code',
  `desform_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表单名称',
  `desform_data_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表单数据ID',
  `bpm_title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程标题',
  `title_exp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '业务标题表达式',
  `process_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程名称',
  `flow_code` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程编码',
  `table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '存储主表名，一对多只存主表',
  `bpm_status` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程状态',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ext_act_design_flow_data
-- ----------------------------

-- ----------------------------
-- Table structure for ext_act_expression
-- ----------------------------
DROP TABLE IF EXISTS `ext_act_expression`;
CREATE TABLE `ext_act_expression`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表达式名称',
  `expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表达式',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '流程表达式' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ext_act_expression
-- ----------------------------

-- ----------------------------
-- Table structure for ext_act_flow_data
-- ----------------------------
DROP TABLE IF EXISTS `ext_act_flow_data`;
CREATE TABLE `ext_act_flow_data`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '序号',
  `form_data_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '多流程表单id',
  `process_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程key',
  `process_inst_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程实例ID',
  `bpm_status_field` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '多流程状态列名',
  `bpm_status` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程状态1:待提交;2:处理中;3处理完毕;4流程作废;5流程挂起',
  `form_table_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '多流程表单表名',
  `relation_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '多流程表单编码',
  `user_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程发起人',
  `process_form_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '业务关联配置id',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_codeformid`(`relation_code` ASC, `form_data_id` ASC) USING BTREE,
  UNIQUE INDEX `uniq_proceskey_formid`(`form_data_id` ASC, `process_key` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '流程表单业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ext_act_flow_data
-- ----------------------------

-- ----------------------------
-- Table structure for ext_act_listener
-- ----------------------------
DROP TABLE IF EXISTS `ext_act_listener`;
CREATE TABLE `ext_act_listener`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `listener_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '监听器名称',
  `listener_type` smallint(6) NULL DEFAULT NULL COMMENT '监听类型 1执行监听 2任务监听',
  `listener_event` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Event属性 触发监听器的事件类型\ncreate：在任务被创建，且所有的任务属性被设置后发生。 \nassignment：在任务分配给某人后发生。注意：当流程执行到 userTask，在触发 create 事件之前，首先触\n发 assignment 事件。这像是一个反常的顺序，但原因很实际：接收到 create 事件，我们往往会要查看包括\n代理人在内的所有任务的属性。 \ncomplete：在任务完成后，任务从运行时的数据中被删除之前发生。',
  `listener_value_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '值类型  javaClass JAVA类，expression 表达式',
  `listener_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '监听器表达式或类名',
  `listener_status` smallint(6) NULL DEFAULT NULL COMMENT '监听器状态\n1：启用\n2：禁用',
  `del_flag` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '删除状态（0，正常，1已删除）',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ext_act_listener
-- ----------------------------

-- ----------------------------
-- Table structure for ext_act_mutil_flow_data
-- ----------------------------
DROP TABLE IF EXISTS `ext_act_mutil_flow_data`;
CREATE TABLE `ext_act_mutil_flow_data`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '序号',
  `form_data_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '多流程表单id',
  `process_key` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程key',
  `process_inst_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程实例ID',
  `bpm_status_field` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bpm_status` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '多流程状态列名',
  `form_table_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '多流程表单表名',
  `relation_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '多流程表单编码',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_codeformid`(`relation_code` ASC, `form_data_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '多流程表单业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ext_act_mutil_flow_data
-- ----------------------------

-- ----------------------------
-- Table structure for ext_act_process
-- ----------------------------
DROP TABLE IF EXISTS `ext_act_process`;
CREATE TABLE `ext_act_process`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `process_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程类型',
  `process_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程ID',
  `process_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程名称',
  `process_status` smallint(6) NULL DEFAULT NULL COMMENT '流程状态0未发布;1已发布',
  `process_xml_path` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程XML路径',
  `process_xml` longblob NULL COMMENT '流程内容',
  `note` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '流程设计表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ext_act_process
-- ----------------------------

-- ----------------------------
-- Table structure for ext_act_process_form
-- ----------------------------
DROP TABLE IF EXISTS `ext_act_process_form`;
CREATE TABLE `ext_act_process_form`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `relation_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '唯一编码',
  `biz_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '业务名称描述',
  `process_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '流程ID',
  `form_table_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Online表名、自定义表单CODE、表名',
  `form_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表单类型：1Online表单,2自定义表单,3自定义开发',
  `title_exp` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题表达式',
  `form_deal_style` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程办理风格',
  `flow_status_col` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程状态列名',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_relationcode`(`relation_code` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '业务基础表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ext_act_process_form
-- ----------------------------

-- ----------------------------
-- Table structure for ext_act_process_node
-- ----------------------------
DROP TABLE IF EXISTS `ext_act_process_node`;
CREATE TABLE `ext_act_process_node`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `form_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `process_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程ID',
  `process_node_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '节点CODE',
  `process_node_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '节点名称',
  `model_and_view` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `model_and_view_mobile` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外部表单跳转方法(移动端)',
  `node_timeout` int(11) NULL DEFAULT NULL COMMENT '节点任务超时设置（单位时）',
  `node_bpm_status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '流程节点表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ext_act_process_node
-- ----------------------------

-- ----------------------------
-- Table structure for ext_act_process_node_auth
-- ----------------------------
DROP TABLE IF EXISTS `ext_act_process_node_auth`;
CREATE TABLE `ext_act_process_node_auth`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `process_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程ID',
  `process_node_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '节点编码',
  `rule_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规则编码',
  `rule_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规则名称',
  `rule_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '策略1显示2禁用',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态(0无效1有效)',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `form_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '3' COMMENT '表单类型：1Online表单,2自定义表单,3自定义开发',
  `form_biz_code` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表单设计编码',
  `desform_com_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件id json中的key',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_pid_nodecode_rulecode`(`process_id` ASC, `process_node_code` ASC, `rule_code` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '流程节点权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ext_act_process_node_auth
-- ----------------------------

-- ----------------------------
-- Table structure for ext_act_process_node_deploy
-- ----------------------------
DROP TABLE IF EXISTS `ext_act_process_node_deploy`;
CREATE TABLE `ext_act_process_node_deploy`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `form_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `process_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程ID',
  `process_node_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '节点CODE',
  `process_node_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '节点名称',
  `model_and_view` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `model_and_view_mobile` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外部表单跳转方法(移动端)',
  `node_timeout` int(11) NULL DEFAULT NULL COMMENT '节点任务超时设置（单位时）',
  `node_bpm_status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程状态',
  `deployment_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部署id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_code_did`(`process_node_code` ASC, `deployment_id` ASC) USING BTREE,
  INDEX `idx_deploymentid`(`deployment_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '流程节点部署表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ext_act_process_node_deploy
-- ----------------------------

-- ----------------------------
-- Table structure for ext_act_task_cc
-- ----------------------------
DROP TABLE IF EXISTS `ext_act_task_cc`;
CREATE TABLE `ext_act_task_cc`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '序号',
  `proc_def_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程定义ID',
  `task_def_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '节点定义ID',
  `proc_inst_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程实例ID',
  `execution_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行实例ID',
  `task_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务ID',
  `task_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `from_user_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务处理人',
  `cc_user_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务抄送人员',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '任务抄送表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ext_act_task_cc
-- ----------------------------

-- ----------------------------
-- Table structure for ext_act_task_notification
-- ----------------------------
DROP TABLE IF EXISTS `ext_act_task_notification`;
CREATE TABLE `ext_act_task_notification`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '序号',
  `task_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务ID',
  `task_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `task_assignee` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务处理人',
  `proc_inst_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程实例id',
  `proc_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程名称',
  `op_time` datetime NULL DEFAULT NULL COMMENT '催办操作时间',
  `notify_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '催办类型1页面通知2邮件',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '催办说明',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '任务催办表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ext_act_task_notification
-- ----------------------------

-- ----------------------------
-- Table structure for ext_biz_leave
-- ----------------------------
DROP TABLE IF EXISTS `ext_biz_leave`;
CREATE TABLE `ext_biz_leave`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ID',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请假人',
  `days` int(11) NULL DEFAULT NULL COMMENT '请假天数',
  `begin_date` datetime NULL DEFAULT NULL COMMENT '开始时间',
  `end_date` datetime NULL DEFAULT NULL COMMENT '请假结束时间',
  `reason` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请假原因',
  `bpm_status` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程状态',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人id'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '请假单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ext_biz_leave
-- ----------------------------

-- ----------------------------
-- Table structure for file_exchange_record
-- ----------------------------
DROP TABLE IF EXISTS `file_exchange_record`;
CREATE TABLE `file_exchange_record`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件标题',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '文件描述',
  `urgent_degree` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '紧急程度(0:一般) (字典code:\'URGENT_DEGREE\')',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'createBy',
  `create_time` datetime NULL DEFAULT NULL COMMENT 'createTime',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'updateBy',
  `update_time` datetime NULL DEFAULT NULL COMMENT 'updateTime',
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发件单位',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT 'isDeleted',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '暂存状态(0：否 1：是)',
  `time_tag` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `IDX_1`(`create_org_code` ASC, `status` ASC, `is_deleted` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1939510727362555906 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文件交换记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of file_exchange_record
-- ----------------------------

-- ----------------------------
-- Table structure for file_record
-- ----------------------------
DROP TABLE IF EXISTS `file_record`;
CREATE TABLE `file_record`  (
  `id` bigint(20) NOT NULL,
  `record_id` bigint(20) NULL DEFAULT NULL COMMENT '记录id',
  `file_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `file_path` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件存储路径',
  `file_type` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件类型',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文件记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of file_record
-- ----------------------------

-- ----------------------------
-- Table structure for file_record_org_rel
-- ----------------------------
DROP TABLE IF EXISTS `file_record_org_rel`;
CREATE TABLE `file_record_org_rel`  (
  `id` bigint(20) NOT NULL,
  `record_id` bigint(20) NULL DEFAULT NULL COMMENT '记录id',
  `org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接收单位',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '已读状态(0:未读 1:已读)',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `IDX_1`(`record_id` ASC) USING BTREE,
  INDEX `IDX_2`(`org_code` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文件交换记录接收单位关系' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of file_record_org_rel
-- ----------------------------

-- ----------------------------
-- Table structure for filing_his
-- ----------------------------
DROP TABLE IF EXISTS `filing_his`;
CREATE TABLE `filing_his`  (
  `id` bigint(20) NOT NULL,
  `temporary_user` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '在家主持工作同志',
  `out_worker` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外出人员',
  `reason` varchar(800) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报备事由',
  `start_time` datetime NULL DEFAULT NULL COMMENT '离岗起始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '离岗结束时间',
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报备人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '报备时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  `out_worker_duty` varchar(640) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外出人员职务',
  `area` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地点',
  `temporary_duty` varchar(640) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '在家主持工作同志职务',
  `temporary_phone` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '在家主持工作同志电话',
  `special_id` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `filing_id` bigint(20) NULL DEFAULT NULL,
  `max_update_num` int(11) NULL DEFAULT 0 COMMENT '最后调整批次，对比展示最大值',
  `sync` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of filing_his
-- ----------------------------

-- ----------------------------
-- Table structure for filing_record
-- ----------------------------
DROP TABLE IF EXISTS `filing_record`;
CREATE TABLE `filing_record`  (
  `id` bigint(20) NOT NULL,
  `temporary_user` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '在家主持工作同志',
  `out_worker` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外出人员',
  `reason` varchar(800) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报备事由',
  `start_time` datetime NULL DEFAULT NULL COMMENT '离岗起始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '离岗结束时间',
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报备人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '报备时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  `out_worker_duty` varchar(640) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外出人员职务',
  `area` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地点',
  `temporary_duty` varchar(640) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '在家主持工作同志职务',
  `temporary_phone` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '在家主持工作同志电话',
  `special_id` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sync` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `filing_record_is_deleted_IDX`(`is_deleted` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '报备记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of filing_record
-- ----------------------------

-- ----------------------------
-- Table structure for group_depart_res
-- ----------------------------
DROP TABLE IF EXISTS `group_depart_res`;
CREATE TABLE `group_depart_res`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tmp_group_id` bigint(20) NULL DEFAULT NULL,
  `org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通过创建部门code判定是本部门或相关部门',
  `is_deleted` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 81 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of group_depart_res
-- ----------------------------

-- ----------------------------
-- Table structure for holiday_schedule
-- ----------------------------
DROP TABLE IF EXISTS `holiday_schedule`;
CREATE TABLE `holiday_schedule`  (
  `id` bigint(20) NOT NULL,
  `hoilday_date` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `hoilday_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '假期维护计划' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of holiday_schedule
-- ----------------------------

-- ----------------------------
-- Table structure for inform_record
-- ----------------------------
DROP TABLE IF EXISTS `inform_record`;
CREATE TABLE `inform_record`  (
  `id` bigint(20) NOT NULL,
  `event_info_id` bigint(20) NULL DEFAULT NULL,
  `file_tile` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件标题',
  `file_mark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件描述',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL COMMENT '指令发送时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL COMMENT '查收时间',
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '查收状态(0:待查收 1：已查收)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of inform_record
-- ----------------------------

-- ----------------------------
-- Table structure for inform_record_det
-- ----------------------------
DROP TABLE IF EXISTS `inform_record_det`;
CREATE TABLE `inform_record_det`  (
  `id` bigint(20) NOT NULL,
  `event_info_id` bigint(20) NULL DEFAULT 0 COMMENT '事件id',
  `inform_record_id` bigint(20) NULL DEFAULT NULL COMMENT '抄告id',
  `target_org_cod` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接收单位',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '0未接收 1已接收',
  `get_time` datetime NULL DEFAULT NULL COMMENT '接收时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `IDX_1`(`inform_record_id` ASC, `status` ASC, `target_org_cod` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of inform_record_det
-- ----------------------------

-- ----------------------------
-- Table structure for inform_record_file
-- ----------------------------
DROP TABLE IF EXISTS `inform_record_file`;
CREATE TABLE `inform_record_file`  (
  `id` bigint(20) NOT NULL,
  `event_info_id` bigint(20) NULL DEFAULT 0 COMMENT '事件id',
  `inform_record_id` bigint(20) NULL DEFAULT NULL COMMENT '抄告id',
  `file_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `file_path` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件存储路径',
  `file_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件类型',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of inform_record_file
-- ----------------------------

-- ----------------------------
-- Table structure for instruction_account
-- ----------------------------
DROP TABLE IF EXISTS `instruction_account`;
CREATE TABLE `instruction_account`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `date` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日期',
  `original_instruction` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '批示原件',
  `title` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件标题',
  `indication_content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '批示指示内容',
  `instruction_no` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '抄清编号',
  `send_user` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通知送达对象',
  `follow_date` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跟批时间',
  `follow_leader` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跟批领导',
  `follow_content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跟批内容',
  `reply_date` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回复时间',
  `reply_dept` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回复单位',
  `reply_content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回复内容',
  `file_path` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '批示文件路径',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人组织机构',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '批示抄清台账' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of instruction_account
-- ----------------------------

-- ----------------------------
-- Table structure for instruction_audit_file
-- ----------------------------
DROP TABLE IF EXISTS `instruction_audit_file`;
CREATE TABLE `instruction_audit_file`  (
  `id` bigint(20) NOT NULL,
  `event_info_id` bigint(20) NULL DEFAULT NULL COMMENT '事件Id',
  `record_id` bigint(20) NULL DEFAULT NULL COMMENT '时间轴记录Id',
  `audit_id` bigint(20) NULL DEFAULT NULL COMMENT '指令分发记录id',
  `file_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `file_path` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件存储路径',
  `file_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件类型',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '事件上传附件' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of instruction_audit_file
-- ----------------------------

-- ----------------------------
-- Table structure for instruction_audit_only_file_org
-- ----------------------------
DROP TABLE IF EXISTS `instruction_audit_only_file_org`;
CREATE TABLE `instruction_audit_only_file_org`  (
  `id` bigint(20) NOT NULL,
  `audit_id` bigint(20) NULL DEFAULT NULL COMMENT '指令审核id',
  `org_code` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '指令仅文件分发对象',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of instruction_audit_only_file_org
-- ----------------------------

-- ----------------------------
-- Table structure for instruction_audit_org
-- ----------------------------
DROP TABLE IF EXISTS `instruction_audit_org`;
CREATE TABLE `instruction_audit_org`  (
  `id` bigint(20) NOT NULL,
  `audit_id` bigint(20) NULL DEFAULT NULL COMMENT '指令审核id',
  `org_code` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '指令分发对象',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '指令分发对象表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of instruction_audit_org
-- ----------------------------

-- ----------------------------
-- Table structure for instruction_audit_person
-- ----------------------------
DROP TABLE IF EXISTS `instruction_audit_person`;
CREATE TABLE `instruction_audit_person`  (
  `id` bigint(20) NOT NULL,
  `audit_id` bigint(20) NULL DEFAULT NULL COMMENT '指令审核id',
  `user_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '指令分发审核人员id',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `opinion` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核意见',
  `status` tinyint(4) NULL DEFAULT 0 COMMENT '审核结果  0待审核  1不通过  2通过',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '指令分发审核人员表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of instruction_audit_person
-- ----------------------------

-- ----------------------------
-- Table structure for instruction_audit_record
-- ----------------------------
DROP TABLE IF EXISTS `instruction_audit_record`;
CREATE TABLE `instruction_audit_record`  (
  `id` bigint(20) NOT NULL,
  `event_info_id` bigint(20) NULL DEFAULT NULL COMMENT '事件id',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件title',
  `report_time` datetime NULL DEFAULT NULL COMMENT '报审时间',
  `content` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '指令内容',
  `proc_inst_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程实例id',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '0.审核中    1.通过   2.不通过   3.已确认发送',
  `stakeholder` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '相关人员（批示领导）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '指令分发审核记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of instruction_audit_record
-- ----------------------------

-- ----------------------------
-- Table structure for instruction_distr_record
-- ----------------------------
DROP TABLE IF EXISTS `instruction_distr_record`;
CREATE TABLE `instruction_distr_record`  (
  `id` bigint(20) NOT NULL,
  `event_info_id` bigint(20) NULL DEFAULT NULL,
  `content` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL COMMENT '指令发送时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL COMMENT '查收时间',
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '查收状态(0:待查收 1：已查收)',
  `stakeholder` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '相关人员（批示领导）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '指令分发记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of instruction_distr_record
-- ----------------------------

-- ----------------------------
-- Table structure for instruction_report
-- ----------------------------
DROP TABLE IF EXISTS `instruction_report`;
CREATE TABLE `instruction_report`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `template_type` tinyint(1) NULL DEFAULT NULL COMMENT '模板类型(0.市委批示抄清模板  1.市政府批示抄清模板)',
  `head` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头信息',
  `phase_year` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '期数年份',
  `phase` int(11) NULL DEFAULT NULL COMMENT '期数',
  `title` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `event_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '事件描述内容(包含html)',
  `instruction_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '批示文本内容(包含html)',
  `from_dept` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成批示抄清的部门',
  `generate_date` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '批示抄清生成的日期',
  `target_user_str` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '目标用户',
  `duty_user_str` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '值班人员',
  `mobile` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `fax` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '传真',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人部门',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '批示抄清报告' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of instruction_report
-- ----------------------------

-- ----------------------------
-- Table structure for jeecg_monthly_growth_analysis
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_monthly_growth_analysis`;
CREATE TABLE `jeecg_monthly_growth_analysis`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `year` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `month` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '月份',
  `main_income` decimal(18, 2) NULL DEFAULT NULL COMMENT '佣金/主营收入',
  `other_income` decimal(18, 2) NULL DEFAULT NULL COMMENT '其他收入',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jeecg_monthly_growth_analysis
-- ----------------------------

-- ----------------------------
-- Table structure for jeecg_order_customer
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_order_customer`;
CREATE TABLE `jeecg_order_customer`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户名',
  `sex` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `idcard` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证号码',
  `idcard_pic` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证扫描件',
  `telphone` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话1',
  `order_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '外键',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jeecg_order_customer
-- ----------------------------

-- ----------------------------
-- Table structure for jeecg_order_main
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_order_main`;
CREATE TABLE `jeecg_order_main`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `order_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单号',
  `ctype` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单类型',
  `order_date` datetime NULL DEFAULT NULL COMMENT '订单日期',
  `order_money` double(10, 3) NULL DEFAULT NULL COMMENT '订单金额',
  `content` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单备注',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jeecg_order_main
-- ----------------------------

-- ----------------------------
-- Table structure for jeecg_order_ticket
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_order_ticket`;
CREATE TABLE `jeecg_order_ticket`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `ticket_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '航班号',
  `tickect_date` datetime NULL DEFAULT NULL COMMENT '航班时间',
  `order_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '外键',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jeecg_order_ticket
-- ----------------------------

-- ----------------------------
-- Table structure for jeecg_project_nature_income
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_project_nature_income`;
CREATE TABLE `jeecg_project_nature_income`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nature` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '项目性质',
  `insurance_fee` decimal(18, 2) NULL DEFAULT NULL COMMENT '保险经纪佣金费',
  `risk_consulting_fee` decimal(18, 2) NULL DEFAULT NULL COMMENT '风险咨询费',
  `evaluation_fee` decimal(18, 2) NULL DEFAULT NULL COMMENT '承保公估评估费',
  `insurance_evaluation_fee` decimal(18, 2) NULL DEFAULT NULL COMMENT '保险公估费',
  `bidding_consulting_fee` decimal(18, 2) NULL DEFAULT NULL COMMENT '投标咨询费',
  `interol_consulting_fee` decimal(18, 2) NULL DEFAULT NULL COMMENT '内控咨询费',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jeecg_project_nature_income
-- ----------------------------

-- ----------------------------
-- Table structure for jeecg_tree_demo
-- ----------------------------
DROP TABLE IF EXISTS `jeecg_tree_demo`;
CREATE TABLE `jeecg_tree_demo`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门',
  `wl_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物料名字',
  `wl_code` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物料编码',
  `pid` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父物料',
  `has_child` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否有子节点',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jeecg_tree_demo
-- ----------------------------

-- ----------------------------
-- Table structure for joa_busines_strip
-- ----------------------------
DROP TABLE IF EXISTS `joa_busines_strip`;
CREATE TABLE `joa_busines_strip`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `apply_no` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出差申请单编号',
  `apply_user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出差人',
  `depart_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门id',
  `depart_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `project_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '项目id',
  `project_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '项目名称',
  `destination` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '目的地',
  `departure_time` datetime NULL DEFAULT NULL COMMENT '出发时间',
  `planned_return_time` datetime NULL DEFAULT NULL COMMENT '计划返回时间',
  `actual_return_time` datetime NULL DEFAULT NULL COMMENT '实际返回时间',
  `day_num` smallint(6) NULL DEFAULT NULL COMMENT '出差天数',
  `travel_tool` smallint(6) NULL DEFAULT NULL COMMENT '出行工具',
  `loan_money` decimal(11, 2) NULL DEFAULT NULL COMMENT '借款金额',
  `travel_expenses_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出差经费支出类型',
  `reason` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '任务及事由',
  `depart_leader_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门领导id',
  `depart_leader_audit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门领导审核',
  `finance_user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '财务用户id',
  `finance_audit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '财务审核',
  `cashier_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出纳员id',
  `cashier_loan_amount` decimal(11, 2) NULL DEFAULT NULL COMMENT '出纳放款金额',
  `manager_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '总经理id',
  `manager_audit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '总经理审核',
  `cashier_loan_time` datetime NULL DEFAULT NULL COMMENT '借款发放时间',
  `depart_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出发地',
  `bpm_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '流转状态',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '出差表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of joa_busines_strip
-- ----------------------------

-- ----------------------------
-- Table structure for joa_demo
-- ----------------------------
DROP TABLE IF EXISTS `joa_demo`;
CREATE TABLE `joa_demo`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ID',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请假人',
  `days` int(11) NULL DEFAULT NULL COMMENT '请假天数',
  `begin_date` datetime NULL DEFAULT NULL COMMENT '开始时间',
  `end_date` datetime NULL DEFAULT NULL COMMENT '请假结束时间',
  `reason` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请假原因',
  `bpm_status` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '流程状态',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人id'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '流程测试' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of joa_demo
-- ----------------------------

-- ----------------------------
-- Table structure for joa_doc_receiving
-- ----------------------------
DROP TABLE IF EXISTS `joa_doc_receiving`;
CREATE TABLE `joa_doc_receiving`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `create_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程状态',
  `doc_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收文字号',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '来文标题',
  `from_depart` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '来文部门',
  `from_date` datetime NULL DEFAULT NULL COMMENT '来文日期',
  `urgency` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '缓急程度',
  `confidentiality` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机密度',
  `classification` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文种',
  `doc_type` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公文分类',
  `receive_num` int(11) NULL DEFAULT NULL COMMENT '收文份数',
  `keyword` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关键词',
  `ext_file` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '相关文件',
  `booker` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登记人',
  `book_date` datetime NULL DEFAULT NULL COMMENT '登记时间',
  `receiver` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收文人',
  `receiver_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收文人名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '公文收文' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of joa_doc_receiving
-- ----------------------------

-- ----------------------------
-- Table structure for joa_doc_sending
-- ----------------------------
DROP TABLE IF EXISTS `joa_doc_sending`;
CREATE TABLE `joa_doc_sending`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `create_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属公司',
  `bpm_status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程状态',
  `doc_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发文字号',
  `booker` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登记人',
  `book_date` datetime NULL DEFAULT NULL COMMENT '登记时间',
  `receiver` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收文人',
  `receiver_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收文人名称',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公文标题',
  `send_target` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发文目标',
  `send_depart` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主送机关',
  `doc_type` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公文分类',
  `classification` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文种',
  `confidentiality` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机密度',
  `urgency` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '缓急程度',
  `written_date` datetime NULL DEFAULT NULL COMMENT '成文日期',
  `review_date` datetime NULL DEFAULT NULL COMMENT '审阅时间',
  `theme` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主题词',
  `ext_file` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '相关文件',
  `print_score` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '印刷分数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '公文发文' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of joa_doc_sending
-- ----------------------------

-- ----------------------------
-- Table structure for joa_employee_leave
-- ----------------------------
DROP TABLE IF EXISTS `joa_employee_leave`;
CREATE TABLE `joa_employee_leave`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `apply_no` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '申请编号',
  `apply_date` datetime NULL DEFAULT NULL COMMENT '申请日期',
  `duty` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务',
  `leave_category` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请假类别',
  `leave_reason` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请假原因',
  `leave_start_date` datetime NULL DEFAULT NULL COMMENT '请假开始时间',
  `leave_end_date` datetime NULL DEFAULT NULL COMMENT '请假结束时间',
  `total` double(5, 1) NULL DEFAULT NULL COMMENT '共计',
  `contact_way` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '紧急联系方式',
  `duty_deputy` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '批定职务代理人',
  `leader_approval` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '直接主管审批',
  `dept_principal_approval` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门负责人审批',
  `hr_principal_approval` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'HR负责人审批',
  `hr_records` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '行政部备案',
  `department` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门',
  `bpm_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '流转状态',
  `create_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人id',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '请假申请' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of joa_employee_leave
-- ----------------------------

-- ----------------------------
-- Table structure for joa_loan
-- ----------------------------
DROP TABLE IF EXISTS `joa_loan`;
CREATE TABLE `joa_loan`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `apply_no` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '借款单编号',
  `trip_apply_no` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出差申请单编号',
  `loan_user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '借款人id',
  `loan_user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '借款人',
  `depart_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门id',
  `depart_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `loan_time` datetime NULL DEFAULT NULL COMMENT '借款时间',
  `loan_amount` decimal(11, 2) NULL DEFAULT NULL COMMENT '借款金额',
  `loan_usage` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '借款用途',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `depart_leader_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门领导id',
  `depart_leader_audit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门领导审核',
  `finance_user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '财务用户id',
  `finance_audit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '财务审核',
  `cashier_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出纳员id',
  `cashier_loan_amount` decimal(11, 2) NULL DEFAULT NULL COMMENT '出纳放款金额',
  `cashier_loan_time` datetime NULL DEFAULT NULL COMMENT '出纳放款时间',
  `manager_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '总经理id',
  `manager_audit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '总经理审核',
  `bpm_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '流转状态',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '借款表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of joa_loan
-- ----------------------------

-- ----------------------------
-- Table structure for joa_onl_bthuiq
-- ----------------------------
DROP TABLE IF EXISTS `joa_onl_bthuiq`;
CREATE TABLE `joa_onl_bthuiq`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'id',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '并行会签标题',
  `start_time` datetime NULL DEFAULT NULL COMMENT '会签发起时间',
  `bpm_status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '流程状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '并行会签测试' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of joa_onl_bthuiq
-- ----------------------------

-- ----------------------------
-- Table structure for joa_onl_leave
-- ----------------------------
DROP TABLE IF EXISTS `joa_onl_leave`;
CREATE TABLE `joa_onl_leave`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ID',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请假人',
  `days` int(11) NULL DEFAULT NULL COMMENT '请假天数',
  `begin_date` datetime NULL DEFAULT NULL COMMENT '开始时间',
  `end_date` datetime NULL DEFAULT NULL COMMENT '请假结束时间',
  `reason` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请假原因',
  `bpm_status` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '流程状态',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人id',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人id'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '请假单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of joa_onl_leave
-- ----------------------------

-- ----------------------------
-- Table structure for joa_onl_sxhuiq
-- ----------------------------
DROP TABLE IF EXISTS `joa_onl_sxhuiq`;
CREATE TABLE `joa_onl_sxhuiq`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '顺序会签标题',
  `start_time` datetime NULL DEFAULT NULL COMMENT '会签发起时间',
  `bpm_status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '流程状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '顺序会签测试' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of joa_onl_sxhuiq
-- ----------------------------

-- ----------------------------
-- Table structure for leader_duty
-- ----------------------------
DROP TABLE IF EXISTS `leader_duty`;
CREATE TABLE `leader_duty`  (
  `id` bigint(20) NOT NULL,
  `duty_date` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '值班日期',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  `org_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '值班单位',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '领导排班' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of leader_duty
-- ----------------------------

-- ----------------------------
-- Table structure for leader_duty_user_rel
-- ----------------------------
DROP TABLE IF EXISTS `leader_duty_user_rel`;
CREATE TABLE `leader_duty_user_rel`  (
  `id` bigint(20) NOT NULL,
  `leader_duty_id` bigint(20) NULL DEFAULT NULL,
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '人员姓名',
  `user_phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '人员电话',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '领导排班人员关系' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of leader_duty_user_rel
-- ----------------------------

-- ----------------------------
-- Table structure for leader_roster
-- ----------------------------
DROP TABLE IF EXISTS `leader_roster`;
CREATE TABLE `leader_roster`  (
  `id` bigint(20) NOT NULL,
  `duty_date` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '值班日期',
  `duty_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '值班单位',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of leader_roster
-- ----------------------------

-- ----------------------------
-- Table structure for leader_roster_user_rel
-- ----------------------------
DROP TABLE IF EXISTS `leader_roster_user_rel`;
CREATE TABLE `leader_roster_user_rel`  (
  `id` bigint(20) NOT NULL,
  `duty_roster_id` bigint(20) NULL DEFAULT NULL,
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '人员姓名',
  `user_url` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '人员照片url',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  `duty_level` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '排班级别',
  `user_post` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务名称',
  `post_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务编码',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户角色',
  `land_line` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '座机',
  `man_order` int(11) NULL DEFAULT NULL COMMENT '人员排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of leader_roster_user_rel
-- ----------------------------

-- ----------------------------
-- Table structure for ne_event_district
-- ----------------------------
DROP TABLE IF EXISTS `ne_event_district`;
CREATE TABLE `ne_event_district`  (
  `id` bigint(20) NOT NULL,
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父id',
  `type` tinyint(4) NULL DEFAULT NULL COMMENT '类型：市，区，街道',
  `full_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区域全名',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '事件区域信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ne_event_district
-- ----------------------------

-- ----------------------------
-- Table structure for oa_become_regular
-- ----------------------------
DROP TABLE IF EXISTS `oa_become_regular`;
CREATE TABLE `oa_become_regular`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'id',
  `biz_no` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编号',
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户ID',
  `real_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `hiredate` datetime NULL DEFAULT NULL COMMENT '入职时间',
  `depart_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门ID',
  `depart_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `probation_post` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '试用期职位',
  `reason` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '申请理由',
  `work_summary` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '工作总结',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态（1：申请中 2：通过）',
  `create_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `sys_org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组织机构编码',
  `bpm_status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '流程状态'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '人事转正记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oa_become_regular
-- ----------------------------

-- ----------------------------
-- Table structure for oa_employee_award
-- ----------------------------
DROP TABLE IF EXISTS `oa_employee_award`;
CREATE TABLE `oa_employee_award`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'id',
  `employee_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工ID',
  `award_time` datetime NULL DEFAULT NULL COMMENT '获奖时间',
  `award_place` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '获奖地点',
  `award_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '获奖名称',
  `order_no` int(11) NULL DEFAULT NULL COMMENT '序号',
  `create_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `sys_org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组织机构编码'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工所获奖励表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oa_employee_award
-- ----------------------------

-- ----------------------------
-- Table structure for oa_employee_certificate
-- ----------------------------
DROP TABLE IF EXISTS `oa_employee_certificate`;
CREATE TABLE `oa_employee_certificate`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'id',
  `employee_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工ID',
  `cert_time` datetime NULL DEFAULT NULL COMMENT '发证时间',
  `cert_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '证书名称',
  `cert_level` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '证书级别',
  `cert_organizations` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发证机关',
  `memo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `order_no` int(11) NULL DEFAULT NULL COMMENT '序号',
  `create_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `sys_org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组织机构编码'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工证书表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oa_employee_certificate
-- ----------------------------

-- ----------------------------
-- Table structure for oa_employee_education
-- ----------------------------
DROP TABLE IF EXISTS `oa_employee_education`;
CREATE TABLE `oa_employee_education`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'id',
  `employee_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工ID',
  `from_time` datetime NULL DEFAULT NULL COMMENT '开始日期',
  `to_time` datetime NULL DEFAULT NULL COMMENT '截止时间',
  `school` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学校',
  `speciality` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '专业',
  `post` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务',
  `order_no` int(11) NULL DEFAULT NULL COMMENT '序号',
  `create_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `sys_org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组织机构编码'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工学历表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oa_employee_education
-- ----------------------------

-- ----------------------------
-- Table structure for oa_employee_experience
-- ----------------------------
DROP TABLE IF EXISTS `oa_employee_experience`;
CREATE TABLE `oa_employee_experience`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'id',
  `employee_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工ID',
  `from_time` datetime NULL DEFAULT NULL COMMENT '开始日期',
  `to_time` datetime NULL DEFAULT NULL COMMENT '截止时间',
  `workplace` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工作单位',
  `witness` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '证明人',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系方式',
  `order_no` int(11) NULL DEFAULT NULL COMMENT '序号',
  `create_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `sys_org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组织机构编码'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工工作经历表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oa_employee_experience
-- ----------------------------

-- ----------------------------
-- Table structure for oa_employee_family
-- ----------------------------
DROP TABLE IF EXISTS `oa_employee_family`;
CREATE TABLE `oa_employee_family`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'id',
  `employee_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工ID',
  `real_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `relation` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关系',
  `age` int(11) NULL DEFAULT NULL COMMENT '年龄',
  `workplace` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工作单位',
  `politically_status` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '政治面貌',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系方式',
  `order_no` int(11) NULL DEFAULT NULL COMMENT '序号',
  `create_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `sys_org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组织机构编码'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工家庭成员表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oa_employee_family
-- ----------------------------

-- ----------------------------
-- Table structure for oa_employee_info
-- ----------------------------
DROP TABLE IF EXISTS `oa_employee_info`;
CREATE TABLE `oa_employee_info`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'id',
  `depart_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所在部门',
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户id',
  `post` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务',
  `real_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `sex` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `birthday` datetime NULL DEFAULT NULL COMMENT '出生日期',
  `politically_status` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '政治面貌',
  `school` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '毕业学校',
  `native_place` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '籍贯',
  `nation` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '民族',
  `healthy` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '健康状况',
  `residence_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '户籍类别',
  `education` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学历',
  `speciality` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '专业',
  `graduation_time` datetime NULL DEFAULT NULL COMMENT '毕业时间',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `mobile` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '照片',
  `identity_no` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `first_job_time` datetime NULL DEFAULT NULL COMMENT '首次工作时间',
  `entrytime` datetime NULL DEFAULT NULL COMMENT '入职时间',
  `marital_status` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '婚姻状况',
  `have_children` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '有无子女',
  `join_party_info` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '入党（团）时间地点',
  `residence_street` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '户口所在街道',
  `residence_address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '户籍地址',
  `residence_postcode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '户籍邮编',
  `current_address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '现居住地',
  `current_postcode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '现居住地邮编',
  `paying_social_insurance` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否上社保',
  `having_reserve_funds` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否有公积金',
  `interest` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '兴趣爱好',
  `social_insurance_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参加社保类型',
  `archives_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '档案所在地',
  `inside_transfer` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内部工作调动情况',
  `social_insurance_time` datetime NULL DEFAULT NULL COMMENT '五险一金日期',
  `create_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `sys_org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组织机构编码',
  `depart_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所在部门id',
  `bpm_status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '流程状态'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工登记信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oa_employee_info
-- ----------------------------

-- ----------------------------
-- Table structure for oa_employee_relations
-- ----------------------------
DROP TABLE IF EXISTS `oa_employee_relations`;
CREATE TABLE `oa_employee_relations`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'id',
  `employee_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工ID',
  `real_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `relation` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关系',
  `age` int(11) NULL DEFAULT NULL COMMENT '年龄',
  `workplace` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工作单位',
  `politically_status` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '政治面貌',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系方式',
  `order_no` int(11) NULL DEFAULT NULL COMMENT '序号',
  `create_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `sys_org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组织机构编码'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工社会关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oa_employee_relations
-- ----------------------------

-- ----------------------------
-- Table structure for onl_cgform_button
-- ----------------------------
DROP TABLE IF EXISTS `onl_cgform_button`;
CREATE TABLE `onl_cgform_button`  (
  `ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键ID',
  `BUTTON_CODE` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮编码',
  `BUTTON_ICON` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮图标',
  `BUTTON_NAME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮名称',
  `BUTTON_STATUS` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮状态',
  `BUTTON_STYLE` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮样式',
  `EXP` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表达式',
  `CGFORM_HEAD_ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表单ID',
  `OPT_TYPE` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮类型',
  `ORDER_NUM` int(11) NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `index_formid`(`CGFORM_HEAD_ID` ASC) USING BTREE,
  INDEX `index_button_code`(`BUTTON_CODE` ASC) USING BTREE,
  INDEX `index_button_status`(`BUTTON_STATUS` ASC) USING BTREE,
  INDEX `index_button_order`(`ORDER_NUM` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of onl_cgform_button
-- ----------------------------

-- ----------------------------
-- Table structure for onl_cgform_enhance_java
-- ----------------------------
DROP TABLE IF EXISTS `onl_cgform_enhance_java`;
CREATE TABLE `onl_cgform_enhance_java`  (
  `ID` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `BUTTON_CODE` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮编码',
  `CG_JAVA_TYPE` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型',
  `CG_JAVA_VALUE` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数值',
  `CGFORM_HEAD_ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表单ID',
  `ACTIVE_STATUS` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '生效状态',
  `EVENT` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'end' COMMENT '事件状态(end:结束，start:开始)',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `index_fmid`(`CGFORM_HEAD_ID` ASC) USING BTREE,
  INDEX `index_buttoncode`(`BUTTON_CODE` ASC) USING BTREE,
  INDEX `index_status`(`ACTIVE_STATUS` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of onl_cgform_enhance_java
-- ----------------------------

-- ----------------------------
-- Table structure for onl_cgform_enhance_js
-- ----------------------------
DROP TABLE IF EXISTS `onl_cgform_enhance_js`;
CREATE TABLE `onl_cgform_enhance_js`  (
  `ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键ID',
  `CG_JS` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'JS增强内容',
  `CG_JS_TYPE` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型',
  `CONTENT` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `CGFORM_HEAD_ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表单ID',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `index_fmid`(`CGFORM_HEAD_ID` ASC) USING BTREE,
  INDEX `index_jstype`(`CG_JS_TYPE` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of onl_cgform_enhance_js
-- ----------------------------

-- ----------------------------
-- Table structure for onl_cgform_enhance_sql
-- ----------------------------
DROP TABLE IF EXISTS `onl_cgform_enhance_sql`;
CREATE TABLE `onl_cgform_enhance_sql`  (
  `ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键ID',
  `BUTTON_CODE` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮编码',
  `CGB_SQL` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'SQL内容',
  `CGB_SQL_NAME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Sql名称',
  `CONTENT` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `CGFORM_HEAD_ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表单ID',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `index_formid`(`CGFORM_HEAD_ID` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of onl_cgform_enhance_sql
-- ----------------------------

-- ----------------------------
-- Table structure for onl_cgform_field
-- ----------------------------
DROP TABLE IF EXISTS `onl_cgform_field`;
CREATE TABLE `onl_cgform_field`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键ID',
  `cgform_head_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表ID',
  `db_field_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名字',
  `db_field_txt` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段备注',
  `db_field_name_old` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '原字段名',
  `db_is_key` tinyint(1) NULL DEFAULT NULL COMMENT '是否主键 0否 1是',
  `db_is_null` tinyint(1) NULL DEFAULT NULL COMMENT '是否允许为空0否 1是',
  `db_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据库字段类型',
  `db_length` int(11) NOT NULL COMMENT '数据库字段长度',
  `db_point_length` int(11) NULL DEFAULT NULL COMMENT '小数点',
  `db_default_val` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表字段默认值',
  `dict_field` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典code',
  `dict_table` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典表',
  `dict_text` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典Text',
  `field_show_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表单控件类型',
  `field_href` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跳转URL',
  `field_length` int(11) NULL DEFAULT NULL COMMENT '表单控件长度',
  `field_valid_type` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表单字段校验规则',
  `field_must_input` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段是否必填',
  `field_extend_json` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展参数JSON',
  `field_value_rule_code` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '填值规则code',
  `is_query` tinyint(1) NULL DEFAULT NULL COMMENT '是否查询条件0否 1是',
  `is_show_form` tinyint(1) NULL DEFAULT NULL COMMENT '表单是否显示0否 1是',
  `is_show_list` tinyint(1) NULL DEFAULT NULL COMMENT '列表是否显示0否 1是',
  `query_mode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询模式',
  `main_table` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外键主表名',
  `main_field` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外键主键字段',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `inex_table_id`(`cgform_head_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of onl_cgform_field
-- ----------------------------

-- ----------------------------
-- Table structure for onl_cgform_head
-- ----------------------------
DROP TABLE IF EXISTS `onl_cgform_head`;
CREATE TABLE `onl_cgform_head`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键ID',
  `table_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表名',
  `table_type` int(11) NOT NULL COMMENT '表类型: 0单表、1主表、2附表',
  `table_version` int(11) NULL DEFAULT 1 COMMENT '表版本',
  `table_txt` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表说明',
  `is_checkbox` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否带checkbox',
  `is_db_synch` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'N' COMMENT '同步数据库状态',
  `is_page` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否分页',
  `is_tree` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否是树',
  `id_sequence` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主键生成序列',
  `id_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主键类型',
  `query_mode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '查询模式',
  `relation_type` int(11) NULL DEFAULT NULL COMMENT '映射关系 0一对多  1一对一',
  `sub_table_str` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '子表',
  `tab_order_num` int(11) NULL DEFAULT NULL COMMENT '附表排序序号',
  `tree_parent_id_field` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '树形表单父id',
  `tree_id_field` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '树表主键字段',
  `tree_fieldname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '树开表单列字段',
  `form_category` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'bdfl_ptbd' COMMENT '表单分类',
  `form_template` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'PC表单模板',
  `form_template_mobile` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表单模板样式(移动端)',
  `scroll` int(11) NULL DEFAULT 0 COMMENT '是否有横向滚动条',
  `copy_version` int(11) NULL DEFAULT NULL COMMENT '复制版本号',
  `copy_type` int(11) NULL DEFAULT 0 COMMENT '复制表类型1为复制表 0为原始表',
  `physic_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '原始表ID',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `index_onlineform_table_name`(`table_name` ASC) USING BTREE,
  INDEX `index_form_templdate`(`form_template` ASC) USING BTREE,
  INDEX `index_templdate_mobile`(`form_template_mobile` ASC) USING BTREE,
  INDEX `index_onlineform_table_version`(`table_version` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of onl_cgform_head
-- ----------------------------

-- ----------------------------
-- Table structure for onl_cgform_index
-- ----------------------------
DROP TABLE IF EXISTS `onl_cgform_index`;
CREATE TABLE `onl_cgform_index`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `cgform_head_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主表id',
  `index_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '索引名称',
  `index_field` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '索引栏位',
  `index_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '索引类型',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_table_id`(`cgform_head_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of onl_cgform_index
-- ----------------------------

-- ----------------------------
-- Table structure for onl_cgreport_head
-- ----------------------------
DROP TABLE IF EXISTS `onl_cgreport_head`;
CREATE TABLE `onl_cgreport_head`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表编码',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表名字',
  `cgr_sql` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表SQL',
  `return_val_field` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '返回值字段',
  `return_txt_field` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '返回文本字段',
  `return_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '返回类型，单选或多选',
  `db_source` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '动态数据源',
  `content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人id',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `index_onlinereport_code`(`code` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of onl_cgreport_head
-- ----------------------------

-- ----------------------------
-- Table structure for onl_cgreport_item
-- ----------------------------
DROP TABLE IF EXISTS `onl_cgreport_item`;
CREATE TABLE `onl_cgreport_item`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cgrhead_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表ID',
  `field_name` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名字',
  `field_txt` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段文本',
  `field_width` int(11) NULL DEFAULT NULL,
  `field_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段类型',
  `search_mode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询模式',
  `is_order` int(11) NULL DEFAULT 0 COMMENT '是否排序  0否,1是',
  `is_search` int(11) NULL DEFAULT 0 COMMENT '是否查询  0否,1是',
  `dict_code` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典CODE',
  `field_href` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段跳转URL',
  `is_show` int(11) NULL DEFAULT 1 COMMENT '是否显示  0否,1显示',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  `replace_val` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '取值表达式',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_CGRHEAD_ID`(`cgrhead_id` ASC) USING BTREE,
  INDEX `index_isshow`(`is_show` ASC) USING BTREE,
  INDEX `index_order_num`(`order_num` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of onl_cgreport_item
-- ----------------------------

-- ----------------------------
-- Table structure for onl_cgreport_param
-- ----------------------------
DROP TABLE IF EXISTS `onl_cgreport_param`;
CREATE TABLE `onl_cgreport_param`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cgrhead_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '动态报表ID',
  `param_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参数字段',
  `param_txt` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数文本',
  `param_value` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数默认值',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_cgrheadid`(`cgrhead_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of onl_cgreport_param
-- ----------------------------

-- ----------------------------
-- Table structure for onl_graphreport_head
-- ----------------------------
DROP TABLE IF EXISTS `onl_graphreport_head`;
CREATE TABLE `onl_graphreport_head`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'id',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图表名称',
  `code` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图表编码',
  `cgr_sql` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '查询数据SQL',
  `xaxis_field` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'X轴数据字段',
  `yaxis_field` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'Y轴数据字段',
  `yaxis_text` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'y轴文字描述',
  `content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `extend_js` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展JS',
  `graph_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图表类型',
  `is_combination` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'combination' COMMENT '是否组合',
  `display_template` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '展示模板',
  `data_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据类型',
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `index_code`(`code` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of onl_graphreport_head
-- ----------------------------

-- ----------------------------
-- Table structure for onl_graphreport_item
-- ----------------------------
DROP TABLE IF EXISTS `onl_graphreport_item`;
CREATE TABLE `onl_graphreport_item`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'id',
  `graphreport_head_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主表ID',
  `field_name` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段名',
  `field_txt` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段文本',
  `is_show` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否列表显示',
  `is_total` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否计算总计（仅对数值有效）',
  `search_flag` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否查询',
  `search_mode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询模式',
  `dict_code` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典Code',
  `field_href` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段href',
  `field_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段类型',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  `replace_val` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '取值表达式',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_headid`(`graphreport_head_id` ASC) USING BTREE,
  INDEX `index_isshow`(`is_show` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'jform_graphreport_item' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of onl_graphreport_item
-- ----------------------------

-- ----------------------------
-- Table structure for onl_graphreport_templet
-- ----------------------------
DROP TABLE IF EXISTS `onl_graphreport_templet`;
CREATE TABLE `onl_graphreport_templet`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `templet_code` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `templet_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报表名称',
  `templet_style` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报表风格模板（单排、双排、Tab模式、分组模式-根据配置动态展示、可自定义...）',
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of onl_graphreport_templet
-- ----------------------------

-- ----------------------------
-- Table structure for onl_graphreport_templet_item
-- ----------------------------
DROP TABLE IF EXISTS `onl_graphreport_templet_item`;
CREATE TABLE `onl_graphreport_templet_item`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `graphreport_templet_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `graphreport_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图表编码',
  `graphreport_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图表类型（饼状图、曲线图、柱状图、数据列表等）',
  `group_num` int(11) NULL DEFAULT NULL COMMENT '组合数字，默认值0 非必填',
  `group_style` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组合展示风格（1 卡片，2 tab）非必填',
  `group_txt` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分组描述',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  `is_show` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否显示 1显示 0不显示，默认1',
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_graphreport_templet_id_fk`(`graphreport_templet_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of onl_graphreport_templet_item
-- ----------------------------

-- ----------------------------
-- Table structure for oss_file
-- ----------------------------
DROP TABLE IF EXISTS `oss_file`;
CREATE TABLE `oss_file`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键id',
  `file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件地址',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Oss File' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oss_file
-- ----------------------------

-- ----------------------------
-- Table structure for person_plan
-- ----------------------------
DROP TABLE IF EXISTS `person_plan`;
CREATE TABLE `person_plan`  (
  `id` bigint(20) NOT NULL,
  `plan_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL COMMENT '指令发送时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL COMMENT '查收时间',
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of person_plan
-- ----------------------------

-- ----------------------------
-- Table structure for person_plan_res
-- ----------------------------
DROP TABLE IF EXISTS `person_plan_res`;
CREATE TABLE `person_plan_res`  (
  `id` bigint(20) NOT NULL,
  `plan_id` bigint(20) NULL DEFAULT NULL,
  `person_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `person_type` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL COMMENT '指令发送时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL COMMENT '查收时间',
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of person_plan_res
-- ----------------------------

-- ----------------------------
-- Table structure for phone_event_res
-- ----------------------------
DROP TABLE IF EXISTS `phone_event_res`;
CREATE TABLE `phone_event_res`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `event_id` bigint(20) NULL DEFAULT NULL COMMENT '事件id',
  `user_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '人员ID',
  `rep_status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '上报：1   续报 ：2',
  `user_status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '主送：1 抄送：2',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通过创建部门code判定是本部门或相关部门',
  `is_deleted` int(11) NULL DEFAULT 0,
  `is_read` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '是否已读(0:未读 1：已读)',
  `first_time` datetime NULL DEFAULT NULL COMMENT '首报阅读时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of phone_event_res
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `BLOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CRON_EXPRESSION` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TIME_ZONE_ID` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ENTRY_ID` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `FIRED_TIME` bigint(20) NOT NULL,
  `SCHED_TIME` bigint(20) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `ENTRY_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `IS_DURABLE` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `IS_UPDATE_DATA` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `LOCK_NAME` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `LOCK_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('quartzScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `LAST_CHECKIN_TIME` bigint(20) NOT NULL,
  `CHECKIN_INTERVAL` bigint(20) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `REPEAT_COUNT` bigint(20) NOT NULL,
  `REPEAT_INTERVAL` bigint(20) NOT NULL,
  `TIMES_TRIGGERED` bigint(20) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `STR_PROP_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `STR_PROP_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `STR_PROP_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `INT_PROP_1` int(11) NULL DEFAULT NULL,
  `INT_PROP_2` int(11) NULL DEFAULT NULL,
  `LONG_PROP_1` bigint(20) NULL DEFAULT NULL,
  `LONG_PROP_2` bigint(20) NULL DEFAULT NULL,
  `DEC_PROP_1` decimal(13, 4) NULL DEFAULT NULL,
  `DEC_PROP_2` decimal(13, 4) NULL DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(20) NULL DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(20) NULL DEFAULT NULL,
  `PRIORITY` int(11) NULL DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_TYPE` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `START_TIME` bigint(20) NOT NULL,
  `END_TIME` bigint(20) NULL DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `MISFIRE_INSTR` smallint(6) NULL DEFAULT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `SCHED_NAME`(`SCHED_NAME` ASC, `JOB_NAME` ASC, `JOB_GROUP` ASC) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for recording_account
-- ----------------------------
DROP TABLE IF EXISTS `recording_account`;
CREATE TABLE `recording_account`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `call_time` datetime NULL DEFAULT NULL COMMENT '发起呼叫时间',
  `send_org_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '呼出单位编码',
  `answer_org_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接听单位编码',
  `ring_number` tinyint(4) NULL DEFAULT NULL COMMENT '响铃次数',
  `recording_length` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '录音文件长度',
  `recording_url` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '录音文件地址',
  `is_bind_event` tinyint(1) NULL DEFAULT 0 COMMENT '是否关联了事件(0:未关联  1：已关联)',
  `event_info_id` bigint(20) NULL DEFAULT NULL COMMENT '事件id',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  `is_finish_call` tinyint(1) NULL DEFAULT 0 COMMENT '是否结束通话（0：未结束 1：已结束）',
  `call_end_time` datetime NULL DEFAULT NULL COMMENT '结束呼叫时间',
  `ucid` varchar(22) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通话唯一表示Id',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `oss_url` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'oss文件地址',
  `text_status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '转文字情况  0：未转   1：完成   2：失败',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '录音台账' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of recording_account
-- ----------------------------

-- ----------------------------
-- Table structure for recording_account1
-- ----------------------------
DROP TABLE IF EXISTS `recording_account1`;
CREATE TABLE `recording_account1`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `call_time` datetime NULL DEFAULT NULL COMMENT '发起呼叫时间',
  `send_org_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '呼出单位编码',
  `answer_org_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接听单位编码',
  `ring_number` tinyint(4) NULL DEFAULT NULL COMMENT '响铃次数',
  `recording_length` varchar(7) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '录音文件长度',
  `recording_url` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '录音文件地址',
  `is_bind_event` tinyint(1) NULL DEFAULT 0 COMMENT '是否关联了事件(0:未关联  1：已关联)',
  `event_info_id` bigint(20) NULL DEFAULT NULL COMMENT '事件id',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '录音台账' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of recording_account1
-- ----------------------------

-- ----------------------------
-- Table structure for recording_account_text
-- ----------------------------
DROP TABLE IF EXISTS `recording_account_text`;
CREATE TABLE `recording_account_text`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `ra_id` bigint(20) NULL DEFAULT NULL COMMENT 'recording表外键',
  `lid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `begin` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `spk` int(11) NULL DEFAULT NULL COMMENT '1：呼叫方   2：被呼方',
  `end` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sc` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `onebest` varchar(800) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of recording_account_text
-- ----------------------------

-- ----------------------------
-- Table structure for relevant_depart
-- ----------------------------
DROP TABLE IF EXISTS `relevant_depart`;
CREATE TABLE `relevant_depart`  (
  `id` bigint(20) NOT NULL,
  `dept_org_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '部门组织编码',
  `dept_org_code_rel` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '相关部门组织编码',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '相关部门关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of relevant_depart
-- ----------------------------

-- ----------------------------
-- Table structure for report_dept
-- ----------------------------
DROP TABLE IF EXISTS `report_dept`;
CREATE TABLE `report_dept`  (
  `id` bigint(20) NOT NULL,
  `report_info_id` bigint(20) NULL DEFAULT NULL,
  `event_info_id` bigint(20) NULL DEFAULT NULL,
  `org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上报部门',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '信息接报状态',
  `is_read` int(11) NULL DEFAULT 0 COMMENT '是否已读(0:未读 1：已读)',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `IDX_2`(`report_info_id` ASC) USING BTREE,
  INDEX `IDX_3`(`status` ASC) USING BTREE,
  INDEX `IDX_ONE`(`org_code` ASC, `is_deleted` ASC) USING BTREE,
  INDEX `IDX_TWO`(`org_code` ASC, `is_deleted` ASC, `create_time` ASC) USING BTREE,
  INDEX `IDX_FOUR`(`event_info_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '信息上报部门关系' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of report_dept
-- ----------------------------

-- ----------------------------
-- Table structure for report_event_continue_info
-- ----------------------------
DROP TABLE IF EXISTS `report_event_continue_info`;
CREATE TABLE `report_event_continue_info`  (
  `id` bigint(20) NOT NULL,
  `event_id` bigint(20) NULL DEFAULT NULL,
  `title` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '记录内容',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '事件续报信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of report_event_continue_info
-- ----------------------------

-- ----------------------------
-- Table structure for report_event_continue_person
-- ----------------------------
DROP TABLE IF EXISTS `report_event_continue_person`;
CREATE TABLE `report_event_continue_person`  (
  `id` bigint(20) NOT NULL,
  `event_id` bigint(20) NULL DEFAULT NULL,
  `person_type` tinyint(4) NULL DEFAULT NULL COMMENT '人员类型',
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `IDX_1`(`person_type` ASC, `user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '事件续报上报对象表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of report_event_continue_person
-- ----------------------------

-- ----------------------------
-- Table structure for report_event_record
-- ----------------------------
DROP TABLE IF EXISTS `report_event_record`;
CREATE TABLE `report_event_record`  (
  `id` bigint(20) NOT NULL,
  `event_info_id` bigint(20) NULL DEFAULT NULL,
  `record_type` int(11) NULL DEFAULT NULL COMMENT '记录类型(0：上报 1：续报)',
  `title` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `record_content` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '记录内容',
  `report_type` int(11) NULL DEFAULT NULL COMMENT '上报类型(0：直报 1：需审核)',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '已读状态(0:未读 1：已读)',
  `record_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `proc_inst_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程实例id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '事件上报、续报处理记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of report_event_record
-- ----------------------------

-- ----------------------------
-- Table structure for report_event_record_rel_person
-- ----------------------------
DROP TABLE IF EXISTS `report_event_record_rel_person`;
CREATE TABLE `report_event_record_rel_person`  (
  `id` bigint(20) NOT NULL,
  `report_event_record_id` bigint(20) NULL DEFAULT NULL COMMENT '事件操作记录id',
  `event_info_id` bigint(20) NULL DEFAULT NULL COMMENT '事件id',
  `person_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '人员类型(0：上报对象 1：审核人员 2：知晓人员  3:抄送人员)',
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户id',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `IDX_2`(`event_info_id` ASC) USING BTREE,
  INDEX `IDX_1`(`person_type` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '事件上报、续报处理相关审核、知晓人员' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of report_event_record_rel_person
-- ----------------------------

-- ----------------------------
-- Table structure for report_handle_process
-- ----------------------------
DROP TABLE IF EXISTS `report_handle_process`;
CREATE TABLE `report_handle_process`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门',
  `submitted_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报送单位编码',
  `info_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '信息ID（上报、事件）',
  `stage` int(11) NULL DEFAULT 0 COMMENT '处置阶段（0默认，1上报2处置）',
  `handle_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '处置类型',
  `title` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容',
  `handle_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '处置部门编码',
  `bpm_status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流程',
  `sms_status` int(11) NULL DEFAULT 0 COMMENT '短信通知状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of report_handle_process
-- ----------------------------

-- ----------------------------
-- Table structure for report_info
-- ----------------------------
DROP TABLE IF EXISTS `report_info`;
CREATE TABLE `report_info`  (
  `id` bigint(20) NOT NULL,
  `level` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '信息级别(字典code :\"INFO_LEVEL\")(0：一般 1：较大 2：重大 3：特别重大 )',
  `info_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '信息类型(字典code: \"INFO_TYPE\")',
  `description` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '信息描述',
  `location` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事发地点',
  `lng` double(18, 15) NULL DEFAULT NULL COMMENT '经度',
  `lat` double(18, 15) NULL DEFAULT NULL COMMENT '纬度',
  `incident_time` datetime NULL DEFAULT NULL COMMENT '事发时间',
  `report_channel` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报送渠道',
  `info_media` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '信息媒介(例如：声音)',
  `report_org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上报单位',
  `event_info_id` bigint(20) NULL DEFAULT 0 COMMENT '关联值班事件id',
  `is_hurt` int(11) NULL DEFAULT 1 COMMENT '是否伤亡(0：否 1：是)',
  `injured_count` int(11) NULL DEFAULT NULL COMMENT '受伤人数',
  `death_count` int(11) NULL DEFAULT NULL COMMENT '死亡人数',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通过创建部门code判定是本部门或相关部门',
  `is_deleted` int(11) NULL DEFAULT 0,
  `is_read` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '是否已读(0:未读 1：已读)',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '信息状态(0:待上报 1：待审核 2：审核不通过 3：待确认发送 4.处理中 5.处理结束 10：待处理 11：交办跟踪)',
  `info_status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '下级上报信息状态',
  `city` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '成都市' COMMENT '城市',
  `city_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '城市编码',
  `area` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区域',
  `area_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区域编码',
  `street` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '街道',
  `street_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '街道编码',
  `is_follow` int(11) NULL DEFAULT 0 COMMENT '是否有续报(0:否)',
  `district_id` bigint(20) NULL DEFAULT NULL COMMENT '区域信息id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `IDX_1`(`create_time` ASC) USING BTREE,
  INDEX `IDX_2`(`district_id` ASC) USING BTREE,
  INDEX `IDX_3`(`is_deleted` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '上报信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of report_info
-- ----------------------------

-- ----------------------------
-- Table structure for report_info_dept_rel
-- ----------------------------
DROP TABLE IF EXISTS `report_info_dept_rel`;
CREATE TABLE `report_info_dept_rel`  (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `report_dept_id` bigint(20) NULL DEFAULT NULL COMMENT '关系id',
  `org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '核实部门',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建部门',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '删除状态',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '签收状态(0：未签收 1:已签收)',
  `is_verify` int(11) NULL DEFAULT 0 COMMENT '是否需要核实',
  `distribute_type` int(11) NULL DEFAULT 0 COMMENT '1:信息核实 2：指令分发',
  `report_info_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `IDX_TWO`(`report_info_id` ASC, `org_code` ASC) USING BTREE,
  INDEX `IDX_ONE`(`is_deleted` ASC, `org_code` ASC, `distribute_type` ASC, `is_verify` ASC) USING BTREE,
  INDEX `IDX_3`(`is_deleted` ASC, `org_code` ASC, `distribute_type` ASC, `is_verify` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '上报信息相关部门' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of report_info_dept_rel
-- ----------------------------

-- ----------------------------
-- Table structure for report_info_file
-- ----------------------------
DROP TABLE IF EXISTS `report_info_file`;
CREATE TABLE `report_info_file`  (
  `id` bigint(20) NOT NULL,
  `report_info_id` bigint(20) NULL DEFAULT 0 COMMENT '信息上报id',
  `report_info_record_id` bigint(20) NULL DEFAULT NULL COMMENT '信息处理记录id',
  `file_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `file_path` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件存储路径',
  `file_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件类型',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `IDX_1`(`report_info_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '上传附件' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of report_info_file
-- ----------------------------

-- ----------------------------
-- Table structure for report_info_record
-- ----------------------------
DROP TABLE IF EXISTS `report_info_record`;
CREATE TABLE `report_info_record`  (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `report_dept_id` bigint(20) NULL DEFAULT NULL COMMENT '信息接报id',
  `event_info_id` bigint(20) NULL DEFAULT NULL COMMENT '事件id',
  `report_info_id` bigint(20) NULL DEFAULT NULL COMMENT '信息上报id',
  `record_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典（\"RECORD_TYPE\"）',
  `record_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '记录内容',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建部门',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '删除标识',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '已读状态(0:未读 1：已读)',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容文本',
  `is_sync` tinyint(4) NULL DEFAULT 0 COMMENT '是否已同步处置过程  0:未同步  1.已同步',
  `template_data` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '模板数据',
  `ps_man` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '批示人',
  `is_to_event` tinyint(4) NULL DEFAULT 0 COMMENT '是否关联事件',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `IDX_1`(`report_info_id` ASC) USING BTREE,
  INDEX `IDX_2`(`report_dept_id` ASC) USING BTREE,
  INDEX `IDX_3`(`event_info_id` ASC) USING BTREE,
  INDEX `IDX_4`(`record_type` ASC) USING BTREE,
  INDEX `IDX_5`(`is_deleted` ASC) USING BTREE,
  INDEX `IDX_ONE`(`is_deleted` ASC, `record_type` ASC, `create_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '信息上报处理记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of report_info_record
-- ----------------------------

-- ----------------------------
-- Table structure for report_info_street
-- ----------------------------
DROP TABLE IF EXISTS `report_info_street`;
CREATE TABLE `report_info_street`  (
  `id` bigint(20) NOT NULL,
  `level` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '信息级别(字典code :\"INFO_LEVEL\")(0：一般 1：较大 2：重大 3：特别重大 )',
  `info_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '信息类型(字典code: \"INFO_TYPE\")',
  `description` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '信息描述',
  `location` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事发地点',
  `incident_time` datetime NULL DEFAULT NULL COMMENT '事发时间',
  `report_channel` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报送渠道',
  `info_media` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '信息媒介(例如：声音)',
  `report_org_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上报单位',
  `is_hurt` int(11) NULL DEFAULT NULL COMMENT '是否伤亡(0：否 1：是)',
  `injured_count` int(11) NULL DEFAULT NULL COMMENT '受伤人数',
  `death_count` int(11) NULL DEFAULT NULL COMMENT '死亡人数',
  `lng` double(18, 15) NULL DEFAULT NULL COMMENT '经度',
  `lat` double(18, 15) NULL DEFAULT NULL COMMENT '纬度',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通过创建部门code判定是本部门或相关部门',
  `is_deleted` int(11) NULL DEFAULT 0,
  `is_read` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '是否已读(0:未读 1：已读)',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '信息状态(0:待上报 1：待审核 2：审核不通过 3：待确认发送 4.处理中 5.处理结束 10：待处理 11：交办跟踪)',
  `report_info_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '上报信息(街道)' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of report_info_street
-- ----------------------------

-- ----------------------------
-- Table structure for report_info_street_file
-- ----------------------------
DROP TABLE IF EXISTS `report_info_street_file`;
CREATE TABLE `report_info_street_file`  (
  `id` bigint(20) NOT NULL,
  `report_info_street_id` bigint(20) NULL DEFAULT 0,
  `report_info_record_id` bigint(20) NULL DEFAULT NULL COMMENT '信息处理记录id',
  `file_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `file_path` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件存储路径',
  `file_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件类型',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '信息上报(街道)上传附件' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of report_info_street_file
-- ----------------------------

-- ----------------------------
-- Table structure for rzt_msg
-- ----------------------------
DROP TABLE IF EXISTS `rzt_msg`;
CREATE TABLE `rzt_msg`  (
  `id` bigint(20) NOT NULL,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通过创建部门code判定是本部门或相关部门',
  `is_deleted` int(11) NULL DEFAULT 0,
  `to_user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `from_user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `from_user_name_str` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `msg_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `msg_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `agent_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `c_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of rzt_msg
-- ----------------------------

-- ----------------------------
-- Table structure for search_hotword
-- ----------------------------
DROP TABLE IF EXISTS `search_hotword`;
CREATE TABLE `search_hotword`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关键词',
  `create_time` timestamp NULL DEFAULT NULL,
  `search_user` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `search_full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_keywords`(`keywords` ASC) USING BTREE,
  INDEX `idx_search_date`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26176 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of search_hotword
-- ----------------------------

-- ----------------------------
-- Table structure for shift_record
-- ----------------------------
DROP TABLE IF EXISTS `shift_record`;
CREATE TABLE `shift_record`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `shift_user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交办人姓名',
  `shift_user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `successor_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接班人姓名',
  `pending_info_count` int(11) NULL DEFAULT NULL COMMENT '待处理信息数',
  `process_event_count` int(11) NULL DEFAULT NULL COMMENT '处理中事件',
  `memo` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备忘录',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'createBy',
  `create_time` datetime NULL DEFAULT NULL COMMENT '交班时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'updateBy',
  `update_time` datetime NULL DEFAULT NULL COMMENT '接班时间',
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'createOrgCode',
  `is_deleted` int(11) NULL DEFAULT NULL COMMENT 'isDeleted',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接班状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1650767595441360897 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '交班记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of shift_record
-- ----------------------------

-- ----------------------------
-- Table structure for sita_resume_area
-- ----------------------------
DROP TABLE IF EXISTS `sita_resume_area`;
CREATE TABLE `sita_resume_area`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `id_card` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '证件号码',
  `resume_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '履历ID',
  `area` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任职地区',
  `begin_time` datetime NULL DEFAULT NULL COMMENT '开始年月',
  `end_time` datetime NULL DEFAULT NULL COMMENT '结束年月',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `del_flag` int(11) NULL DEFAULT NULL COMMENT '删除标记 1已删除 0否',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `resume`(`id_card` ASC, `resume_id` ASC) USING BTREE,
  INDEX `id_card`(`id_card` ASC) USING BTREE,
  INDEX `resume_id`(`resume_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '学员信息任职地区' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sita_resume_area
-- ----------------------------

-- ----------------------------
-- Table structure for sita_resume_dept
-- ----------------------------
DROP TABLE IF EXISTS `sita_resume_dept`;
CREATE TABLE `sita_resume_dept`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `id_card` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '证件号码',
  `resume_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '履历ID',
  `dept` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任职部门',
  `begin_time` datetime NULL DEFAULT NULL COMMENT '开始年月',
  `end_time` datetime NULL DEFAULT NULL COMMENT '结束年月',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `del_flag` int(11) NULL DEFAULT NULL COMMENT '删除标记 1已删除 0否',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `resume`(`id_card` ASC, `resume_id` ASC) USING BTREE,
  INDEX `id_card`(`id_card` ASC) USING BTREE,
  INDEX `resume_id`(`resume_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '学员信息任职部门' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sita_resume_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sita_resume_duty
-- ----------------------------
DROP TABLE IF EXISTS `sita_resume_duty`;
CREATE TABLE `sita_resume_duty`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `id_card` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '证件号码',
  `resume_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '履历ID',
  `duty` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任职职务',
  `begin_time` datetime NULL DEFAULT NULL COMMENT '开始年月',
  `end_time` datetime NULL DEFAULT NULL COMMENT '结束年月',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `del_flag` int(11) NULL DEFAULT NULL COMMENT '删除标记 1已删除 0否',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `resume`(`id_card` ASC, `resume_id` ASC) USING BTREE,
  INDEX `id_card`(`id_card` ASC) USING BTREE,
  INDEX `resume_id`(`resume_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '学员信息任职职务' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sita_resume_duty
-- ----------------------------

-- ----------------------------
-- Table structure for sita_resume_job
-- ----------------------------
DROP TABLE IF EXISTS `sita_resume_job`;
CREATE TABLE `sita_resume_job`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `id_card` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '证件号码',
  `resume_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '履历ID',
  `job` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任职岗位',
  `begin_time` datetime NULL DEFAULT NULL COMMENT '开始年月',
  `end_time` datetime NULL DEFAULT NULL COMMENT '结束年月',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `del_flag` int(11) NULL DEFAULT NULL COMMENT '删除标记 1已删除 0否',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `resume`(`id_card` ASC, `resume_id` ASC) USING BTREE,
  INDEX `id_card`(`id_card` ASC) USING BTREE,
  INDEX `resume_id`(`resume_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '学员信息任职岗位' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sita_resume_job
-- ----------------------------

-- ----------------------------
-- Table structure for sita_resume_org
-- ----------------------------
DROP TABLE IF EXISTS `sita_resume_org`;
CREATE TABLE `sita_resume_org`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `id_card` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '证件号码',
  `resume_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '履历ID',
  `org` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任职岗位',
  `begin_time` datetime NULL DEFAULT NULL COMMENT '开始年月',
  `end_time` datetime NULL DEFAULT NULL COMMENT '结束年月',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `del_flag` int(11) NULL DEFAULT NULL COMMENT '删除标记 1已删除 0否',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `resume`(`id_card` ASC, `resume_id` ASC) USING BTREE,
  INDEX `id_card`(`id_card` ASC) USING BTREE,
  INDEX `resume_id`(`resume_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '学员信息任职部门' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sita_resume_org
-- ----------------------------

-- ----------------------------
-- Table structure for sita_resume_top_org
-- ----------------------------
DROP TABLE IF EXISTS `sita_resume_top_org`;
CREATE TABLE `sita_resume_top_org`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `id_card` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '证件号码',
  `resume_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '履历ID',
  `top_org` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '大单位',
  `begin_time` datetime NULL DEFAULT NULL COMMENT '开始年月',
  `end_time` datetime NULL DEFAULT NULL COMMENT '结束年月',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `del_flag` int(11) NULL DEFAULT NULL COMMENT '删除标记 1已删除 0否',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `resume`(`id_card` ASC, `resume_id` ASC) USING BTREE,
  INDEX `id_card`(`id_card` ASC) USING BTREE,
  INDEX `resume_id`(`resume_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '学员信息任职大单位' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sita_resume_top_org
-- ----------------------------

-- ----------------------------
-- Table structure for sms_record
-- ----------------------------
DROP TABLE IF EXISTS `sms_record`;
CREATE TABLE `sms_record`  (
  `id` bigint(20) NOT NULL,
  `event_info_id` bigint(20) NULL DEFAULT NULL,
  `report_event_record_id` bigint(20) NULL DEFAULT NULL COMMENT '事件上报、续保记录id',
  `sms_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '短信内容',
  `record_type` int(11) NULL DEFAULT 0 COMMENT '记录类型(0:上报 1：批示回复 )',
  `phone` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `ext_port` int(11) NULL DEFAULT NULL COMMENT '短信扩展码',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '查收状态(0:待查收 1：已查收)',
  `is_read` int(11) NULL DEFAULT 0 COMMENT '是否已读(0:未读 1：已读)',
  `state` int(11) NULL DEFAULT 0 COMMENT '短信接收状态(0：成功、3：失败)',
  `taskid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '短信编号',
  `is_bind_event` tinyint(4) NULL DEFAULT 0 COMMENT '是否绑定了事件',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sms_record_record_type_IDX`(`record_type` ASC, `status` ASC, `is_read` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '短信发送记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sms_record
-- ----------------------------

-- ----------------------------
-- Table structure for spot_check_configuration
-- ----------------------------
DROP TABLE IF EXISTS `spot_check_configuration`;
CREATE TABLE `spot_check_configuration`  (
  `id` bigint(20) NOT NULL,
  `spot_count` int(11) NULL DEFAULT NULL COMMENT '每日抽查数量',
  `spot_time` time NULL DEFAULT '00:00:00' COMMENT '每日抽查开始时间',
  `ring_number` int(11) NULL DEFAULT NULL COMMENT '响铃阈值',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  `action` varchar(22) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '抽查类型（save：保存   execution：立即执行）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '抽查配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of spot_check_configuration
-- ----------------------------

-- ----------------------------
-- Table structure for spot_check_person_rel
-- ----------------------------
DROP TABLE IF EXISTS `spot_check_person_rel`;
CREATE TABLE `spot_check_person_rel`  (
  `id` bigint(20) NOT NULL,
  `config_id` bigint(20) NULL DEFAULT NULL COMMENT '配置id',
  `org_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '抽查单位',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  `contacts_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系人Id',
  `org_check_num` int(11) NULL DEFAULT 0 COMMENT '抽查次数（次数越大权重越小）',
  `do_status` int(11) NULL DEFAULT NULL COMMENT '任务状态：1-执行中，2-完成',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '抽查对象' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of spot_check_person_rel
-- ----------------------------

-- ----------------------------
-- Table structure for spot_check_record
-- ----------------------------
DROP TABLE IF EXISTS `spot_check_record`;
CREATE TABLE `spot_check_record`  (
  `id` bigint(20) NOT NULL,
  `spot_target_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '抽查对象',
  `spot_time` datetime NULL DEFAULT NULL COMMENT '抽查时间',
  `ring_number` int(11) NULL DEFAULT 0 COMMENT '响铃次数',
  `record_file_url` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通话录音',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发起抽查单位',
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '抽样结果  1,成功  2,失败  3,异常',
  `call_end_time` datetime NULL DEFAULT NULL COMMENT '结束呼叫时间',
  `uc_id` varchar(22) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通话唯一表示Id',
  `call_time` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通话时间',
  `sc_person_id` bigint(20) NULL DEFAULT NULL COMMENT '关联配置中间表id',
  `oss_url` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'oss文件地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '抽查记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of spot_check_record
-- ----------------------------

-- ----------------------------
-- Table structure for sql_config
-- ----------------------------
DROP TABLE IF EXISTS `sql_config`;
CREATE TABLE `sql_config`  (
  `id` int(11) NOT NULL COMMENT '主键',
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `content` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'sql内容',
  `param_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'sql参数说明',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sql_config
-- ----------------------------

-- ----------------------------
-- Table structure for standing_book
-- ----------------------------
DROP TABLE IF EXISTS `standing_book`;
CREATE TABLE `standing_book`  (
  `id` bigint(20) NOT NULL,
  `incident_site` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事发地',
  `event_title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件标题',
  `event_info_id` bigint(20) NULL DEFAULT NULL COMMENT '关联事件',
  `event_descript` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '事件描述',
  `first_report_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '首报时间',
  `first_report_unit` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '首报单位',
  `event_category` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件类别(字典：\"EVENT_CATEGORY\")',
  `affiliation` varchar(340) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '属地',
  `affiliation_report_time` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '属地首报时间',
  `affiliation_written_time` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '属地书面时间',
  `competent_dept` varchar(340) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主管部门',
  `competent_dept_report_time` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主管部门首报时间',
  `competent_dept_written_time` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主管部门书面时间',
  `assist_report_dept_code` varchar(340) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '协报单位',
  `report_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报告类型',
  `remark` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` int(11) NULL DEFAULT 0,
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  `incident_time` datetime NULL DEFAULT NULL COMMENT '事发时间',
  `event_level` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件级别',
  `event_description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '事件描述',
  `event_type_one` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件类型 一级分类',
  `event_type_two` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件类型 二级分类',
  `event_type_three` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件类型 三级分类',
  `man_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '涉及人员类型',
  `place` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '涉及场所',
  `age_begin` double(20, 1) NULL DEFAULT NULL COMMENT '涉及人员年龄起',
  `age_end` double(20, 1) NULL DEFAULT NULL COMMENT '涉及人员年龄止',
  `man_sum` int(11) NULL DEFAULT NULL COMMENT '涉及人员数量',
  `special_flag` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '有无特殊身份  1有   0无',
  `afo_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '非正常伤亡形式',
  `help_org` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '协报单位',
  `instructions` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '领导批示',
  `end_time` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '结束时间',
  `num_one` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '应急值班信息第XX期',
  `num_two` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '汇入值班报告第XX期',
  `happened_area` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dutyd_area` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `zs_names` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `event_classify` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_province` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sensitive_time` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `man_age` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `man_nationality` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `man_sex` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `public_opinion` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `death_num` int(11) NULL DEFAULT NULL,
  `injured_num` int(11) NULL DEFAULT NULL,
  `excesses` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fire_area` int(11) NULL DEFAULT NULL,
  `fire_time` int(11) NULL DEFAULT NULL,
  `idioctonia_reason` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `idioctonia_reason_text` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `registration_man` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `other_point` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `event_type_four` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件类型 四级分类',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id1`(`place` ASC) USING BTREE,
  INDEX `standing_book_competent_dept_IDX`(`competent_dept` ASC) USING BTREE,
  INDEX `standing_book_event_info_id_IDX`(`event_info_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '台账' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of standing_book
-- ----------------------------

-- ----------------------------
-- Table structure for sync_record
-- ----------------------------
DROP TABLE IF EXISTS `sync_record`;
CREATE TABLE `sync_record`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键ID',
  `sync_type` enum('department','user') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '同步类型',
  `sync_status` enum('success','failed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '同步状态',
  `sync_params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '同步参数',
  `sync_mode` enum('FULL','INCREMENT') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `start_time` datetime NULL DEFAULT NULL COMMENT '同步开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '同步结束时间',
  `total_count` int(11) NULL DEFAULT 0 COMMENT '总记录数',
  `error_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '错误信息',
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '操作人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sync_type`(`sync_type` ASC) USING BTREE,
  INDEX `idx_start_time`(`start_time` ASC) USING BTREE,
  INDEX `idx_status`(`sync_status` ASC) USING BTREE,
  INDEX `idx_type_time`(`sync_type` ASC, `start_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '数据同步记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sync_record
-- ----------------------------
INSERT INTO `sync_record` VALUES ('1985938193924612097', 'department', 'success', '{\"headers\":{\"x-qys-signature\":\"40e2c1268fa473e8f11f8de00c7cbc0d\",\"x-qys-accesstoken\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdXRoa2V5IjoiMTYyZWQwNjI2NGE5NDI4ODliNTRiZjVhNjE4MjAxNmYiLCJpc3MiOiJ1cmFudXMiLCJleHAiOjE3NjIzMjQ5MzZ9.utPrZJrbXvIcLFVQV-OUOOxtvOve1z7xxmKfTrLVcqo\",\"x-ys-timestamp\":\"1762319536567\"},\"response\":\"{\\\"code\\\":0,\\\"data\\\":{\\\"errcode\\\":0,\\\"errmsg\\\":\\\"ok\\\",\\\"department\\\":[{\\\"id\\\":1,\\\"name\\\":\\\"经信技术支持组\\\",\\\"shortName\\\":\\\"经信技术支持组\\\",\\\"parentid\\\":2061118,\\\"order\\\":99999500,\\\"hasChild\\\":1,\\\"creditcode\\\":\\\"ceshi\\\",\\\"isDeleted\\\":0},{\\\"id\\\":72,\\\"name\\\":\\\"成都市委\\\",\\\"shortName\\\":\\\"成都市委\\\",\\\"parentid\\\":1,\\\"order\\\":100000000,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":73,\\\"name\\\":\\\"团市委\\\",\\\"shortName\\\":\\\"团市委\\\",\\\"parentid\\\":72,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":74,\\\"name\\\":\\\"市委办公厅\\\",\\\"shortName\\\":\\\"市委办公厅\\\",\\\"parentid\\\":72,\\\"order\\\":99999500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":75,\\\"name\\\":\\\"市委外事办\\\",\\\"shortName\\\":\\\"市委外事办\\\",\\\"parentid\\\":72,\\\"order\\\":99999000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":76,\\\"name\\\":\\\"市委宣传部\\\",\\\"shortName\\\":\\\"市委宣传部\\\",\\\"parentid\\\":72,\\\"order\\\":99998500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":77,\\\"name\\\":\\\"市委政法委\\\",\\\"shortName\\\":\\\"市委政法委\\\",\\\"parentid\\\":72,\\\"order\\\":99998000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":78,\\\"name\\\":\\\"市委社会工作部\\\",\\\"shortName\\\":\\\"市委社会工作部\\\",\\\"parentid\\\":72,\\\"order\\\":99997500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":79,\\\"name\\\":\\\"市委统战部\\\",\\\"shortName\\\":\\\"市委统战部\\\",\\\"parentid\\\":72,\\\"order\\\":99997000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":80,\\\"name\\\":\\\"市委网信办\\\",\\\"shortName\\\":\\\"市委网信办\\\",\\\"parentid\\\":72,\\\"order\\\":99996500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":81,\\\"name\\\":\\\"市纪委\\\",\\\"shortName\\\":\\\"市纪委\\\",\\\"parentid\\\":72,\\\"order\\\":99996000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":82,\\\"name\\\":\\\"市政府部门\\\",\\\"shortName\\\":\\\"市政府部门\\\",\\\"parentid\\\":1,\\\"order\\\":99999000,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":83,\\\"name\\\":\\\"市互联网信息办\\\",\\\"shortName\\\":\\\"市互联网信息办\\\",\\\"parentid\\\":82,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":84,\\\"name\\\":\\\"市交通运输局\\\",\\\"shortName\\\":\\\"市交通运输局\\\",\\\"parentid\\\":82,\\\"order\\\":99999500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":85,\\\"name\\\":\\\"市人社局\\\",\\\"shortName\\\":\\\"市人社局\\\",\\\"parentid\\\":82,\\\"order\\\":99999000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":86,\\\"name\\\":\\\"市人防办\\\",\\\"shortName\\\":\\\"市人防办\\\",\\\"parentid\\\":82,\\\"order\\\":99998500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":87,\\\"name\\\":\\\"市住建局\\\",\\\"shortName\\\":\\\"市住建局\\\",\\\"parentid\\\":82,\\\"order\\\":99998000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":88,\\\"name\\\":\\\"市体育局\\\",\\\"shortName\\\":\\\"市体育局\\\",\\\"parentid\\\":82,\\\"order\\\":99997500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":89,\\\"name\\\":\\\"市信访局\\\",\\\"shortName\\\":\\\"市信访局\\\",\\\"parentid\\\":82,\\\"order\\\":99997000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":90,\\\"name\\\":\\\"市公园城市局\\\",\\\"shortName\\\":\\\"市公园城市局\\\",\\\"parentid\\\":82,\\\"order\\\":99996500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":91,\\\"name\\\":\\\"市公安局\\\",\\\"shortName\\\":\\\"市公安局\\\",\\\"parentid\\\":82,\\\"order\\\":99996000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":92,\\\"name\\\":\\\"市公资交易中心\\\",\\\"shortName\\\":\\\"市公资交易中心\\\",\\\"parentid\\\":82,\\\"order\\\":99995500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":93,\\\"name\\\":\\\"市农业农村局\\\",\\\"shortName\\\":\\\"市农业农村局\\\",\\\"parentid\\\":82,\\\"order\\\":99995000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":94,\\\"name\\\":\\\"市农林科学院\\\",\\\"shortName\\\":\\\"市农林科学院\\\",\\\"parentid\\\":82,\\\"order\\\":99994500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":95,\\\"name\\\":\\\"市医保局\\\",\\\"shortName\\\":\\\"市医保局\\\",\\\"parentid\\\":82,\\\"order\\\":99994000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":96,\\\"name\\\":\\\"市博览局\\\",\\\"shortName\\\":\\\"市博览局\\\",\\\"parentid\\\":82,\\\"order\\\":99993500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":97,\\\"name\\\":\\\"市卫健委\\\",\\\"shortName\\\":\\\"市卫健委\\\",\\\"parentid\\\":82,\\\"order\\\":99993000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":98,\\\"name\\\":\\\"市发改委\\\",\\\"shortName\\\":\\\"市发改委\\\",\\\"parentid\\\":82,\\\"order\\\":99992500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":99,\\\"name\\\":\\\"市口岸物流办\\\",\\\"shortName\\\":\\\"市口岸物流办\\\",\\\"parentid\\\":82,\\\"order\\\":99992000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":100,\\\"name\\\":\\\"市司法局\\\",\\\"shortName\\\":\\\"市司法局\\\",\\\"parentid\\\":82,\\\"order\\\":99991500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":101,\\\"name\\\":\\\"市商务局\\\",\\\"shortName\\\":\\\"市商务局\\\",\\\"parentid\\\":82,\\\"order\\\":99991000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":102,\\\"name\\\":\\\"市国动办\\\",\\\"shortName\\\":\\\"市国动办\\\",\\\"parentid\\\":82,\\\"order\\\":99990500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":103,\\\"name\\\":\\\"市国资委\\\",\\\"shortName\\\":\\\"市国资委\\\",\\\"parentid\\\":82,\\\"order\\\":99990000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":104,\\\"name\\\":\\\"市地志办\\\",\\\"shortName\\\":\\\"市地志办\\\",\\\"parentid\\\":82,\\\"order\\\":99989500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":105,\\\"name\\\":\\\"市城市运行和政务服务办\\\",\\\"shortName\\\":\\\"市城市运行和政务服务办\\\",\\\"parentid\\\":82,\\\"order\\\":99989000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":106,\\\"name\\\":\\\"市城管委\\\",\\\"shortName\\\":\\\"市城管委\\\",\\\"parentid\\\":82,\\\"order\\\":99988500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":107,\\\"name\\\":\\\"市城运中心\\\",\\\"shortName\\\":\\\"市城运中心\\\",\\\"parentid\\\":82,\\\"order\\\":99988000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":108,\\\"name\\\":\\\"市审计局\\\",\\\"shortName\\\":\\\"市审计局\\\",\\\"parentid\\\":82,\\\"order\\\":99987500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":109,\\\"name\\\":\\\"市市场监管局\\\",\\\"shortName\\\":\\\"市市场监管局\\\",\\\"parentid\\\":82,\\\"order\\\":99987000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":110,\\\"name\\\":\\\"市应急局\\\",\\\"shortName\\\":\\\"市应急局\\\",\\\"parentid\\\":82,\\\"order\\\":99986500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":111,\\\"name\\\":\\\"市投促局\\\",\\\"shortName\\\":\\\"市投促局\\\",\\\"parentid\\\":82,\\\"order\\\":99986000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":112,\\\"name\\\":\\\"市政府侨办\\\",\\\"shortName\\\":\\\"市政府侨办\\\",\\\"parentid\\\":82,\\\"order\\\":99985500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":113,\\\"name\\\":\\\"市政府办公厅\\\",\\\"shortName\\\":\\\"市政府办公厅\\\",\\\"parentid\\\":82,\\\"order\\\":99985000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":114,\\\"name\\\":\\\"市政府台办\\\",\\\"shortName\\\":\\\"市政府台办\\\",\\\"parentid\\\":82,\\\"order\\\":99984500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":115,\\\"name\\\":\\\"市政府外办\\\",\\\"shortName\\\":\\\"市政府外办\\\",\\\"parentid\\\":82,\\\"order\\\":99984000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":116,\\\"name\\\":\\\"市政府新闻办\\\",\\\"shortName\\\":\\\"市政府新闻办\\\",\\\"parentid\\\":82,\\\"order\\\":99983500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":117,\\\"name\\\":\\\"市教育局\\\",\\\"shortName\\\":\\\"市教育局\\\",\\\"parentid\\\":82,\\\"order\\\":99983000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":118,\\\"name\\\":\\\"市文广旅局\\\",\\\"shortName\\\":\\\"市文广旅局\\\",\\\"parentid\\\":82,\\\"order\\\":99982500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":119,\\\"name\\\":\\\"市新经济委\\\",\\\"shortName\\\":\\\"市新经济委\\\",\\\"parentid\\\":82,\\\"order\\\":99982000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":120,\\\"name\\\":\\\"市机关事务局\\\",\\\"shortName\\\":\\\"市机关事务局\\\",\\\"parentid\\\":82,\\\"order\\\":99981500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":121,\\\"name\\\":\\\"市民宗局\\\",\\\"shortName\\\":\\\"市民宗局\\\",\\\"parentid\\\":82,\\\"order\\\":99981000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":122,\\\"name\\\":\\\"市民政局\\\",\\\"shortName\\\":\\\"市民政局\\\",\\\"parentid\\\":82,\\\"order\\\":99980500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":123,\\\"name\\\":\\\"市气象局\\\",\\\"shortName\\\":\\\"市气象局\\\",\\\"parentid\\\":82,\\\"order\\\":99980000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":124,\\\"name\\\":\\\"市水务局\\\",\\\"shortName\\\":\\\"市水务局\\\",\\\"parentid\\\":82,\\\"order\\\":99979500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":125,\\\"name\\\":\\\"市消防救援支队\\\",\\\"shortName\\\":\\\"市消防救援支队\\\",\\\"parentid\\\":82,\\\"order\\\":99979000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":126,\\\"name\\\":\\\"市生态环境局\\\",\\\"shortName\\\":\\\"市生态环境局\\\",\\\"parentid\\\":82,\\\"order\\\":99978500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":127,\\\"name\\\":\\\"市科技局\\\",\\\"shortName\\\":\\\"市科技局\\\",\\\"parentid\\\":82,\\\"order\\\":99978000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":128,\\\"name\\\":\\\"市税务局\\\",\\\"shortName\\\":\\\"市税务局\\\",\\\"parentid\\\":82,\\\"order\\\":99977500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":129,\\\"name\\\":\\\"市经信局\\\",\\\"shortName\\\":\\\"市经信局\\\",\\\"parentid\\\":82,\\\"order\\\":99977000,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":130,\\\"name\\\":\\\"市统计局\\\",\\\"shortName\\\":\\\"市统计局\\\",\\\"parentid\\\":82,\\\"order\\\":99976500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":131,\\\"name\\\":\\\"市规划和自然资源局\\\",\\\"shortName\\\":\\\"市规划和自然资源局\\\",\\\"parentid\\\":82,\\\"order\\\":99976000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":132,\\\"name\\\":\\\"市财政局\\\",\\\"shortName\\\":\\\"市财政局\\\",\\\"parentid\\\":82,\\\"order\\\":99975500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":133,\\\"name\\\":\\\"市贸促会\\\",\\\"shortName\\\":\\\"市贸促会\\\",\\\"parentid\\\":82,\\\"order\\\":99975000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":134,\\\"name\\\":\\\"市邮政管理局\\\",\\\"shortName\\\":\\\"市邮政管理局\\\",\\\"parentid\\\":82,\\\"order\\\":99974500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":135,\\\"name\\\":\\\"市金融监管局\\\",\\\"shortName\\\":\\\"市金融监管局\\\",\\\"parentid\\\":82,\\\"order\\\":99974000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":136,\\\"name\\\":\\\"成都住房公积金管理中心\\\",\\\"shortName\\\":\\\"成都住房公积金管理中心\\\",\\\"parentid\\\":82,\\\"order\\\":99973500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":137,\\\"name\\\":\\\"成都大运会执委会办公室\\\",\\\"shortName\\\":\\\"成都大运会执委会办公室\\\",\\\"parentid\\\":82,\\\"order\\\":99973000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":138,\\\"name\\\":\\\"成都市淮州新城管理委员会\\\",\\\"shortName\\\":\\\"成都市淮州新城管理委员会\\\",\\\"parentid\\\":82,\\\"order\\\":99972500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":139,\\\"name\\\":\\\"成都市退役军人事务局\\\",\\\"shortName\\\":\\\"成都市退役军人事务局\\\",\\\"parentid\\\":82,\\\"order\\\":99972000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":140,\\\"name\\\":\\\"成都森林消防(特种救援)大队\\\",\\\"shortName\\\":\\\"成都森林消防(特种救援)大队\\\",\\\"parentid\\\":82,\\\"order\\\":99971500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":141,\\\"name\\\":\\\"成都石化园区管委会\\\",\\\"shortName\\\":\\\"成都石化园区管委会\\\",\\\"parentid\\\":82,\\\"order\\\":99971000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":142,\\\"name\\\":\\\"成都警备区\\\",\\\"shortName\\\":\\\"成都警备区\\\",\\\"parentid\\\":82,\\\"order\\\":99970500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":143,\\\"name\\\":\\\"成都龙泉山城市森林公园管委会\\\",\\\"shortName\\\":\\\"成都龙泉山城市森林公园管委会\\\",\\\"parentid\\\":82,\\\"order\\\":99970000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":144,\\\"name\\\":\\\"武警成都支队\\\",\\\"shortName\\\":\\\"武警成都支队\\\",\\\"parentid\\\":82,\\\"order\\\":99969500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":145,\\\"name\\\":\\\"系统运维\\\",\\\"shortName\\\":\\\"系统运维\\\",\\\"parentid\\\":82,\\\"order\\\":99969000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":146,\\\"name\\\":\\\"区（市）县\\\",\\\"shortName\\\":\\\"区（市）县\\\",\\\"parentid\\\":1,\\\"order\\\":99998500,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":147,\\\"name\\\":\\\"东部新区\\\",\\\"shortName\\\":\\\"东部新区\\\",\\\"parentid\\\":146,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":148,\\\"name\\\":\\\"双流区\\\",\\\"shortName\\\":\\\"双流区\\\",\\\"parentid\\\":146,\\\"order\\\":99999500,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":149,\\\"name\\\":\\\"大邑县\\\",\\\"shortName\\\":\\\"大邑县\\\",\\\"parentid\\\":146,\\\"order\\\":99999000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":150,\\\"name\\\":\\\"天府新区\\\",\\\"shortName\\\":\\\"天府新区\\\",\\\"parentid\\\":146,\\\"order\\\":99998500,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":151,\\\"name\\\":\\\"崇州市\\\",\\\"shortName\\\":\\\"崇州市\\\",\\\"parentid\\\":146,\\\"order\\\":99998000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":152,\\\"name\\\":\\\"彭州市\\\",\\\"shortName\\\":\\\"彭州市\\\",\\\"parentid\\\":146,\\\"order\\\":99997500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":153,\\\"name\\\":\\\"成华区\\\",\\\"shortName\\\":\\\"成华区\\\",\\\"parentid\\\":146,\\\"order\\\":99997000,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":154,\\\"name\\\":\\\"新津区\\\",\\\"shortName\\\":\\\"新津区\\\",\\\"parentid\\\":146,\\\"order\\\":99996500,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":155,\\\"name\\\":\\\"新都区\\\",\\\"shortName\\\":\\\"新都区\\\",\\\"parentid\\\":146,\\\"order\\\":99996000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":156,\\\"name\\\":\\\"武侯区\\\",\\\"shortName\\\":\\\"武侯区\\\",\\\"parentid\\\":146,\\\"order\\\":99995500,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":157,\\\"name\\\":\\\"温江区\\\",\\\"shortName\\\":\\\"温江区\\\",\\\"parentid\\\":146,\\\"order\\\":99995000,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":158,\\\"name\\\":\\\"简阳市\\\",\\\"shortName\\\":\\\"简阳市\\\",\\\"parentid\\\":146,\\\"order\\\":99994500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":159,\\\"name\\\":\\\"蒲江县\\\",\\\"shortName\\\":\\\"蒲江县\\\",\\\"parentid\\\":146,\\\"order\\\":99994000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":160,\\\"name\\\":\\\"邛崃市\\\",\\\"shortName\\\":\\\"邛崃市\\\",\\\"parentid\\\":146,\\\"order\\\":99993500,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":161,\\\"name\\\":\\\"郫都区\\\",\\\"shortName\\\":\\\"郫都区\\\",\\\"parentid\\\":146,\\\"order\\\":99993000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":162,\\\"name\\\":\\\"都江堰市\\\",\\\"shortName\\\":\\\"都江堰市\\\",\\\"parentid\\\":146,\\\"order\\\":99992500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":163,\\\"name\\\":\\\"金堂县\\\",\\\"shortName\\\":\\\"金堂县\\\",\\\"parentid\\\":146,\\\"order\\\":99992000,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":164,\\\"name\\\":\\\"金牛区\\\",\\\"shortName\\\":\\\"金牛区\\\",\\\"parentid\\\":146,\\\"order\\\":99991500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":165,\\\"name\\\":\\\"锦江区\\\",\\\"shortName\\\":\\\"锦江区\\\",\\\"parentid\\\":146,\\\"order\\\":99991000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":166,\\\"name\\\":\\\"青白江区\\\",\\\"shortName\\\":\\\"青白江区\\\",\\\"parentid\\\":146,\\\"order\\\":99990500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":167,\\\"name\\\":\\\"青羊区\\\",\\\"shortName\\\":\\\"青羊区\\\",\\\"parentid\\\":146,\\\"order\\\":99990000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":168,\\\"name\\\":\\\"高新区\\\",\\\"shortName\\\":\\\"高新区\\\",\\\"parentid\\\":146,\\\"order\\\":99989500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":169,\\\"name\\\":\\\"龙泉驿区\\\",\\\"shortName\\\":\\\"龙泉驿区\\\",\\\"parentid\\\":146,\\\"order\\\":99989000,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":170,\\\"name\\\":\\\"国企\\\",\\\"shortName\\\":\\\"国企\\\",\\\"parentid\\\":1,\\\"order\\\":99998000,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":171,\\\"name\\\":\\\"中国安能集团第三工程局成都分公司\\\",\\\"shortName\\\":\\\"中国安能集团第三工程局成都分公司\\\",\\\"parentid\\\":170,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":172,\\\"name\\\":\\\"中国铁路成都局集团公司\\\",\\\"shortName\\\":\\\"中国铁路成都局集团公司\\\",\\\"parentid\\\":170,\\\"order\\\":99999500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":173,\\\"name\\\":\\\"中国铁通成都分公司\\\",\\\"shortName\\\":\\\"中国铁通成都分公司\\\",\\\"parentid\\\":170,\\\"order\\\":99999000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":174,\\\"name\\\":\\\"国网四川省检修公司成都中心\\\",\\\"shortName\\\":\\\"国网四川省检修公司成都中心\\\",\\\"parentid\\\":170,\\\"order\\\":99998500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":175,\\\"name\\\":\\\"国网天府新区供电公司\\\",\\\"shortName\\\":\\\"国网天府新区供电公司\\\",\\\"parentid\\\":170,\\\"order\\\":99998000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":176,\\\"name\\\":\\\"国网成都供电公司\\\",\\\"shortName\\\":\\\"国网成都供电公司\\\",\\\"parentid\\\":170,\\\"order\\\":99997500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":177,\\\"name\\\":\\\"市红十字会\\\",\\\"shortName\\\":\\\"市红十字会\\\",\\\"parentid\\\":170,\\\"order\\\":99997000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":178,\\\"name\\\":\\\"成都交子金控集团\\\",\\\"shortName\\\":\\\"成都交子金控集团\\\",\\\"parentid\\\":170,\\\"order\\\":99996500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":179,\\\"name\\\":\\\"成都交投集团\\\",\\\"shortName\\\":\\\"成都交投集团\\\",\\\"parentid\\\":170,\\\"order\\\":99996000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":180,\\\"name\\\":\\\"成都产业集团\\\",\\\"shortName\\\":\\\"成都产业集团\\\",\\\"parentid\\\":170,\\\"order\\\":99995500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":181,\\\"name\\\":\\\"成都传媒集团\\\",\\\"shortName\\\":\\\"成都传媒集团\\\",\\\"parentid\\\":170,\\\"order\\\":99995000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":182,\\\"name\\\":\\\"成都兴城投资集团有限公司\\\",\\\"shortName\\\":\\\"成都兴城投资集团有限公司\\\",\\\"parentid\\\":170,\\\"order\\\":99994500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":183,\\\"name\\\":\\\"成都地铁运营有限公司\\\",\\\"shortName\\\":\\\"成都地铁运营有限公司\\\",\\\"parentid\\\":170,\\\"order\\\":99994000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":184,\\\"name\\\":\\\"成都城建投资管理集团有限责任公司\\\",\\\"shortName\\\":\\\"成都城建投资管理集团有限责任公司\\\",\\\"parentid\\\":170,\\\"order\\\":99993500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":185,\\\"name\\\":\\\"成都城投集团\\\",\\\"shortName\\\":\\\"成都城投集团\\\",\\\"parentid\\\":170,\\\"order\\\":99993000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":186,\\\"name\\\":\\\"成都市公共交通集团有限公司\\\",\\\"shortName\\\":\\\"成都市公共交通集团有限公司\\\",\\\"parentid\\\":170,\\\"order\\\":99992500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":187,\\\"name\\\":\\\"成都文旅集团\\\",\\\"shortName\\\":\\\"成都文旅集团\\\",\\\"parentid\\\":170,\\\"order\\\":99992000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":188,\\\"name\\\":\\\"成都环境投资集团\\\",\\\"shortName\\\":\\\"成都环境投资集团\\\",\\\"parentid\\\":170,\\\"order\\\":99991500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":189,\\\"name\\\":\\\"成都设计咨询集团\\\",\\\"shortName\\\":\\\"成都设计咨询集团\\\",\\\"parentid\\\":170,\\\"order\\\":99991000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":190,\\\"name\\\":\\\"成都轨道交通集团有限公司\\\",\\\"shortName\\\":\\\"成都轨道交通集团有限公司\\\",\\\"parentid\\\":170,\\\"order\\\":99990500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":191,\\\"name\\\":\\\"电信成都分公司\\\",\\\"shortName\\\":\\\"电信成都分公司\\\",\\\"parentid\\\":170,\\\"order\\\":99990000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":192,\\\"name\\\":\\\"益民集团\\\",\\\"shortName\\\":\\\"益民集团\\\",\\\"parentid\\\":170,\\\"order\\\":99989500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":193,\\\"name\\\":\\\"移动天府新区分公司\\\",\\\"shortName\\\":\\\"移动天府新区分公司\\\",\\\"parentid\\\":170,\\\"order\\\":99989000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":194,\\\"name\\\":\\\"移动成都分公司\\\",\\\"shortName\\\":\\\"移动成都分公司\\\",\\\"parentid\\\":170,\\\"order\\\":99988500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":195,\\\"name\\\":\\\"联通成都分公司\\\",\\\"shortName\\\":\\\"联通成都分公司\\\",\\\"parentid\\\":170,\\\"order\\\":99988000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":196,\\\"name\\\":\\\"铁塔成都分公司\\\",\\\"shortName\\\":\\\"铁塔成都分公司\\\",\\\"parentid\\\":170,\\\"order\\\":99987500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":197,\\\"name\\\":\\\"锦泰财产保险股份有限公司\\\",\\\"shortName\\\":\\\"锦泰财产保险股份有限公司\\\",\\\"parentid\\\":170,\\\"order\\\":99987000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":198,\\\"name\\\":\\\"省级事业单位\\\",\\\"shortName\\\":\\\"省级事业单位\\\",\\\"parentid\\\":1,\\\"order\\\":99997500,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":199,\\\"name\\\":\\\"民航四川监管局\\\",\\\"shortName\\\":\\\"民航四川监管局\\\",\\\"parentid\\\":198,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":200,\\\"name\\\":\\\"省机场集团\\\",\\\"shortName\\\":\\\"省机场集团\\\",\\\"parentid\\\":198,\\\"order\\\":99999500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":201,\\\"name\\\":\\\"高校\\\",\\\"shortName\\\":\\\"高校\\\",\\\"parentid\\\":1,\\\"order\\\":99997000,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":202,\\\"name\\\":\\\"成都农业科技职业学院\\\",\\\"shortName\\\":\\\"成都农业科技职业学院\\\",\\\"parentid\\\":201,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":203,\\\"name\\\":\\\"成都大学\\\",\\\"shortName\\\":\\\"成都大学\\\",\\\"parentid\\\":201,\\\"order\\\":99999500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":204,\\\"name\\\":\\\"成都工业职业技术学院\\\",\\\"shortName\\\":\\\"成都工业职业技术学院\\\",\\\"parentid\\\":201,\\\"order\\\":99999000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":205,\\\"name\\\":\\\"成都市技师学院\\\",\\\"shortName\\\":\\\"成都市技师学院\\\",\\\"parentid\\\":201,\\\"order\\\":99998500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":206,\\\"name\\\":\\\"成都开放大学\\\",\\\"shortName\\\":\\\"成都开放大学\\\",\\\"parentid\\\":201,\\\"order\\\":99998000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":207,\\\"name\\\":\\\"成都职业技术学院\\\",\\\"shortName\\\":\\\"成都职业技术学院\\\",\\\"parentid\\\":201,\\\"order\\\":99997500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":208,\\\"name\\\":\\\"司法机构\\\",\\\"shortName\\\":\\\"司法机构\\\",\\\"parentid\\\":1,\\\"order\\\":99996500,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":209,\\\"name\\\":\\\"市人民检察院\\\",\\\"shortName\\\":\\\"市人民检察院\\\",\\\"parentid\\\":208,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":210,\\\"name\\\":\\\"成都市中级人民法院\\\",\\\"shortName\\\":\\\"成都市中级人民法院\\\",\\\"parentid\\\":208,\\\"order\\\":99999500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":211,\\\"name\\\":\\\"市属事业单位\\\",\\\"shortName\\\":\\\"市属事业单位\\\",\\\"parentid\\\":1,\\\"order\\\":99996000,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":212,\\\"name\\\":\\\"市政府火车站地区管理委员会\\\",\\\"shortName\\\":\\\"市政府火车站地区管理委员会\\\",\\\"parentid\\\":211,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":213,\\\"name\\\":\\\"市社科联\\\",\\\"shortName\\\":\\\"市社科联\\\",\\\"parentid\\\":211,\\\"order\\\":99999500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":214,\\\"name\\\":\\\"人民团体\\\",\\\"shortName\\\":\\\"人民团体\\\",\\\"parentid\\\":1,\\\"order\\\":99995500,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":215,\\\"name\\\":\\\"市侨联\\\",\\\"shortName\\\":\\\"市侨联\\\",\\\"parentid\\\":214,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":216,\\\"name\\\":\\\"市妇联\\\",\\\"shortName\\\":\\\"市妇联\\\",\\\"parentid\\\":214,\\\"order\\\":99999500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":217,\\\"name\\\":\\\"市文联\\\",\\\"shortName\\\":\\\"市文联\\\",\\\"parentid\\\":214,\\\"order\\\":99999000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":218,\\\"name\\\":\\\"市科协\\\",\\\"shortName\\\":\\\"市科协\\\",\\\"parentid\\\":214,\\\"order\\\":99998500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":219,\\\"name\\\":\\\"成都市工商业联合会\\\",\\\"shortName\\\":\\\"成都市工商业联合会\\\",\\\"parentid\\\":214,\\\"order\\\":99998000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":220,\\\"name\\\":\\\"成都市总工会\\\",\\\"shortName\\\":\\\"成都市总工会\\\",\\\"parentid\\\":214,\\\"order\\\":99997500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":221,\\\"name\\\":\\\"成都市残疾人联合会\\\",\\\"shortName\\\":\\\"成都市残疾人联合会\\\",\\\"parentid\\\":214,\\\"order\\\":99997000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":222,\\\"name\\\":\\\"政协\\\",\\\"shortName\\\":\\\"政协\\\",\\\"parentid\\\":1,\\\"order\\\":99995000,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":223,\\\"name\\\":\\\"市政协办公厅\\\",\\\"shortName\\\":\\\"市政协办公厅\\\",\\\"parentid\\\":222,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":224,\\\"name\\\":\\\"垂管单位\\\",\\\"shortName\\\":\\\"垂管单位\\\",\\\"parentid\\\":1,\\\"order\\\":99994500,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":225,\\\"name\\\":\\\"国家统计局调查队\\\",\\\"shortName\\\":\\\"国家统计局调查队\\\",\\\"parentid\\\":224,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":226,\\\"name\\\":\\\"市烟草专卖局\\\",\\\"shortName\\\":\\\"市烟草专卖局\\\",\\\"parentid\\\":224,\\\"order\\\":99999500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":227,\\\"name\\\":\\\"成都市八0三研究所\\\",\\\"shortName\\\":\\\"成都市八0三研究所\\\",\\\"parentid\\\":224,\\\"order\\\":99999000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":228,\\\"name\\\":\\\"人大\\\",\\\"shortName\\\":\\\"人大\\\",\\\"parentid\\\":1,\\\"order\\\":99994000,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":229,\\\"name\\\":\\\"市人大常委会办公厅\\\",\\\"shortName\\\":\\\"市人大常委会办公厅\\\",\\\"parentid\\\":228,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":230,\\\"name\\\":\\\"成都市产业研究院\\\",\\\"shortName\\\":\\\"成都市产业研究院\\\",\\\"parentid\\\":1,\\\"order\\\":99993500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":7879,\\\"name\\\":\\\"市经信局新经济委\\\",\\\"shortName\\\":\\\"市经信局\\\",\\\"parentid\\\":82,\\\"order\\\":99968500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":7881,\\\"name\\\":\\\"软件和信息服务业处\\\",\\\"shortName\\\":\\\"软件和信息服务业处\\\",\\\"parentid\\\":129,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":7882,\\\"name\\\":\\\"成都市软件行业协会\\\",\\\"shortName\\\":\\\"成都市软件行业协会\\\",\\\"parentid\\\":129,\\\"order\\\":99999500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":7883,\\\"name\\\":\\\"新能源与节能环保产业处\\\",\\\"shortName\\\":\\\"新能源与节能环保产业处\\\",\\\"parentid\\\":129,\\\"order\\\":99999000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":7884,\\\"name\\\":\\\"通用电子处\\\",\\\"shortName\\\":\\\"通用电子处\\\",\\\"parentid\\\":129,\\\"order\\\":99998500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":7885,\\\"name\\\":\\\"新材料处\\\",\\\"shortName\\\":\\\"新材料处\\\",\\\"parentid\\\":129,\\\"order\\\":99998000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":7886,\\\"name\\\":\\\"航空航天处\\\",\\\"shortName\\\":\\\"航空航天处\\\",\\\"parentid\\\":129,\\\"order\\\":99997500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":7887,\\\"name\\\":\\\"工业互联网处\\\",\\\"shortName\\\":\\\"工业互联网处\\\",\\\"parentid\\\":129,\\\"order\\\":99997000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":7888,\\\"name\\\":\\\"食品处\\\",\\\"shortName\\\":\\\"食品处\\\",\\\"parentid\\\":129,\\\"order\\\":99996500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":7889,\\\"name\\\":\\\"人工智能产业处\\\",\\\"shortName\\\":\\\"人工智能产业处\\\",\\\"parentid\\\":129,\\\"order\\\":99996000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":7890,\\\"name\\\":\\\"新型显示产业处\\\",\\\"shortName\\\":\\\"新型显示产业处\\\",\\\"parentid\\\":129,\\\"order\\\":99995500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":7891,\\\"name\\\":\\\"医药健康产业处\\\",\\\"shortName\\\":\\\"医药健康产业处\\\",\\\"parentid\\\":1,\\\"order\\\":99993000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":7892,\\\"name\\\":\\\"医药健康产业处\\\",\\\"shortName\\\":\\\"医药健康产业处\\\",\\\"parentid\\\":129,\\\"order\\\":99995000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":7893,\\\"name\\\":\\\"招商处\\\",\\\"shortName\\\":\\\"招商处\\\",\\\"parentid\\\":129,\\\"order\\\":99994500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":7895,\\\"name\\\":\\\"电力处\\\",\\\"shortName\\\":\\\"电力处\\\",\\\"parentid\\\":129,\\\"order\\\":99994000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":7896,\\\"name\\\":\\\"都市产业处\\\",\\\"shortName\\\":\\\"都市产业处\\\",\\\"parentid\\\":129,\\\"order\\\":99993500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":1002052,\\\"name\\\":\\\"产业生态规划处\\\",\\\"shortName\\\":\\\"产业生态规划处\\\",\\\"parentid\\\":129,\\\"order\\\":99993000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":1002055,\\\"name\\\":\\\"温江区医学城\\\",\\\"shortName\\\":\\\"温江区医学城\\\",\\\"parentid\\\":157,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":2007129,\\\"name\\\":\\\"金堂县经济科技和信息化局\\\",\\\"shortName\\\":\\\"金堂县经济科技和信息化局\\\",\\\"parentid\\\":163,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":2007130,\\\"name\\\":\\\"成都市她妆美谷管理委员会\\\",\\\"shortName\\\":\\\"成都市她妆美谷管理委员会\\\",\\\"parentid\\\":156,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":2007131,\\\"name\\\":\\\"天府智能制造产业园管委会\\\",\\\"shortName\\\":\\\"天府智能制造产业园管委会\\\",\\\"parentid\\\":154,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":2007132,\\\"name\\\":\\\"新津区经济和信息化局\\\",\\\"shortName\\\":\\\"新津区经济和信息化局\\\",\\\"parentid\\\":154,\\\"order\\\":99999500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":2007133,\\\"name\\\":\\\"成都市天府农业博览园管委会\\\",\\\"shortName\\\":\\\"成都市天府农业博览园管委会\\\",\\\"parentid\\\":154,\\\"order\\\":99999000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":2007134,\\\"name\\\":\\\"邛崃天府现代种业园\\\",\\\"shortName\\\":\\\"邛崃天府现代种业园\\\",\\\"parentid\\\":160,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":2007135,\\\"name\\\":\\\"天府新区半导体材料产业功能区\\\",\\\"shortName\\\":\\\"天府新区半导体材料产业功能区\\\",\\\"parentid\\\":150,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":2007136,\\\"name\\\":\\\"现代农业装备产业园\\\",\\\"shortName\\\":\\\"现代农业装备产业园\\\",\\\"parentid\\\":163,\\\"order\\\":99999500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":2007137,\\\"name\\\":\\\"成都芯谷发展服务局\\\",\\\"shortName\\\":\\\"成都芯谷发展服务局\\\",\\\"parentid\\\":148,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":2007138,\\\"name\\\":\\\"龙潭工业机器人产业功能区管委会\\\",\\\"shortName\\\":\\\"龙潭工业机器人产业功能区管委会\\\",\\\"parentid\\\":153,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":2059650,\\\"name\\\":\\\"测试账号\\\",\\\"shortName\\\":\\\"测试账号\\\",\\\"parentid\\\":1,\\\"order\\\":99992500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":2060154,\\\"name\\\":\\\"智慧蓉城建设专班\\\",\\\"shortName\\\":\\\"智慧蓉城建设专班\\\",\\\"parentid\\\":129,\\\"order\\\":99992500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":2060711,\\\"name\\\":\\\"wjjtest1\\\",\\\"shortName\\\":\\\"wjjtest1\\\",\\\"parentid\\\":1,\\\"order\\\":99992000,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":2060834,\\\"name\\\":\\\"部门管理增加的1\\\",\\\"shortName\\\":\\\"部门管理增加的1\\\",\\\"parentid\\\":2060711,\\\"order\\\":99999000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":2060864,\\\"name\\\":\\\"321321\\\",\\\"shortName\\\":\\\"123123test\\\",\\\"parentid\\\":2060711,\\\"order\\\":100000000,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":2060943,\\\"name\\\":\\\"最后的部门\\\",\\\"shortName\\\":\\\"最后的部门\\\",\\\"parentid\\\":2060864,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":2061118,\\\"name\\\":\\\"技术支持组\\\",\\\"shortName\\\":\\\"技术支持组\\\",\\\"parentid\\\":9,\\\"order\\\":99998000,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":2061121,\\\"name\\\":\\\"其他团队\\\",\\\"shortName\\\":\\\"其他团队\\\",\\\"parentid\\\":2061118,\\\"order\\\":100000000,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":2061122,\\\"name\\\":\\\"数据资源体系技术支持组\\\",\\\"shortName\\\":\\\"数据资源体系技术支持组\\\",\\\"parentid\\\":2061121,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":2061130,\\\"name\\\":\\\"大数据股份\\\",\\\"shortName\\\":\\\"数股\\\",\\\"parentid\\\":1,\\\"order\\\":99999500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":2061131,\\\"name\\\":\\\"底座技术支持组\\\",\\\"shortName\\\":\\\"底座技术支持组\\\",\\\"parentid\\\":2061118,\\\"order\\\":99999000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":2061132,\\\"name\\\":\\\"临时测试组\\\",\\\"shortName\\\":\\\"临时测试组\\\",\\\"parentid\\\":2061118,\\\"order\\\":99998500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":2061138,\\\"name\\\":\\\"经信驻局纪检组\\\",\\\"shortName\\\":\\\"经信驻局纪检组\\\",\\\"parentid\\\":1,\\\"order\\\":99991500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":2061139,\\\"name\\\":\\\"经信局工业投资处\\\",\\\"shortName\\\":\\\"经信局工业投资处\\\",\\\"parentid\\\":1,\\\"order\\\":99991000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":2061148,\\\"name\\\":\\\"测试部门2\\\",\\\"shortName\\\":\\\"测试部门2\\\",\\\"parentid\\\":169,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":2061150,\\\"name\\\":\\\"层级1\\\",\\\"shortName\\\":\\\"层级1\\\",\\\"parentid\\\":169,\\\"order\\\":99999500,\\\"hasChild\\\":1,\\\"isDeleted\\\":0},{\\\"id\\\":2061151,\\\"name\\\":\\\"层级3\\\",\\\"shortName\\\":\\\"层级3\\\",\\\"parentid\\\":2061150,\\\"order\\\":100000000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":2061152,\\\"name\\\":\\\"导入使用\\\",\\\"shortName\\\":\\\"导入使用\\\",\\\"parentid\\\":2060711,\\\"order\\\":99999500,\\\"hasChild\\\":0,\\\"isDeleted\\\":0},{\\\"id\\\":2061159,\\\"name\\\":\\\"2\\\",\\\"shortName\\\":\\\"1\\\",\\\"parentid\\\":1,\\\"order\\\":99990500,\\\"hasChild\\\":0,\\\"creditcode\\\":\\\"3\\\",\\\"isDeleted\\\":0},{\\\"id\\\":2061171,\\\"name\\\":\\\"低代码平台\\\",\\\"shortName\\\":\\\"低代码平台\\\",\\\"parentid\\\":2061118,\\\"order\\\":99998000,\\\"hasChild\\\":0,\\\"isDeleted\\\":0}],\\\"version\\\":4744941},\\\"msg\\\":\\\"ok\\\"}\",\"request_params\":{\"access_token\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdXRoa2V5IjoiMTYyZWQwNjI2NGE5NDI4ODliNTRiZjVhNjE4MjAxNmYiLCJpc3MiOiJ1cmFudXMiLCJleHAiOjE3NjIzMjQ5MzZ9.utPrZJrbXvIcLFVQV-OUOOxtvOve1z7xxmKfTrLVcqo\",\"source\":\"0\"}}', 'FULL', '2025-11-05 13:12:17', '2025-11-05 13:12:17', 208, NULL, NULL, NULL, NULL);
INSERT INTO `sync_record` VALUES ('1985938326737248258', 'department', 'success', '{\"headers\":{\"x-qys-signature\":\"a9514e3a39dce02b4fe17cb6e068577e\",\"x-qys-accesstoken\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdXRoa2V5IjoiMTYyZWQwNjI2NGE5NDI4ODliNTRiZjVhNjE4MjAxNmYiLCJpc3MiOiJ1cmFudXMiLCJleHAiOjE3NjIzMjQ5Njd9.fV-8euKulfCDUfQaaIDPSjsqNjv48SKzpD2Qd8MREOI\",\"x-ys-timestamp\":\"1762319568242\"},\"response\":\"{\\\"code\\\":0,\\\"data\\\":{\\\"errcode\\\":0,\\\"errmsg\\\":\\\"ok\\\",\\\"department\\\":[],\\\"version\\\":4744941},\\\"msg\\\":\\\"ok\\\"}\",\"request_params\":{\"access_token\":\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdXRoa2V5IjoiMTYyZWQwNjI2NGE5NDI4ODliNTRiZjVhNjE4MjAxNmYiLCJpc3MiOiJ1cmFudXMiLCJleHAiOjE3NjIzMjQ5Njd9.fV-8euKulfCDUfQaaIDPSjsqNjv48SKzpD2Qd8MREOI\",\"updateTime\":1762319537000,\"source\":\"0\"}}', 'INCREMENT', '2025-11-05 13:12:48', '2025-11-05 13:12:49', 0, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_announcement
-- ----------------------------
DROP TABLE IF EXISTS `sys_announcement`;
CREATE TABLE `sys_announcement`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `titile` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `msg_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `start_time` datetime NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '结束时间',
  `sender` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发布人',
  `priority` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '优先级（L低，M中，H高）',
  `msg_category` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2' COMMENT '消息类型1:通知公告2:系统消息',
  `msg_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通告对象类型（USER:指定用户，ALL:全体用户）',
  `send_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发布状态（0未发布，1已发布，2已撤销）',
  `send_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `cancel_time` datetime NULL DEFAULT NULL COMMENT '撤销时间',
  `del_flag` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '删除状态（0，正常，1已删除）',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `user_ids` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '指定用户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统通告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_announcement
-- ----------------------------

-- ----------------------------
-- Table structure for sys_announcement_send
-- ----------------------------
DROP TABLE IF EXISTS `sys_announcement_send`;
CREATE TABLE `sys_announcement_send`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `annt_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通告ID',
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户id',
  `read_flag` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '阅读状态（0未读，1已读）',
  `read_time` datetime NULL DEFAULT NULL COMMENT '阅读时间',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户通告阅读标记表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_announcement_send
-- ----------------------------

-- ----------------------------
-- Table structure for sys_category
-- ----------------------------
DROP TABLE IF EXISTS `sys_category`;
CREATE TABLE `sys_category`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pid` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父级节点',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型名称',
  `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型编码',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门',
  `has_child` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否有子节点',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_category
-- ----------------------------
INSERT INTO `sys_category` VALUES ('1564086904362930178', '0', '区划', 'B02', NULL, NULL, NULL, NULL, NULL, '1');
INSERT INTO `sys_category` VALUES ('1564087025263742977', '1564086904362930178', '成都市', 'B02A01', NULL, NULL, NULL, NULL, NULL, '1');
INSERT INTO `sys_category` VALUES ('1564087779772895233', '1564087025263742977', '成华区', 'B02A01A01', NULL, NULL, NULL, NULL, NULL, '1');
INSERT INTO `sys_category` VALUES ('1564088534969913345', '1564087025263742977', '崇州市', 'B02A01A02', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_category` VALUES ('1564088676422815746', '1564087779772895233', '万年场街道', 'B02A01A01A01', NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_data_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_data_log`;
CREATE TABLE `sys_data_log`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'id',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `data_table` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表名',
  `data_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据ID',
  `data_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '数据内容',
  `data_version` int(11) NULL DEFAULT NULL COMMENT '版本号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sindex`(`data_table` ASC, `data_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_data_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_depart
-- ----------------------------
DROP TABLE IF EXISTS `sys_depart`;
CREATE TABLE `sys_depart`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ID',
  `parent_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父机构ID',
  `depart_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '机构/部门名称',
  `depart_name_en` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '英文名',
  `depart_name_abbr` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '缩写',
  `depart_order` int(11) NULL DEFAULT 0 COMMENT '排序',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '描述',
  `org_category` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '机构类别 1组织机构，2岗位',
  `org_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机构类型 1一级部门 2子部门',
  `org_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '机构编码',
  `mobile` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `fax` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '传真',
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  `memo` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态（1启用，0不启用）',
  `del_flag` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '删除状态（0，正常，1已删除）',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `district_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '核算级次',
  `district_full_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '核算级次全名',
  `create_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户真实姓名',
  `duty_order` double(20, 1) NULL DEFAULT 0.0 COMMENT '值班排序',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_depart_parent_id`(`parent_id` ASC) USING BTREE,
  INDEX `index_depart_depart_order`(`depart_order` ASC) USING BTREE,
  INDEX `index_depart_org_code`(`org_code` ASC) USING BTREE,
  INDEX `sys_depart_org_code_IDX`(`org_code` ASC, `depart_name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '组织机构表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_depart
-- ----------------------------
INSERT INTO `sys_depart` VALUES ('1', '2061118', '经信技术支持组', NULL, '经信技术支持组', 99999500, NULL, '1', NULL, '1', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('100', '82', '市司法局', NULL, '市司法局', 99991500, NULL, '1', NULL, '100', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('1002052', '129', '产业生态规划处', NULL, '产业生态规划处', 99993000, NULL, '1', NULL, '1002052', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('1002055', '157', '温江区医学城', NULL, '温江区医学城', 100000000, NULL, '1', NULL, '1002055', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('101', '82', '市商务局', NULL, '市商务局', 99991000, NULL, '1', NULL, '101', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('102', '82', '市国动办', NULL, '市国动办', 99990500, NULL, '1', NULL, '102', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('103', '82', '市国资委', NULL, '市国资委', 99990000, NULL, '1', NULL, '103', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('104', '82', '市地志办', NULL, '市地志办', 99989500, NULL, '1', NULL, '104', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('105', '82', '市城市运行和政务服务办', NULL, '市城市运行和政务服务办', 99989000, NULL, '1', NULL, '105', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('106', '82', '市城管委', NULL, '市城管委', 99988500, NULL, '1', NULL, '106', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('107', '82', '市城运中心', NULL, '市城运中心', 99988000, NULL, '1', NULL, '107', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('108', '82', '市审计局', NULL, '市审计局', 99987500, NULL, '1', NULL, '108', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('109', '82', '市市场监管局', NULL, '市市场监管局', 99987000, NULL, '1', NULL, '109', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('110', '82', '市应急局', NULL, '市应急局', 99986500, NULL, '1', NULL, '110', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('111', '82', '市投促局', NULL, '市投促局', 99986000, NULL, '1', NULL, '111', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('112', '82', '市政府侨办', NULL, '市政府侨办', 99985500, NULL, '1', NULL, '112', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('113', '82', '市政府办公厅', NULL, '市政府办公厅', 99985000, NULL, '1', NULL, '113', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('114', '82', '市政府台办', NULL, '市政府台办', 99984500, NULL, '1', NULL, '114', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('115', '82', '市政府外办', NULL, '市政府外办', 99984000, NULL, '1', NULL, '115', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('116', '82', '市政府新闻办', NULL, '市政府新闻办', 99983500, NULL, '1', NULL, '116', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('117', '82', '市教育局', NULL, '市教育局', 99983000, NULL, '1', NULL, '117', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('118', '82', '市文广旅局', NULL, '市文广旅局', 99982500, NULL, '1', NULL, '118', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('119', '82', '市新经济委', NULL, '市新经济委', 99982000, NULL, '1', NULL, '119', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('120', '82', '市机关事务局', NULL, '市机关事务局', 99981500, NULL, '1', NULL, '120', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('121', '82', '市民宗局', NULL, '市民宗局', 99981000, NULL, '1', NULL, '121', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('122', '82', '市民政局', NULL, '市民政局', 99980500, NULL, '1', NULL, '122', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('123', '82', '市气象局', NULL, '市气象局', 99980000, NULL, '1', NULL, '123', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('124', '82', '市水务局', NULL, '市水务局', 99979500, NULL, '1', NULL, '124', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('125', '82', '市消防救援支队', NULL, '市消防救援支队', 99979000, NULL, '1', NULL, '125', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('126', '82', '市生态环境局', NULL, '市生态环境局', 99978500, NULL, '1', NULL, '126', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('127', '82', '市科技局', NULL, '市科技局', 99978000, NULL, '1', NULL, '127', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('128', '82', '市税务局', NULL, '市税务局', 99977500, NULL, '1', NULL, '128', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('129', '82', '市经信局', NULL, '市经信局', 99977000, NULL, '1', NULL, '129', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('130', '82', '市统计局', NULL, '市统计局', 99976500, NULL, '1', NULL, '130', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('131', '82', '市规划和自然资源局', NULL, '市规划和自然资源局', 99976000, NULL, '1', NULL, '131', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('132', '82', '市财政局', NULL, '市财政局', 99975500, NULL, '1', NULL, '132', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('133', '82', '市贸促会', NULL, '市贸促会', 99975000, NULL, '1', NULL, '133', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('134', '82', '市邮政管理局', NULL, '市邮政管理局', 99974500, NULL, '1', NULL, '134', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('135', '82', '市金融监管局', NULL, '市金融监管局', 99974000, NULL, '1', NULL, '135', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('136', '82', '成都住房公积金管理中心', NULL, '成都住房公积金管理中心', 99973500, NULL, '1', NULL, '136', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('137', '82', '成都大运会执委会办公室', NULL, '成都大运会执委会办公室', 99973000, NULL, '1', NULL, '137', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('138', '82', '成都市淮州新城管理委员会', NULL, '成都市淮州新城管理委员会', 99972500, NULL, '1', NULL, '138', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('139', '82', '成都市退役军人事务局', NULL, '成都市退役军人事务局', 99972000, NULL, '1', NULL, '139', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('140', '82', '成都森林消防(特种救援)大队', NULL, '成都森林消防(特种救援)大队', 99971500, NULL, '1', NULL, '140', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('141', '82', '成都石化园区管委会', NULL, '成都石化园区管委会', 99971000, NULL, '1', NULL, '141', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('142', '82', '成都警备区', NULL, '成都警备区', 99970500, NULL, '1', NULL, '142', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('143', '82', '成都龙泉山城市森林公园管委会', NULL, '成都龙泉山城市森林公园管委会', 99970000, NULL, '1', NULL, '143', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('144', '82', '武警成都支队', NULL, '武警成都支队', 99969500, NULL, '1', NULL, '144', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('145', '82', '系统运维', NULL, '系统运维', 99969000, NULL, '1', NULL, '145', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('146', '1', '区（市）县', NULL, '区（市）县', 99998500, NULL, '1', NULL, '146', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('147', '146', '东部新区', NULL, '东部新区', 100000000, NULL, '1', NULL, '147', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('148', '146', '双流区', NULL, '双流区', 99999500, NULL, '1', NULL, '148', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('149', '146', '大邑县', NULL, '大邑县', 99999000, NULL, '1', NULL, '149', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('150', '146', '天府新区', NULL, '天府新区', 99998500, NULL, '1', NULL, '150', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('151', '146', '崇州市', NULL, '崇州市', 99998000, NULL, '1', NULL, '151', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('152', '146', '彭州市', NULL, '彭州市', 99997500, NULL, '1', NULL, '152', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('153', '146', '成华区', NULL, '成华区', 99997000, NULL, '1', NULL, '153', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('154', '146', '新津区', NULL, '新津区', 99996500, NULL, '1', NULL, '154', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('155', '146', '新都区', NULL, '新都区', 99996000, NULL, '1', NULL, '155', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('156', '146', '武侯区', NULL, '武侯区', 99995500, NULL, '1', NULL, '156', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('157', '146', '温江区', NULL, '温江区', 99995000, NULL, '1', NULL, '157', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('158', '146', '简阳市', NULL, '简阳市', 99994500, NULL, '1', NULL, '158', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('159', '146', '蒲江县', NULL, '蒲江县', 99994000, NULL, '1', NULL, '159', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('160', '146', '邛崃市', NULL, '邛崃市', 99993500, NULL, '1', NULL, '160', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('161', '146', '郫都区', NULL, '郫都区', 99993000, NULL, '1', NULL, '161', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('162', '146', '都江堰市', NULL, '都江堰市', 99992500, NULL, '1', NULL, '162', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('163', '146', '金堂县', NULL, '金堂县', 99992000, NULL, '1', NULL, '163', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('164', '146', '金牛区', NULL, '金牛区', 99991500, NULL, '1', NULL, '164', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('165', '146', '锦江区', NULL, '锦江区', 99991000, NULL, '1', NULL, '165', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('166', '146', '青白江区', NULL, '青白江区', 99990500, NULL, '1', NULL, '166', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('167', '146', '青羊区', NULL, '青羊区', 99990000, NULL, '1', NULL, '167', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('168', '146', '高新区', NULL, '高新区', 99989500, NULL, '1', NULL, '168', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('169', '146', '龙泉驿区', NULL, '龙泉驿区', 99989000, NULL, '1', NULL, '169', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('170', '1', '国企', NULL, '国企', 99998000, NULL, '1', NULL, '170', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('171', '170', '中国安能集团第三工程局成都分公司', NULL, '中国安能集团第三工程局成都分公司', 100000000, NULL, '1', NULL, '171', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('172', '170', '中国铁路成都局集团公司', NULL, '中国铁路成都局集团公司', 99999500, NULL, '1', NULL, '172', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('173', '170', '中国铁通成都分公司', NULL, '中国铁通成都分公司', 99999000, NULL, '1', NULL, '173', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('174', '170', '国网四川省检修公司成都中心', NULL, '国网四川省检修公司成都中心', 99998500, NULL, '1', NULL, '174', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('175', '170', '国网天府新区供电公司', NULL, '国网天府新区供电公司', 99998000, NULL, '1', NULL, '175', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('176', '170', '国网成都供电公司', NULL, '国网成都供电公司', 99997500, NULL, '1', NULL, '176', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('177', '170', '市红十字会', NULL, '市红十字会', 99997000, NULL, '1', NULL, '177', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('178', '170', '成都交子金控集团', NULL, '成都交子金控集团', 99996500, NULL, '1', NULL, '178', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('179', '170', '成都交投集团', NULL, '成都交投集团', 99996000, NULL, '1', NULL, '179', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('180', '170', '成都产业集团', NULL, '成都产业集团', 99995500, NULL, '1', NULL, '180', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('181', '170', '成都传媒集团', NULL, '成都传媒集团', 99995000, NULL, '1', NULL, '181', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('182', '170', '成都兴城投资集团有限公司', NULL, '成都兴城投资集团有限公司', 99994500, NULL, '1', NULL, '182', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('183', '170', '成都地铁运营有限公司', NULL, '成都地铁运营有限公司', 99994000, NULL, '1', NULL, '183', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('184', '170', '成都城建投资管理集团有限责任公司', NULL, '成都城建投资管理集团有限责任公司', 99993500, NULL, '1', NULL, '184', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('185', '170', '成都城投集团', NULL, '成都城投集团', 99993000, NULL, '1', NULL, '185', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('186', '170', '成都市公共交通集团有限公司', NULL, '成都市公共交通集团有限公司', 99992500, NULL, '1', NULL, '186', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('187', '170', '成都文旅集团', NULL, '成都文旅集团', 99992000, NULL, '1', NULL, '187', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('188', '170', '成都环境投资集团', NULL, '成都环境投资集团', 99991500, NULL, '1', NULL, '188', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('189', '170', '成都设计咨询集团', NULL, '成都设计咨询集团', 99991000, NULL, '1', NULL, '189', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('190', '170', '成都轨道交通集团有限公司', NULL, '成都轨道交通集团有限公司', 99990500, NULL, '1', NULL, '190', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('191', '170', '电信成都分公司', NULL, '电信成都分公司', 99990000, NULL, '1', NULL, '191', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('192', '170', '益民集团', NULL, '益民集团', 99989500, NULL, '1', NULL, '192', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('193', '170', '移动天府新区分公司', NULL, '移动天府新区分公司', 99989000, NULL, '1', NULL, '193', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('194', '170', '移动成都分公司', NULL, '移动成都分公司', 99988500, NULL, '1', NULL, '194', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('195', '170', '联通成都分公司', NULL, '联通成都分公司', 99988000, NULL, '1', NULL, '195', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('196', '170', '铁塔成都分公司', NULL, '铁塔成都分公司', 99987500, NULL, '1', NULL, '196', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('197', '170', '锦泰财产保险股份有限公司', NULL, '锦泰财产保险股份有限公司', 99987000, NULL, '1', NULL, '197', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('198', '1', '省级事业单位', NULL, '省级事业单位', 99997500, NULL, '1', NULL, '198', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('199', '198', '民航四川监管局', NULL, '民航四川监管局', 100000000, NULL, '1', NULL, '199', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('200', '198', '省机场集团', NULL, '省机场集团', 99999500, NULL, '1', NULL, '200', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2007129', '163', '金堂县经济科技和信息化局', NULL, '金堂县经济科技和信息化局', 100000000, NULL, '1', NULL, '2007129', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2007130', '156', '成都市她妆美谷管理委员会', NULL, '成都市她妆美谷管理委员会', 100000000, NULL, '1', NULL, '2007130', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2007131', '154', '天府智能制造产业园管委会', NULL, '天府智能制造产业园管委会', 100000000, NULL, '1', NULL, '2007131', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2007132', '154', '新津区经济和信息化局', NULL, '新津区经济和信息化局', 99999500, NULL, '1', NULL, '2007132', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2007133', '154', '成都市天府农业博览园管委会', NULL, '成都市天府农业博览园管委会', 99999000, NULL, '1', NULL, '2007133', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2007134', '160', '邛崃天府现代种业园', NULL, '邛崃天府现代种业园', 100000000, NULL, '1', NULL, '2007134', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2007135', '150', '天府新区半导体材料产业功能区', NULL, '天府新区半导体材料产业功能区', 100000000, NULL, '1', NULL, '2007135', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2007136', '163', '现代农业装备产业园', NULL, '现代农业装备产业园', 99999500, NULL, '1', NULL, '2007136', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2007137', '148', '成都芯谷发展服务局', NULL, '成都芯谷发展服务局', 100000000, NULL, '1', NULL, '2007137', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2007138', '153', '龙潭工业机器人产业功能区管委会', NULL, '龙潭工业机器人产业功能区管委会', 100000000, NULL, '1', NULL, '2007138', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('201', '1', '高校', NULL, '高校', 99997000, NULL, '1', NULL, '201', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('202', '201', '成都农业科技职业学院', NULL, '成都农业科技职业学院', 100000000, NULL, '1', NULL, '202', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('203', '201', '成都大学', NULL, '成都大学', 99999500, NULL, '1', NULL, '203', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('204', '201', '成都工业职业技术学院', NULL, '成都工业职业技术学院', 99999000, NULL, '1', NULL, '204', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('205', '201', '成都市技师学院', NULL, '成都市技师学院', 99998500, NULL, '1', NULL, '205', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2059650', '1', '测试账号', NULL, '测试账号', 99992500, NULL, '1', NULL, '2059650', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('206', '201', '成都开放大学', NULL, '成都开放大学', 99998000, NULL, '1', NULL, '206', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2060154', '129', '智慧蓉城建设专班', NULL, '智慧蓉城建设专班', 99992500, NULL, '1', NULL, '2060154', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2060711', '1', 'wjjtest1', NULL, 'wjjtest1', 99992000, NULL, '1', NULL, '2060711', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2060834', '2060711', '部门管理增加的1', NULL, '部门管理增加的1', 99999000, NULL, '1', NULL, '2060834', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2060864', '2060711', '321321', NULL, '123123test', 100000000, NULL, '1', NULL, '2060864', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2060943', '2060864', '最后的部门', NULL, '最后的部门', 100000000, NULL, '1', NULL, '2060943', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2061118', '9', '技术支持组', NULL, '技术支持组', 99998000, NULL, '1', NULL, '2061118', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2061121', '2061118', '其他团队', NULL, '其他团队', 100000000, NULL, '1', NULL, '2061121', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2061122', '2061121', '数据资源体系技术支持组', NULL, '数据资源体系技术支持组', 100000000, NULL, '1', NULL, '2061122', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2061130', '1', '大数据股份', NULL, '数股', 99999500, NULL, '1', NULL, '2061130', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2061131', '2061118', '底座技术支持组', NULL, '底座技术支持组', 99999000, NULL, '1', NULL, '2061131', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2061132', '2061118', '临时测试组', NULL, '临时测试组', 99998500, NULL, '1', NULL, '2061132', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2061138', '1', '经信驻局纪检组', NULL, '经信驻局纪检组', 99991500, NULL, '1', NULL, '2061138', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2061139', '1', '经信局工业投资处', NULL, '经信局工业投资处', 99991000, NULL, '1', NULL, '2061139', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2061148', '169', '测试部门2', NULL, '测试部门2', 100000000, NULL, '1', NULL, '2061148', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2061150', '169', '层级1', NULL, '层级1', 99999500, NULL, '1', NULL, '2061150', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2061151', '2061150', '层级3', NULL, '层级3', 100000000, NULL, '1', NULL, '2061151', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2061152', '2060711', '导入使用', NULL, '导入使用', 99999500, NULL, '1', NULL, '2061152', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2061159', '1', '2', NULL, '1', 99990500, NULL, '1', NULL, '2061159', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('2061171', '2061118', '低代码平台', NULL, '低代码平台', 99998000, NULL, '1', NULL, '2061171', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('207', '201', '成都职业技术学院', NULL, '成都职业技术学院', 99997500, NULL, '1', NULL, '207', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('208', '1', '司法机构', NULL, '司法机构', 99996500, NULL, '1', NULL, '208', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('209', '208', '市人民检察院', NULL, '市人民检察院', 100000000, NULL, '1', NULL, '209', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('210', '208', '成都市中级人民法院', NULL, '成都市中级人民法院', 99999500, NULL, '1', NULL, '210', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('211', '1', '市属事业单位', NULL, '市属事业单位', 99996000, NULL, '1', NULL, '211', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('212', '211', '市政府火车站地区管理委员会', NULL, '市政府火车站地区管理委员会', 100000000, NULL, '1', NULL, '212', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('213', '211', '市社科联', NULL, '市社科联', 99999500, NULL, '1', NULL, '213', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('214', '1', '人民团体', NULL, '人民团体', 99995500, NULL, '1', NULL, '214', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('215', '214', '市侨联', NULL, '市侨联', 100000000, NULL, '1', NULL, '215', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('216', '214', '市妇联', NULL, '市妇联', 99999500, NULL, '1', NULL, '216', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('217', '214', '市文联', NULL, '市文联', 99999000, NULL, '1', NULL, '217', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('218', '214', '市科协', NULL, '市科协', 99998500, NULL, '1', NULL, '218', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('219', '214', '成都市工商业联合会', NULL, '成都市工商业联合会', 99998000, NULL, '1', NULL, '219', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('220', '214', '成都市总工会', NULL, '成都市总工会', 99997500, NULL, '1', NULL, '220', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('221', '214', '成都市残疾人联合会', NULL, '成都市残疾人联合会', 99997000, NULL, '1', NULL, '221', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('222', '1', '政协', NULL, '政协', 99995000, NULL, '1', NULL, '222', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('223', '222', '市政协办公厅', NULL, '市政协办公厅', 100000000, NULL, '1', NULL, '223', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('224', '1', '垂管单位', NULL, '垂管单位', 99994500, NULL, '1', NULL, '224', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('225', '224', '国家统计局调查队', NULL, '国家统计局调查队', 100000000, NULL, '1', NULL, '225', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('226', '224', '市烟草专卖局', NULL, '市烟草专卖局', 99999500, NULL, '1', NULL, '226', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('227', '224', '成都市八0三研究所', NULL, '成都市八0三研究所', 99999000, NULL, '1', NULL, '227', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('228', '1', '人大', NULL, '人大', 99994000, NULL, '1', NULL, '228', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('229', '228', '市人大常委会办公厅', NULL, '市人大常委会办公厅', 100000000, NULL, '1', NULL, '229', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('230', '1', '成都市产业研究院', NULL, '成都市产业研究院', 99993500, NULL, '1', NULL, '230', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('72', '1', '成都市委', NULL, '成都市委', 100000000, NULL, '1', NULL, '72', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('73', '72', '团市委', NULL, '团市委', 100000000, NULL, '1', NULL, '73', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('74', '72', '市委办公厅', NULL, '市委办公厅', 99999500, NULL, '1', NULL, '74', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('75', '72', '市委外事办', NULL, '市委外事办', 99999000, NULL, '1', NULL, '75', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('76', '72', '市委宣传部', NULL, '市委宣传部', 99998500, NULL, '1', NULL, '76', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('77', '72', '市委政法委', NULL, '市委政法委', 99998000, NULL, '1', NULL, '77', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('78', '72', '市委社会工作部', NULL, '市委社会工作部', 99997500, NULL, '1', NULL, '78', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('7879', '82', '市经信局新经济委', NULL, '市经信局', 99968500, NULL, '1', NULL, '7879', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('7881', '129', '软件和信息服务业处', NULL, '软件和信息服务业处', 100000000, NULL, '1', NULL, '7881', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('7882', '129', '成都市软件行业协会', NULL, '成都市软件行业协会', 99999500, NULL, '1', NULL, '7882', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('7883', '129', '新能源与节能环保产业处', NULL, '新能源与节能环保产业处', 99999000, NULL, '1', NULL, '7883', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('7884', '129', '通用电子处', NULL, '通用电子处', 99998500, NULL, '1', NULL, '7884', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('7885', '129', '新材料处', NULL, '新材料处', 99998000, NULL, '1', NULL, '7885', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('7886', '129', '航空航天处', NULL, '航空航天处', 99997500, NULL, '1', NULL, '7886', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('7887', '129', '工业互联网处', NULL, '工业互联网处', 99997000, NULL, '1', NULL, '7887', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('7888', '129', '食品处', NULL, '食品处', 99996500, NULL, '1', NULL, '7888', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('7889', '129', '人工智能产业处', NULL, '人工智能产业处', 99996000, NULL, '1', NULL, '7889', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('7890', '129', '新型显示产业处', NULL, '新型显示产业处', 99995500, NULL, '1', NULL, '7890', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('7891', '1', '医药健康产业处', NULL, '医药健康产业处', 99993000, NULL, '1', NULL, '7891', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('7892', '129', '医药健康产业处', NULL, '医药健康产业处', 99995000, NULL, '1', NULL, '7892', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('7893', '129', '招商处', NULL, '招商处', 99994500, NULL, '1', NULL, '7893', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('7895', '129', '电力处', NULL, '电力处', 99994000, NULL, '1', NULL, '7895', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('7896', '129', '都市产业处', NULL, '都市产业处', 99993500, NULL, '1', NULL, '7896', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('79', '72', '市委统战部', NULL, '市委统战部', 99997000, NULL, '1', NULL, '79', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('80', '72', '市委网信办', NULL, '市委网信办', 99996500, NULL, '1', NULL, '80', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('81', '72', '市纪委', NULL, '市纪委', 99996000, NULL, '1', NULL, '81', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('82', '1', '市政府部门', NULL, '市政府部门', 99999000, NULL, '1', NULL, '82', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('83', '82', '市互联网信息办', NULL, '市互联网信息办', 100000000, NULL, '1', NULL, '83', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('84', '82', '市交通运输局', NULL, '市交通运输局', 99999500, NULL, '1', NULL, '84', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('85', '82', '市人社局', NULL, '市人社局', 99999000, NULL, '1', NULL, '85', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('86', '82', '市人防办', NULL, '市人防办', 99998500, NULL, '1', NULL, '86', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('87', '82', '市住建局', NULL, '市住建局', 99998000, NULL, '1', NULL, '87', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('88', '82', '市体育局', NULL, '市体育局', 99997500, NULL, '1', NULL, '88', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('89', '82', '市信访局', NULL, '市信访局', 99997000, NULL, '1', NULL, '89', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('90', '82', '市公园城市局', NULL, '市公园城市局', 99996500, NULL, '1', NULL, '90', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('91', '82', '市公安局', NULL, '市公安局', 99996000, NULL, '1', NULL, '91', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('92', '82', '市公资交易中心', NULL, '市公资交易中心', 99995500, NULL, '1', NULL, '92', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('93', '82', '市农业农村局', NULL, '市农业农村局', 99995000, NULL, '1', NULL, '93', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('94', '82', '市农林科学院', NULL, '市农林科学院', 99994500, NULL, '1', NULL, '94', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('95', '82', '市医保局', NULL, '市医保局', 99994000, NULL, '1', NULL, '95', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('96', '82', '市博览局', NULL, '市博览局', 99993500, NULL, '1', NULL, '96', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('97', '82', '市卫健委', NULL, '市卫健委', 99993000, NULL, '1', NULL, '97', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('98', '82', '市发改委', NULL, '市发改委', 99992500, NULL, '1', NULL, '98', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);
INSERT INTO `sys_depart` VALUES ('99', '82', '市口岸物流办', NULL, '市口岸物流办', 99992000, NULL, '1', NULL, '99', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0);

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `dict_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典名称',
  `dict_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典编码',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `del_flag` int(11) NULL DEFAULT NULL COMMENT '删除状态',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `type` int(1) UNSIGNED ZEROFILL NULL DEFAULT 0 COMMENT '字典类型0为string,1为number',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `indextable_dict_code`(`dict_code` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('6e50829c530846f19d7b309604d5cf62', '经信统一认证', 'JX_UNIFY_AUTH', NULL, 0, NULL, NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for sys_dict_item
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_item`;
CREATE TABLE `sys_dict_item`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `dict_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典id',
  `item_text` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典项文本',
  `item_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字典项值',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '描述',
  `sort_order` int(11) NULL DEFAULT NULL COMMENT '排序',
  `status` int(11) NULL DEFAULT NULL COMMENT '状态（1启用 0不启用）',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_table_dict_id`(`dict_id` ASC) USING BTREE,
  INDEX `index_table_sort_order`(`sort_order` ASC) USING BTREE,
  INDEX `index_table_dict_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_item
-- ----------------------------
INSERT INTO `sys_dict_item` VALUES ('2460101633d64022ad1a73c5c9708b59', '6e50829c530846f19d7b309604d5cf62', 'AUTH_PATH', 'http://221.237.111.10:50080', NULL, 1, 0, 'admin', '2025-11-04 16:51:59', 'admin', '2025-11-04 16:52:04');
INSERT INTO `sys_dict_item` VALUES ('5717e67f5a6946f6b6c2b9384bcb315c', '6e50829c530846f19d7b309604d5cf62', 'JUMP_ADDRESS', 'http://192.168.8.45:1090/unifiedAuth', NULL, 3, 0, 'admin', '2025-11-05 09:37:07', 'admin', '2025-11-05 09:37:15');
INSERT INTO `sys_dict_item` VALUES ('c7541d25b8da4359b88541dfed15a136', '6e50829c530846f19d7b309604d5cf62', 'CORPSECRET', '162ed06264a942889b54bf5a6182016f', NULL, 2, 0, 'admin', '2025-11-04 16:58:20', 'admin', '2025-11-04 16:58:29');

-- ----------------------------
-- Table structure for sys_district
-- ----------------------------
DROP TABLE IF EXISTS `sys_district`;
CREATE TABLE `sys_district`  (
  `code` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '区划代码',
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '名称',
  `full_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '全称（\"-\"隔开）',
  `level` tinyint(1) NOT NULL COMMENT '级别1-5,省市县镇村',
  `pcode` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父级区划代码',
  `smcode` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区划短代码',
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'id',
  `Column8` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`code`) USING BTREE,
  INDEX `name`(`name` ASC) USING BTREE,
  INDEX `level`(`level` ASC) USING BTREE,
  INDEX `pcode`(`pcode` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_district
-- ----------------------------
INSERT INTO `sys_district` VALUES ('510000000000', '四川省', '四川省', 1, NULL, '51', '510000000000', NULL);
INSERT INTO `sys_district` VALUES ('510100000000', '成都市', '四川省-成都市', 2, '510000000000', '5101', '510100000000', NULL);
INSERT INTO `sys_district` VALUES ('510101000000', '市辖区', '四川省-成都市-市辖区', 3, '510100000000', '510101', '510101000000', NULL);
INSERT INTO `sys_district` VALUES ('510102000000', '高新区', '四川省-成都市-高新区', 3, '510100000000', '510102', '510102000000', NULL);
INSERT INTO `sys_district` VALUES ('510102001000', '肖家河街道', '成都市-高新区-肖家河街道', 4, '510102000000', '510102001', '510102001000', NULL);
INSERT INTO `sys_district` VALUES ('510102002000', '芳草街街道', '成都市-高新区-芳草街街道', 4, '510102000000', '510102002', '510102002000', NULL);
INSERT INTO `sys_district` VALUES ('510102003000', '石羊街道', '成都市-高新区-石羊街道', 4, '510102000000', '510102003', '510102003000', NULL);
INSERT INTO `sys_district` VALUES ('510102004000', '桂溪街道', '成都市-高新区-桂溪街道', 4, '510102000000', '510102004', '510102004000', NULL);
INSERT INTO `sys_district` VALUES ('510102006000', '合作街道', '成都市-高新区-合作街道', 4, '510102000000', '510102006', '510102006000', NULL);
INSERT INTO `sys_district` VALUES ('510102007000', '中和街道', '成都市-高新区-中和街道', 4, '510102000000', '510102007', '510102007000', NULL);
INSERT INTO `sys_district` VALUES ('510102033000', '西园街道', '成都市-高新区-西园街道', 4, '510102000000', '510102033', '510102033000', NULL);
INSERT INTO `sys_district` VALUES ('510104000000', '锦江区', '四川省-成都市-锦江区', 3, '510100000000', '510104', '510104000000', NULL);
INSERT INTO `sys_district` VALUES ('510104019000', '锦华路街道', '成都市-锦江区-锦华路街道', 4, '510104000000', '510104019', '510104019000', NULL);
INSERT INTO `sys_district` VALUES ('510104022000', '春熙路街道', '成都市-锦江区-春熙路街道', 4, '510104000000', '510104022', '510104022000', NULL);
INSERT INTO `sys_district` VALUES ('510104023000', '书院街街道', '成都市-锦江区-书院街街道', 4, '510104000000', '510104023', '510104023000', NULL);
INSERT INTO `sys_district` VALUES ('510104025000', '锦官驿街道', '成都市-锦江区-锦官驿街道', 4, '510104000000', '510104025', '510104025000', NULL);
INSERT INTO `sys_district` VALUES ('510104026000', '牛市口街道', '成都市-锦江区-牛市口街道', 4, '510104000000', '510104026', '510104026000', NULL);
INSERT INTO `sys_district` VALUES ('510104027000', '东湖街道', '成都市-锦江区-东湖街道', 4, '510104000000', '510104027', '510104027000', NULL);
INSERT INTO `sys_district` VALUES ('510104030000', '沙河街道', '成都市-锦江区-沙河街道', 4, '510104000000', '510104030', '510104030000', NULL);
INSERT INTO `sys_district` VALUES ('510104032000', '狮子山街道', '成都市-锦江区-狮子山街道', 4, '510104000000', '510104032', '510104032000', NULL);
INSERT INTO `sys_district` VALUES ('510104035000', '成龙路街道', '成都市-锦江区-成龙路街道', 4, '510104000000', '510104035', '510104035000', NULL);
INSERT INTO `sys_district` VALUES ('510104036000', '柳江街道', '成都市-锦江区-柳江街道', 4, '510104000000', '510104036', '510104036000', NULL);
INSERT INTO `sys_district` VALUES ('510104037000', '三圣街道', '成都市-锦江区-三圣街道', 4, '510104000000', '510104037', '510104037000', NULL);
INSERT INTO `sys_district` VALUES ('510105000000', '青羊区', '四川省-成都市-青羊区', 3, '510100000000', '510105', '510105000000', NULL);
INSERT INTO `sys_district` VALUES ('510105002000', '草市街街道', '成都市-青羊区-草市街街道', 4, '510105000000', '510105002', '510105002000', NULL);
INSERT INTO `sys_district` VALUES ('510105003000', '西御河街道', '成都市-青羊区-西御河街道', 4, '510105000000', '510105003', '510105003000', NULL);
INSERT INTO `sys_district` VALUES ('510105005000', '少城街道', '成都市-青羊区-少城街道', 4, '510105000000', '510105005', '510105005000', NULL);
INSERT INTO `sys_district` VALUES ('510105007000', '草堂街道', '成都市-青羊区-草堂街道', 4, '510105000000', '510105007', '510105007000', NULL);
INSERT INTO `sys_district` VALUES ('510105008000', '府南街道', '成都市-青羊区-府南街道', 4, '510105000000', '510105008', '510105008000', NULL);
INSERT INTO `sys_district` VALUES ('510105009000', '光华街道', '成都市-青羊区-光华街道', 4, '510105000000', '510105009', '510105009000', NULL);
INSERT INTO `sys_district` VALUES ('510105011000', '金沙街道', '成都市-青羊区-金沙街道', 4, '510105000000', '510105011', '510105011000', NULL);
INSERT INTO `sys_district` VALUES ('510105012000', '黄田坝街道', '成都市-青羊区-黄田坝街道', 4, '510105000000', '510105012', '510105012000', NULL);
INSERT INTO `sys_district` VALUES ('510105013000', '苏坡街道', '成都市-青羊区-苏坡街道', 4, '510105000000', '510105013', '510105013000', NULL);
INSERT INTO `sys_district` VALUES ('510105014000', '文家街道', '成都市-青羊区-文家街道', 4, '510105000000', '510105014', '510105014000', NULL);
INSERT INTO `sys_district` VALUES ('510105015000', '康河街道', '成都市-青羊区-康河街道', 4, '510105000000', '510105015', '510105015000', NULL);
INSERT INTO `sys_district` VALUES ('510105018000', '蔡桥街道', '成都市-青羊区-蔡桥街道', 4, '510105000000', '510105018', '510105018000', NULL);
INSERT INTO `sys_district` VALUES ('510106000000', '金牛区', '四川省-成都市-金牛区', 3, '510100000000', '510106', '510106000000', NULL);
INSERT INTO `sys_district` VALUES ('510106024000', '西安路街道', '成都市-金牛区-西安路街道', 4, '510106000000', '510106024', '510106024000', NULL);
INSERT INTO `sys_district` VALUES ('510106025000', '西华街道', '成都市-金牛区-西华街道', 4, '510106000000', '510106025', '510106025000', NULL);
INSERT INTO `sys_district` VALUES ('510106027000', '荷花池街道', '成都市-金牛区-荷花池街道', 4, '510106000000', '510106027', '510106027000', NULL);
INSERT INTO `sys_district` VALUES ('510106030000', '驷马桥街道', '成都市-金牛区-驷马桥街道', 4, '510106000000', '510106030', '510106030000', NULL);
INSERT INTO `sys_district` VALUES ('510106031000', '茶店子街道', '成都市-金牛区-茶店子街道', 4, '510106000000', '510106031', '510106031000', NULL);
INSERT INTO `sys_district` VALUES ('510106032000', '抚琴街道', '成都市-金牛区-抚琴街道', 4, '510106000000', '510106032', '510106032000', NULL);
INSERT INTO `sys_district` VALUES ('510106035000', '九里堤街道', '成都市-金牛区-九里堤街道', 4, '510106000000', '510106035', '510106035000', NULL);
INSERT INTO `sys_district` VALUES ('510106036000', '五块石街道', '成都市-金牛区-五块石街道', 4, '510106000000', '510106036', '510106036000', NULL);
INSERT INTO `sys_district` VALUES ('510106038000', '营门口街道', '成都市-金牛区-营门口街道', 4, '510106000000', '510106038', '510106038000', NULL);
INSERT INTO `sys_district` VALUES ('510106040000', '金泉街道', '成都市-金牛区-金泉街道', 4, '510106000000', '510106040', '510106040000', NULL);
INSERT INTO `sys_district` VALUES ('510106041000', '沙河源街道', '成都市-金牛区-沙河源街道', 4, '510106000000', '510106041', '510106041000', NULL);
INSERT INTO `sys_district` VALUES ('510106042000', '天回镇街道', '成都市-金牛区-天回镇街道', 4, '510106000000', '510106042', '510106042000', NULL);
INSERT INTO `sys_district` VALUES ('510106043000', '凤凰山街道', '成都市-金牛区-凤凰山街道', 4, '510106000000', '510106043', '510106043000', NULL);
INSERT INTO `sys_district` VALUES ('510107000000', '武侯区', '四川省-成都市-武侯区', 3, '510100000000', '510107', '510107000000', NULL);
INSERT INTO `sys_district` VALUES ('510107001000', '浆洗街街道', '成都市-武侯区-浆洗街街道', 4, '510107000000', '510107001', '510107001000', NULL);
INSERT INTO `sys_district` VALUES ('510107004000', '望江路街道', '成都市-武侯区-望江路街道', 4, '510107000000', '510107004', '510107004000', NULL);
INSERT INTO `sys_district` VALUES ('510107005000', '玉林街道', '成都市-武侯区-玉林街道', 4, '510107000000', '510107005', '510107005000', NULL);
INSERT INTO `sys_district` VALUES ('510107007000', '火车南站街道', '成都市-武侯区-火车南站街道', 4, '510107000000', '510107007', '510107007000', NULL);
INSERT INTO `sys_district` VALUES ('510107009000', '晋阳街道', '成都市-武侯区-晋阳街道', 4, '510107000000', '510107009', '510107009000', NULL);
INSERT INTO `sys_district` VALUES ('510107010000', '红牌楼街道', '成都市-武侯区-红牌楼街道', 4, '510107000000', '510107010', '510107010000', NULL);
INSERT INTO `sys_district` VALUES ('510107011000', '簇桥街道', '成都市-武侯区-簇桥街道', 4, '510107000000', '510107011', '510107011000', NULL);
INSERT INTO `sys_district` VALUES ('510107012000', '机投桥街道', '成都市-武侯区-机投桥街道', 4, '510107000000', '510107012', '510107012000', NULL);
INSERT INTO `sys_district` VALUES ('510107013000', '金花桥街道', '成都市-武侯区-金花桥街道', 4, '510107000000', '510107013', '510107013000', NULL);
INSERT INTO `sys_district` VALUES ('510107014000', '簇锦街道', '成都市-武侯区-簇锦街道', 4, '510107000000', '510107014', '510107014000', NULL);
INSERT INTO `sys_district` VALUES ('510107015000', '华兴街道', '成都市-武侯区-华兴街道', 4, '510107000000', '510107015', '510107015000', NULL);
INSERT INTO `sys_district` VALUES ('510108000000', '成华区', '四川省-成都市-成华区', 3, '510100000000', '510108', '510108000000', NULL);
INSERT INTO `sys_district` VALUES ('510108002000', '猛追湾街道', '成都市-成华区-猛追湾街道', 4, '510108000000', '510108002', '510108002000', NULL);
INSERT INTO `sys_district` VALUES ('510108004000', '双桥子街道', '成都市-成华区-双桥子街道', 4, '510108000000', '510108004', '510108004000', NULL);
INSERT INTO `sys_district` VALUES ('510108006000', '府青路街道', '成都市-成华区-府青路街道', 4, '510108000000', '510108006', '510108006000', NULL);
INSERT INTO `sys_district` VALUES ('510108007000', '二仙桥街道', '成都市-成华区-二仙桥街道', 4, '510108000000', '510108007', '510108007000', NULL);
INSERT INTO `sys_district` VALUES ('510108008000', '跳蹬河街道', '成都市-成华区-跳蹬河街道', 4, '510108000000', '510108008', '510108008000', NULL);
INSERT INTO `sys_district` VALUES ('510108010000', '双水碾街道', '成都市-成华区-双水碾街道', 4, '510108000000', '510108010', '510108010000', NULL);
INSERT INTO `sys_district` VALUES ('510108011000', '万年场街道', '成都市-成华区-万年场街道', 4, '510108000000', '510108011', '510108011000', NULL);
INSERT INTO `sys_district` VALUES ('510108014000', '保和街道', '成都市-成华区-保和街道', 4, '510108000000', '510108014', '510108014000', NULL);
INSERT INTO `sys_district` VALUES ('510108015000', '青龙街道', '成都市-成华区-青龙街道', 4, '510108000000', '510108015', '510108015000', NULL);
INSERT INTO `sys_district` VALUES ('510108016000', '龙潭街道', '成都市-成华区-龙潭街道', 4, '510108000000', '510108016', '510108016000', NULL);
INSERT INTO `sys_district` VALUES ('510108017000', '白莲池街道', '成都市-成华区-白莲池街道', 4, '510108000000', '510108017', '510108017000', NULL);
INSERT INTO `sys_district` VALUES ('510110001000', '华阳街道', '成都市-天府新区-华阳街道', 4, '510156000000', '510110001', '510110001000', NULL);
INSERT INTO `sys_district` VALUES ('510110004000', '煎茶街道', '成都市-天府新区-煎茶街道', 4, '510156000000', '510110004', '510110004000', NULL);
INSERT INTO `sys_district` VALUES ('510110006000', '太平街道', '成都市-天府新区-太平街道', 4, '510156000000', '510110006', '510110006000', NULL);
INSERT INTO `sys_district` VALUES ('510110007000', '兴隆街道', '成都市-天府新区-兴隆街道', 4, '510156000000', '510110007', '510110007000', NULL);
INSERT INTO `sys_district` VALUES ('510110008000', '永兴街道', '成都市-天府新区-永兴街道', 4, '510156000000', '510110008', '510110008000', NULL);
INSERT INTO `sys_district` VALUES ('510110009000', '正兴街道', '成都市-天府新区-正兴街道', 4, '510156000000', '510110009', '510110009000', NULL);
INSERT INTO `sys_district` VALUES ('510110010000', '新兴街道', '成都市-天府新区-新兴街道', 4, '510156000000', '510110010', '510110010000', NULL);
INSERT INTO `sys_district` VALUES ('510110011000', '万安街道', '成都市-天府新区-万安街道', 4, '510156000000', '510110011', '510110011000', NULL);
INSERT INTO `sys_district` VALUES ('510110013000', '籍田街道', '成都市-天府新区-籍田街道', 4, '510156000000', '510110013', '510110013000', NULL);
INSERT INTO `sys_district` VALUES ('510112000000', '龙泉驿区', '四川省-成都市-龙泉驿区', 3, '510100000000', '510112', '510112000000', NULL);
INSERT INTO `sys_district` VALUES ('510112001000', '龙泉街道', '成都市-龙泉驿区-龙泉街道', 4, '510112000000', '510112001', '510112001000', NULL);
INSERT INTO `sys_district` VALUES ('510112002000', '大面街道', '成都市-龙泉驿区-大面街道', 4, '510112000000', '510112002', '510112002000', NULL);
INSERT INTO `sys_district` VALUES ('510112003000', '十陵街道', '成都市-龙泉驿区-十陵街道', 4, '510112000000', '510112003', '510112003000', NULL);
INSERT INTO `sys_district` VALUES ('510112004000', '同安街道', '成都市-龙泉驿区-同安街道', 4, '510112000000', '510112004', '510112004000', NULL);
INSERT INTO `sys_district` VALUES ('510112007000', '东安街道', '成都市-龙泉驿区-东安街道', 4, '510112000000', '510112007', '510112007000', NULL);
INSERT INTO `sys_district` VALUES ('510112086000', '西河街道', '成都市-龙泉驿区-西河街道', 4, '510112000000', '510112086', '510112086000', NULL);
INSERT INTO `sys_district` VALUES ('510112102000', '洛带镇', '成都市-龙泉驿区-洛带镇', 4, '510112000000', '510112102', '510112102000', NULL);
INSERT INTO `sys_district` VALUES ('510112108000', '洪安镇', '成都市-龙泉驿区-洪安镇', 4, '510112000000', '510112108', '510112108000', NULL);
INSERT INTO `sys_district` VALUES ('510112109000', '柏合街道', '成都市-龙泉驿区-柏合街道', 4, '510112000000', '510112109', '510112109000', NULL);
INSERT INTO `sys_district` VALUES ('510112115000', '山泉镇', '成都市-龙泉驿区-山泉镇', 4, '510112000000', '510112115', '510112115000', NULL);
INSERT INTO `sys_district` VALUES ('510113000000', '青白江区', '四川省-成都市-青白江区', 3, '510100000000', '510113', '510113000000', NULL);
INSERT INTO `sys_district` VALUES ('510113002000', '大弯街道', '成都市-青白江区-大弯街道', 4, '510113000000', '510113002', '510113002000', NULL);
INSERT INTO `sys_district` VALUES ('510113100000', '福洪镇', '成都市-青白江区-福洪镇', 4, '510113000000', '510113100', '510113100000', NULL);
INSERT INTO `sys_district` VALUES ('510113102000', '弥牟镇', '成都市-青白江区-弥牟镇', 4, '510113000000', '510113102', '510113102000', NULL);
INSERT INTO `sys_district` VALUES ('510113103000', '大同街道', '成都市-青白江区-大同街道', 4, '510113000000', '510113103', '510113103000', NULL);
INSERT INTO `sys_district` VALUES ('510113104000', '城厢镇', '成都市-青白江区-城厢镇', 4, '510113000000', '510113104', '510113104000', NULL);
INSERT INTO `sys_district` VALUES ('510113106000', '姚渡镇', '成都市-青白江区-姚渡镇', 4, '510113000000', '510113106', '510113106000', NULL);
INSERT INTO `sys_district` VALUES ('510113108000', '清泉镇', '成都市-青白江区-清泉镇', 4, '510113000000', '510113108', '510113108000', NULL);
INSERT INTO `sys_district` VALUES ('510114000000', '新都区', '四川省-成都市-新都区', 3, '510100000000', '510114', '510114000000', NULL);
INSERT INTO `sys_district` VALUES ('510114001000', '大丰街道', '成都市-新都区-大丰街道', 4, '510114000000', '510114001', '510114001000', NULL);
INSERT INTO `sys_district` VALUES ('510114003000', '三河街道', '成都市-新都区-三河街道', 4, '510114000000', '510114003', '510114003000', NULL);
INSERT INTO `sys_district` VALUES ('510114004000', '新都街道', '成都市-新都区-新都街道', 4, '510114000000', '510114004', '510114004000', NULL);
INSERT INTO `sys_district` VALUES ('510114008000', '桂湖街道', '成都市-新都区-桂湖街道', 4, '510114000000', '510114008', '510114008000', NULL);
INSERT INTO `sys_district` VALUES ('510114102000', '石板滩街道', '成都市-新都区-石板滩街道', 4, '510114000000', '510114102', '510114102000', NULL);
INSERT INTO `sys_district` VALUES ('510114103000', '新繁街道', '成都市-新都区-新繁街道', 4, '510114000000', '510114103', '510114103000', NULL);
INSERT INTO `sys_district` VALUES ('510114108000', '斑竹园街道', '成都市-新都区-斑竹园街道', 4, '510114000000', '510114108', '510114108000', NULL);
INSERT INTO `sys_district` VALUES ('510114109000', '清流镇', '成都市-新都区-清流镇', 4, '510114000000', '510114109', '510114109000', NULL);
INSERT INTO `sys_district` VALUES ('510114116000', '军屯镇', '成都市-新都区-军屯镇', 4, '510114000000', '510114116', '510114116000', NULL);
INSERT INTO `sys_district` VALUES ('510115000000', '温江区', '四川省-成都市-温江区', 3, '510100000000', '510115', '510115000000', NULL);
INSERT INTO `sys_district` VALUES ('510115001000', '柳城街道', '成都市-温江区-柳城街道', 4, '510115000000', '510115001', '510115001000', NULL);
INSERT INTO `sys_district` VALUES ('510115002000', '公平街道', '成都市-温江区-公平街道', 4, '510115000000', '510115002', '510115002000', NULL);
INSERT INTO `sys_district` VALUES ('510115003000', '涌泉街道', '成都市-温江区-涌泉街道', 4, '510115000000', '510115003', '510115003000', NULL);
INSERT INTO `sys_district` VALUES ('510115004000', '天府街道', '成都市-温江区-天府街道', 4, '510115000000', '510115004', '510115004000', NULL);
INSERT INTO `sys_district` VALUES ('510115005000', '金马街道', '成都市-温江区-金马街道', 4, '510115000000', '510115005', '510115005000', NULL);
INSERT INTO `sys_district` VALUES ('510115101000', '和盛镇', '成都市-温江区-和盛镇', 4, '510115000000', '510115101', '510115101000', NULL);
INSERT INTO `sys_district` VALUES ('510115104000', '永宁街道', '成都市-温江区-永宁街道', 4, '510115000000', '510115104', '510115104000', NULL);
INSERT INTO `sys_district` VALUES ('510115105000', '万春镇', '成都市-温江区-万春镇', 4, '510115000000', '510115105', '510115105000', NULL);
INSERT INTO `sys_district` VALUES ('510115106000', '寿安镇', '成都市-温江区-寿安镇', 4, '510115000000', '510115106', '510115106000', NULL);
INSERT INTO `sys_district` VALUES ('510116000000', '双流区', '四川省-成都市-双流区', 3, '510100000000', '510116', '510116000000', NULL);
INSERT INTO `sys_district` VALUES ('510116001000', '东升街道', '成都市-双流区-东升街道', 4, '510116000000', '510116001', '510116001000', NULL);
INSERT INTO `sys_district` VALUES ('510116002000', '西航港街道', '成都市-双流区-西航港街道', 4, '510116000000', '510116002', '510116002000', NULL);
INSERT INTO `sys_district` VALUES ('510116004000', '九江街道', '成都市-双流区-九江街道', 4, '510116000000', '510116004', '510116004000', NULL);
INSERT INTO `sys_district` VALUES ('510116005000', '黄甲街道', '成都市-双流区-黄甲街道', 4, '510116000000', '510116005', '510116005000', NULL);
INSERT INTO `sys_district` VALUES ('510116007000', '怡心街道', '成都市-双流区-怡心街道', 4, '510116000000', '510116007', '510116007000', NULL);
INSERT INTO `sys_district` VALUES ('510116108000', '彭镇', '成都市-双流区-彭镇', 4, '510116000000', '510116108', '510116108000', NULL);
INSERT INTO `sys_district` VALUES ('510116111000', '黄龙溪镇', '成都市-双流区-黄龙溪镇', 4, '510116000000', '510116111', '510116111000', NULL);
INSERT INTO `sys_district` VALUES ('510116112000', '永安镇', '成都市-双流区-永安镇', 4, '510116000000', '510116112', '510116112000', NULL);
INSERT INTO `sys_district` VALUES ('510116115000', '黄水镇', '成都市-双流区-黄水镇', 4, '510116000000', '510116115', '510116115000', NULL);
INSERT INTO `sys_district` VALUES ('510117000000', '郫都区', '四川省-成都市-郫都区', 3, '510100000000', '510117', '510117000000', NULL);
INSERT INTO `sys_district` VALUES ('510117001000', '郫筒街道', '成都市-郫都区-郫筒街道', 4, '510117000000', '510117001', '510117001000', NULL);
INSERT INTO `sys_district` VALUES ('510117101000', '团结街道', '成都市-郫都区-团结街道', 4, '510117000000', '510117101', '510117101000', NULL);
INSERT INTO `sys_district` VALUES ('510117102000', '犀浦街道', '成都市-郫都区-犀浦街道', 4, '510117000000', '510117102', '510117102000', NULL);
INSERT INTO `sys_district` VALUES ('510117104000', '唐昌镇', '成都市-郫都区-唐昌镇', 4, '510117000000', '510117104', '510117104000', NULL);
INSERT INTO `sys_district` VALUES ('510117105000', '安德街道', '成都市-郫都区-安德街道', 4, '510117000000', '510117105', '510117105000', NULL);
INSERT INTO `sys_district` VALUES ('510117106000', '三道堰镇', '成都市-郫都区-三道堰镇', 4, '510117000000', '510117106', '510117106000', NULL);
INSERT INTO `sys_district` VALUES ('510117107000', '安靖街道', '成都市-郫都区-安靖街道', 4, '510117000000', '510117107', '510117107000', NULL);
INSERT INTO `sys_district` VALUES ('510117108000', '红光街道', '成都市-郫都区-红光街道', 4, '510117000000', '510117108', '510117108000', NULL);
INSERT INTO `sys_district` VALUES ('510117112000', '德源街道', '成都市-郫都区-德源街道', 4, '510117000000', '510117112', '510117112000', NULL);
INSERT INTO `sys_district` VALUES ('510117115000', '友爱镇', '成都市-郫都区-友爱镇', 4, '510117000000', '510117115', '510117115000', NULL);
INSERT INTO `sys_district` VALUES ('510121000000', '金堂县', '四川省-成都市-金堂县', 3, '510100000000', '510121', '510121000000', NULL);
INSERT INTO `sys_district` VALUES ('510121104000', '淮口街道', '成都市-金堂县-淮口街道', 4, '510121000000', '510121104', '510121104000', NULL);
INSERT INTO `sys_district` VALUES ('510121105000', '白果街道', '成都市-金堂县-白果街道', 4, '510121000000', '510121105', '510121105000', NULL);
INSERT INTO `sys_district` VALUES ('510121106000', '五凤镇', '成都市-金堂县-五凤镇', 4, '510121000000', '510121106', '510121106000', NULL);
INSERT INTO `sys_district` VALUES ('510121108000', '高板街道', '成都市-金堂县-高板街道', 4, '510121000000', '510121108', '510121108000', NULL);
INSERT INTO `sys_district` VALUES ('510121109000', '三溪镇', '成都市-金堂县-三溪镇', 4, '510121000000', '510121109', '510121109000', NULL);
INSERT INTO `sys_district` VALUES ('510121110000', '福兴镇', '成都市-金堂县-福兴镇', 4, '510121000000', '510121110', '510121110000', NULL);
INSERT INTO `sys_district` VALUES ('510121111000', '金龙镇', '成都市-金堂县-金龙镇', 4, '510121000000', '510121111', '510121111000', NULL);
INSERT INTO `sys_district` VALUES ('510121112000', '赵家镇', '成都市-金堂县-赵家镇', 4, '510121000000', '510121112', '510121112000', NULL);
INSERT INTO `sys_district` VALUES ('510121113000', '竹篙镇', '成都市-金堂县-竹篙镇', 4, '510121000000', '510121113', '510121113000', NULL);
INSERT INTO `sys_district` VALUES ('510121116000', '转龙镇', '成都市-金堂县-转龙镇', 4, '510121000000', '510121116', '510121116000', NULL);
INSERT INTO `sys_district` VALUES ('510121117000', '土桥镇', '成都市-金堂县-土桥镇', 4, '510121000000', '510121117', '510121117000', NULL);
INSERT INTO `sys_district` VALUES ('510121118000', '云合镇', '成都市-金堂县-云合镇', 4, '510121000000', '510121118', '510121118000', NULL);
INSERT INTO `sys_district` VALUES ('510121119000', '又新镇', '成都市-金堂县-又新镇', 4, '510121000000', '510121119', '510121119000', NULL);
INSERT INTO `sys_district` VALUES ('510129000000', '大邑县', '四川省-成都市-大邑县', 3, '510100000000', '510129', '510129000000', NULL);
INSERT INTO `sys_district` VALUES ('510129001000', '晋原街道', '大邑县-晋原街道', 4, '510129000000', '510129001', '510129001000', NULL);
INSERT INTO `sys_district` VALUES ('510129101000', '王泗镇', '大邑县-王泗镇', 4, '510129000000', '510129101', '510129101000', NULL);
INSERT INTO `sys_district` VALUES ('510129103000', '新场镇', '大邑县-新场镇', 4, '510129000000', '510129103', '510129103000', NULL);
INSERT INTO `sys_district` VALUES ('510129104000', '悦来镇', '大邑县-悦来镇', 4, '510129000000', '510129104', '510129104000', NULL);
INSERT INTO `sys_district` VALUES ('510129105000', '安仁镇', '大邑县-安仁镇', 4, '510129000000', '510129105', '510129105000', NULL);
INSERT INTO `sys_district` VALUES ('510129106000', '䢺江镇', '大邑县-䢺江镇', 4, '510129000000', '510129106', '510129106000', NULL);
INSERT INTO `sys_district` VALUES ('510129107000', '花水湾镇', '大邑县-花水湾镇', 4, '510129000000', '510129107', '510129107000', NULL);
INSERT INTO `sys_district` VALUES ('510129108000', '西岭镇', '大邑县-西岭镇', 4, '510129000000', '510129108', '510129108000', NULL);
INSERT INTO `sys_district` VALUES ('510129115000', '青霞街道', '大邑县-青霞街道', 4, '510129000000', '510129115', '510129115000', NULL);
INSERT INTO `sys_district` VALUES ('510129116000', '沙渠街道', '大邑县-沙渠街道', 4, '510129000000', '510129116', '510129116000', NULL);
INSERT INTO `sys_district` VALUES ('510129205000', '鹤鸣镇', '大邑县-鹤鸣镇', 4, '510129000000', '510129205', '510129205000', NULL);
INSERT INTO `sys_district` VALUES ('510131000000', '蒲江县', '四川省-成都市-蒲江县', 3, '510100000000', '510131', '510131000000', NULL);
INSERT INTO `sys_district` VALUES ('510131001000', '鹤山街道', '成都市-蒲江县-鹤山街道', 4, '510131000000', '510131001', '510131001', NULL);
INSERT INTO `sys_district` VALUES ('510131002000', '寿安街道', '成都市-蒲江县-寿安街道', 4, '510131000000', '510131002', '510131002000', NULL);
INSERT INTO `sys_district` VALUES ('510131101000', '大塘镇', '成都市-蒲江县-大塘镇', 4, '510131000000', '510131101', '510131101000', NULL);
INSERT INTO `sys_district` VALUES ('510131103000', '朝阳湖镇', '成都市-蒲江县-朝阳湖镇', 4, '510131000000', '510131103', '510131103000', NULL);
INSERT INTO `sys_district` VALUES ('510131104000', '西来镇', '成都市-蒲江县-西来镇', 4, '510131000000', '510131104', '510131104000', NULL);
INSERT INTO `sys_district` VALUES ('510131105000', '大兴镇', '成都市-蒲江县-大兴镇', 4, '510131000000', '510131105', '510131105000', NULL);
INSERT INTO `sys_district` VALUES ('510131106000', '甘溪镇', '成都市-蒲江县-甘溪镇', 4, '510131000000', '510131106', '510131106000', NULL);
INSERT INTO `sys_district` VALUES ('510131107000', '成佳镇', '成都市-蒲江县-成佳镇', 4, '510131000000', '510131107', '510131107000', NULL);
INSERT INTO `sys_district` VALUES ('510132000000', '新津县', '四川省-成都市-新津县', 3, '510100000000', '510132', '510132000000', NULL);
INSERT INTO `sys_district` VALUES ('510132001000', '五津街道', '成都市-新津区-五津街道', 4, '510132000000', '510132001', '510132001000', NULL);
INSERT INTO `sys_district` VALUES ('510132101000', '花桥街道', '成都市-新津区-花桥街道', 4, '510132000000', '510132001', '510132001000', NULL);
INSERT INTO `sys_district` VALUES ('510132102000', '花源街道', '成都市-新津区-花源街道', 4, '510132000000', '510132102', '510132102000', NULL);
INSERT INTO `sys_district` VALUES ('510132104000', '普兴街道', '成都市-新津区-普兴街道', 4, '510132000000', '510132104', '510132104000', NULL);
INSERT INTO `sys_district` VALUES ('510132105000', '兴义镇', '成都市-新津区-兴义镇', 4, '510132000000', '510132105', '510132105000', NULL);
INSERT INTO `sys_district` VALUES ('510132108000', '安西镇', '成都市-新津区-安西镇', 4, '510132000000', '510132108', '510132108000', NULL);
INSERT INTO `sys_district` VALUES ('510132109000', '永商镇', '成都市-新津区-永商镇', 4, '510132000000', '510132109', '510132109000', NULL);
INSERT INTO `sys_district` VALUES ('510132114000', '宝墩镇', '成都市-新津区-宝墩镇', 4, '510132000000', '510132114', '510132114000', NULL);
INSERT INTO `sys_district` VALUES ('510156000000', '天府新区', '四川省-成都市-天府新区', 3, '510100000000', '510156', '510156000000', NULL);
INSERT INTO `sys_district` VALUES ('510181000000', '都江堰市', '四川省-成都市-都江堰市', 3, '510100000000', '510181', '510181000000', NULL);
INSERT INTO `sys_district` VALUES ('510181001000', '奎光塔街道', '都江堰市-奎光塔街道', 4, '510181000000', '510181001', '510181001000', NULL);
INSERT INTO `sys_district` VALUES ('510181002000', '灌口街道', '都江堰市-灌口街道', 4, '510181000000', '510181002', '510181002000', NULL);
INSERT INTO `sys_district` VALUES ('510181003000', '幸福街道', '都江堰市-幸福街道', 4, '510181000000', '510181003', '510181003000', NULL);
INSERT INTO `sys_district` VALUES ('510181004000', '银杏街道', '都江堰市-银杏街道', 4, '510181000000', '510181004', '510181004000', NULL);
INSERT INTO `sys_district` VALUES ('510181102000', '蒲阳街道', '都江堰市-蒲阳街道', 4, '510181000000', '510181102', '510181102000', NULL);
INSERT INTO `sys_district` VALUES ('510181103000', '聚源镇', '都江堰市-聚源镇', 4, '510181000000', '510181103', '510181103000', NULL);
INSERT INTO `sys_district` VALUES ('510181105000', '天马镇', '都江堰市-天马镇', 4, '510181000000', '510181105', '510181105000', NULL);
INSERT INTO `sys_district` VALUES ('510181106000', '石羊镇', '都江堰市-石羊镇', 4, '510181000000', '510181106', '510181106000', NULL);
INSERT INTO `sys_district` VALUES ('510181108000', '玉堂街道', '都江堰市-玉堂街道', 4, '510181000000', '510181108', '510181108000', NULL);
INSERT INTO `sys_district` VALUES ('510181110000', '青城山镇', '都江堰市-青城山镇', 4, '510181000000', '510181110', '510181110000', NULL);
INSERT INTO `sys_district` VALUES ('510181111000', '龙池镇', '都江堰市-龙池镇', 4, '510181000000', '510181111', '510181111000', NULL);
INSERT INTO `sys_district` VALUES ('510182000000', '彭州市', '四川省-成都市-彭州市', 3, '510100000000', '510182', '510182000000', NULL);
INSERT INTO `sys_district` VALUES ('510182100000', '天彭街道', '彭州市-天彭街道', 4, '510182000000', '510182100', '510182100000', NULL);
INSERT INTO `sys_district` VALUES ('510182101000', '龙门山镇', '彭州市-龙门山镇', 4, '510182000000', '510182101', '510182101000', NULL);
INSERT INTO `sys_district` VALUES ('510182103000', '丽春镇', '彭州市-丽春镇', 4, '510182000000', '510182103', '510182103000', NULL);
INSERT INTO `sys_district` VALUES ('510182104000', '九尺镇', '彭州市-九尺镇', 4, '510182000000', '510182104', '510182104000', NULL);
INSERT INTO `sys_district` VALUES ('510182105000', '濛阳街道', '彭州市-濛阳街道', 4, '510182000000', '510182105', '510182105000', NULL);
INSERT INTO `sys_district` VALUES ('510182106000', '通济镇', '彭州市-通济镇', 4, '510182000000', '510182106', '510182106000', NULL);
INSERT INTO `sys_district` VALUES ('510182107000', '丹景山镇', '彭州市-丹景山镇', 4, '510182000000', '510182107', '510182107000', NULL);
INSERT INTO `sys_district` VALUES ('510182108000', '隆丰街道', '彭州市-隆丰街道', 4, '510182000000', '510182108', '510182108000', NULL);
INSERT INTO `sys_district` VALUES ('510182109000', '敖平镇', '彭州市-敖平镇', 4, '510182000000', '510182109', '510182109000', NULL);
INSERT INTO `sys_district` VALUES ('510182111000', '桂花镇', '彭州市-桂花镇', 4, '510182000000', '510182111', '510182111000', NULL);
INSERT INTO `sys_district` VALUES ('510182121000', '白鹿镇', '彭州市-白鹿镇', 4, '510182000000', '510182121', '510182121000', NULL);
INSERT INTO `sys_district` VALUES ('510182123000', '葛仙山镇', '彭州市-葛仙山镇', 4, '510182000000', '510182123', '510182123000', NULL);
INSERT INTO `sys_district` VALUES ('510182126000', '致和街道', '彭州市-致和街道', 4, '510182000000', '510182126', '510182126000', NULL);
INSERT INTO `sys_district` VALUES ('510183000000', '邛崃市', '四川省-成都市-邛崃市', 3, '510100000000', '510183', '510183000000', NULL);
INSERT INTO `sys_district` VALUES ('510183001000', '临邛街道', '邛崃市-临邛街道', 4, '510183000000', '510183001', '510183001000', NULL);
INSERT INTO `sys_district` VALUES ('510183002000', '文君街道', '邛崃市-文君街道', 4, '510183000000', '510183002', '510183002000', NULL);
INSERT INTO `sys_district` VALUES ('510183101000', '羊安街道', '邛崃市-羊安街道', 4, '510183000000', '510183101', '510183101000', NULL);
INSERT INTO `sys_district` VALUES ('510183103000', '桑园镇', '邛崃市-桑园镇', 4, '510183000000', '510183103', '510183103000', NULL);
INSERT INTO `sys_district` VALUES ('510183104000', '平乐镇', '邛崃市-平乐镇', 4, '510183000000', '510183104', '510183104000', NULL);
INSERT INTO `sys_district` VALUES ('510183105000', '夹关镇', '邛崃市-夹关镇', 4, '510183000000', '510183105', '510183105000', NULL);
INSERT INTO `sys_district` VALUES ('510183106000', '火井镇', '邛崃市-火井镇', 4, '510183000000', '510183106', '510183106000', NULL);
INSERT INTO `sys_district` VALUES ('510183108000', '固驿街道', '邛崃市-固驿街道', 4, '510183000000', '510183108', '510183108000', NULL);
INSERT INTO `sys_district` VALUES ('510183111000', '高埂街道', '邛崃市-高埂街道', 4, '510183000000', '510183111', '510183111000', NULL);
INSERT INTO `sys_district` VALUES ('510183115000', '临济镇', '邛崃市-临济镇', 4, '510183000000', '510183115', '510183115000', NULL);
INSERT INTO `sys_district` VALUES ('510183118000', '天台山镇', '邛崃市-天台山镇', 4, '510183000000', '510183118', '510183118000', NULL);
INSERT INTO `sys_district` VALUES ('510183121000', '南宝山镇', '邛崃市-南宝山镇', 4, '510183000000', '510183121', '510183121000', NULL);
INSERT INTO `sys_district` VALUES ('510183212000', '大同镇', '邛崃市-大同镇', 4, '510183000000', '510183212', '510183212000', NULL);
INSERT INTO `sys_district` VALUES ('510183214000', '孔明街道', '邛崃市-孔明街道', 4, '510183000000', '510183214', '510183214000', NULL);
INSERT INTO `sys_district` VALUES ('510184000000', '崇州市', '四川省-成都市-崇州市', 3, '510100000000', '510184', '510184000000', NULL);
INSERT INTO `sys_district` VALUES ('510184001000', '崇阳街道', '崇州市-崇阳街道', 4, '510184000000', '510184001', '510184001000', NULL);
INSERT INTO `sys_district` VALUES ('510184006000', '崇庆街道', '崇州市-崇庆街道', 4, '510184000000', '510184006', '510184006000', NULL);
INSERT INTO `sys_district` VALUES ('510184101000', '三江街道', '崇州市-三江街道', 4, '510184000000', '510184101', '510184101000', NULL);
INSERT INTO `sys_district` VALUES ('510184102000', '江源街道', '崇州市-江源街道', 4, '510184000000', '510184102', '510184102000', NULL);
INSERT INTO `sys_district` VALUES ('510184103000', '羊马街道', '崇州市-羊马街道', 4, '510184000000', '510184103', '510184103000', NULL);
INSERT INTO `sys_district` VALUES ('510184104000', '廖家镇', '崇州市-廖家镇', 4, '510184000000', '510184104', '510184104000', NULL);
INSERT INTO `sys_district` VALUES ('510184105000', '元通镇', '崇州市-元通镇', 4, '510184000000', '510184105', '510184105000', NULL);
INSERT INTO `sys_district` VALUES ('510184106000', '观胜镇', '崇州市-观胜镇', 4, '510184000000', '510184106', '510184106000', NULL);
INSERT INTO `sys_district` VALUES ('510184107000', '怀远镇', '崇州市-怀远镇', 4, '510184000000', '510184107', '510184107000', NULL);
INSERT INTO `sys_district` VALUES ('510184109000', '街子镇', '崇州市-街子镇', 4, '510184000000', '510184109', '510184109000', NULL);
INSERT INTO `sys_district` VALUES ('510184110000', '文井江镇', '崇州市-文井江镇', 4, '510184000000', '510184110', '510184110000', NULL);
INSERT INTO `sys_district` VALUES ('510184112000', '白头镇', '崇州市-白头镇', 4, '510184000000', '510184112', '510184112000', NULL);
INSERT INTO `sys_district` VALUES ('510184113000', '道明镇', '崇州市-道明镇', 4, '510184000000', '510184113', '510184113000', NULL);
INSERT INTO `sys_district` VALUES ('510184114000', '隆兴镇', '崇州市-隆兴镇', 4, '510184000000', '510184114', '510184114000', NULL);
INSERT INTO `sys_district` VALUES ('510184116000', '大划街道', '崇州市-大划街道', 4, '510184000000', '510184116', '510184116000', NULL);
INSERT INTO `sys_district` VALUES ('510185000000', '简阳市', '四川省-成都市-简阳市', 3, '510100000000', '510185', '510185000000', NULL);
INSERT INTO `sys_district` VALUES ('510185001000', '简城街道', '简阳市-简城街道', 4, '510185000000', '510185001', '510185001000', NULL);
INSERT INTO `sys_district` VALUES ('510185002000', '射洪坝街道', '简阳市-射洪坝街道', 4, '510185000000', '510185002', '510185002000', NULL);
INSERT INTO `sys_district` VALUES ('510185008000', '赤水街道', '简阳市-赤水街道', 4, '510185000000', '510185008', '510185008000', NULL);
INSERT INTO `sys_district` VALUES ('510185100000', '东溪街道', '简阳市-东溪街道', 4, '510185000000', '510185100', '510185100000', NULL);
INSERT INTO `sys_district` VALUES ('510185101000', '新市街道', '简阳市-新市街道', 4, '510185000000', '510185101', '510185101000', NULL);
INSERT INTO `sys_district` VALUES ('510185102000', '杨家镇', '简阳市-杨家镇', 4, '510185000000', '510185102', '510185102000', NULL);
INSERT INTO `sys_district` VALUES ('510185103000', '施家镇', '简阳市-施家镇', 4, '510185000000', '510185103', '510185103000', NULL);
INSERT INTO `sys_district` VALUES ('510185104000', '镇金镇', '简阳市-镇金镇', 4, '510185000000', '510185104', '510185104000', NULL);
INSERT INTO `sys_district` VALUES ('510185105000', '踏水镇', '简阳市-踏水镇', 4, '510185000000', '510185105', '510185105000', NULL);
INSERT INTO `sys_district` VALUES ('510185106000', '青龙镇', '简阳市-青龙镇', 4, '510185000000', '510185106', '510185106000', NULL);
INSERT INTO `sys_district` VALUES ('510185109000', '涌泉镇', '简阳市-涌泉镇', 4, '510185000000', '510185109', '510185109000', NULL);
INSERT INTO `sys_district` VALUES ('510185110000', '江源镇', '简阳市-江源镇', 4, '510185000000', '510185110', '510185110000', NULL);
INSERT INTO `sys_district` VALUES ('510185111000', '石钟镇', '简阳市-石钟镇', 4, '510185000000', '510185111', '510185111000', NULL);
INSERT INTO `sys_district` VALUES ('510185112000', '平武镇', '简阳市-平武镇', 4, '510185000000', '510185112', '510185112000', NULL);
INSERT INTO `sys_district` VALUES ('510185114000', '三合镇', '简阳市-三合镇', 4, '510185000000', '510185114', '510185114000', NULL);
INSERT INTO `sys_district` VALUES ('510185115000', '平泉街道', '简阳市-平泉街道', 4, '510185000000', '510185115', '510185115000', NULL);
INSERT INTO `sys_district` VALUES ('510185117000', '云龙镇', '简阳市-云龙镇', 4, '510185000000', '510185117', '510185117000', NULL);
INSERT INTO `sys_district` VALUES ('510185118000', '三星镇', '简阳市-三星镇', 4, '510185000000', '510185118', '510185118000', NULL);
INSERT INTO `sys_district` VALUES ('510185119000', '石桥街道', '简阳市-石桥街道', 4, '510185000000', '510185119', '510185119000', NULL);
INSERT INTO `sys_district` VALUES ('510185121000', '禾丰镇', '简阳市-禾丰镇', 4, '510185000000', '510185121', '510185121000', NULL);
INSERT INTO `sys_district` VALUES ('510185200000', '雷家镇', '简阳市-雷家镇', 4, '510185000000', '510185200', '510185200000', NULL);
INSERT INTO `sys_district` VALUES ('510185220000', '宏缘镇', '简阳市-宏缘镇', 4, '510185000000', '510185220', '510185220000', NULL);
INSERT INTO `sys_district` VALUES ('510186001000', '武庙镇', '成都市-简阳市-武庙镇', 4, '510185000000', '510186001', '510186001000', NULL);
INSERT INTO `sys_district` VALUES ('510186002000', '玉成街道', '成都市-简阳市-玉成街道', 4, '510185000000', '510186002', '510186002000', NULL);
INSERT INTO `sys_district` VALUES ('510186003000', '贾家街道', '成都市-简阳市-贾家街道', 4, '510185000000', '510186003', '510186003000', NULL);
INSERT INTO `sys_district` VALUES ('510186004000', '高明镇', '成都市-简阳市-高明镇', 4, '510185000000', '510186004', '510186004000', NULL);
INSERT INTO `sys_district` VALUES ('510186005000', '壮溪镇', '成都市-简阳市-壮溪镇', 4, '510185000000', '510186005', '510186005000', NULL);
INSERT INTO `sys_district` VALUES ('510186006000', '丹景街道', '成都市-简阳市-丹景街道', 4, '510185000000', '510186006', '510186006000', NULL);
INSERT INTO `sys_district` VALUES ('510186007000', '草池街道', '成都市-简阳市-草池街道', 4, '510185000000', '510186007', '510186007000', NULL);
INSERT INTO `sys_district` VALUES ('510186008000', '石板凳街道', '成都市-简阳市-石板凳街道', 4, '510185000000', '510186008', '510186008000', NULL);
INSERT INTO `sys_district` VALUES ('510186009000', '海螺镇', '成都市-简阳市-海螺镇', 4, '510185000000', '510186009', '510186009000', NULL);
INSERT INTO `sys_district` VALUES ('510186010000', '三岔街道', '成都市-简阳市-三岔街道', 4, '510185000000', '510186010', '510186010000', NULL);
INSERT INTO `sys_district` VALUES ('510186011000', '福田街道', '成都市-简阳市-福田街道', 4, '510185000000', '510186011', '510186011000', NULL);
INSERT INTO `sys_district` VALUES ('510186012000', '芦葭镇', '成都市-简阳市-芦葭镇', 4, '510185000000', '510186012', '510186012000', NULL);
INSERT INTO `sys_district` VALUES ('510186013000', '养马街道', '成都市-简阳市-养马街道', 4, '510185000000', '510186013', '510186013000', NULL);
INSERT INTO `sys_district` VALUES ('510186014000', '董家埂镇', '成都市-简阳市-董家埂镇', 4, '510185000000', '510186014', '510186014000', NULL);
INSERT INTO `sys_district` VALUES ('510186015000', '石盘街道', '成都市-简阳市-石盘街道', 4, '510185000000', '510186015', '510186015000', NULL);

-- ----------------------------
-- Table structure for sys_do_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_do_log`;
CREATE TABLE `sys_do_log`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `log_type` int(11) NULL DEFAULT NULL COMMENT '日志类型',
  `log_content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志内容',
  `operate_type` int(11) NULL DEFAULT NULL COMMENT '操作类型',
  `userid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作用户账号',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作用户名称',
  `ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP',
  `method` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求java方法',
  `request_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求路径',
  `request_param` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '请求参数',
  `request_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求类型',
  `cost_time` bigint(20) NULL DEFAULT NULL COMMENT '耗时',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_table_userid`(`userid` ASC) USING BTREE,
  INDEX `index_logt_ype`(`log_type` ASC) USING BTREE,
  INDEX `index_operate_type`(`operate_type` ASC) USING BTREE,
  FULLTEXT INDEX `index_log_cont`(`log_content`)
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_do_log
-- ----------------------------
INSERT INTO `sys_do_log` VALUES ('1982980291832569858', 2, '用户登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.login()', NULL, '[{\"captcha\":\"5551\",\"checkKey\":\"01478fd7a5ed45640a322e53786334a7\",\"password\":\"f1c929097b74e9bf0bc0a7dcaa02cb5e\",\"username\":\"admin\"}]', NULL, 82, NULL, '2025-10-28 09:18:38', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1982980376423292929', 2, '用户登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.login()', NULL, '[{\"captcha\":\"2612\",\"checkKey\":\"0383d848247fd4caf21b36795e0c4857\",\"password\":\"f1c929097b74e9bf0bc0a7dcaa02cb5e\",\"username\":\"admin\"}]', NULL, 22, NULL, '2025-10-28 09:18:58', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1982980691717513217', 2, '用户登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.login()', NULL, '[{\"captcha\":\"2612\",\"checkKey\":\"0383d848247fd4caf21b36795e0c4857\",\"password\":\"f1c929097b74e9bf0bc0a7dcaa02cb5e\",\"username\":\"admin\"}]', NULL, 7, NULL, '2025-10-28 09:20:14', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1982980745362661377', 2, '用户登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.login()', NULL, '[{\"captcha\":\"3166\",\"checkKey\":\"ef5996caab05b019a9efab694ab772ae\",\"password\":\"f1c929097b74e9bf0bc0a7dcaa02cb5e\",\"username\":\"admin\"}]', NULL, 13, NULL, '2025-10-28 09:20:26', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1982980943556108289', 2, '用户登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.login()', NULL, '[{\"captcha\":\"2726\",\"checkKey\":\"bfe8677e2baefca9cc0ac6c5850fdacf\",\"password\":\"f1c929097b74e9bf0bc0a7dcaa02cb5e\",\"username\":\"admin\"}]', NULL, 13, NULL, '2025-10-28 09:21:14', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1982981767317413889', 2, '用户登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.login()', NULL, '[{\"captcha\":\"9615\",\"checkKey\":\"b850d83fa3b5a9d313cb3c17d230d2cc\",\"password\":\"f1c929097b74e9bf0bc0a7dcaa02cb5e\",\"username\":\"admin\"}]', NULL, 4, NULL, '2025-10-28 09:24:30', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1982984169764397058', 2, '用户登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.login()', NULL, '[{\"captcha\":\"4042\",\"checkKey\":\"8a8371abefb7cb4146e1d2d25a2f0dc4\",\"password\":\"f1c929097b74e9bf0bc0a7dcaa02cb5e\",\"username\":\"admin\"}]', NULL, 83, NULL, '2025-10-28 09:34:02', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1982984250253090817', 2, '用户登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.login()', NULL, '[{\"captcha\":\"5089\",\"checkKey\":\"2a08be2f88bb63888a25ef95291da89a\",\"password\":\"f1c929097b74e9bf0bc0a7dcaa02cb5e\",\"username\":\"admin\"}]', NULL, 23, NULL, '2025-10-28 09:34:22', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1982985149969047553', 2, '用户登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.login()', NULL, '[{\"captcha\":\"8514\",\"checkKey\":\"7ce27130e9a30b60c5a1280e7867ac7c\",\"password\":\"f1c929097b74e9bf0bc0a7dcaa02cb5e\",\"username\":\"admin\"}]', NULL, 347, NULL, '2025-10-28 09:37:56', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983067285462200321', 2, '用户角色-信息新增', 2, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysRoleController.add()', NULL, '[{\"createTime\":1761635058473,\"id\":\"1983067284573007874\",\"roleCode\":\"attendant\",\"roleName\":\"值班员\"}]', NULL, 449, NULL, '2025-10-28 15:04:19', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983067350146756609', 2, '用户角色-信息编辑', 3, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysRoleController.edit()', NULL, '[{\"createTime\":1761635058000,\"description\":\"/dashboard/analysis\",\"id\":\"1983067284573007874\",\"roleCode\":\"attendant\",\"roleName\":\"值班员\",\"updateTime\":1761635074529}]', NULL, 26, NULL, '2025-10-28 15:04:35', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983067779060477955', 2, '用户信息-数据新增', 2, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysUserController.add()', NULL, '[{\"birthday\":\"\",\"password\":\"f1c929097b74e9bf0bc0a7dcaa02cb5e\",\"selecteddeparts\":\"\",\"activitiSync\":\"1\",\"selectedroles\":\"1983067284573007874\",\"confirmpassword\":\"zhishen@2018~!@\",\"username\":\"值班员\",\"realname\":\"经信局值班员\"}]', NULL, 149, NULL, '2025-10-28 15:06:17', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983074722743332866', 2, '菜单-保存角色授权', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPermissionController.saveRolePermission()', NULL, '[{\"lastpermissionIds\":\"\",\"roleId\":\"1983067284573007874\",\"permissionIds\":\"1531909548084310018,1531909913546600450,1541963267527282690\"}]', NULL, 54, NULL, '2025-10-28 15:33:52', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983343879527452674', 2, '退出登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.logout()', NULL, NULL, NULL, 502, NULL, '2025-10-29 09:23:24', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983344036943876098', 2, '用户登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.login()', NULL, '[{\"captcha\":\"8204\",\"checkKey\":\"c87b09dd3309aedc86bd81d469aac514\",\"password\":\"f1c929097b74e9bf0bc0a7dcaa02cb5e\",\"username\":\"admin\"}]', NULL, 131, NULL, '2025-10-29 09:24:02', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983345070378438659', 2, '菜单-保存角色授权', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPermissionController.saveRolePermission()', NULL, '[{\"lastpermissionIds\":\"1531909548084310018,1531909913546600450,1541963267527282690\",\"roleId\":\"1983067284573007874\",\"permissionIds\":\"1531909548084310018,1531909913546600450,1541963267527282690,1536534573105156097,1547458558128951298,1536536628179898369\"}]', NULL, 28, NULL, '2025-10-29 09:28:08', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983345096257294338', 2, '退出登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.logout()', NULL, NULL, NULL, 17, NULL, '2025-10-29 09:28:14', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983345199965655042', 2, '用户登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.login()', NULL, '[{\"captcha\":\"6185\",\"checkKey\":\"9dceec3a54cd0e5109c33070b24dc059\",\"password\":\"f1c929097b74e9bf0bc0a7dcaa02cb5e\",\"username\":\"admin\"}]', NULL, 28, NULL, '2025-10-29 09:28:39', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983345425266888706', 2, '退出登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.logout()', NULL, NULL, NULL, 12, NULL, '2025-10-29 09:29:33', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983345761884950530', 2, '用户登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.login()', NULL, '[{\"captcha\":\"9329\",\"checkKey\":\"11b9fa1ae68d0c6d7305b7bc4f2529ac\",\"password\":\"f1c929097b74e9bf0bc0a7dcaa02cb5e\",\"username\":\"admin\"}]', NULL, 24, NULL, '2025-10-29 09:30:53', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983345965732319233', 2, '用户角色-信息编辑', 3, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysRoleController.edit()', NULL, '[{\"createTime\":1761635058000,\"description\":\"/dashboard/analysis\",\"id\":\"1983067284573007874\",\"indexUrl\":\"/dashboard/analysis\",\"roleCode\":\"attendant\",\"roleName\":\"值班员\",\"updateTime\":1761701501660}]', NULL, 10, NULL, '2025-10-29 09:31:42', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983346581166739457', 2, '用户信息-信息编辑', 3, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysUserController.edit()', NULL, '[{\"birthday\":\"\",\"activitiSync\":\"1\",\"status_dictText\":\"\",\"delFlag\":\"0\",\"loginNum\":0,\"post\":\"\",\"selectedroles\":\"1983067284573007874\",\"id\":\"1983067778993369090\",\"checkedDepartNameString\":\"市经信局\",\"level\":1,\"avatar\":\"files/20251029/2020-11-26_111050_03_1761701634251.jpg\",\"realname\":\"经信局值班员\",\"createTime\":\"2025-10-28 15:06:17\",\"selecteddeparts\":\"a2fcde1b0b94446e86ea7878056e87f6\",\"username\":\"值班员\",\"status\":1}]', NULL, 168, NULL, '2025-10-29 09:34:08', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983346632366608386', 2, '退出登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.logout()', NULL, NULL, NULL, 11, NULL, '2025-10-29 09:34:21', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983346725157195778', 2, '用户登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.login()', NULL, '[{\"captcha\":\"2385\",\"checkKey\":\"c00df0f5d2493fe420f7132aa0c78670\",\"password\":\"f1c929097b74e9bf0bc0a7dcaa02cb5e\",\"username\":\"值班员\"}]', NULL, 24, NULL, '2025-10-29 09:34:43', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983346841784012801', 2, '用户信息-重置密码', 1, '值班员', '经信局值班员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysUserController.changPassword()', NULL, '[{\"password\":\"376976918de0ce6fb9da52f03b933859\",\"oldpassword\":\"f1c929097b74e9bf0bc0a7dcaa02cb5e\",\"confirmpassword\":\"376976918de0ce6fb9da52f03b933859\",\"username\":\"值班员\"}]', NULL, 30, NULL, '2025-10-29 09:35:11', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983346843302350850', 2, '退出登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.logout()', NULL, NULL, NULL, 12, NULL, '2025-10-29 09:35:11', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983346904677601282', 2, '用户登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.login()', NULL, '[{\"captcha\":\"0398\",\"checkKey\":\"a12b6791996d03571e7bc996ed4ba7ff\",\"password\":\"f1c929097b74e9bf0bc0a7dcaa02cb5e\",\"username\":\"值班员\"}]', NULL, 8, NULL, '2025-10-29 09:35:26', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983346938282364930', 2, '退出登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.logout()', NULL, NULL, NULL, 9, NULL, '2025-10-29 09:35:34', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983347458480918530', 2, '用户登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.login()', NULL, '[{\"captcha\":\"5516\",\"checkKey\":\"a8bcf406c81c3141c0c3325e05a5c915\",\"password\":\"376976918de0ce6fb9da52f03b933859\",\"username\":\"值班员\"}]', NULL, 4, NULL, '2025-10-29 09:37:38', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983347515724779521', 2, '用户登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.login()', NULL, '[{\"captcha\":\"9172\",\"checkKey\":\"063062216723fee7eb10bbc66a314566\",\"password\":\"376976918de0ce6fb9da52f03b933859\",\"username\":\"值班员\"}]', NULL, 29, NULL, '2025-10-29 09:37:51', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983349913843257345', 2, '退出登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.logout()', NULL, NULL, NULL, 11, NULL, '2025-10-29 09:47:23', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983350058710323202', 2, '用户登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.login()', NULL, '[{\"captcha\":\"6888\",\"checkKey\":\"a97385cc3564e0a62076ecfa7dd6c3d9\",\"password\":\"f1c929097b74e9bf0bc0a7dcaa02cb5e\",\"username\":\"admin\"}]', NULL, 22, NULL, '2025-10-29 09:47:58', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983350353922215937', 2, '用户角色-信息编辑', 3, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysRoleController.edit()', NULL, '[{\"createTime\":1761635058000,\"description\":\"/information/reportSignList\",\"id\":\"1983067284573007874\",\"indexUrl\":\"/information/reportSignList\",\"roleCode\":\"attendant\",\"roleName\":\"值班员\",\"updateTime\":1761702547894}]', NULL, 6, NULL, '2025-10-29 09:49:08', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983350478090391553', 2, '菜单-保存角色授权', 1, 'admin', '管理员', '127.0.0.1', 'org.jeecg.modules.system.controller.SysPermissionController.saveRolePermission()', NULL, '[{\"lastpermissionIds\":\"1531909548084310018,1531909913546600450,1536534573105156097,1536536628179898369,1541963267527282690,1547458558128951298\",\"roleId\":\"1983067284573007874\",\"permissionIds\":\"1531909548084310018,1531909913546600450,1536534573105156097,1536536628179898369,1541963267527282690,1547458558128951298,1536534252509335553\"}]', NULL, 5, NULL, '2025-10-29 09:49:38', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983350513100247042', 2, '退出登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.logout()', NULL, NULL, NULL, 13, NULL, '2025-10-29 09:49:46', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983350594608156674', 2, '用户登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.login()', NULL, '[{\"captcha\":\"9704\",\"checkKey\":\"b71f3dc91b64084fd78d6ee340b6424d\",\"password\":\"f1c929097b74e9bf0bc0a7dcaa02cb5e\",\"username\":\"admin\"}]', NULL, 23, NULL, '2025-10-29 09:50:05', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983350646252621825', 2, '退出登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.logout()', NULL, NULL, NULL, 12, NULL, '2025-10-29 09:50:18', NULL, NULL);
INSERT INTO `sys_do_log` VALUES ('1983350880953290754', 2, '用户登录', 1, NULL, NULL, '127.0.0.1', 'org.jeecg.modules.system.controller.LoginController.login()', NULL, '[{\"captcha\":\"9704\",\"checkKey\":\"1b295b6bc43a1530b26f5b1b226267a8\",\"password\":\"376976918de0ce6fb9da52f03b933859\",\"username\":\"值班员\"}]', NULL, 30, NULL, '2025-10-29 09:51:14', NULL, NULL);

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `log_type` int(11) NULL DEFAULT NULL COMMENT '日志类型（1登录日志，2操作日志）',
  `log_content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志内容',
  `operate_type` int(11) NULL DEFAULT NULL COMMENT '操作类型',
  `userid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作用户账号',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作用户名称',
  `ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP',
  `method` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求java方法',
  `request_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求路径',
  `request_param` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '请求参数',
  `request_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求类型',
  `cost_time` bigint(20) NULL DEFAULT NULL COMMENT '耗时',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_table_userid`(`userid`) USING BTREE,
  INDEX `index_logt_ype`(`log_type`) USING BTREE,
  INDEX `index_operate_type`(`operate_type`) USING BTREE,
  FULLTEXT INDEX `index_log_cont`(`log_content`)
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('1982985149906132993', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-28 09:37:56', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1983343878898307074', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-29 09:23:24', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1983344036922904577', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-29 09:24:02', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1983345096190185474', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-29 09:28:14', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1983345199965655041', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-29 09:28:39', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1983345425216557058', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-29 09:29:33', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1983345761872367617', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-29 09:30:53', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1983346580449513473', 2, '编辑用户，id： 1983067778993369090', 2, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-29 09:34:08', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1983346632337248257', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-29 09:34:21', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1983346725144612866', 1, '用户名: 值班员,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-29 09:34:43', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1983346843260407809', 1, '用户名: 经信局值班员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-29 09:35:11', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1983346938244616194', 1, '用户名: 经信局值班员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-29 09:35:34', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1983347515712196609', 1, '用户名: 值班员,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-29 09:37:51', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1983349913805508610', 1, '用户名: 经信局值班员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-29 09:47:23', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1983350058701934593', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-29 09:47:58', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1983350513049915394', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-29 09:49:46', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1983350594595573761', 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-29 09:50:05', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1983350646206484481', 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-29 09:50:18', NULL, NULL);
INSERT INTO `sys_log` VALUES ('1983350880940707841', 1, '用户名: 值班员,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-29 09:51:14', NULL, NULL);

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键id',
  `parent_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父id',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单标题',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路径',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件',
  `component_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件名字',
  `redirect` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '一级菜单跳转地址',
  `menu_type` int(11) NULL DEFAULT NULL COMMENT '菜单类型(0:一级菜单; 1:子菜单:2:按钮权限)',
  `perms` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单权限编码',
  `perms_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '权限策略1显示2禁用',
  `sort_no` double(8, 2) NULL DEFAULT NULL COMMENT '菜单排序',
  `always_show` tinyint(1) NULL DEFAULT NULL COMMENT '聚合子路由: 1是0否',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `is_route` tinyint(1) NULL DEFAULT 1 COMMENT '是否路由菜单: 0:不是  1:是（默认值1）',
  `is_leaf` tinyint(1) NULL DEFAULT NULL COMMENT '是否叶子节点:    1:是   0:不是',
  `keep_alive` tinyint(1) NULL DEFAULT NULL COMMENT '是否缓存该页面:    1:是   0:不是',
  `hidden` int(11) NULL DEFAULT 0 COMMENT '是否隐藏路由: 0否,1是',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮权限状态(0无效1有效)',
  `del_flag` int(11) NULL DEFAULT 0 COMMENT '删除状态 0正常 1已删除',
  `rule_flag` int(11) NULL DEFAULT 0 COMMENT '是否添加数据权限1是0否',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `internal_or_external` tinyint(1) NULL DEFAULT NULL COMMENT '外链菜单打开方式 0/内部打开 1/外部打开',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_prem_pid`(`parent_id` ASC) USING BTREE,
  INDEX `index_prem_is_route`(`is_route` ASC) USING BTREE,
  INDEX `index_prem_is_leaf`(`is_leaf` ASC) USING BTREE,
  INDEX `index_prem_sort_no`(`sort_no` ASC) USING BTREE,
  INDEX `index_prem_del_flag`(`del_flag` ASC) USING BTREE,
  INDEX `index_menu_type`(`menu_type` ASC) USING BTREE,
  INDEX `index_menu_hidden`(`hidden` ASC) USING BTREE,
  INDEX `index_menu_status`(`status` ASC) USING BTREE,
  INDEX `IDX_1`(`del_flag` ASC, `sort_no` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES ('00a2a0ae65cdca5e93209cdbde97cbe6', '2e42e3835c2b44ec9f7bc26c146ee531', '成功', '/result/success', 'result/Success', NULL, NULL, 1, NULL, NULL, 1.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('020b06793e4de2eee0007f603000c769', 'f0675b52d89100ee88472b6800754a08', 'ViserChartDemo', '/report/ViserChartDemo', 'jeecg/report/ViserChartDemo', NULL, NULL, 1, NULL, NULL, 0.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-03 19:08:53', 'admin', '2019-04-12 23:12:28', NULL);
INSERT INTO `sys_permission` VALUES ('0230a2c89be59104a1b048195150f2d0', 'f4b0985a992eca541c1914a118669f44', '月度增长分析同比', '/online/graphreport/chart/27accd782f98c41eae5fad1b0514238d', 'modules/online/graphreport/auto/OnlGraphreportAutoChart', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 0, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-29 20:11:58', 'admin', '2019-04-29 20:12:50', NULL);
INSERT INTO `sys_permission` VALUES ('024f1fd1283dc632458976463d8984e1', '700b7f95165c46cc7a78bf227aa8fed3', 'Tomcat信息', '/monitor/TomcatInfo', 'modules/monitor/TomcatInfo', NULL, NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-02 09:44:29', 'admin', '2019-05-07 15:19:10', NULL);
INSERT INTO `sys_permission` VALUES ('027aee69baee98a0ed2e01806e89c891', 'e41b69c57a941a3bbcce45032fe57605', '在线数据报表1', '/online/cgreport/87b55a515d3441b6b98e48e5b35474a6', 'modules/online/cgreport/auto/OnlCgreportAutoList', 'onlineAutoList', NULL, 1, NULL, NULL, 24.00, 0, NULL, 0, 1, 0, 0, NULL, NULL, 0, 0, 'admin', '2019-03-13 19:08:20', 'admin', '2019-10-03 15:42:26', 0);
INSERT INTO `sys_permission` VALUES ('043780fa095ff1b2bec4dc406d76f023', '2a470fc0c3954d9dbb61de6d80846549', '表格合计', '/jeecg/tableTotal', 'jeecg/TableTotal', NULL, NULL, 1, NULL, '1', 3.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2019-08-14 10:28:46', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('05b3c82ddb2536a4a5ee1a4c46b5abef', '540a2936940846cb98114ffb0d145cb8', '用户列表', '/list/user-list', 'list/UserList', NULL, NULL, 1, NULL, NULL, 3.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('0620e402857b8c5b605e1ad9f4b89350', '2a470fc0c3954d9dbb61de6d80846549', '异步树列表Demo', '/jeecg/JeecgTreeTable', 'jeecg/JeecgTreeTable', NULL, NULL, 1, NULL, '0', 3.00, 0, NULL, 1, 1, NULL, 0, NULL, '1', 0, 0, 'admin', '2019-05-13 17:30:30', 'admin', '2019-05-13 17:32:17', NULL);
INSERT INTO `sys_permission` VALUES ('078f9558cdeab239aecb2bda1a8ed0d1', 'fb07ca05a3e13674dbf6d3245956da2e', '搜索列表（文章）', '/list/search/article', 'list/TableList', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-02-12 14:00:34', 'admin', '2019-02-12 14:17:54', NULL);
INSERT INTO `sys_permission` VALUES ('08e6b9dc3c04489c8e1ff2ce6f105aa4', '', '系统监控', '/dashboard3', 'layouts/RouteView', NULL, NULL, 0, NULL, NULL, 7.00, 0, 'dashboard', 1, 0, 0, 0, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', 'admin', '2024-08-12 14:48:02', 0);
INSERT INTO `sys_permission` VALUES ('09e7db25b4555332333f83afdadc7897', '', 'OA办公', '/oa', 'layouts/RouteView', NULL, NULL, 0, NULL, '1', 3.00, 0, 'alert', 1, 0, 0, 0, NULL, '1', 0, 0, 'admin', '2019-07-05 20:51:45', 'admin', '2019-09-23 16:01:35', 0);
INSERT INTO `sys_permission` VALUES ('0ac2ad938963b6c6d1af25477d5b8b51', '8d4683aacaa997ab86b966b464360338', '代码生成按钮', NULL, NULL, NULL, NULL, 2, 'online:goGenerateCode', '1', 1.00, 0, NULL, 1, 1, NULL, 0, NULL, '1', 0, 0, 'admin', '2019-06-11 14:20:09', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('0bbf8639ce155779594f2a9948978f10', 'e41b69c57a941a3bbcce45032fe57605', '自定义按钮', '/online/cgformButton/:code', 'modules/online/cgform/button/OnlCgformButtonList', NULL, NULL, 1, NULL, NULL, 9.00, 0, NULL, 1, 1, NULL, 1, NULL, NULL, 0, 0, 'admin', '2019-04-02 17:40:42', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('109c78a583d4693ce2f16551b7786786', 'e41b69c57a941a3bbcce45032fe57605', 'Online报表配置', '/online/cgreport', 'modules/online/cgreport/OnlCgreportHeadList', NULL, NULL, 1, NULL, NULL, 2.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-03-08 10:51:07', 'admin', '2019-03-30 19:04:28', NULL);
INSERT INTO `sys_permission` VALUES ('1166535831146504193', '2a470fc0c3954d9dbb61de6d80846549', '对象存储', '/oss/file', 'modules/oss/OSSFileList', NULL, NULL, 1, NULL, '1', 1.00, 0, '', 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2019-08-28 02:19:50', 'admin', '2019-08-28 02:20:57', NULL);
INSERT INTO `sys_permission` VALUES ('1170592628746878978', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '菜单管理', '/isystem/newPermissionList', 'system/NewPermissionList', NULL, NULL, 1, NULL, '1', 2.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2019-09-08 15:00:05', 'admin', '2019-09-25 15:40:52', 0);
INSERT INTO `sys_permission` VALUES ('1174291880345526274', '1174628684611563521', '文档管理', '/modules/eoa/filemanage/eoaFileInit', 'modules/eoa/filemanage/EoaFileInit', NULL, NULL, 1, NULL, '1', 2.00, 0, '', 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2019-09-18 19:59:36', 'admin', '2019-10-01 14:21:55', 0);
INSERT INTO `sys_permission` VALUES ('1174506953255182338', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '职务管理', '/isystem/position', 'system/SysPositionList', NULL, NULL, 1, NULL, '1', 2.20, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2019-09-19 10:14:13', 'admin', '2019-09-25 15:43:25', 0);
INSERT INTO `sys_permission` VALUES ('1174590283938041857', '1174628684611563521', '通讯录', '/isystem/addressList', 'system/AddressList', NULL, NULL, 1, NULL, '1', 3.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2019-09-19 15:45:21', 'admin', '2019-09-25 11:28:16', 0);
INSERT INTO `sys_permission` VALUES ('1174628684611563521', '', 'OA组件', '/eoa', 'layouts/RouteView', NULL, NULL, 0, NULL, '1', 4.10, 0, 'qrcode', 1, 0, 0, 0, NULL, '1', 0, 0, 'admin', '2019-09-19 18:17:57', 'admin', '2019-10-07 17:15:30', 0);
INSERT INTO `sys_permission` VALUES ('1174628954015903745', '1174628684611563521', '文章栏目', '/eoa/cms/EoaCmsMenuList', 'modules/eoa/cms/EoaCmsMenuList', NULL, NULL, 1, NULL, '1', 8.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2019-09-19 18:19:01', 'admin', '2019-10-01 14:22:25', 0);
INSERT INTO `sys_permission` VALUES ('1174629137172770818', '1174628684611563521', '文章管理', '/eoa/cms/EoaCmsArticleList', 'modules/eoa/cms/EoaCmsArticleList', NULL, NULL, 1, NULL, '1', 8.10, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2019-09-19 18:19:45', 'admin', '2019-10-01 14:19:59', 0);
INSERT INTO `sys_permission` VALUES ('1176031222112026625', '1174628684611563521', '日程计划列表', '/eoa/planList', 'modules/eoa/plan/EoaPlanList', NULL, NULL, 1, NULL, '1', 3.20, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2019-09-23 15:11:08', 'admin', '2019-10-07 17:15:51', 0);
INSERT INTO `sys_permission` VALUES ('11760312221121525513', '1174628684611563521', '日程计划', '/eoa/plan', 'modules/eoa/plan/EoaPlanView', NULL, NULL, 1, NULL, '1', 3.10, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2019-09-23 15:17:53', 'admin', '2019-10-07 17:16:03', 0);
INSERT INTO `sys_permission` VALUES ('1176103166991773698', '1174628684611563521', '我的邮箱', '/modules/eoa/email/EoaCmsEmailList', 'modules/eoa/email/EoaCmsEmailList', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2019-09-23 19:57:01', 'admin', '2019-09-27 14:47:50', 0);
INSERT INTO `sys_permission` VALUES ('1176679204206522369', '8d4683aacaa997ab86b966b464360338', 'SQL增强', NULL, NULL, NULL, NULL, 2, 'online:sql', '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2019-09-25 10:05:59', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES ('1176852999002075137', '1174628684611563521', '文档查看', '/modules/eoa/filemanage/eoaFileView', 'modules/eoa/filemanage/EoaFileView', NULL, NULL, 1, NULL, '1', 2.00, 0, '', 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2019-09-25 21:36:33', 'admin', '2019-10-01 14:21:41', 0);
INSERT INTO `sys_permission` VALUES ('13212d3416eb690c2e1d5033166ff47a', '2e42e3835c2b44ec9f7bc26c146ee531', '失败', '/result/fail', 'result/Error', NULL, NULL, 1, NULL, NULL, 2.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('1367a93f2c410b169faa7abcbad2f77c', '6e73eb3c26099c191bf03852ee1310a1', '基本设置', '/account/settings/base', 'account/settings/BaseSetting', NULL, NULL, 1, 'BaseSettings', NULL, NULL, 0, NULL, 1, 1, NULL, 1, NULL, NULL, 0, 0, NULL, '2018-12-26 18:58:35', 'admin', '2019-03-20 12:57:31', NULL);
INSERT INTO `sys_permission` VALUES ('1526767314089922561', '', '值班管理', '/dutyManagement1', 'layouts/RouteView', NULL, NULL, 0, NULL, '1', 1.00, 0, 'bars', 1, 0, 0, 0, NULL, '1', 0, 0, 'admin', '2022-05-18 11:31:08', 'admin', '2022-07-13 11:13:17', 0);
INSERT INTO `sys_permission` VALUES ('1526775641918230529', '1526767314089922561', '业务系统管理', '/dutyManagement/business', 'dutyManagement/business', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2022-05-18 12:04:14', 'admin', '2022-05-19 16:10:29', 0);
INSERT INTO `sys_permission` VALUES ('1526775914543796226', '1526767314089922561', '工作人员类型管理', '/dutyManagement/people', 'dutyManagement/people', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2022-05-18 12:05:19', 'admin', '2022-05-19 16:10:43', 0);
INSERT INTO `sys_permission` VALUES ('1526814321496084481', '1526767314089922561', '值班表管理', '/dutyManagement/duty', 'dutyManagement/duty', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2022-05-18 14:37:56', 'admin', '2022-05-19 16:10:56', 0);
INSERT INTO `sys_permission` VALUES ('1526911125638197250', '1526767314089922561', '值班表台账', '/dutyManagement/dutyStandingBook', 'dutyManagement/dutyStandingBook', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2022-05-18 21:02:35', 'admin', '2022-05-19 16:11:12', 0);
INSERT INTO `sys_permission` VALUES ('1527100512351043585', '1526767314089922561', '我的值班', '/dutyManagement/myDuty', 'dutyManagement/myDuty', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2022-05-19 09:35:09', 'admin', '2022-05-19 16:11:35', 0);
INSERT INTO `sys_permission` VALUES ('1527105581565886465', '', '值班报告', '/dutyReport', 'layouts/RouteView', NULL, NULL, 0, NULL, '1', 1.00, 0, 'file-text', 1, 0, 0, 0, NULL, '1', 0, 0, 'admin', '2022-05-19 09:55:18', 'admin', '2022-06-01 11:23:55', 0);
INSERT INTO `sys_permission` VALUES ('1527200555208814593', '1527105581565886465', '报告指标管理', '/dutyReport/reportingIndicators', 'dutyReport/reportingIndicators', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2022-05-19 16:12:41', 'admin', '2022-05-19 17:21:19', 0);
INSERT INTO `sys_permission` VALUES ('1527200755562328065', '1527105581565886465', '报告模板管理', '/dutyReport/reportTemplate', 'dutyReport/reportTemplate', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2022-05-19 16:13:29', 'admin', '2022-05-19 17:21:34', 0);
INSERT INTO `sys_permission` VALUES ('1527248907900309505', '1527105581565886465', '值班报告下载', '/dutyReport/dutyReport', 'dutyReport/dutyReport', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2022-05-19 19:24:49', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES ('1531909548084310018', '', '值班信息', '/dutyManagement', 'layouts/RouteView', NULL, NULL, 0, NULL, '1', 1.00, 0, 'code', 1, 0, 0, 0, NULL, '1', 0, 0, 'admin', '2022-06-01 16:04:32', 'admin', '2025-07-23 17:18:23', 0);
INSERT INTO `sys_permission` VALUES ('1531909913546600450', '1531909548084310018', '信息上报', '/information/report', 'modules/info/ReportInfoList', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2022-06-01 16:06:00', 'admin', '2022-06-01 16:06:37', 0);
INSERT INTO `sys_permission` VALUES ('1531910209106620417', '1531909548084310018', '信息接报', '/information/receive', 'modules/info/ReportReceiveList', NULL, NULL, 1, NULL, '1', 3.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2022-06-01 16:07:10', 'admin', '2022-07-06 11:18:26', 0);
INSERT INTO `sys_permission` VALUES ('1533631589450596353', '1531909548084310018', '上报事件', '/event/EventInfoList', 'modules/event/EventInfoList', NULL, NULL, 1, NULL, '1', 4.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2022-06-06 10:07:19', 'admin', '2023-12-13 16:27:10', 0);
INSERT INTO `sys_permission` VALUES ('1533631742416863233', '1531909548084310018', '上报审核', '/event/EventAuditList', 'modules/event/EventAuditList', NULL, NULL, 1, NULL, '1', 5.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2022-06-06 10:07:56', 'admin', '2022-07-06 11:18:55', 0);
INSERT INTO `sys_permission` VALUES ('1533632024915820545', '1531909548084310018', '事件批示', '/event/EventInstructionList', 'modules/event/EventInstructionList', NULL, NULL, 1, NULL, '1', 7.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2022-06-06 10:09:03', 'admin', '2022-07-06 11:19:27', 0);
INSERT INTO `sys_permission` VALUES ('1533632216142528513', '1531909548084310018', '领导批示信息', '/event/LeadeInstructionList', 'modules/event/LeadeInstructionList', NULL, NULL, 1, NULL, '1', 8.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2022-06-06 10:09:48', 'admin', '2022-07-06 11:19:38', 0);
INSERT INTO `sys_permission` VALUES ('1534516284275535873', '1531909548084310018', '相关部门', '/dept/RelevantDepartList', 'modules/dept/RelevantDepartList', NULL, NULL, 1, NULL, '1', 9.00, 0, 'drag', 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2022-06-08 20:42:47', 'admin', '2022-07-06 11:19:57', 0);
INSERT INTO `sys_permission` VALUES ('1536534252509335553', '', '值班管理', '/duty', 'layouts/RouteView', NULL, NULL, 0, NULL, '1', 3.00, 0, 'file-protect', 1, 0, 0, 0, NULL, '1', 0, 0, 'admin', '2022-06-14 10:21:28', 'admin', '2025-07-23 17:18:41', 0);
INSERT INTO `sys_permission` VALUES ('1536534573105156097', '1536534252509335553', '值班室排班', '/duty/DutyManagement', 'modules/duty/DutyManagement/DutyManagementCard', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2022-06-14 10:22:44', 'admin', '2025-07-22 21:55:28', 0);
INSERT INTO `sys_permission` VALUES ('1536535063935193090', '1536534252509335553', '交接班记录', '/duty/ShiftRecord', 'modules/duty/ShiftRecord/ShiftRecordList', NULL, NULL, 1, NULL, '1', 2.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2022-06-14 10:24:41', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES ('1536535560624672769', '1536534252509335553', '值班台账', '/duty/StandingBook', 'modules/duty/StandingBook/StandingBookList', NULL, NULL, 1, NULL, '1', 3.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2022-06-14 10:26:40', 'admin', '2022-06-14 15:38:25', 0);
INSERT INTO `sys_permission` VALUES ('1536536008777666562', '1536534252509335553', '值班考核', '/duty/dutyCheck', 'modules/duty/dutyCheck/SpotCheckRecordList', NULL, NULL, 1, NULL, '1', 4.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2022-06-14 10:28:27', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES ('1536536359895437313', '1536534252509335553', '值班报告', '/duty/report', 'modules/duty/report/dutyReport', NULL, NULL, 1, NULL, '1', 5.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2022-06-14 10:29:50', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES ('1536536628179898369', '1536534252509335553', '领导外出报备', '/duty/FilingRecord', 'modules/duty/FilingRecord/FilingRecordList', NULL, NULL, 1, NULL, '1', 6.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2022-06-14 10:30:54', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES ('1541963267527282690', '1531909548084310018', '信息签收', '/information/reportSignList', 'modules/info/ReportSignList', NULL, NULL, 1, NULL, '1', 2.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2022-06-29 09:54:26', 'admin', '2022-07-06 11:18:09', 0);
INSERT INTO `sys_permission` VALUES ('1543872404432519169', '1531909548084310018', '抄清抄告审核', '/event/instructionReview', 'modules/event/instructionReview', NULL, NULL, 1, NULL, '1', 6.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2022-07-04 16:20:40', 'admin', '2022-09-19 11:16:23', 0);
INSERT INTO `sys_permission` VALUES ('1547169113101864962', '', '首页', '/dashboard/analysis', 'dashboard/Analysis', NULL, NULL, 0, NULL, '1', 0.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'e9ca23d68d884d4ebb19d07889727dae', '2022-07-13 18:40:36', 'e9ca23d68d884d4ebb19d07889727dae', '2022-07-13 21:52:35', 0);
INSERT INTO `sys_permission` VALUES ('1547458558128951298', '1536534252509335553', '文件交换', '/filesChange', 'modules/filesChange/file_exchange_recordList', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'e9ca23d68d884d4ebb19d07889727dae', '2022-07-14 13:50:45', 'e9ca23d68d884d4ebb19d07889727dae', '2022-07-14 13:58:11', 0);
INSERT INTO `sys_permission` VALUES ('1548909504239509506', '1531909548084310018', '信息上报(街道)', '/information/reportStreet', 'modules/info/ReportStreet', NULL, NULL, 1, NULL, '1', 2.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'e9ca23d68d884d4ebb19d07889727dae', '2022-07-18 13:56:18', 'e9ca23d68d884d4ebb19d07889727dae', '2022-07-20 15:27:37', 0);
INSERT INTO `sys_permission` VALUES ('1549272269711970305', '1531909548084310018', '下级上报', '/information/lowerReport', 'modules/info/lowerReport', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'e9ca23d68d884d4ebb19d07889727dae', '2022-07-19 13:57:48', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES ('1551381649861881858', '1536534252509335553', '大运排班', '/duty/leader/leaderWorkforce', 'modules/duty/leaderWorkforce/leaderWorkforce', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'e9ca23d68d884d4ebb19d07889727dae', '2022-07-25 09:39:43', NULL, '2023-07-10 09:23:35', 0);
INSERT INTO `sys_permission` VALUES ('1551823099912736770', '1536534252509335553', '通话记录', '/duty/callLog', 'modules/duty/callLog/callLog', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'e9ca23d68d884d4ebb19d07889727dae', '2022-07-26 14:53:53', 'e9ca23d68d884d4ebb19d07889727dae', '2022-07-26 14:54:27', 0);
INSERT INTO `sys_permission` VALUES ('1556461882692739073', '1536534252509335553', '市级城运排班', '/duty/workingSchedule/workingSchedule', 'modules/duty/workingSchedule/workingSchedule', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'e9ca23d68d884d4ebb19d07889727dae', '2022-08-08 10:06:45', 'e9ca23d68d884d4ebb19d07889727dae', '2025-07-22 21:53:52', 0);
INSERT INTO `sys_permission` VALUES ('1557603476425080833', '1536534252509335553', '批示抄清台账', '/duty/instructionAccountList', 'modules/duty/instructionAccountList/instructionAccountList', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'e9ca23d68d884d4ebb19d07889727dae', '2022-08-11 13:43:02', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES ('1577666863444291585', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '配置', '/isystem/configuration', 'system/Configuration', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 1, 0, NULL, '1', 0, 0, NULL, '2022-10-05 22:27:46', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES ('1582625357877501954', '1531909548084310018', '抄清抄告', '/inform/record', 'modules/inform/inform', NULL, NULL, 1, NULL, '1', 6.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, NULL, '2022-10-19 14:51:04', NULL, '2022-10-21 14:06:25', 0);
INSERT INTO `sys_permission` VALUES ('1594877472880701441', '', '城运日报', '/cyDaily', 'layouts/RouteView', NULL, '/cyDaily/dailyTteListempla', 0, NULL, '1', 1.00, 0, 'tool', 1, 0, 0, 0, NULL, '1', 0, 0, NULL, '2022-11-22 10:16:36', NULL, '2022-11-22 10:23:28', 0);
INSERT INTO `sys_permission` VALUES ('1594877658768060418', '1594877472880701441', '城运日报模板', '/cyDaily/dailyTemplateList', 'modules/cyDaily/dailyTemplateList/DailyTemplateList', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, NULL, '2022-11-22 10:17:20', NULL, '2022-11-22 10:25:08', 0);
INSERT INTO `sys_permission` VALUES ('1597053932250746882', '1594877472880701441', '城运日报填报', '/cyDaily/dailyFill', 'modules/cyDaily/dailyFill/DailyRecordList2', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, NULL, '2022-11-28 10:25:04', NULL, '2022-11-28 10:40:28', 0);
INSERT INTO `sys_permission` VALUES ('1597054257091203073', '1594877472880701441', '城运日报查阅', '/cyDaily/dailyConsult', 'modules/cyDaily/dailyConsult/DailyRecordList', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, NULL, '2022-11-28 10:26:21', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES ('1602122141296574466', '1531909548084310018', '公文转译', '/cyDaily/officia', 'modules/cyDaily/officia/Officia', NULL, NULL, 1, NULL, '1', 10.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, NULL, '2022-12-12 10:04:19', NULL, '2022-12-22 10:04:37', 0);
INSERT INTO `sys_permission` VALUES ('1623224735260291074', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '临时分组', '/isystem/temporaryGrpup', 'modules/temporaryGrpup/temporary_group_recordList', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, NULL, '2023-02-08 15:38:30', NULL, '2023-02-13 10:15:15', 0);
INSERT INTO `sys_permission` VALUES ('1628573451689103362', '1536534252509335553', '县(区)城运排班', '/duty/workingScheduleCounty/workingScheduleCounty', 'modules/duty/workingScheduleCounty/workingScheduleCounty', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, NULL, '2023-02-23 09:52:23', NULL, '2025-07-22 21:53:32', 0);
INSERT INTO `sys_permission` VALUES ('1635096824664199169', '1531909548084310018', '跟踪信息', '/information/traceEvent', 'modules/info/TraceEvent', NULL, NULL, 1, NULL, '1', 3.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, NULL, '2023-03-13 09:53:56', NULL, '2023-11-28 11:03:15', 0);
INSERT INTO `sys_permission` VALUES ('1646038793693044737', '1536534252509335553', '申请记录', '/duty/ApplicationRecord', 'modules/duty/ApplicationRecord/ApplicationRecord', NULL, NULL, 1, NULL, '1', 7.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, NULL, '2023-04-12 14:33:25', NULL, '2023-04-12 14:35:37', 0);
INSERT INTO `sys_permission` VALUES ('1694537269673787393', '1536534252509335553', '每日值班综报', '/duty/EveryDayReport', 'modules/duty/EveryDayReport/EveryDayList', NULL, NULL, 1, NULL, '1', 6.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, NULL, '2023-08-24 10:29:03', NULL, '2023-08-24 10:30:58', 0);
INSERT INTO `sys_permission` VALUES ('1729336251411177474', '1531909548084310018', '跟踪事件', '/event/TrackEventInfoList', 'modules/event/TrackEventInfoList', NULL, NULL, 1, NULL, '1', 4.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, NULL, '2023-11-28 11:07:46', NULL, '2023-11-28 11:09:42', 0);
INSERT INTO `sys_permission` VALUES ('1768166372325580801', '1536534252509335553', '市委市政府办公室排班', '/duty/leaderDuty', 'modules/duty/leaderDuty/LeaderDutyCard', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, NULL, '2024-03-14 14:44:49', NULL, '2025-06-06 16:10:22', 0);
INSERT INTO `sys_permission` VALUES ('1822887784340287490', NULL, 'dawda', '/wdawd', 'awdawd', NULL, NULL, 0, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, NULL, '2024-08-12 14:48:10', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES ('1822899435642843137', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '日志信息', '/isystem/syslog', 'system/SysDoLogList', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, NULL, '2024-08-12 15:34:28', NULL, '2024-08-12 15:35:27', 0);
INSERT INTO `sys_permission` VALUES ('1876144238232698882', '1536534252509335553', '通讯录', '/duty/AddressBook', 'modules/duty/AddressBook/AddressBookList', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, NULL, '2025-01-06 13:50:18', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES ('1892445302548152322', '1536534252509335553', 'AI智能助手', '/duty/AiChat', 'modules/duty/AiChat/AiChatFrame', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, NULL, '2025-02-20 13:24:55', NULL, '2025-03-28 17:37:54', 0);
INSERT INTO `sys_permission` VALUES ('1905554985752473602', '1531909548084310018', '应急指挥', '/duty/Emergency', 'modules/duty/Emergency/EmergencyList', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, NULL, '2025-03-28 17:38:07', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES ('190c2b43bec6a5f7a4194a85db67d96a', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '角色维护', '/isystem/roleUserList', 'system/RoleUserList', NULL, NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, 1, 0, NULL, NULL, 0, 0, 'admin', '2019-04-17 15:13:56', 'admin', '2019-09-25 15:43:39', 0);
INSERT INTO `sys_permission` VALUES ('191e453f3de11d56cd376679958bcea2', 'a44c30db536349e91106223957e684eb', '历史流程', '/bpm/task/HisProcessList', 'modules/bpm/task/HisProcessList', NULL, NULL, 1, NULL, NULL, 8.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-02 17:21:49', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('1939e035e803a99ceecb6f5563570fb2', 'baf16b7174bd821b6bab23fa9abb200d', '我的任务', '/bpm/task/MyTaskList', 'modules/bpm/task/MyTaskList', NULL, NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-03-08 10:08:12', 'admin', '2019-07-02 18:57:13', NULL);
INSERT INTO `sys_permission` VALUES ('1a0811914300741f4e11838ff37a1d3a', '3f915b2769fc80648e92d04e84ca059d', '手机号禁用', NULL, NULL, NULL, NULL, 2, 'user:form:phone', '2', 1.00, 0, NULL, 0, 1, NULL, 0, NULL, '1', 0, 0, 'admin', '2019-05-11 17:19:30', 'admin', '2019-06-11 23:14:36', NULL);
INSERT INTO `sys_permission` VALUES ('200006f0edf145a2b50eacca07585451', 'fb07ca05a3e13674dbf6d3245956da2e', '搜索列表（应用）', '/list/search/application', 'list/TableList', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-02-12 14:02:51', 'admin', '2019-02-12 14:14:01', NULL);
INSERT INTO `sys_permission` VALUES ('21c064f4299abae3535caf423a2bc091', NULL, 'Online表单权限', NULL, 'layouts/RouteView', NULL, NULL, 0, NULL, NULL, 99.00, 0, 'deployment-unit', 0, 0, NULL, 1, NULL, NULL, 0, 0, 'admin', '2019-05-07 19:07:22', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('22d6a3d39a59dd7ea9a30acfa6bfb0a5', 'e41b69c57a941a3bbcce45032fe57605', 'AUTO动态表单', '/online/df/:table/:id', 'modules/online/cgform/auto/OnlineDynamicForm', NULL, NULL, 1, NULL, NULL, 9.00, 0, NULL, 0, 1, NULL, 1, NULL, NULL, 0, 0, 'admin', '2019-04-22 15:15:43', 'admin', '2019-04-30 18:18:26', NULL);
INSERT INTO `sys_permission` VALUES ('250bacc3044cab801746140e32b2a1b5', '2b0459d0823b8cc6f0e4cce3463ed3a8', '用户岗位禁用', NULL, NULL, NULL, NULL, 2, 'online:air_china_persion_config:post', '2', 1.00, 0, NULL, 0, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2019-05-11 18:39:10', 'admin', '2019-07-02 19:54:38', NULL);
INSERT INTO `sys_permission` VALUES ('25ecd6db517f9018fafb1f36a64f89c4', '3f915b2769fc80648e92d04e84ca059d', '用户列表数据', '', NULL, NULL, NULL, 2, 'sys:user:list', '1', 1.00, 0, NULL, 1, 1, NULL, 0, NULL, '0', 0, 0, 'admin', '2019-05-06 18:36:35', 'admin', '2019-05-28 10:29:24', NULL);
INSERT INTO `sys_permission` VALUES ('265de841c58907954b8877fb85212622', '2a470fc0c3954d9dbb61de6d80846549', '图片拖拽排序', '/jeecg/imgDragSort', 'jeecg/ImgDragSort', NULL, NULL, 1, NULL, NULL, 9.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-25 10:43:08', 'admin', '2019-04-25 18:31:04', NULL);
INSERT INTO `sys_permission` VALUES ('277bfabef7d76e89b33062b16a9a5020', 'e3c13679c73a4f829bcff2aba8fd68b1', '基础表单', '/form/base-form', 'form/BasicForm', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 0, NULL, 0, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', 'admin', '2019-02-26 17:02:08', NULL);
INSERT INTO `sys_permission` VALUES ('2a470fc0c3954d9dbb61de6d80846549', '', '常见案例', '/jeecg', 'layouts/RouteView', NULL, NULL, 0, NULL, NULL, 7.00, 0, 'qrcode', 1, 0, NULL, 0, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', 'admin', '2019-04-02 11:46:42', NULL);
INSERT INTO `sys_permission` VALUES ('2aa1fc959c2d0d8f78ab936c8f8560fb', 'f4b0985a992eca541c1914a118669f44', '来源收入统计', '{{ window._CONFIG[\'domianURL\'] }}/ReportServer?reportlet=kunlun_02.cpt', 'layouts/IframeFReportView', NULL, NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-29 19:18:12', 'admin', '2019-04-29 20:15:31', NULL);
INSERT INTO `sys_permission` VALUES ('2aeddae571695cd6380f6d6d334d6e7d', 'f0675b52d89100ee88472b6800754a08', '布局统计报表', '/report/ArchivesStatisticst', 'jeecg/report/ArchivesStatisticst', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-03 18:32:48', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('2b0459d0823b8cc6f0e4cce3463ed3a8', '21c064f4299abae3535caf423a2bc091', '个人标准积分配置权限', NULL, NULL, NULL, NULL, 2, NULL, '0', 1.00, 0, NULL, 0, 0, NULL, 0, NULL, '1', 0, 0, 'admin', '2019-05-11 18:37:05', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('2dbbafa22cda07fa5d169d741b81fe12', '08e6b9dc3c04489c8e1ff2ce6f105aa4', '在线文档', '{{ window._CONFIG[\'domianURL\'] }}/doc.html', 'layouts/IframePageView', NULL, NULL, 1, NULL, NULL, 3.00, 0, NULL, 1, 1, 0, 0, NULL, NULL, 0, 0, 'admin', '2019-01-30 10:00:01', 'admin', '2019-09-08 14:34:20', 1);
INSERT INTO `sys_permission` VALUES ('2e42e3835c2b44ec9f7bc26c146ee531', '', '结果页', '/result', 'layouts/PageView', NULL, NULL, 0, NULL, NULL, 8.00, 0, 'check-circle-o', 1, 0, NULL, 0, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', 'admin', '2019-04-02 11:46:56', NULL);
INSERT INTO `sys_permission` VALUES ('2ea33825c6b365607b9ff04f3362bdda', '09e7db25b4555332333f83afdadc7897', 'OA申请单查看更多', '/extbpm/process/BpmAutoDesformApplyMore', 'modules/extbpm/process/BpmAutoDesformApplyMore', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 1, NULL, '1', 0, 0, 'admin', '2019-07-23 16:30:47', 'admin', '2019-07-23 16:31:01', NULL);
INSERT INTO `sys_permission` VALUES ('326a99be05ab907332fad34944a906af', 'f4b0985a992eca541c1914a118669f44', '项目性质收入统计', '/online/graphreport/chart/1c034f6063cee129e6aa32016ac42ce8', 'modules/online/graphreport/auto/OnlGraphreportAutoChart', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 0, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-29 20:14:33', 'admin', '2019-04-29 20:17:28', NULL);
INSERT INTO `sys_permission` VALUES ('339329ed54cf255e1f9392e84f136901', '2a470fc0c3954d9dbb61de6d80846549', 'helloworld', '/jeecg/helloworld', 'jeecg/helloworld', NULL, NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', 'admin', '2019-02-15 16:24:56', NULL);
INSERT INTO `sys_permission` VALUES ('3560fc68c74f72b4260ffee65b373c82', '', '国航E选模块', '/air', 'layouts/RouteView', NULL, NULL, 0, NULL, NULL, 11.00, 0, 'team', 1, 0, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-24 17:35:39', 'admin', '2019-04-29 20:22:10', NULL);
INSERT INTO `sys_permission` VALUES ('3b45e691929312bdc23047b25483ba77', 'edfa74d66e8ea63ea432c2910837b150', '出差申请', '/joa/JoaBusinesStripList', 'modules/extbpm/joa/JoaBusinesStripList', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-10 14:21:29', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('3be6ff6704723141960ea0f397a18727', 'edfa74d66e8ea63ea432c2910837b150', '借款申请', '/joa/JoaLoanList', 'modules/extbpm/joa/JoaLoanList', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-10 14:22:57', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('3f915b2769fc80648e92d04e84ca059d', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '用户管理', '/isystem/user', 'system/UserList', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 0, NULL, 0, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', 'admin', '2019-03-16 11:20:33', NULL);
INSERT INTO `sys_permission` VALUES ('3fac0d3c9cd40fa53ab70d4c583821f8', '2a470fc0c3954d9dbb61de6d80846549', '分屏', '/jeecg/splitPanel', 'jeecg/SplitPanel', NULL, NULL, 1, NULL, NULL, 10.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-25 16:27:06', 'admin', '2019-04-25 18:39:15', NULL);
INSERT INTO `sys_permission` VALUES ('4148ec82b6acd69f470bea75fe41c357', '2a470fc0c3954d9dbb61de6d80846549', '单表模型示例', '/jeecg/jeecgDemoList', 'jeecg/JeecgDemoList', 'DemoList', NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 1, NULL, '2018-12-28 15:57:30', 'admin', '2019-02-15 16:24:37', NULL);
INSERT INTO `sys_permission` VALUES ('418964ba087b90a84897b62474496b93', '540a2936940846cb98114ffb0d145cb8', '查询表格', '/list/query-list', 'list/TableList', NULL, NULL, 1, NULL, NULL, 1.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('4356a1a67b564f0988a484f5531fd4d9', '2a470fc0c3954d9dbb61de6d80846549', '内嵌Table', '/jeecg/TableExpandeSub', 'jeecg/TableExpandeSub', NULL, NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-04 22:48:13', 'admin', '2019-07-01 18:23:14', NULL);
INSERT INTO `sys_permission` VALUES ('45c966826eeff4c99b8f8ebfe74511fc', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '部门管理', '/isystem/depart', 'system/DepartList', NULL, NULL, 1, NULL, NULL, 2.00, 0, NULL, 1, 1, 0, 0, NULL, NULL, 0, 0, 'admin', '2019-01-29 18:47:40', 'admin', '2019-09-25 15:43:01', 0);
INSERT INTO `sys_permission` VALUES ('4875ebe289344e14844d8e3ea1edd73f', '', '详情页', '/profile', 'layouts/RouteView', NULL, NULL, 0, NULL, NULL, 8.00, 0, 'profile', 1, 0, NULL, 0, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', 'admin', '2019-04-02 11:46:48', NULL);
INSERT INTO `sys_permission` VALUES ('4b4bd85fe5394c162d3cab46ecc52bca', 'f780d0d3083d849ccbdb1b1baee4911d', '删除权限', NULL, NULL, NULL, NULL, 2, 'sysMessageTemplate:delete', NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, '1', 0, 0, 'admin', '2019-04-21 18:52:54', 'admin', '2019-04-24 22:36:24', NULL);
INSERT INTO `sys_permission` VALUES ('4f66409ef3bbd69c1d80469d6e2a885e', '6e73eb3c26099c191bf03852ee1310a1', '账户绑定', '/account/settings/binding', 'account/settings/Binding', NULL, NULL, 1, 'BindingSettings', NULL, NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2018-12-26 19:01:20', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('4f84f9400e5e92c95f05b554724c2b58', '540a2936940846cb98114ffb0d145cb8', '角色列表', '/list/role-list', 'list/RoleList', NULL, NULL, 1, NULL, NULL, 4.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('53a9230444d33de28aa11cc108fb1dba', '08e6b9dc3c04489c8e1ff2ce6f105aa4', '我的消息', '/isps/userAnnouncement', 'system/UserAnnouncementList', NULL, NULL, 1, NULL, NULL, 5.00, 0, NULL, 1, 1, 0, 0, NULL, NULL, 0, 0, 'admin', '2019-04-19 10:16:00', 'admin', '2019-09-25 15:48:03', 0);
INSERT INTO `sys_permission` VALUES ('54097c6a3cf50fad0793a34beff1efdf', 'e41b69c57a941a3bbcce45032fe57605', 'AUTO在线表单', '/online/cgformList/:code', 'modules/online/cgform/auto/OnlCgformAutoList', NULL, NULL, 1, NULL, NULL, 9.00, 0, NULL, 1, 1, NULL, 1, NULL, NULL, 0, 0, 'admin', '2019-03-19 16:03:06', 'admin', '2019-04-30 18:19:03', NULL);
INSERT INTO `sys_permission` VALUES ('540a2936940846cb98114ffb0d145cb8', '', '列表页', '/list', 'layouts/PageView', NULL, '/list/query-list', 0, NULL, NULL, 9.00, 0, 'table', 1, 0, 0, 0, NULL, NULL, 0, 1, NULL, '2018-12-25 20:34:38', 'admin', '2019-03-31 22:20:20', 0);
INSERT INTO `sys_permission` VALUES ('54dd5457a3190740005c1bfec55b1c34', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '菜单管理(老)', '/isystem/permission', 'system/PermissionList', NULL, NULL, 1, NULL, NULL, 1.10, 0, NULL, 1, 1, 0, 0, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', 'admin', '2019-09-25 15:45:23', 0);
INSERT INTO `sys_permission` VALUES ('56ca78fe0f22d815fabc793461af67b8', 'edfa74d66e8ea63ea432c2910837b150', '批量申请', '/biz/ExtBizLeaveList', 'modules/extbpm/biz/ExtBizLeaveList', NULL, NULL, 1, NULL, NULL, 3.00, 0, NULL, 1, 1, 0, 0, NULL, NULL, 0, 0, 'admin', '2019-03-26 18:38:14', 'admin', '2019-07-09 22:32:21', NULL);
INSERT INTO `sys_permission` VALUES ('58857ff846e61794c69208e9d3a85466', '08e6b9dc3c04489c8e1ff2ce6f105aa4', '日志管理', '/isystem/log', 'system/LogList', NULL, NULL, 1, NULL, NULL, 1.00, 0, '', 1, 1, NULL, 0, NULL, NULL, 0, 0, NULL, '2018-12-26 10:11:18', 'admin', '2019-04-02 11:38:17', NULL);
INSERT INTO `sys_permission` VALUES ('58b9204feaf07e47284ddb36cd2d8468', '2a470fc0c3954d9dbb61de6d80846549', '图片翻页', '/jeecg/imgTurnPage', 'jeecg/ImgTurnPage', NULL, NULL, 1, NULL, NULL, 9.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-25 11:36:42', 'admin', '2019-04-25 18:31:17', NULL);
INSERT INTO `sys_permission` VALUES ('5c2f42277948043026b7a14692456828', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '我的部门', '/isystem/departUserList', 'system/DepartUserList', NULL, NULL, 1, NULL, NULL, 2.10, 0, NULL, 1, 1, 0, 0, NULL, NULL, 0, 0, 'admin', '2019-04-17 15:12:24', 'admin', '2019-09-25 15:43:15', 0);
INSERT INTO `sys_permission` VALUES ('5c8042bd6c601270b2bbd9b20bccc68b', '', '消息中心', '/message', 'layouts/RouteView', NULL, NULL, 0, NULL, NULL, 6.00, 0, 'message', 1, 0, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-09 11:05:04', 'admin', '2019-04-12 22:40:02', NULL);
INSERT INTO `sys_permission` VALUES ('6242fb02030e9778973390766a5791a7', 'e41b69c57a941a3bbcce45032fe57605', 'Online组合报表', '/online/graphreport/templet', 'modules/online/graphreport/OnlGraphreportTempletList', NULL, NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, 0, 0, NULL, NULL, 0, 0, 'admin', '2019-04-22 10:21:30', 'admin', '2019-10-03 15:42:54', 0);
INSERT INTO `sys_permission` VALUES ('63b551e81c5956d5c861593d366d8c57', '', '流程设计', '/process', 'layouts/RouteView', NULL, NULL, 0, NULL, NULL, 3.40, 0, 'cluster', 1, 0, 0, 0, NULL, NULL, 0, 0, 'admin', '2019-03-15 16:32:06', 'admin', '2019-09-23 16:01:15', 0);
INSERT INTO `sys_permission` VALUES ('6523422a6c69a62d48dacf90932e5302', 'e41b69c57a941a3bbcce45032fe57605', 'AUTO多数据源图表', '/online/graphreport/templet/:code', 'modules/online/graphreport/auto/OnlGraphreportTempletAutoChart', NULL, NULL, 1, NULL, NULL, 9.00, 0, NULL, 1, 1, NULL, 1, NULL, NULL, 0, 0, 'admin', '2019-04-18 16:07:48', 'admin', '2019-05-16 17:11:11', NULL);
INSERT INTO `sys_permission` VALUES ('6531cf3421b1265aeeeabaab5e176e6d', 'e3c13679c73a4f829bcff2aba8fd68b1', '分步表单', '/form/step-form', 'form/stepForm/StepForm', NULL, NULL, 1, NULL, NULL, 2.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('655563cd64b75dcf52ef7bcdd4836953', '2a470fc0c3954d9dbb61de6d80846549', '图片预览', '/jeecg/ImagPreview', 'jeecg/ImagPreview', NULL, NULL, 1, NULL, NULL, 9.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-17 11:18:45', 'admin', '2019-04-25 18:30:53', NULL);
INSERT INTO `sys_permission` VALUES ('65a8f489f25a345836b7f44b1181197a', 'c65321e57b7949b7a975313220de0422', '403', '/exception/403', 'exception/403', NULL, NULL, 1, NULL, NULL, 1.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('6ad53fd1b220989a8b71ff482d683a5a', '2a470fc0c3954d9dbb61de6d80846549', '一对多Tab示例', '/jeecg/tablist/JeecgOrderDMainList', 'jeecg/tablist/JeecgOrderDMainList', NULL, NULL, 1, NULL, NULL, 2.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-02-20 14:45:09', 'admin', '2019-02-21 16:26:21', NULL);
INSERT INTO `sys_permission` VALUES ('6c6a033650e64a14543a8a401d790093', 'e41b69c57a941a3bbcce45032fe57605', 'AUTO表单详情页', '/online/dfview/:table/:id', 'modules/online/cgform/auto/OnlineDynamicViewForm', NULL, NULL, 1, NULL, NULL, 9.00, 0, NULL, 1, 1, NULL, 1, NULL, NULL, 0, 0, 'admin', '2019-04-23 09:53:20', 'admin', '2019-05-16 17:11:26', NULL);
INSERT INTO `sys_permission` VALUES ('6e73eb3c26099c191bf03852ee1310a1', '717f6bee46f44a3897eca9abd6e2ec44', '个人设置', '/account/settings/base', 'account/settings/Index', NULL, NULL, 1, NULL, NULL, 2.00, 1, NULL, 1, 0, NULL, 0, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', 'admin', '2019-04-19 09:41:05', NULL);
INSERT INTO `sys_permission` VALUES ('700b7f95165c46cc7a78bf227aa8fed3', '08e6b9dc3c04489c8e1ff2ce6f105aa4', '性能监控', '/monitor', 'layouts/RouteView', NULL, NULL, 1, NULL, NULL, 0.00, 0, NULL, 1, 0, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-02 11:34:34', 'admin', '2019-05-05 17:49:47', NULL);
INSERT INTO `sys_permission` VALUES ('712e63c3e6d6f443a321c60c19c0a0f3', '712e63c3e6d6f443a321c60c19c0a0f3', '2223', '/222', 'layouts/RouteView', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 0, NULL, 0, NULL, '1', 0, 0, 'admin', '2019-06-06 23:37:09', 'admin', '2019-06-06 23:37:19', NULL);
INSERT INTO `sys_permission` VALUES ('717f6bee46f44a3897eca9abd6e2ec44', '', '个人页', '/account', 'layouts/RouteView', NULL, NULL, 0, NULL, NULL, 9.00, 0, 'user', 1, 0, NULL, 0, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', 'admin', '2019-06-21 18:45:29', NULL);
INSERT INTO `sys_permission` VALUES ('732d48f8e0abe99fe6a23d18a3171cd1', '63b551e81c5956d5c861593d366d8c57', '流程表达式', '/process/ExtActExpressionList', 'modules/extbpm/process/ExtActExpressionList', NULL, NULL, 1, NULL, NULL, 1.30, 0, NULL, 1, 1, 0, 0, NULL, NULL, 0, 0, 'admin', '2019-03-18 17:57:05', 'admin', '2019-09-23 15:55:27', 0);
INSERT INTO `sys_permission` VALUES ('73678f9daa45ed17a3674131b03432fb', '540a2936940846cb98114ffb0d145cb8', '权限列表', '/list/permission-list', 'list/PermissionList', NULL, NULL, 1, NULL, NULL, 5.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('7593c9e3523a17bca83b8d7fe8a34e58', '3f915b2769fc80648e92d04e84ca059d', '添加用户', '', NULL, NULL, NULL, 2, 'user:add', '1', 1.00, 0, NULL, 1, 1, NULL, 0, NULL, '1', 0, 0, 'admin', '2019-03-16 11:20:33', 'admin', '2019-06-11 23:14:49', NULL);
INSERT INTO `sys_permission` VALUES ('7654fd49b2e86a2db8139552a2f8e670', 'edfa74d66e8ea63ea432c2910837b150', '公文发文', '/joa/JoaDocSendingList', 'modules/extbpm/joa/JoaDocSendingList', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-16 11:24:03', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('765dd244f37b804e3d00f475fd56149b', '63b551e81c5956d5c861593d366d8c57', '流程监听', '/process/ExtActListenerList', 'modules/extbpm/process/ExtActListenerList', NULL, NULL, 1, NULL, NULL, 1.20, 0, NULL, 1, 1, 0, 0, NULL, NULL, 0, 0, 'admin', '2019-03-18 17:58:37', 'admin', '2019-09-23 15:55:13', 0);
INSERT INTO `sys_permission` VALUES ('7960961b0063228937da5fa8dd73d371', '2a470fc0c3954d9dbb61de6d80846549', 'JEditableTable示例', '/jeecg/JEditableTable', 'jeecg/JeecgEditableTableExample', NULL, NULL, 1, NULL, NULL, 7.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-03-22 15:22:18', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('7ac9eb9ccbde2f7a033cd4944272bf1e', '540a2936940846cb98114ffb0d145cb8', '卡片列表', '/list/card', 'list/CardList', NULL, NULL, 1, NULL, NULL, 7.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('7d08d3885671cf0ff1c4fe5d82fcd0e2', 'e41b69c57a941a3bbcce45032fe57605', 'Online图表配置', '/online/graphreport', 'modules/online/graphreport/OnlGraphreportHeadList', NULL, NULL, 1, NULL, NULL, 3.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-10 10:33:14', 'admin', '2019-04-10 10:33:53', NULL);
INSERT INTO `sys_permission` VALUES ('8200f83bcfa7b44190f4c15d805b3bf8', 'edfa74d66e8ea63ea432c2910837b150', '请假申请', '/joa/JoaEmployeeLeaveList', 'modules/extbpm/joa/JoaEmployeeLeaveList', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-10 14:20:32', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('841057b8a1bef8f6b4b20f9a618a7fa6', '08e6b9dc3c04489c8e1ff2ce6f105aa4', '数据日志', '/sys/dataLog-list', 'system/DataLogList', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-03-11 19:26:49', 'admin', '2019-03-12 11:40:47', NULL);
INSERT INTO `sys_permission` VALUES ('882a73768cfd7f78f3a37584f7299656', '6e73eb3c26099c191bf03852ee1310a1', '个性化设置', '/account/settings/custom', 'account/settings/Custom', NULL, NULL, 1, 'CustomSettings', NULL, NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2018-12-26 19:00:46', NULL, '2018-12-26 21:13:25', NULL);
INSERT INTO `sys_permission` VALUES ('8b3bff2eee6f1939147f5c68292a1642', '700b7f95165c46cc7a78bf227aa8fed3', '服务器信息', '/monitor/SystemInfo', 'modules/monitor/SystemInfo', NULL, NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-02 11:39:19', 'admin', '2019-04-02 15:40:02', NULL);
INSERT INTO `sys_permission` VALUES ('8d1ebd663688965f1fd86a2f0ead3416', '700b7f95165c46cc7a78bf227aa8fed3', 'Redis监控', '/monitor/redis/info', 'modules/monitor/RedisInfo', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-02 13:11:33', 'admin', '2019-05-07 15:18:54', NULL);
INSERT INTO `sys_permission` VALUES ('8d4683aacaa997ab86b966b464360338', 'e41b69c57a941a3bbcce45032fe57605', 'Online表单开发', '/online/cgform', 'modules/online/cgform/OnlCgformHeadList', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 0, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-03-12 15:48:14', 'admin', '2019-06-11 14:19:17', NULL);
INSERT INTO `sys_permission` VALUES ('8fb8172747a78756c11916216b8b8066', '717f6bee46f44a3897eca9abd6e2ec44', '工作台', '/dashboard/workplace', 'dashboard/Workplace', NULL, NULL, 1, NULL, NULL, 3.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', 'admin', '2019-04-02 11:45:02', NULL);
INSERT INTO `sys_permission` VALUES ('90c79e5009514eb7503a77bce5480e9e', '2b0459d0823b8cc6f0e4cce3463ed3a8', '用户账号显示', NULL, NULL, NULL, NULL, 2, 'online:air_china_persion_config:account', '1', 1.00, 0, NULL, 0, 1, NULL, 0, NULL, '1', 0, 0, 'admin', '2019-05-11 18:38:39', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('91c23960fab49335831cf43d820b0a61', 'e41b69c57a941a3bbcce45032fe57605', '在线数据报表2', '/online/cgreport/402880ec5d872157015d87f2dd940010', 'modules/online/cgreport/auto/OnlCgreportAutoList', NULL, NULL, 1, NULL, NULL, 25.00, 0, NULL, 0, 1, 0, 0, NULL, NULL, 0, 0, 'admin', '2019-03-20 13:26:52', 'admin', '2019-10-03 15:42:39', 0);
INSERT INTO `sys_permission` VALUES ('93d5cfb4448f11e9916698e7f462b4b6', 'e41b69c57a941a3bbcce45032fe57605', '动态表单', '/jeecg/jeecgOnlineTest', 'jeecg/online/JeecgOnlineTest', NULL, NULL, 1, NULL, NULL, 8.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, NULL, '2019-03-12 14:26:29', 'admin', '2019-04-12 22:38:57', NULL);
INSERT INTO `sys_permission` VALUES ('944abf0a8fc22fe1f1154a389a574154', '5c8042bd6c601270b2bbd9b20bccc68b', '消息管理', '/modules/message/sysMessageList', 'modules/message/SysMessageList', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-09 11:27:53', 'admin', '2019-04-09 19:31:23', NULL);
INSERT INTO `sys_permission` VALUES ('96dfaf38ff6625dd7ffc57e2b6b53f51', '98ab93226c45e39dc2bc9aa67b377183', '表单设计器模板', '/online/desformTemplate', 'modules/online/desform/DesignFormTempletList', NULL, NULL, 1, NULL, '1', 3.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2019-06-03 18:24:09', 'admin', '2019-07-23 10:05:42', NULL);
INSERT INTO `sys_permission` VALUES ('97c8629abc7848eccdb6d77c24bb3ebb', '700b7f95165c46cc7a78bf227aa8fed3', '磁盘监控', '/monitor/Disk', 'modules/monitor/DiskMonitoring', NULL, NULL, 1, NULL, NULL, 6.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-25 14:30:06', 'admin', '2019-05-05 14:37:14', NULL);
INSERT INTO `sys_permission` VALUES ('98ab93226c45e39dc2bc9aa67b377183', '', '表单设计', '/desform', 'layouts/RouteView', NULL, '2', 0, NULL, '1', 3.50, 0, 'gold', 1, 0, 0, 0, NULL, '1', 0, 0, 'admin', '2019-05-28 09:59:50', 'admin', '2019-09-23 16:01:25', 0);
INSERT INTO `sys_permission` VALUES ('9a90363f216a6a08f32eecb3f0bf12a3', '2a470fc0c3954d9dbb61de6d80846549', '常用封装组件', '/jeecg/SelectDemo', 'jeecg/SelectDemo', NULL, NULL, 1, NULL, NULL, 0.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-03-19 11:19:05', 'admin', '2019-07-01 18:23:56', NULL);
INSERT INTO `sys_permission` VALUES ('9fe26464838de2ea5e90f2367e35efa0', 'e41b69c57a941a3bbcce45032fe57605', 'AUTO在线报表', '/online/cgreport/:code', 'modules/online/cgreport/auto/OnlCgreportAutoList', 'onlineAutoList', NULL, 1, NULL, NULL, 9.00, 0, NULL, 1, 1, NULL, 1, NULL, NULL, 0, 0, 'admin', '2019-03-12 11:06:48', 'admin', '2019-04-30 18:19:10', NULL);
INSERT INTO `sys_permission` VALUES ('a1630fadfe194a5cd36d1ad0075ac525', '3f915b2769fc80648e92d04e84ca059d', '编辑用户', NULL, NULL, NULL, NULL, 2, 'user:edit', '1', 1.00, 0, NULL, 1, 1, NULL, 0, NULL, '1', 0, 0, 'admin', '2019-04-24 22:43:37', 'admin', '2019-05-13 17:22:12', NULL);
INSERT INTO `sys_permission` VALUES ('a2b11669e98c5fe54a53c3e3c4f35d14', 'f0675b52d89100ee88472b6800754a08', '类别统计报表', '/report/Analysis', 'jeecg/report/Analysis', NULL, '', 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-03 19:03:56', 'admin', '2019-04-03 19:05:26', NULL);
INSERT INTO `sys_permission` VALUES ('a400e4f4d54f79bf5ce160ae432231af', '2a470fc0c3954d9dbb61de6d80846549', '百度', 'http://www.baidu.com', 'layouts/IframePageView', NULL, NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-01-29 19:44:06', 'admin', '2019-02-15 16:25:02', NULL);
INSERT INTO `sys_permission` VALUES ('a44c30db536349e91106223957e684eb', '', '流程管理', '/bpm', 'layouts/RouteView', NULL, NULL, 0, NULL, NULL, 3.20, 0, 'cluster', 1, 0, 0, 0, NULL, NULL, 0, 0, 'admin', '2019-03-06 15:56:50', 'admin', '2019-09-23 16:00:03', 0);
INSERT INTO `sys_permission` VALUES ('a4fc7b64b01a224da066bb16230f9c5a', 'a44c30db536349e91106223957e684eb', '流程实例', '/modules/bpm/ProcessInstanceList', 'modules/bpm/ProcessInstanceList', NULL, NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-03-07 19:14:37', 'admin', '2019-04-12 23:19:11', NULL);
INSERT INTO `sys_permission` VALUES ('a8ee330fb0cb867340101717e54998b5', 'e41b69c57a941a3bbcce45032fe57605', 'AUTO表单列表', '/online/desform/list/:code', 'modules/online/desform/auto/AutoDesignDataForm', NULL, NULL, 1, NULL, '1', 99.00, 0, NULL, 1, 1, NULL, 1, NULL, '1', 0, 0, 'admin', '2019-05-17 18:12:39', 'admin', '2019-05-18 16:33:48', NULL);
INSERT INTO `sys_permission` VALUES ('abb2641990431ea1d4b638e16933fbb5', 'e41b69c57a941a3bbcce45032fe57605', 'AUTO在线图表', '/online/graphreport/chart/:code', 'modules/online/graphreport/auto/OnlGraphreportAutoChart', NULL, NULL, 1, NULL, NULL, 9.00, 0, NULL, 1, 1, NULL, 1, NULL, NULL, 0, 0, 'admin', '2019-04-15 22:08:10', 'admin', '2019-04-30 18:19:18', NULL);
INSERT INTO `sys_permission` VALUES ('abd50036ff42f0a9943ace7eb63c63b6', 'baf16b7174bd821b6bab23fa9abb200d', '我发起流程', '/bpm/task/MyApplyProcessList', 'modules/bpm/task/MyApplyProcessList', NULL, NULL, 1, NULL, NULL, 5.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-02 17:16:46', 'admin', '2019-04-12 23:20:06', NULL);
INSERT INTO `sys_permission` VALUES ('ae491565af973985d044b911e57ecbfc', '3560fc68c74f72b4260ffee65b373c82', '个人标准积分', '/online/cgformList/e2faf977fdaf4b25a524f58c2441a51c', 'modules/online/cgform/auto/OnlCgformAutoList', NULL, NULL, 1, NULL, NULL, 3.00, 0, NULL, 0, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-24 17:43:18', 'admin', '2019-04-24 17:44:02', NULL);
INSERT INTO `sys_permission` VALUES ('ae4fed059f67086fd52a73d913cf473d', '540a2936940846cb98114ffb0d145cb8', '内联编辑表格', '/list/edit-table', 'list/TableInnerEditList', NULL, NULL, 1, NULL, NULL, 2.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('aedbf679b5773c1f25e9f7b10111da73', '08e6b9dc3c04489c8e1ff2ce6f105aa4', 'SQL监控', '{{ window._CONFIG[\'domianURL\'] }}/druid/', 'layouts/IframePageView', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, 0, 0, NULL, NULL, 0, 0, 'admin', '2019-01-30 09:43:22', 'admin', '2019-09-08 14:32:35', 1);
INSERT INTO `sys_permission` VALUES ('b1cb0a3fedf7ed0e4653cb5a229837ee', '08e6b9dc3c04489c8e1ff2ce6f105aa4', '定时任务', '/isystem/QuartzJobList', 'system/QuartzJobList', NULL, NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, 0, 0, NULL, NULL, 0, 0, NULL, '2019-01-03 09:38:52', 'admin', '2019-09-25 15:47:04', 0);
INSERT INTO `sys_permission` VALUES ('b3c824fc22bd953e2eb16ae6914ac8f9', '4875ebe289344e14844d8e3ea1edd73f', '高级详情页', '/profile/advanced', 'profile/advanced/Advanced', NULL, NULL, 1, NULL, NULL, 2.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('b4dfc7d5dd9e8d5b6dd6d4579b1aa559', 'c65321e57b7949b7a975313220de0422', '500', '/exception/500', 'exception/500', NULL, NULL, 1, NULL, NULL, 3.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('b6bcee2ccc854052d3cc3e9c96d90197', '71102b3b87fb07e5527bbd2c530dd90a', '加班申请', '/modules/extbpm/joa/JoaOvertimeList', 'modules/extbpm/joa/JoaOvertimeList', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-03 15:33:10', 'admin', '2019-04-03 15:34:48', NULL);
INSERT INTO `sys_permission` VALUES ('bae8992dc6f39b1736d65ef251fa68c2', '09e7db25b4555332333f83afdadc7897', '我的办公', '/extbpm/process/ExtActDesignFlowDataList', 'modules/extbpm/process/ExtActDesignFlowDataList', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2019-06-26 15:22:10', 'admin', '2019-07-05 20:52:56', NULL);
INSERT INTO `sys_permission` VALUES ('baf16b7174bd821b6bab23fa9abb200d', '', '个人办公', '/task', 'layouts/RouteView', NULL, NULL, 0, NULL, NULL, 1.00, 0, 'share-alt', 1, 0, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-03-31 22:18:42', 'admin', '2019-05-13 17:20:52', NULL);
INSERT INTO `sys_permission` VALUES ('c3b050978256957869d860d066bf4049', '98ab93226c45e39dc2bc9aa67b377183', '表单设计器', '/online/desform', 'modules/online/desform/DesignFormList', NULL, NULL, 1, NULL, '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2019-05-16 16:27:26', 'admin', '2019-10-08 11:27:32', 0);
INSERT INTO `sys_permission` VALUES ('c431130c0bc0ec71b0a5be37747bb36a', '2a470fc0c3954d9dbb61de6d80846549', '一对多JEditable', '/jeecg/JeecgOrderMainListForJEditableTable', 'jeecg/JeecgOrderMainListForJEditableTable', NULL, NULL, 1, NULL, NULL, 2.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-03-29 10:51:59', 'admin', '2019-07-01 18:22:22', NULL);
INSERT INTO `sys_permission` VALUES ('c479cd37394b5694ce5cc3aad2caa590', '3560fc68c74f72b4260ffee65b373c82', '物料管理', '/online/cgformList/1acb6f81a1d9439da6cc4e868617b565', 'modules/online/cgform/auto/OnlCgformAutoList', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 0, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-24 17:38:50', 'admin', '2019-04-24 17:47:02', NULL);
INSERT INTO `sys_permission` VALUES ('c61197c4ee457601c1ad8b54721d8d69', '3f915b2769fc80648e92d04e84ca059d', '同步流程', NULL, NULL, NULL, NULL, 2, 'user:syncbpm', '1', NULL, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2019-07-10 12:02:22', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('c65321e57b7949b7a975313220de0422', NULL, '异常页', '/exception', 'layouts/RouteView', NULL, NULL, 0, NULL, NULL, 8.00, NULL, 'warning', 1, 0, NULL, NULL, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('c6cf95444d80435eb37b2f9db3971ae6', '2a470fc0c3954d9dbb61de6d80846549', '数据回执模拟', '/jeecg/InterfaceTest', 'jeecg/InterfaceTest', NULL, NULL, 1, NULL, NULL, 6.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-02-19 16:02:23', 'admin', '2019-02-21 16:25:45', NULL);
INSERT INTO `sys_permission` VALUES ('cab5a60d58871cff3d5858e4d2580a26', '09e7db25b4555332333f83afdadc7897', 'OA申请单', '/extbpm/process/BpmAutoDesformApply', 'modules/extbpm/process/BpmAutoDesformApply', NULL, NULL, 1, NULL, '1', 0.00, 0, NULL, 1, 1, 0, 0, NULL, '1', 0, 0, 'admin', '2019-07-05 17:28:29', 'admin', '2019-07-05 20:52:44', NULL);
INSERT INTO `sys_permission` VALUES ('cc50656cf9ca528e6f2150eba4714ad2', '4875ebe289344e14844d8e3ea1edd73f', '基础详情页', '/profile/basic', 'profile/basic/Index', NULL, NULL, 1, NULL, NULL, 1.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('d07a2c87a451434c99ab06296727ec4f', '700b7f95165c46cc7a78bf227aa8fed3', 'JVM信息', '/monitor/JvmInfo', 'modules/monitor/JvmInfo', NULL, NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-01 23:07:48', 'admin', '2019-04-02 11:37:16', NULL);
INSERT INTO `sys_permission` VALUES ('d2bbf9ebca5a8fa2e227af97d2da7548', 'c65321e57b7949b7a975313220de0422', '404', '/exception/404', 'exception/404', NULL, NULL, 1, NULL, NULL, 2.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('d341b137e79b65edd6fc8f047f221a75', '3560fc68c74f72b4260ffee65b373c82', '岗位标准积分', '/online/cgformList/e67d26b610dd414c884c4dbb24e71ce3', 'modules/online/cgform/auto/OnlCgformAutoList', NULL, NULL, 1, NULL, NULL, 2.00, 0, NULL, 0, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-24 17:42:53', 'admin', '2019-04-24 19:27:14', NULL);
INSERT INTO `sys_permission` VALUES ('d7d6e2e4e2934f2c9385a623fd98c6f3', '', '系统管理', '/isystem', 'layouts/RouteView', NULL, NULL, 0, NULL, NULL, 5.00, 0, 'setting', 1, 0, 0, 0, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', 'admin', '2019-09-25 11:29:18', 0);
INSERT INTO `sys_permission` VALUES ('d86f58e7ab516d3bc6bfb1fe10585f97', '717f6bee46f44a3897eca9abd6e2ec44', '个人中心', '/account/center', 'account/center/Index', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, 0, 0, NULL, NULL, 0, 1, NULL, '2018-12-25 20:34:38', 'e9ca23d68d884d4ebb19d07889727dae', '2022-08-01 16:12:44', 0);
INSERT INTO `sys_permission` VALUES ('de13e0f6328c069748de7399fcc1dbbd', 'fb07ca05a3e13674dbf6d3245956da2e', '搜索列表（项目）', '/list/search/project', 'list/TableList', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-02-12 14:01:40', 'admin', '2019-02-12 14:14:18', NULL);
INSERT INTO `sys_permission` VALUES ('de89c46e0acb9687e1133d44d45b3491', 'a44c30db536349e91106223957e684eb', '历史任务', '/bpm/task/HisTaskList', 'modules/bpm/task/HisTaskList', NULL, NULL, 1, NULL, NULL, 7.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-02 17:20:57', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('e08cb190ef230d5d4f03824198773950', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '系统通告', '/isystem/annountCement', 'system/SysAnnouncementList', NULL, NULL, 1, 'annountCement', NULL, 6.00, NULL, '', 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2019-01-02 17:23:01', NULL, '2019-01-02 17:31:23', NULL);
INSERT INTO `sys_permission` VALUES ('e1979bb53e9ea51cecc74d86fd9d2f64', '2a470fc0c3954d9dbb61de6d80846549', 'PDF预览', '/jeecg/jeecgPdfView', 'jeecg/JeecgPdfView', NULL, NULL, 1, NULL, NULL, 9.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-25 10:39:35', 'admin', '2019-04-25 18:31:36', NULL);
INSERT INTO `sys_permission` VALUES ('e3c13679c73a4f829bcff2aba8fd68b1', '', '表单页', '/form', 'layouts/PageView', NULL, NULL, 0, NULL, NULL, 9.00, 0, 'form', 1, 0, NULL, 0, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', 'admin', '2019-03-31 22:20:14', NULL);
INSERT INTO `sys_permission` VALUES ('e41b69c57a941a3bbcce45032fe57605', '', '在线开发', '/online', 'layouts/RouteView', NULL, NULL, 0, NULL, NULL, 4.00, 0, 'cloud', 1, 0, 0, 0, NULL, NULL, 0, 0, 'admin', '2019-03-08 10:43:10', 'admin', '2019-09-25 11:29:08', 0);
INSERT INTO `sys_permission` VALUES ('e4335a37647952a691fd609ee6f92168', 'baf16b7174bd821b6bab23fa9abb200d', '我的抄送', '/bpm/task/MyCcHisProcessList', 'modules/bpm/task/MyCcHisProcessList', NULL, NULL, 1, NULL, NULL, 6.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-02 17:19:51', 'admin', '2019-04-12 23:21:04', NULL);
INSERT INTO `sys_permission` VALUES ('e47142f2d104aa7f1ba0f9d360226be8', 'f4b0985a992eca541c1914a118669f44', '年度同比报表', '{{ window._CONFIG[\'domianURL\'] }}/ReportServer?reportlet=kunl_re1.cpt', 'layouts/IframeFReportView', NULL, NULL, 1, NULL, NULL, 3.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-29 16:55:17', 'admin', '2019-04-29 20:15:19', NULL);
INSERT INTO `sys_permission` VALUES ('e5973686ed495c379d829ea8b2881fc6', 'e3c13679c73a4f829bcff2aba8fd68b1', '高级表单', '/form/advanced-form', 'form/advancedForm/AdvancedForm', NULL, NULL, 1, NULL, NULL, 3.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('e6bfd1fcabfd7942fdd05f076d1dad38', '2a470fc0c3954d9dbb61de6d80846549', '打印测试', '/jeecg/PrintDemo', 'jeecg/PrintDemo', NULL, NULL, 1, NULL, NULL, 3.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-02-19 15:58:48', 'admin', '2019-05-07 20:14:39', NULL);
INSERT INTO `sys_permission` VALUES ('e8af452d8948ea49d37c934f5100ae6a', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '角色管理', '/isystem/role', 'system/RoleList', NULL, NULL, 1, NULL, NULL, 2.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('ebb9d82ea16ad864071158e0c449d186', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '分类字典', '/isys/category', 'system/SysCategoryList', NULL, NULL, 1, NULL, '1', 5.00, 0, NULL, 1, 1, NULL, 0, NULL, '1', 0, 0, 'admin', '2019-05-29 18:48:07', 'admin', '2019-05-29 18:48:27', NULL);
INSERT INTO `sys_permission` VALUES ('ec8d607d0156e198b11853760319c646', '6e73eb3c26099c191bf03852ee1310a1', '安全设置', '/account/settings/security', 'account/settings/Security', NULL, NULL, 1, 'SecuritySettings', NULL, NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2018-12-26 18:59:52', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('edfa74d66e8ea63ea432c2910837b150', '', '业务办理', '/biz', 'layouts/RouteView', NULL, NULL, 0, NULL, NULL, 1.00, 0, 'cluster', 1, 0, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-03-26 18:35:03', 'admin', '2019-05-15 23:16:18', NULL);
INSERT INTO `sys_permission` VALUES ('f0675b52d89100ee88472b6800754a08', '', '统计报表', '/report', 'layouts/RouteView', NULL, NULL, 0, NULL, NULL, 5.10, 0, 'bar-chart', 1, 0, 0, 0, NULL, NULL, 0, 0, 'admin', '2019-04-03 18:32:02', 'admin', '2019-09-25 11:29:34', 0);
INSERT INTO `sys_permission` VALUES ('f15543b0263cf6c5fac85afdd3eba3f2', '3f915b2769fc80648e92d04e84ca059d', '导入请求', '', NULL, NULL, NULL, 2, 'user:import', '1', 1.00, 0, NULL, 0, 1, NULL, 0, NULL, '1', 0, 0, 'admin', '2019-05-13 19:15:27', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('f1cb187abf927c88b89470d08615f5ac', 'd7d6e2e4e2934f2c9385a623fd98c6f3', '数据字典', '/isystem/dict', 'system/DictList', NULL, NULL, 1, NULL, NULL, 5.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2018-12-28 13:54:43', NULL, '2018-12-28 15:37:54', NULL);
INSERT INTO `sys_permission` VALUES ('f23d9bfff4d9aa6b68569ba2cff38415', '540a2936940846cb98114ffb0d145cb8', '标准列表', '/list/basic-list', 'list/StandardList', NULL, NULL, 1, NULL, NULL, 6.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', NULL, NULL, NULL);
INSERT INTO `sys_permission` VALUES ('f2849d3814fc97993bfc519ae6bbf049', 'e41b69c57a941a3bbcce45032fe57605', 'AUTO复制表单', '/online/copyform/:code', 'modules/online/cgform/OnlCgformCopyList', NULL, NULL, 1, NULL, '1', 10.00, 0, NULL, 1, 1, 0, 1, NULL, '1', 0, 0, 'admin', '2019-08-29 16:05:37', 'admin', '2019-10-03 15:27:41', 0);
INSERT INTO `sys_permission` VALUES ('f4b0985a992eca541c1914a118669f44', '', '业务报表', '/kunlun', 'layouts/RouteView', NULL, '/kunlun', 0, NULL, NULL, 5.20, 0, 'sliders', 1, 0, 0, 0, NULL, NULL, 0, 0, 'admin', '2019-04-29 20:08:11', 'admin', '2019-09-25 11:29:44', 0);
INSERT INTO `sys_permission` VALUES ('f780d0d3083d849ccbdb1b1baee4911d', '5c8042bd6c601270b2bbd9b20bccc68b', '模板管理', '/modules/message/sysMessageTemplateList', 'modules/message/SysMessageTemplateList', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 0, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-09 11:50:31', 'admin', '2019-04-12 22:40:22', NULL);
INSERT INTO `sys_permission` VALUES ('f842bc13739eccaba52e01105ce40055', 'e41b69c57a941a3bbcce45032fe57605', 'AUTO表单浏览', '/online/desform/view/:desformId', 'modules/online/desform/PreviewDesform', NULL, NULL, 1, NULL, '1', 99.00, 0, NULL, 1, 1, NULL, 1, NULL, '1', 0, 0, 'admin', '2019-05-18 16:08:05', 'admin', '2019-05-18 17:23:32', NULL);
INSERT INTO `sys_permission` VALUES ('f9d3f4f27653a71c52faa9fb8070fbe7', '63b551e81c5956d5c861593d366d8c57', '流程设计', '/process/ExtActProcessList', 'modules/extbpm/process/ExtActProcessList', NULL, NULL, 1, NULL, NULL, 1.10, 0, NULL, 1, 1, 0, 0, NULL, NULL, 0, 0, 'admin', '2019-03-15 16:35:24', 'admin', '2019-09-23 15:54:58', 0);
INSERT INTO `sys_permission` VALUES ('fb07ca05a3e13674dbf6d3245956da2e', '540a2936940846cb98114ffb0d145cb8', '搜索列表', '/list/search', 'list/search/SearchLayout', NULL, '/list/search/article', 1, NULL, NULL, 8.00, 0, NULL, 1, 0, NULL, 0, NULL, NULL, 0, 0, NULL, '2018-12-25 20:34:38', 'admin', '2019-02-12 15:09:13', NULL);
INSERT INTO `sys_permission` VALUES ('fb367426764077dcf94640c843733985', '2a470fc0c3954d9dbb61de6d80846549', '一对多示例', '/jeecg/JeecgOrderMainList', 'jeecg/JeecgOrderMainList', NULL, NULL, 1, NULL, NULL, 2.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-02-15 16:24:11', 'admin', '2019-02-18 10:50:14', NULL);
INSERT INTO `sys_permission` VALUES ('fba41089766888023411a978d13c0aa4', 'e41b69c57a941a3bbcce45032fe57605', 'AUTO树表单列表', '/online/cgformTreeList/:code', 'modules/online/cgform/auto/OnlCgformTreeList', NULL, NULL, 1, NULL, '1', 9.00, 0, NULL, 1, 1, NULL, 1, NULL, '1', 0, 0, 'admin', '2019-05-21 14:46:50', 'admin', '2019-06-11 13:52:52', NULL);
INSERT INTO `sys_permission` VALUES ('fc810a2267dd183e4ef7c71cc60f4670', '700b7f95165c46cc7a78bf227aa8fed3', '请求追踪', '/monitor/HttpTrace', 'modules/monitor/HttpTrace', NULL, NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, 0, 0, 'admin', '2019-04-02 09:46:19', 'admin', '2019-04-02 11:37:27', NULL);
INSERT INTO `sys_permission` VALUES ('fedfbf4420536cacc0218557d263dfea', '6e73eb3c26099c191bf03852ee1310a1', '新消息通知', '/account/settings/notification', 'account/settings/Notification', NULL, NULL, 1, 'NotificationSettings', NULL, NULL, NULL, '', 1, 1, NULL, NULL, NULL, NULL, 0, 0, NULL, '2018-12-26 19:02:05', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_permission_data_rule
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission_data_rule`;
CREATE TABLE `sys_permission_data_rule`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ID',
  `permission_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单ID',
  `rule_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规则名称',
  `rule_column` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段',
  `rule_conditions` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '条件',
  `rule_value` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规则值',
  `status` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限有效状态1有0否',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_fucntionid`(`permission_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_permission_data_rule
-- ----------------------------

-- ----------------------------
-- Table structure for sys_position
-- ----------------------------
DROP TABLE IF EXISTS `sys_position`;
CREATE TABLE `sys_position`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务编码',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务名称',
  `rank` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职级',
  `company_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司id',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `sys_org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组织机构编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_position
-- ----------------------------
INSERT INTO `sys_position` VALUES ('1174965375630163970', '001', '市委市政府领导', '5', NULL, 'admin', '2019-09-20 16:35:50', 'admin', '2019-09-20 16:36:15', 'A01');
INSERT INTO `sys_position` VALUES ('1174965446048333825', '002', '两办总值班室领导', '4', NULL, 'admin', '2019-09-20 16:36:07', 'admin', '2019-09-20 16:36:25', 'A01');
INSERT INTO `sys_position` VALUES ('1534882728298569730', '003', '两办总值班室工作人员', '3', NULL, 'admin', '2022-06-09 20:58:54', NULL, NULL, 'A01A01A01');
INSERT INTO `sys_position` VALUES ('1534882822741712897', '004', '区县总值班室工作人员', '1', NULL, 'admin', '2022-06-09 20:59:16', NULL, NULL, 'A01A01A01');
INSERT INTO `sys_position` VALUES ('1536909431237664769', '005', '值班人员', '1', NULL, 'admin', '2022-06-15 11:12:17', NULL, NULL, 'A01A01A02');
INSERT INTO `sys_position` VALUES ('1537047544748060673', '006', '区县值班室领导', '3', NULL, 'admin', '2022-06-15 20:21:06', NULL, NULL, 'A01A01A02');
INSERT INTO `sys_position` VALUES ('1537049767666266114', '007', '区值班室干部', '2', NULL, 'admin', '2022-06-15 20:29:56', NULL, NULL, 'A01A01A02');
INSERT INTO `sys_position` VALUES ('1630746181953929217', 'qxcy', '区县城运排班工作人员', '1', NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_quartz_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_quartz_job`;
CREATE TABLE `sys_quartz_job`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `del_flag` int(11) NULL DEFAULT NULL COMMENT '删除状态',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `job_class_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务类名',
  `cron_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'cron表达式',
  `parameter` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `status` int(11) NULL DEFAULT NULL COMMENT '状态 0正常 -1停止',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_quartz_job
-- ----------------------------
INSERT INTO `sys_quartz_job` VALUES ('df26ecacf0f75d219d746750fe84bbee', NULL, NULL, 0, 'admin', '2019-01-19 15:09:41', 'org.jeecg.modules.quartz.job.SampleParamJob', '0/2 * * * * ?', 'scott', '带参测试 后台将每隔1秒执行输出日志', -1);
INSERT INTO `sys_quartz_job` VALUES ('46defab8bd993eef7fe6197054cab806', 'admin', '2019-04-28 14:12:24', 0, 'admin', '2019-04-28 14:12:28', 'org.jeecg.modules.quartz.job.SampleJob', '0/1 * * * * ?', NULL, NULL, -1);
INSERT INTO `sys_quartz_job` VALUES ('5b3d2c087ad41aa755fc4f89697b01e7', 'admin', '2019-04-11 19:04:21', 0, 'admin', '2019-04-11 19:49:49', 'org.jeecg.modules.message.job.SendMsgJob', '0 0/1 * * * ?', NULL, '系统往外推送消息定时任务（短信、邮件、微信等）', -1);
INSERT INTO `sys_quartz_job` VALUES ('950b0d1cfdc6e7c47b8442c9935d84b6', 'admin', '2019-04-17 18:54:35', 0, 'admin', '2019-04-17 18:54:55', 'org.jeecg.modules.extbpm.job.UserAgentJob', '0 0/1 * * * ?', NULL, '用户任务代理', -1);
INSERT INTO `sys_quartz_job` VALUES ('1177054012256657409', 'admin', '2019-09-26 10:55:20', 0, 'admin', '2019-09-26 10:58:09', 'org.jeecg.modules.eoa.plan.job.RemindJob', '0/3 * * * * ? *', '', '日程提醒定时任务', 0);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键id',
  `role_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `role_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色编码',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `index_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '首页地址',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `index_role_code`(`role_code` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1983067284573007874', '值班员', 'attendant', '/information/reportSignList', NULL, '2025-10-28 15:04:18', NULL, '2025-10-29 09:49:08', '/information/reportSignList');
INSERT INTO `sys_role` VALUES ('f6817f48af4fb3af11b9e8bf182f618b', '管理员', 'admin', '管理员', NULL, '2018-12-21 18:03:39', 'admin', '2022-07-13 21:09:27', '/dashboard/analysis');

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色id',
  `permission_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限id',
  `data_rule_ids` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_group_role_per_id`(`role_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `index_group_role_id`(`role_id` ASC) USING BTREE,
  INDEX `index_group_per_id`(`permission_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES ('019dd452314b4849312e2869b5cd8e16', 'f6817f48af4fb3af11b9e8bf182f618b', '76f9b623d8e362bf7005116271a067e0', NULL);
INSERT INTO `sys_role_permission` VALUES ('02e13fb47eef363ec1c79ffb342d323d', 'f6817f48af4fb3af11b9e8bf182f618b', '6523422a6c69a62d48dacf90932e5302', NULL);
INSERT INTO `sys_role_permission` VALUES ('039e4be0eb78b7da3529523642d49f13', 'f6817f48af4fb3af11b9e8bf182f618b', '0bbf8639ce155779594f2a9948978f10', NULL);
INSERT INTO `sys_role_permission` VALUES ('1168734943985082369', 'f6817f48af4fb3af11b9e8bf182f618b', '1168734866017165314', NULL);
INSERT INTO `sys_role_permission` VALUES ('1170617576058863617', 'f6817f48af4fb3af11b9e8bf182f618b', '1170592628746878978', NULL);
INSERT INTO `sys_role_permission` VALUES ('1174965107370868737', 'f6817f48af4fb3af11b9e8bf182f618b', '1174506953255182338', NULL);
INSERT INTO `sys_role_permission` VALUES ('1176679492208406529', 'f6817f48af4fb3af11b9e8bf182f618b', '1176679204206522369', NULL);
INSERT INTO `sys_role_permission` VALUES ('1176763223476629506', 'f6817f48af4fb3af11b9e8bf182f618b', '6c6a033650e64a14543a8a401d790093', NULL);
INSERT INTO `sys_role_permission` VALUES ('1177474758402478081', 'f6817f48af4fb3af11b9e8bf182f618b', '1176102874501984258', NULL);
INSERT INTO `sys_role_permission` VALUES ('1179659124519997441', 'f6817f48af4fb3af11b9e8bf182f618b', 'f2849d3814fc97993bfc519ae6bbf049', NULL);
INSERT INTO `sys_role_permission` VALUES ('1181410685478846465', 'f6817f48af4fb3af11b9e8bf182f618b', '96dfaf38ff6625dd7ffc57e2b6b53f51', NULL);
INSERT INTO `sys_role_permission` VALUES ('1526775966960013314', 'f6817f48af4fb3af11b9e8bf182f618b', '1526775641918230529', NULL);
INSERT INTO `sys_role_permission` VALUES ('1526775967152951298', 'f6817f48af4fb3af11b9e8bf182f618b', '1526775914543796226', NULL);
INSERT INTO `sys_role_permission` VALUES ('1526819865170661377', 'f6817f48af4fb3af11b9e8bf182f618b', '1526814321496084481', NULL);
INSERT INTO `sys_role_permission` VALUES ('1526911179476283393', 'f6817f48af4fb3af11b9e8bf182f618b', '1526911125638197250', NULL);
INSERT INTO `sys_role_permission` VALUES ('1527101382098698242', 'f6817f48af4fb3af11b9e8bf182f618b', '1527100512351043585', NULL);
INSERT INTO `sys_role_permission` VALUES ('1527200830648758274', 'f6817f48af4fb3af11b9e8bf182f618b', '1527200555208814593', NULL);
INSERT INTO `sys_role_permission` VALUES ('1527200830652952577', 'f6817f48af4fb3af11b9e8bf182f618b', '1527200755562328065', NULL);
INSERT INTO `sys_role_permission` VALUES ('1527248947913969665', 'f6817f48af4fb3af11b9e8bf182f618b', '1527248907900309505', NULL);
INSERT INTO `sys_role_permission` VALUES ('1531269914156830722', 'f6817f48af4fb3af11b9e8bf182f618b', 'f9d3f4f27653a71c52faa9fb8070fbe7', NULL);
INSERT INTO `sys_role_permission` VALUES ('1531269914156830723', 'f6817f48af4fb3af11b9e8bf182f618b', '765dd244f37b804e3d00f475fd56149b', NULL);
INSERT INTO `sys_role_permission` VALUES ('1531269914156830724', 'f6817f48af4fb3af11b9e8bf182f618b', '732d48f8e0abe99fe6a23d18a3171cd1', NULL);
INSERT INTO `sys_role_permission` VALUES ('1531269914156830725', 'f6817f48af4fb3af11b9e8bf182f618b', '191e453f3de11d56cd376679958bcea2', NULL);
INSERT INTO `sys_role_permission` VALUES ('1531269914161025025', 'f6817f48af4fb3af11b9e8bf182f618b', 'de89c46e0acb9687e1133d44d45b3491', NULL);
INSERT INTO `sys_role_permission` VALUES ('1531269914161025026', 'f6817f48af4fb3af11b9e8bf182f618b', 'a4fc7b64b01a224da066bb16230f9c5a', NULL);
INSERT INTO `sys_role_permission` VALUES ('1531549166008168450', 'f6817f48af4fb3af11b9e8bf182f618b', '1531231934331457537', NULL);
INSERT INTO `sys_role_permission` VALUES ('1531549166020751361', 'f6817f48af4fb3af11b9e8bf182f618b', '1531232089080303617', NULL);
INSERT INTO `sys_role_permission` VALUES ('1531559324331167746', 'f6817f48af4fb3af11b9e8bf182f618b', '1531559225232347137', NULL);
INSERT INTO `sys_role_permission` VALUES ('1531559752456359938', 'f6817f48af4fb3af11b9e8bf182f618b', '1531559679479664642', NULL);
INSERT INTO `sys_role_permission` VALUES ('1531910408386392065', 'f6817f48af4fb3af11b9e8bf182f618b', '1531909548084310018', NULL);
INSERT INTO `sys_role_permission` VALUES ('1531910408386392066', 'f6817f48af4fb3af11b9e8bf182f618b', '1531909913546600450', NULL);
INSERT INTO `sys_role_permission` VALUES ('1531910408390586369', 'f6817f48af4fb3af11b9e8bf182f618b', '1531910209106620417', NULL);
INSERT INTO `sys_role_permission` VALUES ('1531980121068179458', 'f6817f48af4fb3af11b9e8bf182f618b', '1174590283938041857', NULL);
INSERT INTO `sys_role_permission` VALUES ('1532182500875079682', 'f6817f48af4fb3af11b9e8bf182f618b', '1939e035e803a99ceecb6f5563570fb2', NULL);
INSERT INTO `sys_role_permission` VALUES ('1532182500875079683', 'f6817f48af4fb3af11b9e8bf182f618b', 'abd50036ff42f0a9943ace7eb63c63b6', NULL);
INSERT INTO `sys_role_permission` VALUES ('1532182500883468289', 'f6817f48af4fb3af11b9e8bf182f618b', 'e4335a37647952a691fd609ee6f92168', NULL);
INSERT INTO `sys_role_permission` VALUES ('1533632304185163777', 'f6817f48af4fb3af11b9e8bf182f618b', '1533631589450596353', NULL);
INSERT INTO `sys_role_permission` VALUES ('1533632304201940994', 'f6817f48af4fb3af11b9e8bf182f618b', '1533631742416863233', NULL);
INSERT INTO `sys_role_permission` VALUES ('1533632304201940995', 'f6817f48af4fb3af11b9e8bf182f618b', '1533632024915820545', NULL);
INSERT INTO `sys_role_permission` VALUES ('1533632304201940996', 'f6817f48af4fb3af11b9e8bf182f618b', '1533632216142528513', NULL);
INSERT INTO `sys_role_permission` VALUES ('1534516466736148482', 'f6817f48af4fb3af11b9e8bf182f618b', '1534516284275535873', NULL);
INSERT INTO `sys_role_permission` VALUES ('1536242620618743810', 'f6817f48af4fb3af11b9e8bf182f618b', 'e41b69c57a941a3bbcce45032fe57605', NULL);
INSERT INTO `sys_role_permission` VALUES ('1536536934909349889', 'f6817f48af4fb3af11b9e8bf182f618b', '1536534252509335553', NULL);
INSERT INTO `sys_role_permission` VALUES ('1536536934909349890', 'f6817f48af4fb3af11b9e8bf182f618b', '1536534573105156097', NULL);
INSERT INTO `sys_role_permission` VALUES ('1536536934976458754', 'f6817f48af4fb3af11b9e8bf182f618b', '1536535063935193090', NULL);
INSERT INTO `sys_role_permission` VALUES ('1536536934976458755', 'f6817f48af4fb3af11b9e8bf182f618b', '1536535560624672769', NULL);
INSERT INTO `sys_role_permission` VALUES ('1536536934976458756', 'f6817f48af4fb3af11b9e8bf182f618b', '1536536008777666562', NULL);
INSERT INTO `sys_role_permission` VALUES ('1536536934976458757', 'f6817f48af4fb3af11b9e8bf182f618b', '1536536359895437313', NULL);
INSERT INTO `sys_role_permission` VALUES ('1536536934976458758', 'f6817f48af4fb3af11b9e8bf182f618b', '1536536628179898369', NULL);
INSERT INTO `sys_role_permission` VALUES ('1541666153182138370', 'f6817f48af4fb3af11b9e8bf182f618b', 'a44c30db536349e91106223957e684eb', NULL);
INSERT INTO `sys_role_permission` VALUES ('1541666153186332673', 'f6817f48af4fb3af11b9e8bf182f618b', '63b551e81c5956d5c861593d366d8c57', NULL);
INSERT INTO `sys_role_permission` VALUES ('1541963510213906433', 'f6817f48af4fb3af11b9e8bf182f618b', '1541963267527282690', NULL);
INSERT INTO `sys_role_permission` VALUES ('1543872527476621313', 'f6817f48af4fb3af11b9e8bf182f618b', '1543872404432519169', NULL);
INSERT INTO `sys_role_permission` VALUES ('1547166508111925249', 'f6817f48af4fb3af11b9e8bf182f618b', '1547166393183801346', NULL);
INSERT INTO `sys_role_permission` VALUES ('1547169194622357505', 'f6817f48af4fb3af11b9e8bf182f618b', '1547169113101864962', NULL);
INSERT INTO `sys_role_permission` VALUES ('1547458656384716801', 'f6817f48af4fb3af11b9e8bf182f618b', '1547458558128951298', NULL);
INSERT INTO `sys_role_permission` VALUES ('1549202286875254785', 'f6817f48af4fb3af11b9e8bf182f618b', '1548909504239509506', NULL);
INSERT INTO `sys_role_permission` VALUES ('1549276460597624834', 'f6817f48af4fb3af11b9e8bf182f618b', '1549272269711970305', NULL);
INSERT INTO `sys_role_permission` VALUES ('1551381810721828865', 'f6817f48af4fb3af11b9e8bf182f618b', '1551381649861881858', NULL);
INSERT INTO `sys_role_permission` VALUES ('1551823155676008450', 'f6817f48af4fb3af11b9e8bf182f618b', '1551823099912736770', NULL);
INSERT INTO `sys_role_permission` VALUES ('1554757298829131777', 'f6817f48af4fb3af11b9e8bf182f618b', '08e6b9dc3c04489c8e1ff2ce6f105aa4', NULL);
INSERT INTO `sys_role_permission` VALUES ('1554757298833326082', 'f6817f48af4fb3af11b9e8bf182f618b', 'b1cb0a3fedf7ed0e4653cb5a229837ee', NULL);
INSERT INTO `sys_role_permission` VALUES ('1556463017851756546', 'f6817f48af4fb3af11b9e8bf182f618b', '1556461882692739073', NULL);
INSERT INTO `sys_role_permission` VALUES ('1556463017851756547', 'f6817f48af4fb3af11b9e8bf182f618b', '1556462012057657346', NULL);
INSERT INTO `sys_role_permission` VALUES ('1557569409398857729', 'f6817f48af4fb3af11b9e8bf182f618b', '1557569366726008833', NULL);
INSERT INTO `sys_role_permission` VALUES ('1557603551352127490', 'f6817f48af4fb3af11b9e8bf182f618b', '1557603476425080833', NULL);
INSERT INTO `sys_role_permission` VALUES ('1577667334745649153', 'f6817f48af4fb3af11b9e8bf182f618b', '1577666863444291585', NULL);
INSERT INTO `sys_role_permission` VALUES ('1582625542322020353', 'f6817f48af4fb3af11b9e8bf182f618b', '1582625357877501954', NULL);
INSERT INTO `sys_role_permission` VALUES ('1594877847314608130', 'f6817f48af4fb3af11b9e8bf182f618b', '1594877658768060418', NULL);
INSERT INTO `sys_role_permission` VALUES ('1594877847318802433', 'f6817f48af4fb3af11b9e8bf182f618b', '1594877472880701441', NULL);
INSERT INTO `sys_role_permission` VALUES ('1597054533567139841', 'f6817f48af4fb3af11b9e8bf182f618b', '1597053932250746882', NULL);
INSERT INTO `sys_role_permission` VALUES ('1597054533567139842', 'f6817f48af4fb3af11b9e8bf182f618b', '1597054257091203073', NULL);
INSERT INTO `sys_role_permission` VALUES ('1602122195503759361', 'f6817f48af4fb3af11b9e8bf182f618b', '1602122141296574466', NULL);
INSERT INTO `sys_role_permission` VALUES ('1623225016081526785', 'f6817f48af4fb3af11b9e8bf182f618b', '1623224735260291074', NULL);
INSERT INTO `sys_role_permission` VALUES ('1628573514909847554', 'f6817f48af4fb3af11b9e8bf182f618b', '1628573451689103362', NULL);
INSERT INTO `sys_role_permission` VALUES ('1635096893144600577', 'f6817f48af4fb3af11b9e8bf182f618b', '1635096824664199169', NULL);
INSERT INTO `sys_role_permission` VALUES ('1646040829973110786', 'f6817f48af4fb3af11b9e8bf182f618b', '1646038793693044737', NULL);
INSERT INTO `sys_role_permission` VALUES ('1686616650034548738', 'f6817f48af4fb3af11b9e8bf182f618b', '1686616193430032386', NULL);
INSERT INTO `sys_role_permission` VALUES ('1686621332387762177', 'f6817f48af4fb3af11b9e8bf182f618b', '1686621083447431170', NULL);
INSERT INTO `sys_role_permission` VALUES ('1694537567674892290', 'f6817f48af4fb3af11b9e8bf182f618b', '1694537269673787393', NULL);
INSERT INTO `sys_role_permission` VALUES ('1729336461415784449', 'f6817f48af4fb3af11b9e8bf182f618b', '1729336251411177474', NULL);
INSERT INTO `sys_role_permission` VALUES ('1768166641612480514', 'f6817f48af4fb3af11b9e8bf182f618b', '1768166372325580801', NULL);
INSERT INTO `sys_role_permission` VALUES ('1822899789524660226', 'f6817f48af4fb3af11b9e8bf182f618b', '1822899435642843137', NULL);
INSERT INTO `sys_role_permission` VALUES ('1876144327260995585', 'f6817f48af4fb3af11b9e8bf182f618b', '1876144238232698882', NULL);
INSERT INTO `sys_role_permission` VALUES ('1892445352762359810', 'f6817f48af4fb3af11b9e8bf182f618b', '1892445302548152322', NULL);
INSERT INTO `sys_role_permission` VALUES ('1905555074722050049', 'f6817f48af4fb3af11b9e8bf182f618b', '1905554985752473602', NULL);
INSERT INTO `sys_role_permission` VALUES ('1945685141361729538', 'f6817f48af4fb3af11b9e8bf182f618b', '1945680202342277122', NULL);
INSERT INTO `sys_role_permission` VALUES ('1945685141374312449', 'f6817f48af4fb3af11b9e8bf182f618b', '1945680410342006785', NULL);
INSERT INTO `sys_role_permission` VALUES ('1947108397621764098', 'f6817f48af4fb3af11b9e8bf182f618b', '1947107392733634561', NULL);
INSERT INTO `sys_role_permission` VALUES ('1983074722579755010', '1983067284573007874', '1531909548084310018', NULL);
INSERT INTO `sys_role_permission` VALUES ('1983074722672029697', '1983067284573007874', '1531909913546600450', NULL);
INSERT INTO `sys_role_permission` VALUES ('1983074722672029698', '1983067284573007874', '1541963267527282690', NULL);
INSERT INTO `sys_role_permission` VALUES ('1983345070315524097', '1983067284573007874', '1536534573105156097', NULL);
INSERT INTO `sys_role_permission` VALUES ('1983345070378438657', '1983067284573007874', '1547458558128951298', NULL);
INSERT INTO `sys_role_permission` VALUES ('1983345070378438658', '1983067284573007874', '1536536628179898369', NULL);
INSERT INTO `sys_role_permission` VALUES ('1983350478069420033', '1983067284573007874', '1536534252509335553', NULL);
INSERT INTO `sys_role_permission` VALUES ('1c0e84e8a3a88874f4ce578cbb724230', 'f6817f48af4fb3af11b9e8bf182f618b', 'f15543b0263cf6c5fac85afdd3eba3f2', NULL);
INSERT INTO `sys_role_permission` VALUES ('1d8bd3d227b23b4e3135b96282787c9e', 'f6817f48af4fb3af11b9e8bf182f618b', 'a1630fadfe194a5cd36d1ad0075ac525', NULL);
INSERT INTO `sys_role_permission` VALUES ('205a89abfe643b2613102b6bbf78c8d3', 'f6817f48af4fb3af11b9e8bf182f618b', 'f1cb187abf927c88b89470d08615f5ac', NULL);
INSERT INTO `sys_role_permission` VALUES ('22a55f055a5182e8ffd1f9a5ba4023e8', 'f6817f48af4fb3af11b9e8bf182f618b', '2d83d62bd2544b8994c8f38cf17b0ddf', NULL);
INSERT INTO `sys_role_permission` VALUES ('35e97c6d967e41dbb8ab7b7118c00480', 'f6817f48af4fb3af11b9e8bf182f618b', 'f842bc13739eccaba52e01105ce40055', NULL);
INSERT INTO `sys_role_permission` VALUES ('3b9702e34497f94f2c9be1192f636092', 'f6817f48af4fb3af11b9e8bf182f618b', '3f915b2769fc80648e92d04e84ca059d', NULL);
INSERT INTO `sys_role_permission` VALUES ('4429fa335a77e9477e491ace4ee8c5ef', 'f6817f48af4fb3af11b9e8bf182f618b', 'c2c356bf4ddd29975347a7047a062440', NULL);
INSERT INTO `sys_role_permission` VALUES ('4cc94369995359fcb34db0c97385c805', 'f6817f48af4fb3af11b9e8bf182f618b', '9cb91b8851db0cf7b19d7ecc2a8193dd', NULL);
INSERT INTO `sys_role_permission` VALUES ('52bb8e6820bef1c7f467f44c81728f8e', 'f6817f48af4fb3af11b9e8bf182f618b', 'c61197c4ee457601c1ad8b54721d8d69', NULL);
INSERT INTO `sys_role_permission` VALUES ('67d8b8c5f9f9db2c334179aad668e9f8', 'f6817f48af4fb3af11b9e8bf182f618b', '109c78a583d4693ce2f16551b7786786', NULL);
INSERT INTO `sys_role_permission` VALUES ('6f1776cd3535335f74d82444e7c4093f', 'f6817f48af4fb3af11b9e8bf182f618b', '7d08d3885671cf0ff1c4fe5d82fcd0e2', NULL);
INSERT INTO `sys_role_permission` VALUES ('7aaf34576688756dcb273214a188df02', 'f6817f48af4fb3af11b9e8bf182f618b', 'a8ee330fb0cb867340101717e54998b5', NULL);
INSERT INTO `sys_role_permission` VALUES ('8057645de939c2630235a679d6cc7f3d', 'f6817f48af4fb3af11b9e8bf182f618b', 'c3b050978256957869d860d066bf4049', NULL);
INSERT INTO `sys_role_permission` VALUES ('890c02edcd48f1ba7a9174cf34726c4d', 'f6817f48af4fb3af11b9e8bf182f618b', '03dc3d93261dda19fc86dd7ca486c6cf', NULL);
INSERT INTO `sys_role_permission` VALUES ('8ac5a055c642352bdb2be766011bd685', 'f6817f48af4fb3af11b9e8bf182f618b', '54097c6a3cf50fad0793a34beff1efdf', NULL);
INSERT INTO `sys_role_permission` VALUES ('95207201a53b05f9b075c33af0d1017d', 'f6817f48af4fb3af11b9e8bf182f618b', '5c2f42277948043026b7a14692456828', NULL);
INSERT INTO `sys_role_permission` VALUES ('99b6699f0ce01b1fcc700f3037fbbe08', 'f6817f48af4fb3af11b9e8bf182f618b', '25ecd6db517f9018fafb1f36a64f89c4', NULL);
INSERT INTO `sys_role_permission` VALUES ('9ed39ff3d6b7eed1bcd9aa2b0353fe4c', 'f6817f48af4fb3af11b9e8bf182f618b', 'ebb9d82ea16ad864071158e0c449d186', NULL);
INSERT INTO `sys_role_permission` VALUES ('9f2594feec20324d63b8c07feaf6fdea', 'f6817f48af4fb3af11b9e8bf182f618b', '9ed19a5e2a5e191b84d8d7338ab68b9c', NULL);
INSERT INTO `sys_role_permission` VALUES ('a9563997a9a4e56ded4e77851980106b', 'f6817f48af4fb3af11b9e8bf182f618b', '22d6a3d39a59dd7ea9a30acfa6bfb0a5', NULL);
INSERT INTO `sys_role_permission` VALUES ('aaa7c3110da881d2a1970838bd5322c7', 'f6817f48af4fb3af11b9e8bf182f618b', '8d4683aacaa997ab86b966b464360338', NULL);
INSERT INTO `sys_role_permission` VALUES ('acbbec8dd04968f3f439e50075500846', 'f6817f48af4fb3af11b9e8bf182f618b', '45c966826eeff4c99b8f8ebfe74511fc', NULL);
INSERT INTO `sys_role_permission` VALUES ('b1783343efbab78507f982815c19e45f', 'f6817f48af4fb3af11b9e8bf182f618b', 'd7d6e2e4e2934f2c9385a623fd98c6f3', NULL);
INSERT INTO `sys_role_permission` VALUES ('b3dc57861f2dbe6e9c5f83defeb1a651', 'f6817f48af4fb3af11b9e8bf182f618b', 'c38ea68e3abf5df9a55d5d2dfb5c3712', NULL);
INSERT INTO `sys_role_permission` VALUES ('c2b913de0c0387993c7a3d9ef316ed2f', 'f6817f48af4fb3af11b9e8bf182f618b', 'ffb423d25cc59dcd0532213c4a518261', NULL);
INSERT INTO `sys_role_permission` VALUES ('c794c94a8722ad06dda8eb86874dbac9', 'f6817f48af4fb3af11b9e8bf182f618b', '2844c2017b858dc965ecc7773f17b111', NULL);
INSERT INTO `sys_role_permission` VALUES ('ca63771414d37bfe9d6db497ed933377', 'f6817f48af4fb3af11b9e8bf182f618b', 'fef097f3903caf3a3c3a6efa8de43fbb', NULL);
INSERT INTO `sys_role_permission` VALUES ('ccfde933e19b5b0f2caa48ce89829392', 'f6817f48af4fb3af11b9e8bf182f618b', 'e08cb190ef230d5d4f03824198773950', NULL);
INSERT INTO `sys_role_permission` VALUES ('cdbd5ca09a51b9f9911053e9b1160a29', 'f6817f48af4fb3af11b9e8bf182f618b', 'da89e38bb67af4b7f930c77570c82c95', NULL);
INSERT INTO `sys_role_permission` VALUES ('d19950513d3e4613139c4b542c6905eb', 'f6817f48af4fb3af11b9e8bf182f618b', '0ac2ad938963b6c6d1af25477d5b8b51', NULL);
INSERT INTO `sys_role_permission` VALUES ('da562e07c4c7b49d3e61c6b689217b33', 'f6817f48af4fb3af11b9e8bf182f618b', 'c89018ea6286e852b424466fd92a2ffc', NULL);
INSERT INTO `sys_role_permission` VALUES ('dba839995b91ec692ac7b8aab8babb05', 'f6817f48af4fb3af11b9e8bf182f618b', '6242fb02030e9778973390766a5791a7', NULL);
INSERT INTO `sys_role_permission` VALUES ('ddde5709fbd232c0033f44270bdc73c3', 'f6817f48af4fb3af11b9e8bf182f618b', 'fba41089766888023411a978d13c0aa4', NULL);
INSERT INTO `sys_role_permission` VALUES ('e0f31a25bc813e722a50e0fb7e804858', 'f6817f48af4fb3af11b9e8bf182f618b', 'e8af452d8948ea49d37c934f5100ae6a', NULL);
INSERT INTO `sys_role_permission` VALUES ('e32c9efd3f0840ddc6c789f32d925026', 'f6817f48af4fb3af11b9e8bf182f618b', '1a0811914300741f4e11838ff37a1d3a', NULL);
INSERT INTO `sys_role_permission` VALUES ('e669051ce15d5ba20617a5228a9bfc0c', 'f6817f48af4fb3af11b9e8bf182f618b', 'a400e4f4d54f79bf5ce160a3432231af', NULL);
INSERT INTO `sys_role_permission` VALUES ('eba6189694617bef6d85e37fc9fb94a3', 'f6817f48af4fb3af11b9e8bf182f618b', '657f9f8f929c8533713fed4423c5416c', NULL);
INSERT INTO `sys_role_permission` VALUES ('ee6127290575894f6b6c4bca5855b42f', 'f6817f48af4fb3af11b9e8bf182f618b', '7593c9e3523a17bca83b8d7fe8a34e58', NULL);
INSERT INTO `sys_role_permission` VALUES ('ef56c1824a2d96ecec5d03a37195141a', 'f6817f48af4fb3af11b9e8bf182f618b', 'abb2641990431ea1d4b638e16933fbb5', NULL);
INSERT INTO `sys_role_permission` VALUES ('fe0ef11dab626d2f1a42ddea4275cab7', 'f6817f48af4fb3af11b9e8bf182f618b', '9fe26464838de2ea5e90f2367e35efa0', NULL);

-- ----------------------------
-- Table structure for sys_sms
-- ----------------------------
DROP TABLE IF EXISTS `sys_sms`;
CREATE TABLE `sys_sms`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ID',
  `es_title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '消息标题',
  `es_type` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发送方式：1短信 2邮件 3微信',
  `es_receiver` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接收人',
  `es_param` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发送所需参数Json格式',
  `es_content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '推送内容',
  `es_send_time` datetime NULL DEFAULT NULL COMMENT '推送时间',
  `es_send_status` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '推送状态 0未推送 1推送成功 2推送失败 -1失败不再发送',
  `es_send_num` int(11) NULL DEFAULT NULL COMMENT '发送次数 超过5次不再发送',
  `es_result` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '推送失败原因',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_type`(`es_type` ASC) USING BTREE,
  INDEX `index_receiver`(`es_receiver` ASC) USING BTREE,
  INDEX `index_sendtime`(`es_send_time` ASC) USING BTREE,
  INDEX `index_status`(`es_send_status` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_sms
-- ----------------------------

-- ----------------------------
-- Table structure for sys_sms_history
-- ----------------------------
DROP TABLE IF EXISTS `sys_sms_history`;
CREATE TABLE `sys_sms_history`  (
  `id` bigint(20) NOT NULL COMMENT '主键Id',
  `user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户Id',
  `smsId` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '短信唯一标识',
  `mobile` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `export` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发送短信号码后缀',
  `sign` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '短信内容前缀签名',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '短信内容',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '当前短信状态[1.发送成功，2.发送失败，3.接收成功，4.接收失败]',
  `return_msg` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发送方返回信息',
  `ext_id` bigint(20) NULL DEFAULT NULL COMMENT '扩展id，用于关联业务信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_deleted` tinyint(4) NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统短信历史记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_sms_history
-- ----------------------------

-- ----------------------------
-- Table structure for sys_sms_template
-- ----------------------------
DROP TABLE IF EXISTS `sys_sms_template`;
CREATE TABLE `sys_sms_template`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `template_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模板标题',
  `template_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模板CODE',
  `template_type` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模板类型：1短信 2邮件 3微信',
  `template_content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `template_test_json` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模板测试json',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_templatecode`(`template_code` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_sms_template
-- ----------------------------

-- ----------------------------
-- Table structure for sys_temp_group
-- ----------------------------
DROP TABLE IF EXISTS `sys_temp_group`;
CREATE TABLE `sys_temp_group`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键id',
  `group_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分组名称',
  `depart_ids` varchar(4000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '选择单位id',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '临时分组表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_temp_group
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键id',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录账号',
  `realname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `salt` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'md5密码盐',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `birthday` datetime NULL DEFAULT NULL COMMENT '生日',
  `sex` tinyint(1) NULL DEFAULT NULL COMMENT '性别(0-默认未知,1-男,2-女)',
  `email` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电子邮件',
  `phone` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `org_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机构编码',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '性别(1-正常,2-冻结)',
  `del_flag` tinyint(1) NULL DEFAULT NULL COMMENT '删除状态(0-正常,1-已删除)',
  `activiti_sync` tinyint(1) NULL DEFAULT NULL COMMENT '同步工作流引擎(1-同步,0-不同步)',
  `work_no` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工号，唯一键',
  `post` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务，关联职务表',
  `telephone` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '座机号',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `login_num` int(11) NOT NULL DEFAULT 0,
  `update_pw_time` datetime NULL DEFAULT NULL,
  `union_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '统一认证平台用户ID',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_sys_user_work_no`(`work_no` ASC) USING BTREE,
  INDEX `index_user_status`(`status` ASC) USING BTREE,
  INDEX `index_user_del_flag`(`del_flag` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1983067778993369090', '值班员', '经信局值班员', 'b0e81216ae6cb3a5c291e4822c7008ff', 'Lq9rjDil', 'files/20251029/2020-11-26_111050_03_1761701634251.jpg', NULL, NULL, NULL, NULL, 'A01A02A16', 1, 0, 1, NULL, '', NULL, NULL, '2025-10-28 15:06:17', NULL, '2025-10-29 09:34:08', 3, '2025-10-29 09:35:11', NULL);
INSERT INTO `sys_user` VALUES ('e9ca23d68d884d4ebb19d07889727dae', 'admin', '管理员', '398a07d09e53b412', 'RCGTeGiH', 'files/20220617/管理员_1655451256667.webp', '2018-12-05 00:00:00', 2, '', '18281084721', 'A01A02A02', 1, 0, 1, 'A000', '002', '', 'admin', '2019-06-21 17:54:10', 'admin', '2022-09-23 18:12:53', 7, '2022-09-23 18:12:53', NULL);

-- ----------------------------
-- Table structure for sys_user_agent
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_agent`;
CREATE TABLE `sys_user_agent`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '序号',
  `user_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `agent_user_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '代理人用户名',
  `start_time` datetime NULL DEFAULT NULL COMMENT '代理开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '代理结束时间',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态0无效1有效',
  `create_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人名称',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人名称',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门',
  `sys_company_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属公司',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_username`(`user_name` ASC) USING BTREE,
  INDEX `statux_index`(`status` ASC) USING BTREE,
  INDEX `begintime_index`(`start_time` ASC) USING BTREE,
  INDEX `endtime_index`(`end_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户代理人设置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_agent
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user_ca
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_ca`;
CREATE TABLE `sys_user_ca`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键id',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联用户主键id',
  `serial_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '序列号',
  `original_certificate` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '证书原文',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表ca数据一对一绑定' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_ca
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user_depart
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_depart`;
CREATE TABLE `sys_user_depart`  (
  `ID` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'id',
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户id',
  `dep_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门id',
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `index_depart_groupk_userid`(`user_id` ASC) USING BTREE,
  INDEX `index_depart_groupkorgid`(`dep_id` ASC) USING BTREE,
  INDEX `index_depart_groupk_uidanddid`(`user_id` ASC, `dep_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_depart
-- ----------------------------
INSERT INTO `sys_user_depart` VALUES ('1983346581103824898', '1983067778993369090', 'a2fcde1b0b94446e86ea7878056e87f6');
INSERT INTO `sys_user_depart` VALUES ('1572047298608910338', 'e9ca23d68d884d4ebb19d07889727dae', '88825c1f7c3d48c8b7e011a346fbc99b');
INSERT INTO `sys_user_depart` VALUES ('1572487178429571073', 'e9ca23d68d884d4ebb19d07889727dae', 'bbeffe94e3f14d74ad521a60889e146f');
INSERT INTO `sys_user_depart` VALUES ('1692014818513539073', 'e9ca23d68d884d4ebb19d07889727dae', 'fa54d8892f27410782701c5d0abbce3f');

-- ----------------------------
-- Table structure for sys_user_face
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_face`;
CREATE TABLE `sys_user_face`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户ID',
  `face_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '人脸识别码',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_face
-- ----------------------------
INSERT INTO `sys_user_face` VALUES ('1303988521558376449', '6faae4f7711d493fa04b06793e2b190b', 'dfc83cdbf54b4fbf0af2a8e686b148b4', '2020-09-10 17:27:45');
INSERT INTO `sys_user_face` VALUES ('1303991363056791553', 'c181e0b01f02486090f926a70d4efdac', '9711df579768f19765492743948a4ec7', '2020-09-10 17:39:03');
INSERT INTO `sys_user_face` VALUES ('1304055175726239746', '496090365ccb497f96f0e41374c7897a', '68d5cccf8fd288e52f52257c7577c9e5', '2020-09-10 21:52:37');
INSERT INTO `sys_user_face` VALUES ('1304260656386281474', '33f2635ad2c542568ab692712e923a0f', 'd31be6dccad55d2a7f265637cd646b7b', '2020-09-11 11:29:07');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键id',
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户id',
  `role_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index2_groupuu_user_id`(`user_id` ASC) USING BTREE,
  INDEX `index2_groupuu_ole_id`(`role_id` ASC) USING BTREE,
  INDEX `index2_groupuu_useridandroleid`(`user_id` ASC, `role_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1983067779060477954', '1983067778993369090', '1983067284573007874');
INSERT INTO `sys_user_role` VALUES ('1573253907721400322', 'e9ca23d68d884d4ebb19d07889727dae', 'f6817f48af4fb3af11b9e8bf182f618b');

-- ----------------------------
-- Table structure for temp_area
-- ----------------------------
DROP TABLE IF EXISTS `temp_area`;
CREATE TABLE `temp_area`  (
  `CITY_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CITY_CODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STREET_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STREET_CODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NEIGHBORHOOD_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of temp_area
-- ----------------------------

-- ----------------------------
-- Table structure for test_aaa
-- ----------------------------
DROP TABLE IF EXISTS `test_aaa`;
CREATE TABLE `test_aaa`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门',
  `bpm_status` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '流程状态',
  `column1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列1',
  `column2` datetime NULL DEFAULT NULL COMMENT '列2',
  `column3` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '列3',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of test_aaa
-- ----------------------------

-- ----------------------------
-- Table structure for test_caigou
-- ----------------------------
DROP TABLE IF EXISTS `test_caigou`;
CREATE TABLE `test_caigou`  (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属部门',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '采购物品',
  `money` double(32, 0) NULL DEFAULT NULL COMMENT '采购预算',
  `descc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '描述',
  `bpm_status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '流程状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of test_caigou
-- ----------------------------

-- ----------------------------
-- Table structure for test_demo
-- ----------------------------
DROP TABLE IF EXISTS `test_demo`;
CREATE TABLE `test_demo`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人登录名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人登录名称',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `sex` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `age` int(11) NULL DEFAULT NULL COMMENT '年龄',
  `descc` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `birthday` datetime NULL DEFAULT NULL COMMENT '生日',
  `user_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户编码',
  `file_kk` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件',
  `top_pic` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `kkkkk`(`name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of test_demo
-- ----------------------------

-- ----------------------------
-- Table structure for test_order_main
-- ----------------------------
DROP TABLE IF EXISTS `test_order_main`;
CREATE TABLE `test_order_main`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `order_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单编码',
  `order_date` datetime NULL DEFAULT NULL COMMENT '下单时间',
  `descc` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `ddd` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ddd',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of test_order_main
-- ----------------------------

-- ----------------------------
-- Table structure for test_order_product
-- ----------------------------
DROP TABLE IF EXISTS `test_order_product`;
CREATE TABLE `test_order_product`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `product_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品名字',
  `price` double(32, 0) NULL DEFAULT NULL COMMENT '价格',
  `num` int(11) NULL DEFAULT NULL COMMENT '数量',
  `order_fk_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单外键ID',
  `pro_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品类型',
  `descp` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of test_order_product
-- ----------------------------

-- ----------------------------
-- Table structure for test_vecation
-- ----------------------------
DROP TABLE IF EXISTS `test_vecation`;
CREATE TABLE `test_vecation`  (
  `id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新日期',
  `sys_org_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请假人姓名',
  `start_time` datetime NULL DEFAULT NULL COMMENT '请假开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '请假结束时间',
  `reason` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '请假理由',
  `bpm_status` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '流程状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of test_vecation
-- ----------------------------

-- ----------------------------
-- Table structure for timeline_variable
-- ----------------------------
DROP TABLE IF EXISTS `timeline_variable`;
CREATE TABLE `timeline_variable`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `record_id` bigint(20) NOT NULL COMMENT '时间轴记录id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '变量名称',
  `has_value` tinyint(1) NULL DEFAULT NULL COMMENT '是否含有值',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `is_deleted` tinyint(4) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '时间轴变量表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of timeline_variable
-- ----------------------------

-- ----------------------------
-- Table structure for timeline_variable_value
-- ----------------------------
DROP TABLE IF EXISTS `timeline_variable_value`;
CREATE TABLE `timeline_variable_value`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `variable_id` bigint(20) NOT NULL COMMENT '变量id',
  `value` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '变量值',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  `ext` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '扩展字段',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `is_deleted` tinyint(4) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '时间轴变量值表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of timeline_variable_value
-- ----------------------------

-- ----------------------------
-- Table structure for tmp_depart_group
-- ----------------------------
DROP TABLE IF EXISTS `tmp_depart_group`;
CREATE TABLE `tmp_depart_group`  (
  `id` bigint(20) NOT NULL,
  `group_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '临时分组名',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `create_org_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通过创建部门code判定是本部门或相关部门',
  `is_deleted` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tmp_depart_group
-- ----------------------------

-- ----------------------------
-- Table structure for tmp_report_data_1
-- ----------------------------
DROP TABLE IF EXISTS `tmp_report_data_1`;
CREATE TABLE `tmp_report_data_1`  (
  `monty` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '月份',
  `main_income` decimal(10, 2) NULL DEFAULT NULL,
  `total` decimal(10, 2) NULL DEFAULT NULL,
  `his_lowest` decimal(10, 2) NULL DEFAULT NULL,
  `his_average` decimal(10, 2) NULL DEFAULT NULL,
  `his_highest` decimal(10, 2) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tmp_report_data_1
-- ----------------------------

-- ----------------------------
-- Table structure for tmp_report_data_income
-- ----------------------------
DROP TABLE IF EXISTS `tmp_report_data_income`;
CREATE TABLE `tmp_report_data_income`  (
  `biz_income` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bx_jj_yongjin` decimal(10, 2) NULL DEFAULT NULL,
  `bx_zx_money` decimal(10, 2) NULL DEFAULT NULL,
  `chengbao_gz_money` decimal(10, 2) NULL DEFAULT NULL,
  `bx_gg_moeny` decimal(10, 2) NULL DEFAULT NULL,
  `tb_zx_money` decimal(10, 2) NULL DEFAULT NULL,
  `neikong_zx_money` decimal(10, 2) NULL DEFAULT NULL,
  `total` decimal(10, 2) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tmp_report_data_income
-- ----------------------------

-- ----------------------------
-- Table structure for user_ca_relativation
-- ----------------------------
DROP TABLE IF EXISTS `user_ca_relativation`;
CREATE TABLE `user_ca_relativation`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键id',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录账号',
  `realname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `salt` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'md5密码盐',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `birthday` datetime NULL DEFAULT NULL COMMENT '生日',
  `sex` tinyint(1) NULL DEFAULT NULL COMMENT '性别(0-默认未知,1-男,2-女)',
  `email` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电子邮件',
  `phone` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `org_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机构编码',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '性别(1-正常,2-冻结)',
  `del_flag` tinyint(1) NULL DEFAULT NULL COMMENT '删除状态(0-正常,1-已删除)',
  `activiti_sync` tinyint(1) NULL DEFAULT NULL COMMENT '同步工作流引擎(1-同步,0-不同步)',
  `work_no` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工号，唯一键',
  `post` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务，关联职务表',
  `telephone` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '座机号',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `ca_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'sys_user_ca表ID',
  `serial_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '序列号',
  `original_certificate` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '证书原文',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `index_user_name`(`username` ASC) USING BTREE,
  UNIQUE INDEX `uniq_sys_user_work_no`(`work_no` ASC) USING BTREE,
  INDEX `index_user_status`(`status` ASC) USING BTREE,
  INDEX `index_user_del_flag`(`del_flag` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_ca_relativation
-- ----------------------------

-- ----------------------------
-- Table structure for user_ca_relativation_copy
-- ----------------------------
DROP TABLE IF EXISTS `user_ca_relativation_copy`;
CREATE TABLE `user_ca_relativation_copy`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键id',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录账号',
  `realname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `salt` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'md5密码盐',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `birthday` datetime NULL DEFAULT NULL COMMENT '生日',
  `sex` tinyint(1) NULL DEFAULT NULL COMMENT '性别(0-默认未知,1-男,2-女)',
  `email` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电子邮件',
  `phone` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `org_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机构编码',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '性别(1-正常,2-冻结)',
  `del_flag` tinyint(1) NULL DEFAULT NULL COMMENT '删除状态(0-正常,1-已删除)',
  `activiti_sync` tinyint(1) NULL DEFAULT NULL COMMENT '同步工作流引擎(1-同步,0-不同步)',
  `work_no` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工号，唯一键',
  `post` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务，关联职务表',
  `telephone` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '座机号',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `ca_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'sys_user_ca表ID',
  `serial_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '序列号',
  `original_certificate` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '证书原文',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `index_user_name`(`username` ASC) USING BTREE,
  UNIQUE INDEX `uniq_sys_user_work_no`(`work_no` ASC) USING BTREE,
  INDEX `index_user_status`(`status` ASC) USING BTREE,
  INDEX `index_user_del_flag`(`del_flag` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_ca_relativation_copy
-- ----------------------------

-- ----------------------------
-- Table structure for user_vein_info
-- ----------------------------
DROP TABLE IF EXISTS `user_vein_info`;
CREATE TABLE `user_vein_info`  (
  `id` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `user_id` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `vein_image` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '指静脉图像',
  `del_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态(0-正常,1-已删除)',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `vein_name` varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '指静脉名称',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id_index`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户指静脉信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_vein_info
-- ----------------------------

-- ----------------------------
-- Table structure for user_vein_info_copy
-- ----------------------------
DROP TABLE IF EXISTS `user_vein_info_copy`;
CREATE TABLE `user_vein_info_copy`  (
  `id` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `user_id` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `vein_image` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '指静脉图像',
  `del_flag` tinyint(1) NOT NULL DEFAULT 0 COMMENT '删除状态(0-正常,1-已删除)',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `vein_name` varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '指静脉名称',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id_index`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户指静脉信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_vein_info_copy
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
