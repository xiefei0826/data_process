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
echo pid:$$ date:$(date "+%Y-%m-%d %H:%M:%S") "CMD:-------------"${cmd} >>createhvietable.log
eval $cmd >$tmpDatabase"hive.table" 2>/dev/null
hiveTableNames=()
tableNum=0
isTableName=0
while read line; do

    if [[ $isTableName -gt 1 ]] && [[ ${#line} -gt 0 ]] && [[ ! $line =~ "-" ]]; then
        hiveTableNames[$((tableNum))]=$(echo pid:$$ date:$line | tr "|" "\n")
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
    if [[ ! ${hiveTableNames[@]} =~ ${tmpTableName} ]]; then
        sql="select * from "$mysqlTable" WHERE Id and \$CONDITIONS"
        cmd="sqoop import  \
        -e  "$sql" --hive-import \
        --create-hive-table \
        --hive-table $tmpTableName \
        --connect $connect \
        --username $username \
        --password-file $passwordfile \
        --hive-database  $tmpDatabase  \
        --split-by Id \
        --merge-key Id \
        --fields-terminated-by '\0001'  \
        --lines-terminated-by '\n'"

        echo pid:$$ date:$(date "+%Y-%m-%d %H:%M:%S") "CMD:-------------""${cmd}" >>createhvietable.log

        echo pid:$$ date:$(date "+%Y-%m-%d %H:%M:%S") " start create hive table $tmpDatabase.$tmpTableName" >>createhvietable.log
        eval "$cmd"

        # $("$cmd") >>createhvietable.log 2>&1
        cmd="hive -e \"ALTER TABLE $tmpDatabase.$tmpTableName SET LOCATION '$hdfsaddress/datacentre/$tmpDatabase/$tmpTableName';\""
        echo pid:$$ date:$(date "+%Y-%m-%d %H:%M:%S") "CMD:-------------"${cmd} >>createhvietable.log
        # eval ${cmd} >>createhvietable.log 2>&1

        echo pid:$$ date:$(date "+%Y-%m-%d %H:%M:%S") " end create hive table $tmpDatabase.$tmpTableName" >>createhvietable.log

    fi
done

echo pid:$$ date:$(date "+%Y-%m-%d %H:%M:%S") end
