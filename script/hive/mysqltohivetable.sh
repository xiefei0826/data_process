#!/bin/bash

# select   TABLE_NAME from information_schema.TABLES where TABLE_SCHEMA='DataCentre';
# select table_name from information_schema.tables  where table_schema='datacentre';
work_path=$(dirname $(readlink -f $0))
# hive -e "select table_name from information_schema.tables  where table_schema='datacentre';" >datacentrehive.table 2>/dev/null

Databases=$1
username=$2
password=$3
connect=$4
hdfsaddress=$5

typeset -l tmpDatabase
tmpDatabase=$Databases

hive -e "  create database if not exists  $tmpDatabase "

cmd=" mysql -u $username -p$password -h tdb -e \"select   TABLE_NAME from information_schema.TABLES where TABLE_SCHEMA='$Databases';\""
eval $cmd >$tmpDatabase"mysql.table"
# mysql table name array
mysqlTableNames=()
tableNum=0
isTableName=0
while read line; do

    if [[ $isTableName -gt 0 ]] && [[ ${#line} -gt 0 ]]; then
        mysqlTableNames[$((tableNum))]=$line
        tableNum=$tableNum+1
    fi

    isTableName=$isTableName+1

done <$tmpDatabase"mysql.table"

cmd="hive -e \"select table_name from information_schema.tables  where table_schema='$tmpDatabase'  ;\""
eval $cmd >$tmpDatabase"hive.table"
hiveTableNames=()
tableNum=0
isTableName=0
while read line; do

    if [[ $isTableName -gt 1 ]] && [[ ${#line} -gt 0 ]] && [[ ! $line =~ "-" ]]; then
        hiveTableNames[$((tableNum))]=$(echo $line | tr "|" "\n")
        tableNum=$tableNum+1
    fi
    isTableName=$isTableName+1
done <$tmpDatabase"hive.table"

# shellcheck disable=SC2068
for mysqlTable in ${mysqlTableNames[@]}; do
    typeset -l tmpTableName
    tmpTableName=$mysqlTable
    # shellcheck disable=SC2199
    # shellcheck disable=SC2076
    if [[ ! " ${hiveTableNames[@]} " =~ " ${tmpTableName} " ]]; then
        cmd="sqoop-create-hive-table  \n
        --connect $connect \n
        --username $username \n
        --password $password \n
        --table $mysqlTable \n
        --hive-database  $tmpDatabase  \n
        --fields-terminated-by '\0001'  \n
        --lines-terminated-by '\n'"

        echo " start create hive table $tmpDatabase.$tmpTableName"
        eval $cmd >/dev/null 2>&1
        hive -e "ALTER TABLE $tmpDatabase.$tmpTableName SET LOCATION '$hdfsaddress/datacentre/$tmpDatabase/$tmpTableName';" >/dev/null 2>&1
        # hive -e "ALTER TABLE $tmpDatabase.$tmpTableName SET TBLPROPERTIES ('EXTERNAL'='TRUE');" >/dev/null
        echo " end create hive table $tmpDatabase.$tmpTableName"

    fi

    # hive -e "drop table $tmpDatabase.$tmpTableName "
done

echo "end"
