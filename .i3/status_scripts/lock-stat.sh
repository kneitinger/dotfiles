#!/bin/bash

PID=$(pgrep "xautolock")

echo -n "Sleep:"
if [ -n "$PID" ]; then
	echo -n 
else
	echo -n 
  fi
