ALTER TABLE `BaseData`.`AppUser` ADD COLUMN `SecurityErrorCount` int NOT NULL DEFAULT 0 COMMENT '密码连续错误次数' ;

ALTER TABLE `BaseData`.`AppUser` ADD COLUMN `SecurityErrorTime` datetime(6) NOT NULL DEFAULT '1970-01-01 00:00:00.000000' COMMENT '密码第一次错误时间' ;

ALTER TABLE `BaseData`.`AppUser` ADD COLUMN `SecurityModifyTime` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '密码修改时间(最后一次)' ;

ALTER TABLE `BaseData`.`UserOperationLog` ADD COLUMN `LogCategory` tinyint  NOT NULL DEFAULT 0 COMMENT '日志分类0普通日志 2安全管理员查看日志' ;

ALTER TABLE `BaseData`.`UserOperationLog` ADD COLUMN `LogParam` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '参数序列化数据' ;

ALTER TABLE `BaseData`.`UserOperationLog` ADD COLUMN `LogType` tinyint NOT NULL DEFAULT 0 COMMENT '日志类型0操作日志  2业务日志' ;



CREATE TABLE `BaseData`.`PwdSecurity`  (
  `Id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '密码安全设置Id',
  `AppUserId` bigint NOT NULL COMMENT '操作人员Id',
  `ErrorCount` int NOT NULL DEFAULT 0 COMMENT '密码输入错误次数',
  `ErrorInterval` int NOT NULL DEFAULT 0 COMMENT '密码输入错误间隔(分钟)',
  `ModifyInterval` int NOT NULL DEFAULT 0 COMMENT '修改密码周期(天)',
  `Status` tinyint NOT NULL default 0 COMMENT '状态',
  `CreateTime` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `UpdateTime` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;


-- 添加按钮配置（密码安全、日志）
INSERT INTO `BaseData`.`SysMenu`(`Id`, `ParentId`, `Code`, `Name`, `Depth`, `Seq`, `Status`, `CreateTime`, `UpdateTime`) VALUES (40000000, 99999999, '', '操作日志', 1, 40, 1, NOW(), NOW());
INSERT INTO `BaseData`.`SysMenu`(`Id`, `ParentId`, `Code`, `Name`, `Depth`, `Seq`, `Status`, `CreateTime`, `UpdateTime`) VALUES (40100000, 40000000, '', '用户安全保密日志', 2, 10, 1, NOW(), NOW());
INSERT INTO `BaseData`.`SysMenu`(`Id`, `ParentId`, `Code`, `Name`, `Depth`, `Seq`, `Status`, `CreateTime`, `UpdateTime`) VALUES (40200000, 40000000, '', '安全审计日志', 2, 20, 1, NOW(), NOW());
INSERT INTO `BaseData`.`SysMenu`(`Id`, `ParentId`, `Code`, `Name`, `Depth`, `Seq`, `Status`, `CreateTime`, `UpdateTime`) VALUES (50000000, 99999999, '', '安全管理', 1, 50, 1, NOW(), NOW());
INSERT INTO `BaseData`.`SysMenu`(`Id`, `ParentId`, `Code`, `Name`, `Depth`, `Seq`, `Status`, `CreateTime`, `UpdateTime`) VALUES (50100000, 50000000, '', '密码安全管理', 2, 10, 1, NOW(), NOW());

-- 添加按钮资源配置（密码安全、日志）
INSERT INTO `BaseData`.`SysResource`(`Id`, `OldId`, `MenuId`, `ResType`, `CtrlId`, `CtrlName`, `Comment`, `RequestUrl`, `Status`, `CreateTime`, `UpdateTime`) VALUES (37, '', 40000000, 4097, '', '操作日志', '', '', 1, NOW(), NOW());
INSERT INTO `BaseData`.`SysResource`(`Id`, `OldId`, `MenuId`, `ResType`, `CtrlId`, `CtrlName`, `Comment`, `RequestUrl`, `Status`, `CreateTime`, `UpdateTime`) VALUES (38, '', 40100000, 4097, '', '用户安全保密日志', '', '/api/App/GetUserLogs', 1, NOW(), NOW());
INSERT INTO `BaseData`.`SysResource`(`Id`, `OldId`, `MenuId`, `ResType`, `CtrlId`, `CtrlName`, `Comment`, `RequestUrl`, `Status`, `CreateTime`, `UpdateTime`) VALUES (39, '', 40200000, 4097, '', '安全审计日志', '', '/api/App/GetUserLogs', 1, NOW(), NOW());
INSERT INTO `BaseData`.`SysResource`(`Id`, `OldId`, `MenuId`, `ResType`, `CtrlId`, `CtrlName`, `Comment`, `RequestUrl`, `Status`, `CreateTime`, `UpdateTime`) VALUES (40, '', 50000000, 4097, '', '安全管理', '', '', 1, NOW(), NOW());
INSERT INTO `BaseData`.`SysResource`(`Id`, `OldId`, `MenuId`, `ResType`, `CtrlId`, `CtrlName`, `Comment`, `RequestUrl`, `Status`, `CreateTime`, `UpdateTime`) VALUES (41, '', 50100000, 4097, '', '密码安全管理', '', '/api/App/UpdatePwdSecurity', 1, NOW(), NOW());
