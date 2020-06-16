#!/usr/bin/env bash

work_path=$(dirname $(readlink -f $0))

Databases=$1
mysqlTableNames=($(echo $2 | tr "," "\n"))
username=$3
passwordfile=$4
connect=$5
hdfsaddress=$6

typeset -l tmpDatabase
tmpDatabase=${Databases}

hive -e "  create database if not exists  $tmpDatabase "

cmd="hive -e \"select table_name from information_schema.tables  where table_schema='$tmpDatabase'  ;\""
eval $cmd >$tmpDatabase"hive.table" 2>/dev/null
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

rm -f ./${tmpDatabase}"hive.table"

# shellcheck disable=SC2068
for mysqlTable in ${mysqlTableNames[@]}; do
    typeset -l tmpTableName
    tmpTableName=$mysqlTable
    # shellcheck disable=SC2199
    # shellcheck disable=SC2076
    if [[ ! " ${hiveTableNames[@]} " =~ " ${tmpTableName} " ]]; then
        cmd="sqoop-create-hive-table  \
        --connect $connect \
        --username $username \
        --password-file $passwordfile \
        --table $mysqlTable \
        --hive-database  $tmpDatabase  \
        --fields-terminated-by '\0001'  \
        --lines-terminated-by '\n'"

        echo " start create hive table $tmpDatabase.$tmpTableName" >>createhvietable.log
        eval ${cmd} >>createhvietable.log 2>/dev/null
        hive -e "ALTER TABLE $tmpDatjpabase.$tmpTableName SET LOCATION '$hdfsaddress/datacentre/$tmpDatabase/$tmpTableName';" >>createhvietable.log 2>/dev/null

        echo " end create hive table $tmpDatabase.$tmpTableName" >>createhvietable.log

    fi
done
