ALTER TABLE `BaseData`.`AgentOrganization` DROP COLUMN `OldId`;
ALTER TABLE `BaseData`.`AgentWorker` DROP COLUMN `OldId`;

ALTER TABLE `BaseData`.`AgentWorker` DROP COLUMN `OldAgentOrganizationId`;
ALTER TABLE `BaseData`.`AppUser` DROP COLUMN `OldId`;

ALTER TABLE `BaseData`.`AppUser` DROP COLUMN `OldOrganizationId`;

ALTER TABLE `BaseData`.`AppUser` DROP INDEX `index_02`;

ALTER TABLE `BaseData`.`AppUser` DROP INDEX `index_01`;

ALTER TABLE `BaseData`.`AppUser` MODIFY COLUMN `SecurityModifyTime` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '密码修改时间(最后一次)'

ALTER TABLE `BaseData`.`AppUser` MODIFY COLUMN `Status` tinyint NOT NULL DEFAULT 0 COMMENT '状态'

ALTER TABLE `BaseData`.`AppUser` MODIFY COLUMN `CreateTime` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间' ;

ALTER TABLE `BaseData`.`AppUser` MODIFY COLUMN `UpdateTime` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间' ;

ALTER TABLE `BaseData`.`AppUser` ADD COLUMN `SecretLevel` int NOT NULL DEFAULT 0 COMMENT '秘密级别：0未设置，10非密，20内部，30秘密，40机密' ;

ALTER TABLE `BaseData`.`AppUser` ADD COLUMN `RemindSecurityModifyStatus` tinyint NOT NULL DEFAULT 0 COMMENT '提醒修改密码状态' ;

ALTER TABLE `BaseData`.`AppUser` ADD COLUMN `IpWhiteList` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'Ip白名单列表，求能超过20个IP' ;

ALTER TABLE `BaseData`.`AppUser` ADD INDEX `index_02`(`OrganizationId`) USING BTREE;
ALTER TABLE `BaseData`.`AssetsSwapGoods` DROP COLUMN `OldId`;

ALTER TABLE `BaseData`.`AssetsSwapGoods` DROP INDEX `index_01`;
ALTER TABLE `BaseData`.`AssetsSwapRecord` DROP COLUMN `OldId`;

ALTER TABLE `BaseData`.`AssetsSwapRecord` DROP COLUMN `OldAssetsSwapGoodsId`;

ALTER TABLE `BaseData`.`AssetsSwapRecord` DROP COLUMN `OldUserId`;

ALTER TABLE `BaseData`.`AssetsSwapRecord` DROP INDEX `index_01`;
ALTER TABLE `BaseData`.`ChatGroupRecord` DROP COLUMN `OldId`;

ALTER TABLE `BaseData`.`ChatGroupRecord` DROP COLUMN `OldUserId`;

ALTER TABLE `BaseData`.`ChatTranslateRecord` DROP COLUMN `OldRecordId`;

ALTER TABLE `BaseData`.`ChatTranslateRecord` DROP COLUMN `OldUserId`;

ALTER TABLE `BaseData`.`ChatUserRecord` DROP COLUMN `OldFromUserId`;

ALTER TABLE `BaseData`.`ChatUserRecord` DROP COLUMN `OldToUserId`;

ALTER TABLE `BaseData`.`Customer` DROP COLUMN `OldId`;

ALTER TABLE `BaseData`.`Customer` DROP COLUMN `OldOrganizationId`;
ALTER TABLE `BaseData`.`CustomerFedback` DROP COLUMN `OldId`;

ALTER TABLE `BaseData`.`DomainType` DROP COLUMN `OldId`;
ALTER TABLE `BaseData`.`DomainTypeLanguageType` DROP COLUMN `OldDomainTypeId`;
ALTER TABLE `BaseData`.`DongleInfo` DROP COLUMN `OldId`;
ALTER TABLE `BaseData`.`Goods` DROP COLUMN `OldId`;
ALTER TABLE `BaseData`.`IpAddressWhiteList` DROP COLUMN `OldOrganizationId`;

ALTER TABLE `BaseData`.`MachineCodeInfo` DROP COLUMN `OldId`;

