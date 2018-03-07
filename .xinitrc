#!/usr/bin/env bash

# Source the system xinit scripts
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?* ; do
    # shellcheck source=/dev/null
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Reverse scroll direction
if [ "$HOSTNAME" = "janeway" ]; then
    xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 1
    xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 2
    xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 200
    xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 6 7 4 5
    xinput set-prop "TPPS/2 IBM TrackPoint" "Device Accel Constant Deceleration" 0.75
    xinput set-prop "TPPS/2 IBM TrackPoint" "Device Accel Constant Deceleration" 0.75
fi
synclient VertScrollDelta=-100
synclient HorizScrollDelta=-100
synclient HorizTwoFingerScroll=1
synclient TapButton1=1
synclient TapButton2=3


# Map CapsLock->ctrl, ctrl-tap->Esc
setxkbmap -option ctrl:nocaps

# Ergonomic tap vs. hold keybindings
xcape -e 'Control_L=Escape' -t 175
xcape -e 'Shift_L=parenleft' -t 130
xcape -e 'Shift_R=parenright' -t 130
xcape -e 'Alt_L=Shift_L|bracketleft' -t 130
xcape -e 'Alt_R=Shift_R|bracketright' -t 130
xcape -e 'Super_L=bracketleft' -t 130
if [ "$HOSTNAME" = "janeway" ]; then
    xcape -e 'Print=bracketright' -t 130
else
    xcape -e 'Menu=bracketright' -t 130
fi

# Map a spacebar hold to act as the i3 modifier
xmodmap -e "clear mod3"
xmodmap -e "clear mod4"
xmodmap -e "add mod3 =  Hyper_L"
xmodmap -e "add mod4 = Super_L Super_R"

spare_mod="Hyper_L"
xmodmap -e "keycode 65 = $spare_mod"
xmodmap -e "add Hyper_L = $spare_mod"
xmodmap -e "keycode any = space"
xcape -e "$spare_mod=space"


# Load Xresources
if [ -f ~/.Xresources ]; then
    xrdb -merge ~/.Xresources
fi

# Power saving
xbacklight -set 30
xset +dpms
if [ "$HOSTNAME" = "tunepad" ]; then
    xset dpms 1200 0 0
else
    xset dpms 1260 0 0
fi

# Disable beep!
xset b off

# Lock screen upon suspend, requires AUR package xss-lock-git
if [ "$(uname)" = 'Linux' ]; then
    xautolock -time 25 -locker "systemctl suspend"&
else
    xautolock -time 25 -locker "sudo zzz"&
fi

# Set laptop screen as primary display
case $HOSTNAME in
    janeway | ziyal)
        xrandr --output eDP1 --primary;;
    tunepad)
        xrandr --output LVDS1 --primary;;
esac

# If using music laptop, start JACK and bridge pulseaudio
if [ "$HOSTNAME" = "tunepad" ]; then
    jack_control start
    pactl set-default-sink jack_out
    pactl set-default-source jack_in
fi

# Call low battery notification script to warn when battery below 7 percent
case $HOSTNAME in
    janeway)
        batt-notify -p 7 -t 70 0 1 & ;;
    tunepad|ziyal|troi)
        batt-notify -p 7 -t 70 0 & ;;
esac

# Call redshift
redshift &

# Automatically ecompile i3 config if any of its component files are changed
if [ -e "$HOME/.i3/i3-file-watch.sh" ]; then
    "$HOME"/.i3/i3-file-watch.sh &
fi

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
