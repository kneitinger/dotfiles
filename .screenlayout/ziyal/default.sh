#!/bin/sh
xrandr --output VIRTUAL1 --off \
       --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
       --output DP-1 --off \
       --output DP-2 --off \
       --output DP-2-1 --off \
       --output DP-2-2 --off \
       --output DP-2-3 --off  \
       --output HDMI-1 --off \
       --output HDMI-2 --off
