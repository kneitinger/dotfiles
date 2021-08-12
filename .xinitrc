#!/usr/bin/env bash

# Source the system xinit scripts
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?* ; do
    # shellcheck source=/dev/null
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Delegate most setting/daemon commands to .xprofile for flexibility around
# using startx or a display manager
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile


# If invoked with startx ~/.xinitrc [some entry or path], launch that.
# If invoked as just startx, run i3
session=${1:-i3}
case $session in
    i3              ) exec i3;;
    gnome           ) exec gnome-shell;;
    ff              ) exec firefox;;
    xmonad          ) exec xmonad;;
    # No known session, try to run it as command
    *               ) exec "$1";;
esac
