#!/bin/sh
xrandr \
  --output eDP --off \
  --output HDMI-A-0 --off \
  --output DisplayPort-0 --off \
  --output DisplayPort-1 --off \
  --output DisplayPort-2 --off \
  --output DisplayPort-3 --off \
  --output DisplayPort-4 --primary --mode 2560x1440 --pos 0x0 --rotate normal
