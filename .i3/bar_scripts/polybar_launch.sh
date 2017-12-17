#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
#while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bars
for i in $(polybar -m | awk -F: '{print $1}'); do
    if xrandr | grep "$i.*primary"; then
        MONITOR_PRIMARY=$i polybar primary -c ~/.i3/polybar.conf &
    else
        MONITOR_AUX=$i polybar aux -c ~/.i3/polybar.conf &
    fi
done

echo "Bars launched..."
