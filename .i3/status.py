# -*- coding: utf-8 -*-

from i3pystatus import Status
from socket import gethostname
from shutil import which
import os


uname = os.uname()
hostname = gethostname()

stat = Status(standalone=True)

# Displays clock like this:
# 10/7 22:52 UTC

# Date highlighting on FreeBSD is interpreted weirdly by notify-send.
# Disable it with the -h flag
cal_flag = ' -h' if 'FreeBSD' in uname[0] else ''
cal_cmd = "notify-send 'Calendar' \"<tt>$(cal{})</tt>\"".format(cal_flag)

stat.register("clock",
              interval=3,
              on_leftclick=cal_cmd,
              on_rightclick=['scroll_format', 1],
              format=[("%-m/%-d %-H:%M %Z", "America/Los_Angeles"),
                      ("%-m/%-d %-H:%M %Z", "UTC")],)

stat.register("pulseaudio",
              muted="Vol:",   # Speaker icon w/ no audio coming out
              unmuted="Vol:",  # Speaker icon w/ audio coming out
              color_muted="#999999",
              format="{muted}{volume}",
              )

# Indicates charging status of battery in direction, percent and time remaining
if "Linux" in uname[0]:
    stat.register("battery",
                  interval=11,
                  battery_ident="BAT0",
                  critical_color="#ff0000",
                  format="{status} {percentage:02.0f}% {remaining:%E%h:%M}",
                  alert=False,
                  alert_percentage=10,
                  status={
                      "DIS": u"()",
                      "CHR": u"()",
                      "FULL": u"(-)",
                  },)
    if "janeway" in hostname:
        stat.register("battery",
                      interval=13,
                      battery_ident="BAT1",
                      critical_color="#ff0000",
                      format="{status} {percentage:02.0f}%"
                             " {remaining:%E%h:%M}",
                      alert=False,
                      alert_percentage=10,
                      status={
                          "DIS": u"()",
                          "CHR": u"()",
                          "FULL": u"(-)",
                      },)

if "FreeBSD" in uname[0]:
    stat.register("shell",
                  command="~/.i3/status_scripts/freebsd-batt.py 0",
                  interval=2)


stat.register("network",
              interval=7,
              interface="wlp3s0",
              color_up="#70F7AA",           # $sand in .i3 config
              color_down="#CCCCCC",
              format_up=" {essid}\[{v4}\]",
              format_down=" ")

stat.register("shell",
              command="~/.i3/status_scripts/lock-stat.sh",
              on_leftclick="~/.i3/status_scripts/lock-toggler.sh",
              interval=2)

if which('pacman') is not None:
    stat.register("shell",
                  command="~/.i3/status_scripts/update-stat.sh",
                  interval=113)

if which('jack') is not None:
    stat.register("shell",
                  command="~/.i3/status_scripts/jack-stat.sh",
                  interval=7)

if "Linux" in uname[0]:
    stat.register("shell",
                  command="~/.i3/status_scripts/spotify_song.sh",
                  interval=4)

stat.run()
