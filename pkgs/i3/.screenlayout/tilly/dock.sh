#!/bin/sh

# Sometimes the monitors are detected as DP-3/DP-4, sometimes DP-5/DP-6...try both
xrandr \
  --output eDP --off \
  --output HDMI-A-0 --off \
  --output DisplayPort-0 --off \
  --output DisplayPort-1 --off \
  --output DisplayPort-2 --off \
  --output DisplayPort-3 --primary --mode 2560x1440 --pos 0x0 --rotate normal \
  --output DisplayPort-4 --mode 2560x1440 --pos 2560x0 --rotate normal \
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
  --output DisplayPort-6 --mode 2560x1440 --pos 2560x0 --rotate normal
