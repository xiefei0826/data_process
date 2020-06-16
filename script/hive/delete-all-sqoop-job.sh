#!/usr/bin/env bash

work_path=$(dirname $(readlink -f $0))

sqoop-job --list >jobName 2>/dev/null

availableJob="Available jobs:"
hasJob=0
while read line; do
    if [[ ${hasJob} -gt 0 ]]; then
        sqoop-job --delete ${line} 2>/dev/null
    fi

    if [[ ${line} =~ $availableJob ]]; then
        hasJob=1
    fi

done <jobName
