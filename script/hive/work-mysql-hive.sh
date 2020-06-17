#!/usr/bin/env bash

./create-hive-table.sh DataCentre FileItem,FileLib,FileType,Label,LanguageType,MemoryItem,MemoryLabel,MemoryLib xf 'file:///home/xf/sqoop/.mysql' 'jdbc:mysql://backdb:3306/DataCentre?characterEncoding%3dutf8mb4' 'hdfs://s2:8020'

./create-hive-table.sh BaseData WordsBook,SystemUser,AppUser xf 'file:///home/xf/sqoop/.mysql' 'jdbc:mysql://backdb:3306/BaseData?characterEncoding%3dutf8mb4' 'hdfs://s2:8020'

./create-sqoop-job.sh DataCentre FileItem,FileLib,FileType,Label,LanguageType,MemoryItem,MemoryLabel,MemoryLib xf 'file:///home/xf/sqoop/.mysql' 'jdbc:mysql://backdb:3306/DataCentre?characterEncoding%3dutf8mb4'

./create-sqoop-job.sh BaseData WordsBook,SystemUser,AppUser xf 'file:///home/xf/sqoop/.mysql' 'jdbc:mysql://backdb:3306/BaseData?characterEncoding%3dutf8mb4'

# export TERM=xterm-color
#drop database basedata cascade ;
