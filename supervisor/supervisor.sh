#!/bin/bash

function msg {
    echo "no one can stop us right now..."
}

function terminate {
    echo "Sending SIGTERM to process $1"
    kill -TERM $1
    exit
}

bash task1.sh &
task1PID=$!

trap msg SIGINT
trap "terminate $task1PID" SIGTERM

while true; do
    kill -0 $task1PID 2>/dev/null >/dev/null
    if [ $? -ne 0 ]
    then
        echo "task 1 is not running..."
        bash task1.sh &
        task1PID=$!
    fi
    sleep 5
done

exit $?
