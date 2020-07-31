update DataCentre.FileLib as a , BaseData.AppUser as b set a.UserId=b.Id  ,a.OrganizationId=b.OrganizationId where a.UserId=b.OldId;
update DataCentre.MemoryLib as a , BaseData.Organization as b set a.OrganizationId=b.Id where a.OrganizationId=b.OldId;

delete  from DataCentre.FileItem where FileLibId in ( select  Id from DataCentre.FileLib where  length(UserId)>10 or length(OrganizationId)>10) ;
delete  from DataCentre.FileLib where  length(UserId)>10 or length(OrganizationId)>10;

delete  from DataCentre.MemoryItem where MemoryLibId in ( select  Id from DataCentre.MemoryLib where   length(UserId)>10 or length(OrganizationId)>10) ;
delete  from  DataCentre.MemoryLib where  length(UserId)>10 or length(OrganizationId)>10 ;

ALTER TABLE `DataCentre`.`FileLib`
MODIFY COLUMN `OrganizationId` bigint(0) unsigned NOT NULL DEFAULT '0' COMMENT ' 组织ID' AFTER `FileType`,
MODIFY COLUMN `UserId` bigint(0) unsigned NOT NULL DEFAULT '0' COMMENT 'UserId' AFTER `OrganizationId`,
MODIFY COLUMN `RelatedId` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '跟消费字数查询系统关连ID' AFTER `ConsumeTotalCharsCount`;


update DataCentre.MemoryLib set UserId=0 ;
ALTER TABLE `DataCentre`.`MemoryLib`
MODIFY COLUMN `UserId` bigint(0) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'UserId' AFTER `Name`,
MODIFY COLUMN `OrganizationId` bigint(0) UNSIGNED NOT NULL DEFAULT '0' COMMENT '组织ID' AFTER `UserId`;


ALTER TABLE `DataCentre`.`Label`
MODIFY COLUMN `ParentId` bigint(0) UNSIGNED NOT NULL DEFAULT 0 AFTER `Id`;

ALTER TABLE `DataCentre`.`MemoryLabel`
MODIFY COLUMN `LabelId` bigint(0) UNSIGNED NOT NULL COMMENT '标识标识' AFTER `Id`;


ALTER TABLE `DataCentre`.`ProductLabel`
MODIFY COLUMN `Id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT FIRST,
MODIFY COLUMN `LabelId` bigint(0) UNSIGNED NOT NULL DEFAULT 0 AFTER `Id`;

ALTER TABLE `DataCentre`.`FileItem` ADD COLUMN `Status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '状态' AFTER `ConsumeCharsCount`;
update `DataCentre`.`FileItem` set Status=1;

ALTER TABLE `DataCentre`.`FileLib` ADD COLUMN `Status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '状态' AFTER `RelatedId`;
update `DataCentre`.`FileLib` set Status=1;
ALTER TABLE `DataCentre`.`MemoryItem` ADD COLUMN `Status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '状态' AFTER `UpdateTime`;
update `DataCentre`.`MemoryItem` set Status=1;
ALTER TABLE `DataCentre`.`MemoryLabel` ADD COLUMN `Status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '状态' AFTER `UpdateTime`;
update `DataCentre`.`MemoryLabel` set Status=1;
ALTER TABLE `DataCentre`.`MemoryLib` ADD COLUMN `Status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '状态' AFTER `UpdateTime`;
update `DataCentre`.`MemoryLib` set Status=1;
ALTER TABLE `DataCentre`.`ProductLabel` ADD COLUMN `Status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '状态' AFTER `UpdateTime`;
update `DataCentre`.`ProductLabel` set Status=1;

update DataCentre.Label set Name='通用' where Id=143;

select * from  DataCentre.ProductLabel as a , BaseData.DomainType as b  where a.ProductId=b.OldId;


update   DataCentre.ProductLabel as a , BaseData.DomainType as b set ProductId=b.Id  where a.ProductId=b.OldId;

ALTER TABLE `DataCentre`.`ProductLabel`
MODIFY COLUMN `ProductId` bigint(0) UNSIGNED NOT NULL DEFAULT '0' AFTER `LabelId`;

