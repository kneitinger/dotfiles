#!/usr/bin/env bash

PID=$(pgrep "xautolock")

echo -n " sleep:"
if [ -n "$PID" ]; then
	echo -n 
else
	echo -n 
  fi
