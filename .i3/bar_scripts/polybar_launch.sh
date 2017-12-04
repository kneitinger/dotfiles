#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
#while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bars
for i in $(polybar -m | awk -F: '{print $1}'); do
    MONITOR=$i polybar example -c ~/.i3/polybar.conf &
done

echo "Bars launched..."