ALTER TABLE `BaseData`.`MachineCodeInfo` DROP COLUMN `OldUserId`;

ALTER TABLE `BaseData`.`OpenUser` DROP COLUMN `OldSystemUserId`;
ALTER TABLE `BaseData`.`OrderList` DROP COLUMN `OldGoodsId`;

ALTER TABLE `BaseData`.`OrderList` DROP COLUMN `OldUserId`;

ALTER TABLE `BaseData`.`Organization` DROP COLUMN `OldId`;

ALTER TABLE `BaseData`.`Organization` DROP COLUMN `OldParentId`;

ALTER TABLE `BaseData`.`Organization` DROP INDEX `index_01`;

ALTER TABLE `BaseData`.`Organization` DROP INDEX `index_02`;

ALTER TABLE `BaseData`.`Organization` ADD COLUMN `ConsumeWordsType` tinyint NULL DEFAULT 0 COMMENT '扣减字数计算方式' AFTER `UpdateTime`;

ALTER TABLE `BaseData`.`PwdSecurity` MODIFY COLUMN `AppUserId` bigint UNSIGNED NOT NULL COMMENT '操作人员Id' AFTER `Id`;

ALTER TABLE `BaseData`.`PwdSecurity` ADD COLUMN `AutoOfflineInterval` int NOT NULL DEFAULT 0 COMMENT '无操作，自动下线间隔(分钟)' AFTER `UpdateTime`;
ALTER TABLE `BaseData`.`RechargeRecord` DROP COLUMN `OldId`;

ALTER TABLE `BaseData`.`RechargeRecord` DROP COLUMN `OldUserId`;

ALTER TABLE `BaseData`.`RechargeRecord` DROP COLUMN `OldOperatorUserId`;

ALTER TABLE `BaseData`.`RechargeRecord` DROP COLUMN `OldOrganizationId`;

ALTER TABLE `BaseData`.`ServiceEngine` DROP COLUMN `OldId`;

ALTER TABLE `BaseData`.`ServiceEngine` DROP COLUMN `OldServiceProviderId`;
ALTER TABLE `BaseData`.`ServiceProvider` DROP COLUMN `OldId`;


ALTER TABLE `BaseData`.`SysDataPermissions` DROP COLUMN `OldUserId`;

ALTER TABLE `BaseData`.`SysDataPermissions` DROP COLUMN `OldDataPermId`;

ALTER TABLE `BaseData`.`SysDataPermissions` ADD INDEX `index_02`(`DataPermId`) USING BTREE;



ALTER TABLE `BaseData`.`SysResRight` DROP COLUMN `OldSysRoleId`;

ALTER TABLE `BaseData`.`SysResRight` DROP COLUMN `OldSysResourceId`;


ALTER TABLE `BaseData`.`SysResource` DROP COLUMN `OldId`;


ALTER TABLE `BaseData`.`SystemRole` DROP COLUMN `OldId`;

ALTER TABLE `BaseData`.`SystemRoleClaim` DROP COLUMN `OldId`;

ALTER TABLE `BaseData`.`SystemRoleClaim` DROP COLUMN `OldRoleId`;


ALTER TABLE `BaseData`.`SystemUser` DROP COLUMN `OldId`;

ALTER TABLE `BaseData`.`SystemUser` DROP COLUMN `OldAppUserId`;

ALTER TABLE `BaseData`.`SystemUser` ADD COLUMN `IsDefaultUser` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否默认用户' ;

