# -*- coding: utf-8 -*-

import subprocess

from i3pystatus import Status

status = Status(standalone=True)

# Displays clock like this:
# Tue 10/7 22:52
status.register("clock",
    interval=11,
    format="%a %-m/%-d %-H:%M",)

# Widget for volume of speakers
status.register("alsa",
    card=1,
    muted="",      # Speaker icon w/ no audio coming out
    unmuted="",    # Speaker icon w/ audio coming out
    color_muted="#999999",
    mixer="Speaker",
    format="{muted} {volume}",)

# Widget for volume of headphones
status.register("alsa",
    card=1,
    color_muted="#999999",
    mixer="Headphone",
    format=" {volume}",)

# Indicates charging status of battery in direction, percent and time remaining
status.register("battery",
    battery_ident="BAT1",
    critical_color="#ff0000",
    format="{status} {percentage:02.1f}% {remaining:%E%h:%M}",
    alert=False,
    alert_percentage=10,
    status={
        "DIS": " ↓",
        "CHR": " ↑",
        "FULL": " ",
    },)


# Has all the options of the normal network and adds some wireless specific things
# like quality and network names.
#
# Note: requires both netifaces and basiciw
status.register("wireless",
    interface="wlp4s0",
    color_up="#37b3f1",
    color_down="#4e5b62",
    format_up=" {essid}[{quality:03.0f}%/{v4}]",
    format_down=" ")

# Shows disk usage of /
# Format:
# 42/128G [86G]
#status.register("disk",
#    path="/",
#    format="{used}/{total}G [{avail}G]",)

status.register("shell",
        command="echo  updates: $(( $(checkupdates | wc -l) + $(cower -u | wc -l) ))",
        interval=600)

status.register("cpu_usage",
        format="{usage}% cpu",)

status.register("shell",
        command="xprop -id $(xdotool getactivewindow) | grep 'WM_NAME(STRING)' | cut -d'\"' -f2",
        interval=1)

status.run()
