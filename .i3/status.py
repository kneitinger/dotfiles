# -*- coding: utf-8 -*-

from i3pystatus import Status

stat = Status(standalone=True)

# Displays clock like this:
# 10/7 22:52
stat.register("clock",
              interval=10,
              on_leftclick="notify-send \"$(cal)\"",
              format="%-m/%-d %-H:%M",)

stat.register("pulseaudio",
              muted=" ",      # Speaker icon w/ no audio coming out
              unmuted="",    # Speaker icon w/ audio coming out
              color_muted="#999999",
              format="{muted} {volume}",
              )

# Indicates charging status of battery in direction, percent and time remaining
stat.register("battery",
              interval=11,
              battery_ident="BAT0",
              critical_color="#ff0000",
              format="{status} {percentage:02.0f}% {remaining:%E%h:%M}",
              alert=False,
              alert_percentage=10,
              status={
                  "DIS": " ↓",
                  "CHR": " ↑",
                  "FULL": " ",
              },)

stat.register("battery",
              interval=13,
              battery_ident="BAT1",
              critical_color="#ff0000",
              format="{status} {percentage:02.0f}% {remaining:%E%h:%M}",
              alert=False,
              alert_percentage=10,
              status={
                  "DIS": " ↓",
                  "CHR": " ↑",
                  "FULL": " ",
              },)

stat.register("network",
              interval=7,
              interface="wlp3s0",
              color_up="#37b3f1",
              color_down="#4e5b62",
              format_up=" {essid}[{v4}]",
              format_down=" ")

stat.register("shell",
              command="~/.i3/status_scripts/lock-stat.sh",
              on_leftclick="~/.i3/status_scripts/lock-toggler.sh",
              interval=2)

stat.register("shell",
              command="~/.i3/status_scripts/update-stat.sh",
              interval=113)

stat.register("shell",
              command="~/.i3/status_scripts/jack-stat.sh",
              interval=7)

stat.register("cpu_usage",
              format="{usage}% cpu",)

stat.run()
