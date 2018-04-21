#!/usr/bin/env bash

echo -n "JACK:"

if jack_control status | grep "stopped" &> /dev/null; then
    echo ;
else
    echo ;
    echo "[$(jack_control dp | grep "device:" | cut -d':' -f7 | cut -d\) -f1)]"
fi
