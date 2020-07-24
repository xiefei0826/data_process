#!/usr/bin/env bash

# if [ -f "./JobName" ]; then
#     echo pid:$$ date:" JobName 文件不存在"
# else
#     rm -rf ./JobName
# fi
sqoop-job --list >jobName 2>/dev/null

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
rm -f ./jobName
#  jobName
work_path=$(dirname $(readlink -f $0))
Databases=$1
tableNames=($(echo $2 | tr "," "\n"))
username=$3
passwordfile=$4
connect=$5

# shellcheck disable=SC2068
for tableName in ${tableNames[@]}; do
    typeset -l tmpTableName
    tmpTableName=$tableName
    typeset -l tmpDataBase
    tmpDataBase=$Databases
    # 判断任务是否存在
    # shellcheck disable=SC2199
    # shellcheck disable=SC2076
    if [[ ${#jobArr[*]} -eq 0 ]] || [[ ! ${jobArr[@]} =~ ${tmpTableName} ]]; then

        cmd="hive -e  \"select  column_name from information_schema.columns where table_schema ='${tmpDataBase}' and table_name='${tmpTableName}' order by ordinal_position asc\""
        echo pid:$$ date:$(date "+%Y-%m-%d %H:%M:%S") "CMD:-------------"${cmd} >>createsqoopjob.log

        eval ${cmd} >tabledetial 2>/dev/null

        columnNameStr=""

        columnIndex=0
        isColumnName=0
        while read line; do

            if [[ $isColumnName -gt 1 ]] && [[ ${#line} -gt 0 ]] && [[ ! $line =~ "-" ]]; then
                if [[ $columnIndex == 0 ]]; then
                    columnNameStr=$(echo pid:$$ date:$line | tr "|" "\n")
                else
                    columnNameStr=$columnNameStr,$(echo pid:$$ date:$line | tr "|" "\n")
                fi
                columnIndex=$columnIndex+1
            fi
            isColumnName=$isColumnName+1
        done <tabledetial

        rm -f ./tabledetial
        # -e ' select $columnNameStr from $tableName WHERE \$CONDITIONS ' \
        # -m 10 \
        # --fetch-size 2000  \
        #不存在任务，则创建任务
        echo pid:$$ date:$(date "+%Y-%m-%d %H:%M:%S") "start create sqoop job $Databases"."$tableName" >>createsqoopjob.log
        cmd=" sqoop-job --create $tmpDataBase"."$tmpTableName \
        -- import \
        --connect  $connect \
        --table $tableName \
        --columns  \"$columnNameStr\"
        --password-file $passwordfile \
        --username $username  \
        --split-by Id \
        --merge-key Id  \
        --check-column UpdateTime \
        --incremental lastmodified \
        --target-dir  '/datacentre/$tmpDataBase/$tmpTableName' \
        --fields-terminated-by '\0001' \
        --lines-terminated-by '\n' \
        --last-value '1970-01-01 00:00:01.0'"

        echo pid:$$ date:$(date "+%Y-%m-%d %H:%M:%S") "CMD:-------------"${cmd} >>createsqoopjob.log

        eval $cmd >>createsqoopjob.log 2>/dev/null
        echo pid:$$ date:$(date "+%Y-%m-%d %H:%M:%S") "end create sqoop job $tableName" >>createsqoopjob.log
    fi

done
