#!/usr/bin/env bash


./mysql-hivetable.sh DataCentre xf Xffx0826+_ 'jdbc:mysql://alidb:3306/DataCentre?characterEncoding%3dutf8mb4' 'hdfs://ld1:8020'
./mysql-hivetable.sh BaseData xf Xffx0826+_ 'jdbc:mysql://alidb:3306/BaseData?characterEncoding%3dutf8mb4' 'hdfs://ld1:8020'

nohup ./mysql-hdfs.sh DataCentre FileItem,FileLib,FileType,Label,LanguageType,MemoryItem,MemoryLabel,MemoryLib xf 'file:///home/xf/sqoop/.mysql' 'jdbc:mysql://tdb:3306/DataCentre?characterEncoding%3dutf8mb4' >/dev/null 2>&1 &

nohup ./mysql-hdfs.sh BaseData WordsBook,SystemUser,AppUser xf 'file:///home/xf/sqoop/.mysql' 'jdbc:mysql://tdb:3306/BaseData?characterEncoding%3dutf8mb4' >/dev/null 2>&1 &


# export TERM=xterm-color
#drop database basedata cascade ;

