#!/bin/sh

# Source the system xinit scripts
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?* ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Reverse scroll direction
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 1
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 2
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 200
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 6 7 4 5
xinput set-prop "TPPS/2 IBM TrackPoint" "Device Accel Constant Deceleration" 0.75
synclient VertScrollDelta=-100

# Map CapsLock->ctrl, ctrl-tap->Esc
setxkbmap -option ctrl:nocaps
xcape -e 'Control_L=Escape' -t 175

# Load Xresources
if [ -f ~/.Xresources ]; then
    xrdb -merge ~/.Xresources
fi

# Power saving
xautolock -time 12 -locker "systemctl suspend" &
xbacklight -set 30
xset +dpms
xset dpms 660 0 0

# If invoked with startx ~/.xinitrc [some entry or path], launch that.
# If invoked as just startx, run i3
session=${1:-i3}
case $session in
    awesome           ) exec awesome;;
    i3                ) exec i3;;
    i3-dev            ) exec ~/Programming/i3/i3 -d all --shmlog-size=26214400;;
    ff                ) exec firefox;;
   # No known session, try to run it as command
    *                 ) exec $1;;
esac
