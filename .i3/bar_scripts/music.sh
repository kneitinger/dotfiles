#!/usr/bin/env bash

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
icon=""

player_status=$(playerctl status 2> /dev/null) || exit 1
metadata="[$(playerctl metadata artist) - $(playerctl metadata title)]"

# Foreground color formatting tags are optional
if [[ $player_status = "Playing" ]]; then
    echo "%{F#D08770} $metadata"       # Orange when playing
elif [[ $player_status = "Paused" ]]; then
    echo "%{F#65737E} $metadata"       # Greyed out info when paused
else
    echo "%{F#65737E}$icon"                 # Greyed out icon when stopped
fi
