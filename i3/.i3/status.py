# -*- coding: utf-8 -*-

import subprocess

from i3pystatus import Status

status = Status(standalone=True)

# Displays clock like this:
# Tue 10/7 22:52
status.register("clock",
    interval=10,
    #on_leftclick= ["notify-send \"\$(cal)\""],
    on_leftclick= "notify-send \"$(cal)\"",
    format="%a %-m/%-d %-H:%M",)

# Widget for volume of speakers
#status.register("alsa",
#    card=1,
#    muted="",      # Speaker icon w/ no audio coming out
#    unmuted="",    # Speaker icon w/ audio coming out
#    color_muted="#999999",
#    mixer="Speaker",
#    format="{muted} {volume}",)

# Widget for volume of headphones
#status.register("alsa",
#    card=1,
#    color_muted="#999999",
#    mixer="Headphone",
#    interval=7,
#    format=" {volume}",)

status.register("pulseaudio",
    muted=" ",      # Speaker icon w/ no audio coming out
    unmuted="",    # Speaker icon w/ audio coming out
    color_muted="#999999",
    format="{muted} {volume}",
    )

# Indicates charging status of battery in direction, percent and time remaining
status.register("battery",
    interval=11,
    battery_ident="BAT0",
    critical_color="#ff0000",
    format="{status} {percentage:02.1f}% {remaining:%E%h:%M}",
    alert=False,
    alert_percentage=10,
    status={
        "DIS": " ↓",
        "CHR": " ↑",
        "FULL": " ",
    },)

status.register("battery",
    interval=13,
    battery_ident="BAT1",
    critical_color="#ff0000",
    format="{status} {percentage:02.1f}% {remaining:%E%h:%M}",
    alert=False,
    alert_percentage=10,
    status={
        "DIS": " ↓",
        "CHR": " ↑",
        "FULL": " ",
    },)

# Has all the options of the normal network and adds some wireless specific things
# like quality and network names.
#
# Note: requires both netifaces and basiciw
status.register("network",
    interval=7,
    interface="wlp3s0",
    color_up="#37b3f1",
    color_down="#4e5b62",
    format_up=" {essid}[{quality:03.0f}%/{v4}]",
    format_down=" ")

# Shows disk usage of /
# Format:
# 42/128G [86G]
#status.register("disk",
#    path="/",
#    format="{used}/{total}G [{avail}G]",)

status.register("shell",
        command="printf %s%s \"   updates:$(( $(checkupdates | wc -l) + $(cower -u | wc -l) ))\"",
        #command="checkupdates | wc -l",
        #command="printf %s uname",
        interval=113)

status.register("shell",
        command=" printf \"%s%s %s\" $(echo JACK:) $(if jack_control status | grep \"stopped\" &> /dev/null; then echo \"\"; else echo \"\"; fi) $(if jack_control status | grep \"started\" &> /dev/null; then echo \" [\"; jack_control dp | grep \"device\:\" | cut -d\: -f7 | cut -d\) -f1; echo \"]\" ; else echo \"\"; fi)",
        #command="checkupdates | wc -l",
        #command="printf %s uname",
        interval=7)

status.register("cpu_usage",
        format="{usage}% cpu",)

#status.register("shell",
#        command="printf %s $(xprop -id $(xdotool getactivewindow) | grep 'WM_NAME(STRING)' | cut -d'\"' -f2)",
#        interval=0.1)

status.run()
