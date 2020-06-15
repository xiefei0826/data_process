#!/bin/bash

# if [ -f "./JobName" ]; then
#     echo " JobName 文件不存在"
# else
#     rm -rf ./JobName
# fi

sqoop-job --list >jobName 2>&1

availableJob="Available jobs:"

jobArr=()
tableNum=0
hasJob=0
while read line; do
    if [ $hasJob -gt 0 ]; then

        jobArr[$((tableNum))]=$line
        tableNum=$tableNum+1
    fi

    if [[ $line =~ $availableJob ]]; then
        hasJob=1
    fi

done <jobName

#  jobName
work_path=$(dirname $(readlink -f $0))
Databases=$1
tableNames=($(echo $2 | tr "," "\n"))
username=$3
passwordfile=$4
connect=$5

# while true; do
# shellcheck disable=SC2068
for tableName in ${tableNames[@]}; do

    typeset -l tmpTableName
    tmpTableName=$tableName
    typeset -l tmpDataBase
    tmpDataBase=$Databases
    # 判断任务是否存在
    # shellcheck disable=SC2199
    # shellcheck disable=SC2076
    if [[ ${#jobArr[*]} -eq 0 ]] || [[ ! " ${jobArr[@]} " =~ " ${tmpTableName} " ]]; then
        #不存在任务，则创建任务
        echo "start create sqoop job $Databases"."$tableName"
        cmd=" sqoop-job --create $tmpDataBase"."$tmpTableName
        -- import \n
        --connect  $connect \n
        --table $tableName  \n
        --password-file $passwordfile \n
        --username $username  \n
        --split-by Id \n
        --merge-key Id  \n
        --fetch-size 100  \n
        --check-column UpdateTime \n
        --incremental lastmodified \n
        --target-dir  '/datacentre/$tmpDataBase/$tmpTableName' \n
        --fields-terminated-by '\0001' \n
        --lines-terminated-by '\n' \n
        --last-value '1970-01-01 00:00:01.0'"

        eval $cmd >$tableName"init.log" 2>&1
        echo "end create sqoop job $tableName"
    fi
    # delete job
    # cmd="sqoop-job --delete $tmpTableName"
    # eval $cmd

    # run job
    echo "start run sqoop job $tableName"
    cmd=" sqoop-job --exec $tmpDataBase"."$tmpTableName"
    eval $cmd >$tableName"job.log" 2>&1 &
    echo "end run sqoop job $tableName"

done

echo "end"
#  sqoop-job  --delete cacheitem
