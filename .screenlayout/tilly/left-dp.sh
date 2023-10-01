#!/bin/sh

# Sometimes the left monitor gets detected as DP-3, sometime DP-5...try both
xrandr \
  --output eDP --off \
  --output HDMI-A-0 --off \
  --output DisplayPort-0 --off \
  --output DisplayPort-1 --off \
  --output DisplayPort-2 --off \
  --output DisplayPort-3 --primary --mode 2560x1440 --pos 0x0 --rotate normal \
  --output DisplayPort-4 --off \
  --output DisplayPort-5 --off \
  --output DisplayPort-6 --off \
|| \
xrandr \
  --output eDP --off \
  --output HDMI-A-0 --off \
  --output DisplayPort-0 --off \
  --output DisplayPort-1 --off \
  --output DisplayPort-2 --off \
  --output DisplayPort-3 --off \
  --output DisplayPort-4 --off \
  --output DisplayPort-5 --primary --mode 2560x1440 --pos 0x0 --rotate normal \
  --output DisplayPort-6 --off \
