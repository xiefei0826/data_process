#!/usr/bin/env bash

work_path=$(dirname $(readlink -f $0))

sqoop-job --list >jobName 2>&1

availableJob="Available jobs:"

while true; do
    hasJob=0
    while read line; do
        if [[ ${hasJob} -gt 0 ]]; then
            # run job
            echo pid:$$ date:$(date "+%Y-%m-%d %H:%M:%S") "start run sqoop job $line" >>runsqoopjob.log
            cmd=" sqoop-job --exec $line"
            echo pid:$$ date:$(date "+%Y-%m-%d %H:%M:%S") "CMD:-------------${cmd}" >>runsqoopjob.log
            eval ${cmd} >>runsqoopjob.log 2>&1
            echo pid:$$ date:$(date "+%Y-%m-%d %H:%M:%S") "end run sqoop job $line" >>runsqoopjob.log
            rm -f ./*.java
        fi

        if [[ ${line} =~ $availableJob ]]; then
            hasJob=1
        fi

    done <jobName
    break

    if [[ ${hasJob} -eq 0 ]]; then
        echo pid:$$ date:"no job"
        break
    fi
done
