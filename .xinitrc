#!/bin/sh

# Source the system xinit scripts
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?* ; do
    # shellcheck source=/dev/null
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
xinput set-prop "TPPS/2 IBM TrackPoint" "Device Accel Constant Deceleration" 0.75
synclient VertScrollDelta=-100
synclient HorizScrollDelta=-100
synclient HorizTwoFingerScroll=1
synclient TapButton1=1
synclient TapButton2=3


# Map CapsLock->ctrl, ctrl-tap->Esc
setxkbmap -option ctrl:nocaps
xcape -e 'Control_L=Escape' -t 175

# Load Xresources
if [ -f ~/.Xresources ]; then
    xrdb -merge ~/.Xresources
fi

# Load the current computer's xmodmap file if present
if [ -f "$HOME/.xmodmap_$MODEL" ]; then
    xmodmap "$HOME/.xmodmap_$MODEL"
fi

# Power saving
xbacklight -set 30
xset +dpms
xset dpms 660 0 0

# Lock screen upon suspend, requires AUR package xss-lock-git
xautolock -time 35 -locker "systemctl suspend"&

# Set laptop screen as primary display
xrandr --output eDP-1 --primary

# Call low battery notification daemon
batt-notify &

# Call redshift
redshift &

# If invoked with startx ~/.xinitrc [some entry or path], launch that.
# If invoked as just startx, run i3
#~/Programming/i3/i3 -d all --shmlog-size=26214400
#/home/leaf/Programming/i3/i3
#exec i3
session=${1:-i3}
case $session in
    awesome           ) exec awesome;;
    i3                ) exec i3;;
    sway              ) exec sway;;
    gnome             ) exec gnome-shell;;
    i3-dev            ) exec ~/Programming/i3/i3 -d all --shmlog-size=26214400;;
    ff                ) exec firefox;;
    # No known session, try to run it as command
    *                 ) exec "$1";;
esac
