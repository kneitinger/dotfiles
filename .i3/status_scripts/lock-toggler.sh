#!/usr/bin/env bash

PID=$(pgrep "xautolock")

if [ -n "$PID" ]; then
	pkill "xautolock"
elif [ "$(uname)" = 'Linux' ]; then
	xautolock -time 25 -locker "systemctl suspend"&
else
	xautolock -time 25 -locker "sudo zzz"&
fi




