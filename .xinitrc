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
if [ "$MODEL" = "thinkpad_t420s" ]; then
    xset dpms 1200 0 0
else
    xset dpms 1260 0 0
fi

# Lock screen upon suspend, requires AUR package xss-lock-git
xautolock -time 25 -locker "systemctl suspend"&

# Set laptop screen as primary display
case $MODEL in
    thinkpad_t450s)
        xrandr --output eDP-1 --primary;;
    thinkpad_t420s)
        xrandr --output LVDS1 --primary;;
esac

# If using music laptop, start JACK and bridge pulseaudio
if [ "$MODEL" = "thinkpad_t420s" ]; then
    jack_control start
    pactl set-default-sink jack_out
    pactl set-default-source jack_in
fi

# Call low battery notification script to warn when battery below 7 percent
batt-notify -p 6 -t 70 &

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
