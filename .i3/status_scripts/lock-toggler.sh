#!/usr/bin/env bash

PID=$(pgrep "xautolock")

if [ -n "$PID" ]; then
	pkill "xautolock"
else
	xautolock -time 25 -locker "systemctl suspend"&
fi




