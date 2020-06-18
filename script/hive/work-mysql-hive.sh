#!/usr/bin/env bash

# ./create-hive-table.sh DataCentre FileItem,FileLib,FileType,Label,LanguageType,MemoryItem,MemoryLabel,MemoryLib xf 'file:///home/xf/sqoop/.mysql' 'jdbc:mysql://backdb:3306/DataCentre?characterEncoding=utf8mb4' 'hdfs://s2:8020'

# ./create-hive-table.sh BaseData WordsBook,SystemUser,AppUser xf 'file:///home/xf/sqoop/.mysql' 'jdbc:mysql://backdb:3306/BaseData?characterEncoding%3dutf8mb4' 'hdfs://s2:8020'

# ./create-sqoop-job.sh DataCentre FileItem,FileLib,FileType,Label,LanguageType,MemoryItem,MemoryLabel,MemoryLib xf 'file:///home/xf/sqoop/.mysql' 'jdbc:mysql://backdb:3306/DataCentre?characterEncoding%3dutf8mb4'

# ./create-sqoop-job.sh BaseData WordsBook,SystemUser,AppUser xf 'file:///home/xf/sqoop/.mysql' 'jdbc:mysql://backdb:3306/BaseData?characterEncoding%3dutf8mb4'

# export TERM=xterm-color
#drop database basedata cascade ;
hive -e "  create database if not exists  datacentre " >>create-table-info.log 2>&1
sqoop-import --connect 'jdbc:mysql://backdb:3306/DataCentre?characterEncoding%3dutf8mb4' -e 'select Id,Name,Value,CreateTime,UpdateTime from FileType where Id <1 and  $CONDITIONS  ' --hive-import --as-parquetfile --create-hive-table --hive-database datacentre --hive-table filetype --incremental append --check-column UpdateTime --target-dir '/datacentre/datacentre/filetype' --password 'xiefei' --username 'xf' --split-by 'Id' --merge-key 'Id' >>create-table-info.log 2>&1
hive -e "ALTER TABLE datacentre.filetype SET LOCATION 'hdfs://s2:8020/datacentre/DataCentre/FileType';" >>create-table-info.log 2>&1
sqoop-job --create datacentre.filetype -- import --connect 'jdbc:mysql://backdb:3306/DataCentre?characterEncoding%3dutf8mb4' --as-parquetfile -e ' select Id,Name,Value,CreateTime,UpdateTime from FileType WHERE $CONDITIONS ' -m 10 --password xiefei --username xf --split-by Id --merge-key Id --check-column UpdateTime --incremental lastmodified --target-dir '/datacentre/DataCentre/FileType' --fields-terminated-by '\0001' --lines-terminated-by '\n' --last-value '1970-01-01 00:00:01.0' >>create-table-info.log 2>&1
rm ./*.java
sqoop-import --connect 'jdbc:mysql://backdb:3306/DataCentre?characterEncoding%3dutf8mb4' -e 'select Id,ParentId,Depth,Seq,Name,IsAdmin,CreateTime,UpdateTime,En,Ko,Th,Status from Label where Id <1 and  $CONDITIONS  ' --hive-import --as-parquetfile --create-hive-table --hive-database datacentre --hive-table label --incremental append --check-column UpdateTime --target-dir '/datacentre/datacentre/label' --password 'xiefei' --username 'xf' --split-by 'Id' --merge-key 'Id' >>create-table-info.log 2>&1
hive -e "ALTER TABLE datacentre.label SET LOCATION 'hdfs://s2:8020/datacentre/DataCentre/Label';" >>create-table-info.log 2>&1
sqoop-job --create datacentre.label -- import --connect 'jdbc:mysql://backdb:3306/DataCentre?characterEncoding%3dutf8mb4' --as-parquetfile -e ' select Id,ParentId,Depth,Seq,Name,IsAdmin,CreateTime,UpdateTime,En,Ko,Th,Status from Label WHERE $CONDITIONS ' -m 10 --password xiefei --username xf --split-by Id --merge-key Id --check-column UpdateTime --incremental lastmodified --target-dir '/datacentre/DataCentre/Label' --fields-terminated-by '\0001' --lines-terminated-by '\n' --last-value '1970-01-01 00:00:01.0' >>create-table-info.log 2>&1
rm ./*.java
sqoop-import --connect 'jdbc:mysql://backdb:3306/DataCentre?characterEncoding%3dutf8mb4' -e 'select Id,LabelId,MemoryLibId,CreateTime,UpdateTime,Status from MemoryLabel where Id <1 and  $CONDITIONS  ' --hive-import --as-parquetfile --create-hive-table --hive-database datacentre --hive-table memorylabel --incremental append --check-column UpdateTime --target-dir '/datacentre/datacentre/memorylabel' --password 'xiefei' --username 'xf' --split-by 'Id' --merge-key 'Id' >>create-table-info.log 2>&1
hive -e "ALTER TABLE datacentre.memorylabel SET LOCATION 'hdfs://s2:8020/datacentre/DataCentre/MemoryLabel';" >>create-table-info.log 2>&1
sqoop-job --create datacentre.memorylabel -- import --connect 'jdbc:mysql://backdb:3306/DataCentre?characterEncoding%3dutf8mb4' --as-parquetfile -e ' select Id,LabelId,MemoryLibId,CreateTime,UpdateTime,Status from MemoryLabel WHERE $CONDITIONS ' -m 10 --password xiefei --username xf --split-by Id --merge-key Id --check-column UpdateTime --incremental lastmodified --target-dir '/datacentre/DataCentre/MemoryLabel' --fields-terminated-by '\0001' --lines-terminated-by '\n' --last-value '1970-01-01 00:00:01.0' >>create-table-info.log 2>&1
rm ./*.java
sqoop-import --connect 'jdbc:mysql://backdb:3306/DataCentre?characterEncoding%3dutf8mb4' -e 'select Id,Name,FileSize,SrcFullPath,ConvertedFullPath,TgtFullPath,ContentType,FileType,OrganizationId,UserId,SrcLanguage,TgtLanguage,SrcViewFullPath,TgtViewFullPath,CreateTime,UpdateTime,ExtraInfo,ConsumeTotalCount,PageNumber,IsCollect,TranslateDuration,ConsumeTotalCharsCount,RelatedId,Status from FileLib where Id <1 and  $CONDITIONS  ' --hive-import --as-parquetfile --create-hive-table --hive-database datacentre --hive-table filelib --incremental append --check-column UpdateTime --target-dir '/datacentre/datacentre/filelib' --password 'xiefei' --username 'xf' --split-by 'Id' --merge-key 'Id' >>create-table-info.log 2>&1
hive -e "ALTER TABLE datacentre.filelib SET LOCATION 'hdfs://s2:8020/datacentre/DataCentre/FileLib';" >>create-table-info.log 2>&1
sqoop-job --create datacentre.filelib -- import --connect 'jdbc:mysql://backdb:3306/DataCentre?characterEncoding%3dutf8mb4' --as-parquetfile -e ' select Id,Name,FileSize,SrcFullPath,ConvertedFullPath,TgtFullPath,ContentType,FileType,OrganizationId,UserId,SrcLanguage,TgtLanguage,SrcViewFullPath,TgtViewFullPath,CreateTime,UpdateTime,ExtraInfo,ConsumeTotalCount,PageNumber,IsCollect,TranslateDuration,ConsumeTotalCharsCount,RelatedId,Status from FileLib WHERE $CONDITIONS ' -m 10 --password xiefei --username xf --split-by Id --merge-key Id --check-column UpdateTime --incremental lastmodified --target-dir '/datacentre/DataCentre/FileLib' --fields-terminated-by '\0001' --lines-terminated-by '\n' --last-value '1970-01-01 00:00:01.0' >>create-table-info.log 2>&1
rm ./*.java
sqoop-import --connect 'jdbc:mysql://backdb:3306/DataCentre?characterEncoding%3dutf8mb4' -e 'select Id,FileLibId,EngineType,SrcContent,SrcContentMD5,TgtContent,TgtContentMD5,SrcWordsCount,TgtWordsCount,ConsumeWordsCount,Seq,CreateTime,UpdateTime,ConsumeCharsCount,Status from FileItem where Id <1 and  $CONDITIONS  ' --hive-import --as-parquetfile --create-hive-table --hive-database datacentre --hive-table fileitem --incremental append --check-column UpdateTime --target-dir '/datacentre/datacentre/fileitem' --password 'xiefei' --username 'xf' --split-by 'Id' --merge-key 'Id' >>create-table-info.log 2>&1
hive -e "ALTER TABLE datacentre.fileitem SET LOCATION 'hdfs://s2:8020/datacentre/DataCentre/FileItem';" >>create-table-info.log 2>&1
sqoop-job --create datacentre.fileitem -- import --connect 'jdbc:mysql://backdb:3306/DataCentre?characterEncoding%3dutf8mb4' --as-parquetfile -e ' select Id,FileLibId,EngineType,SrcContent,SrcContentMD5,TgtContent,TgtContentMD5,SrcWordsCount,TgtWordsCount,ConsumeWordsCount,Seq,CreateTime,UpdateTime,ConsumeCharsCount,Status from FileItem WHERE $CONDITIONS ' -m 10 --password xiefei --username xf --split-by Id --merge-key Id --check-column UpdateTime --incremental lastmodified --target-dir '/datacentre/DataCentre/FileItem' --fields-terminated-by '\0001' --lines-terminated-by '\n' --last-value '1970-01-01 00:00:01.0' >>create-table-info.log 2>&1
rm ./*.java
sqoop-import --connect 'jdbc:mysql://backdb:3306/DataCentre?characterEncoding%3dutf8mb4' -e 'select Id,Name,UserId,OrganizationId,Introduce,IsPublic,NewReleaseNumber,CreateTime,UpdateTime,Status from MemoryLib where Id <1 and  $CONDITIONS  ' --hive-import --as-parquetfile --create-hive-table --hive-database datacentre --hive-table memorylib --incremental append --check-column UpdateTime --target-dir '/datacentre/datacentre/memorylib' --password 'xiefei' --username 'xf' --split-by 'Id' --merge-key 'Id' >>create-table-info.log 2>&1
hive -e "ALTER TABLE datacentre.memorylib SET LOCATION 'hdfs://s2:8020/datacentre/DataCentre/MemoryLib';" >>create-table-info.log 2>&1
sqoop-job --create datacentre.memorylib -- import --connect 'jdbc:mysql://backdb:3306/DataCentre?characterEncoding%3dutf8mb4' --as-parquetfile -e ' select Id,Name,UserId,OrganizationId,Introduce,IsPublic,NewReleaseNumber,CreateTime,UpdateTime,Status from MemoryLib WHERE $CONDITIONS ' -m 10 --password xiefei --username xf --split-by Id --merge-key Id --check-column UpdateTime --incremental lastmodified --target-dir '/datacentre/DataCentre/MemoryLib' --fields-terminated-by '\0001' --lines-terminated-by '\n' --last-value '1970-01-01 00:00:01.0' >>create-table-info.log 2>&1
rm ./*.java
sqoop-import --connect 'jdbc:mysql://backdb:3306/DataCentre?characterEncoding%3dutf8mb4' -e 'select Id,MemoryLibId,SrcContent,SrcContentMD5,TgtContent,TgtContentMD5,ReleaseNumber,Matching,SrcLanguage,TgtLanguage,Seq,CreateTime,UpdateTime,Status from MemoryItem where Id <1 and  $CONDITIONS  ' --hive-import --as-parquetfile --create-hive-table --hive-database datacentre --hive-table memoryitem --incremental append --check-column UpdateTime --target-dir '/datacentre/datacentre/memoryitem' --password 'xiefei' --username 'xf' --split-by 'Id' --merge-key 'Id' >>create-table-info.log 2>&1
hive -e "ALTER TABLE datacentre.memoryitem SET LOCATION 'hdfs://s2:8020/datacentre/DataCentre/MemoryItem';" >>create-table-info.log 2>&1
sqoop-job --create datacentre.memoryitem -- import --connect 'jdbc:mysql://backdb:3306/DataCentre?characterEncoding%3dutf8mb4' --as-parquetfile -e ' select Id,MemoryLibId,SrcContent,SrcContentMD5,TgtContent,TgtContentMD5,ReleaseNumber,Matching,SrcLanguage,TgtLanguage,Seq,CreateTime,UpdateTime,Status from MemoryItem WHERE $CONDITIONS ' -m 10 --password xiefei --username xf --split-by Id --merge-key Id --check-column UpdateTime --incremental lastmodified --target-dir '/datacentre/DataCentre/MemoryItem' --fields-terminated-by '\0001' --lines-terminated-by '\n' --last-value '1970-01-01 00:00:01.0' >>create-table-info.log 2>&1
rm ./*.java
sqoop-import --connect 'jdbc:mysql://backdb:3306/DataCentre?characterEncoding%3dutf8mb4' -e 'select Id,Name,Value,CreateTime,UpdateTime,Code,Status from LanguageType where Id <1 and  $CONDITIONS  ' --hive-import --as-parquetfile --create-hive-table --hive-database datacentre --hive-table languagetype --incremental append --check-column UpdateTime --target-dir '/datacentre/datacentre/languagetype' --password 'xiefei' --username 'xf' --split-by 'Id' --merge-key 'Id' >>create-table-info.log 2>&1
hive -e "ALTER TABLE datacentre.languagetype SET LOCATION 'hdfs://s2:8020/datacentre/DataCentre/LanguageType';" >>create-table-info.log 2>&1
sqoop-job --create datacentre.languagetype -- import --connect 'jdbc:mysql://backdb:3306/DataCentre?characterEncoding%3dutf8mb4' --as-parquetfile -e ' select Id,Name,Value,CreateTime,UpdateTime,Code,Status from LanguageType WHERE $CONDITIONS ' -m 10 --password xiefei --username xf --split-by Id --merge-key Id --check-column UpdateTime --incremental lastmodified --target-dir '/datacentre/DataCentre/LanguageType' --fields-terminated-by '\0001' --lines-terminated-by '\n' --last-value '1970-01-01 00:00:01.0' >>create-table-info.log 2>&1
rm ./*.java
hive -e "  create database if not exists  basedata " >>create-table-info.log 2>&1
sqoop-import --connect 'jdbc:mysql://backdb:3306/BaseData?characterEncoding%3dutf8mb4' -e 'select Id,OldId,AppUserId,OldUserId,ChangeWordsCount,RemainWords,ConsumptionType,Remark,DateDue,OrganizationId,OldOrganizationId,RemainPdfPages,ConsumptionId,ThirdUserId,ThirdUserName,Status,CreateTime,UpdateTime from WordsBook where Id <1 and  $CONDITIONS  ' --hive-import --as-parquetfile --create-hive-table --hive-database basedata --hive-table wordsbook --incremental append --check-column UpdateTime --target-dir '/datacentre/basedata/wordsbook' --password 'xiefei' --username 'xf' --split-by 'Id' --merge-key 'Id' >>create-table-info.log 2>&1
hive -e "ALTER TABLE basedata.wordsbook SET LOCATION 'hdfs://s2:8020/datacentre/BaseData/WordsBook';" >>create-table-info.log 2>&1
sqoop-job --create basedata.wordsbook -- import --connect 'jdbc:mysql://backdb:3306/BaseData?characterEncoding%3dutf8mb4' --as-parquetfile -e ' select Id,OldId,AppUserId,OldUserId,ChangeWordsCount,RemainWords,ConsumptionType,Remark,DateDue,OrganizationId,OldOrganizationId,RemainPdfPages,ConsumptionId,ThirdUserId,ThirdUserName,Status,CreateTime,UpdateTime from WordsBook WHERE $CONDITIONS ' -m 10 --password xiefei --username xf --split-by Id --merge-key Id --check-column UpdateTime --incremental lastmodified --target-dir '/datacentre/BaseData/WordsBook' --fields-terminated-by '\0001' --lines-terminated-by '\n' --last-value '1970-01-01 00:00:01.0' >>create-table-info.log 2>&1
rm ./*.java
sqoop-import --connect 'jdbc:mysql://backdb:3306/BaseData?characterEncoding%3dutf8mb4' -e 'select Id,OldId,Name,OrganizationId,OldOrganizationId,PhoneNumber,Email,IsPayAccount,UserChannel,ThirdPartyUserId,ThirdPartyUserType,IsBeInvited,Status,CreateTime,UpdateTime from AppUser where Id <1 and  $CONDITIONS  ' --hive-import --as-parquetfile --create-hive-table --hive-database basedata --hive-table appuser --incremental append --check-column UpdateTime --target-dir '/datacentre/basedata/appuser' --password 'xiefei' --username 'xf' --split-by 'Id' --merge-key 'Id' >>create-table-info.log 2>&1
hive -e "ALTER TABLE basedata.appuser SET LOCATION 'hdfs://s2:8020/datacentre/BaseData/AppUser';" >>create-table-info.log 2>&1
sqoop-job --create basedata.appuser -- import --connect 'jdbc:mysql://backdb:3306/BaseData?characterEncoding%3dutf8mb4' --as-parquetfile -e ' select Id,OldId,Name,OrganizationId,OldOrganizationId,PhoneNumber,Email,IsPayAccount,UserChannel,ThirdPartyUserId,ThirdPartyUserType,IsBeInvited,Status,CreateTime,UpdateTime from AppUser WHERE $CONDITIONS ' -m 10 --password xiefei --username xf --split-by Id --merge-key Id --check-column UpdateTime --incremental lastmodified --target-dir '/datacentre/BaseData/AppUser' --fields-terminated-by '\0001' --lines-terminated-by '\n' --last-value '1970-01-01 00:00:01.0' >>create-table-info.log 2>&1
rm ./*.java
sqoop-import --connect 'jdbc:mysql://backdb:3306/BaseData?characterEncoding%3dutf8mb4' -e 'select Id,OldId,AccessFailedCount,EmailConfirmed,LockoutEnabled,LockoutEnd,PhoneNumberConfirmed,TwoFactorEnabled,UserName,NormalizedUserName,Email,NormalizedEmail,PasswordHash,SecurityStamp,ConcurrencyStamp,PhoneNumber,AppUserId,OldAppUserId,UserType,ExpireTime,Seq,EncryptionType,MaxMachineCodeCount,Country,Status,CreateTime,UpdateTime from SystemUser where Id <1 and  $CONDITIONS  ' --hive-import --as-parquetfile --create-hive-table --hive-database basedata --hive-table systemuser --incremental append --check-column UpdateTime --target-dir '/datacentre/basedata/systemuser' --password 'xiefei' --username 'xf' --split-by 'Id' --merge-key 'Id' >>create-table-info.log 2>&1
hive -e "ALTER TABLE basedata.systemuser SET LOCATION 'hdfs://s2:8020/datacentre/BaseData/SystemUser';" >>create-table-info.log 2>&1
sqoop-job --create basedata.systemuser -- import --connect 'jdbc:mysql://backdb:3306/BaseData?characterEncoding%3dutf8mb4' --as-parquetfile -e ' select Id,OldId,AccessFailedCount,EmailConfirmed,LockoutEnabled,LockoutEnd,PhoneNumberConfirmed,TwoFactorEnabled,UserName,NormalizedUserName,Email,NormalizedEmail,PasswordHash,SecurityStamp,ConcurrencyStamp,PhoneNumber,AppUserId,OldAppUserId,UserType,ExpireTime,Seq,EncryptionType,MaxMachineCodeCount,Country,Status,CreateTime,UpdateTime from SystemUser WHERE $CONDITIONS ' -m 10 --password xiefei --username xf --split-by Id --merge-key Id --check-column UpdateTime --incremental lastmodified --target-dir '/datacentre/BaseData/SystemUser' --fields-terminated-by '\0001' --lines-terminated-by '\n' --last-value '1970-01-01 00:00:01.0' >>create-table-info.log 2>&1
rm ./*.java