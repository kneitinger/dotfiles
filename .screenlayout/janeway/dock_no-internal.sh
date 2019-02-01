#!/bin/bash
xrandr --output VIRTUAL1 --off \
       --output eDP1 --off \
       --output DP1 --off \
       --output DP2-1 --off \
       --output DP2-2 --crtc 1 --mode 1920x1080 --pos 0x0 --rotate normal \
       --output DP2-3 --primary --crtc 0 --mode 1920x1080 --pos 1920x0 --rotate normal \
       --output DP2-3 --off \
       --output HDMI2 --off \
       --output HDMI1 --off \
       --output DP2 --off