ALTER TABLE `BaseData`.`SystemUser` ADD COLUMN `ThirdPlatformId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '三方平台Id' ;

ALTER TABLE `BaseData`.`SystemUser` ADD COLUMN `IsResetPassword` bit(1) NOT NULL DEFAULT b'0' COMMENT '用户密码是否被重置，0 未重置，1已经重置' ;

ALTER TABLE `BaseData`.`SystemUserClaim` DROP COLUMN `OldUserId`;

ALTER TABLE `BaseData`.`SystemUserDongleInfo` DROP COLUMN `OldUserId`;

ALTER TABLE `BaseData`.`SystemUserDongleInfo` DROP COLUMN `OldDongleId`;

ALTER TABLE `BaseData`.`SystemUserLogin` DROP COLUMN `OldUserId`;

ALTER TABLE `BaseData`.`SystemUserLogin` DROP INDEX `index_01`;

ALTER TABLE `BaseData`.`SystemUserLogin` ADD INDEX `index_01`(`SystemUserId`) USING BTREE;

ALTER TABLE `BaseData`.`SystemUserRole` DROP COLUMN `OldUserId`;

ALTER TABLE `BaseData`.`SystemUserRole` DROP COLUMN `OldRoleId`;

ALTER TABLE `BaseData`.`SystemUserRole` DROP INDEX `index_01`;

ALTER TABLE `BaseData`.`SystemUserRole` ADD INDEX `index_01`(`SystemUserId`) USING BTREE;


ALTER TABLE `BaseData`.`SystemUserToken` DROP COLUMN `OldUserId`;


ALTER TABLE `BaseData`.`UserAssetsInfo` DROP COLUMN `OldUserId`;

ALTER TABLE `BaseData`.`UserAssetsInfo` DROP COLUMN `OldOrganizationId`;


ALTER TABLE `BaseData`.`UserDomainType` DROP COLUMN `OldUserId`;

ALTER TABLE `BaseData`.`UserDomainType` DROP COLUMN `OldDomainTypeId`;


ALTER TABLE `BaseData`.`UserEnDeCrypt` DROP COLUMN `OldUserId`;



ALTER TABLE `BaseData`.`UserExtendedInfo` DROP COLUMN `OldUserId`;


ALTER TABLE `BaseData`.`UserLanguageType` DROP COLUMN `OldUserId`;


ALTER TABLE `BaseData`.`UserOperationLog` DROP COLUMN `OldId`;

ALTER TABLE `BaseData`.`UserOperationLog` DROP COLUMN `OldUserId`;

ALTER TABLE `BaseData`.`UserOperationLog` DROP COLUMN `OldOrganizationId`;

ALTER TABLE `BaseData`.`UserOperationLog` DROP INDEX `index_01`;

ALTER TABLE `BaseData`.`UserOperationLog` DROP INDEX `index_02`;

ALTER TABLE `BaseData`.`UserOperationLog` ADD COLUMN `IsOperateFailed` bit(1) NOT NULL DEFAULT b'0' COMMENT '0成功日志  1失败日志' AFTER `LogType`;

ALTER TABLE `BaseData`.`UserOperationLog` ADD INDEX `index_01`(`AppUserId`) USING BTREE;

ALTER TABLE `BaseData`.`UserOperationLog` ADD INDEX `index_02`(`OrganizationId`) USING BTREE;



ALTER TABLE `BaseData`.`UserPackageInfo` DROP COLUMN `OldId`;

ALTER TABLE `BaseData`.`UserPackageInfo` DROP COLUMN `OldUserId`;

ALTER TABLE `BaseData`.`UserPackageInfo` DROP COLUMN `OldOrderId`;

ALTER TABLE `BaseData`.`UserPackageInfo` DROP COLUMN `OldGoodsId`;

ALTER TABLE `BaseData`.`UserPackageInfo` DROP INDEX `index_01`;

ALTER TABLE `BaseData`.`UserPackageInfo` MODIFY COLUMN `Quantity` decimal(18, 2) NOT NULL COMMENT '购买份数，一般购买1份' AFTER `Pricing`;

ALTER TABLE `BaseData`.`UserPackageInfo` ADD INDEX `index_01`(`AppUserId`) USING BTREE;



ALTER TABLE `BaseData`.`UserProductServiceInfo` DROP COLUMN `OldId`;

ALTER TABLE `BaseData`.`UserProductServiceInfo` DROP COLUMN `OldUserId`;

ALTER TABLE `BaseData`.`UserProductServiceInfo` DROP COLUMN `OldOrganizationId`;

ALTER TABLE `BaseData`.`UserRemainInfo` DROP COLUMN `OldUserId`;


ALTER TABLE `BaseData`.`WordsBook` DROP COLUMN `OldId`;

ALTER TABLE `BaseData`.`WordsBook` DROP COLUMN `OldUserId`;

ALTER TABLE `BaseData`.`WordsBook` DROP COLUMN `OldOrganizationId`;

ALTER TABLE `BaseData`.`WordsBook` DROP INDEX `index_01`;

ALTER TABLE `BaseData`.`WordsBook` DROP INDEX `index_02`;

ALTER TABLE `BaseData`.`WordsBook` DROP INDEX `index_03`;

ALTER TABLE `BaseData`.`WordsBook` ADD INDEX `index_01`(`AppUserId`) USING BTREE;

ALTER TABLE `BaseData`.`WordsBook` ADD INDEX `index_02`(`OrganizationId`) USING BTREE;

CREATE TABLE `BaseData`.`OrganizationStructure`  (
  `Id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '结构Id',
  `Name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '结构名字',
  `ParentId` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT 'father Id',
  `OrderNumber` int NOT NULL DEFAULT 0 COMMENT '排序值，值越小，越靠前。如果排序值相同，在内部默认Id再asc',
  `Status` tinyint NOT NULL DEFAULT 0 COMMENT '状态',
  `CreateTime` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `UpdateTime` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `index_01`(`Name`, `ParentId`) USING BTREE COMMENT '同级名称只能一个。'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;


ALTER TABLE `DataCentre`.`FileItem` ADD COLUMN `ShowContent` json NULL COMMENT '显示数据' AFTER `Status`;

ALTER TABLE `DataCentre`.`FileItem` ADD COLUMN `CheckStatus` tinyint NOT NULL DEFAULT 0 COMMENT '0未校对，1已校对' ;

ALTER TABLE `DataCentre`.`FileItem` ADD INDEX `index_01`(`SrcContentMD5`) USING BTREE;

ALTER TABLE `DataCentre`.`FileItem` ADD INDEX `index_07`(`FileLibId`) USING BTREE;


ALTER TABLE `DataCentre`.`FileLib` DROP INDEX `index_01`;

ALTER TABLE `DataCentre`.`FileLib` ADD COLUMN `ParentId` bigint UNSIGNED NOT NULL DEFAULT 0 COMMENT '父ID' ;

ALTER TABLE `DataCentre`.`FileLib` ADD COLUMN `TranslateMode` int NOT NULL DEFAULT 0 COMMENT '翻译模式' ;

ALTER TABLE `DataCentre`.`FileLib` ADD COLUMN `BilingualType` int NOT NULL DEFAULT 1 COMMENT '双语对照模式' ;

ALTER TABLE `DataCentre`.`FileLib` ADD COLUMN `SecretLevel` int NOT NULL DEFAULT 0 COMMENT '秘密级别：0未设置，10非密，20内部，30秘密，40机密' ;

ALTER TABLE `DataCentre`.`FileLib` ADD INDEX `index_02`(`OrganizationId`, `UserId`, `SrcLanguage`, `TgtLanguage`) USING BTREE;
ALTER TABLE `DataCentre`.`UserRemainWord` MODIFY COLUMN `Id` bigint UNSIGNED NOT NULL FIRST;

ALTER TABLE `DataCentre`.`UserRemainWord` ADD COLUMN `CreateTime` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ;

ALTER TABLE `DataCentre`.`UserRemainWord` ADD COLUMN `UpdateTime` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) ;

ALTER TABLE `DataCentre`.`UserRemainWord` ADD COLUMN `Status` tinyint NOT NULL DEFAULT 0 ;

ALTER TABLE `DataCentre`.`UserRemainWord` MODIFY COLUMN `Id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;


CREATE TABLE `DataCentre`.`FileLibAssignUser`  (
  `Id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `FileLibId` bigint UNSIGNED NOT NULL COMMENT '文件Id',
  `AppUserId` bigint UNSIGNED NOT NULL COMMENT '用户Id',
  `CreateTime` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '创建时间',
  `OrgId` bigint UNSIGNED NOT NULL COMMENT '组织机构ID',
  `RelationType` tinyint NOT NULL DEFAULT 0 COMMENT '所属关系',
  `UpdateTime` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6) COMMENT '更新时间',
  `Status` tinyint NOT NULL DEFAULT 0 COMMENT '状态',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文件用户关系表' ROW_FORMAT = DYNAMIC;


drop TABLE `DataCentre`.`LogType`;
DROP VIEW `DataCentre`.`yearreport`;






