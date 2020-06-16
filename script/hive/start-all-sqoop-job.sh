#!/usr/bin/env bash

work_path=$(dirname $(readlink -f $0))

sqoop-job --list >jobName 2>&1

availableJob="Available jobs:"

while true; do
    hasJob=0
    while read line; do
        if [[ ${hasJob} -gt 0 ]]; then
            # run job
            echo "start run sqoop job $tableName" >>runsqoopjob.log
            cmd=" sqoop-job --exec $tmpDataBase"."$tmpTableName"
            eval ${cmd} >>runsqoopjob.log 2>/dev/null
            echo "end run sqoop job $tableName" >>runsqoopjob.log
            rm -f ./*.java
        fi

        if [[ ${line} =~ $availableJob ]]; then
            hasJob=1
        fi

    done <jobName

    if [[ ${hasJob} -eq 0 ]]; then
        echo "no job"
        break
    fi
done
