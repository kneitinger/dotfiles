#!/usr/bin/env python3

import sys
import subprocess

batt = sys.argv[1]

c = subprocess.run(['acpiconf', '-i', batt], stdout=subprocess.PIPE)
out = c.stdout.splitlines()

info = {}

for l in out:
    l = str(l, 'utf-8')
    pos = str(l).find(':')
    k = ''.join(w for w in str(l)[:pos].title() if w.isalpha())
    v = str(l)[pos+1:].strip('\t').split(' ')[0]
    info[k] = v

if info['State'] == 'charging':
    text = info['RemainingCapacity']
    icon = "()"
elif info['State'] == 'discharging':
    text = "{} {}".format(info['RemainingCapacity'], info['RemainingTime'])
    icon = "()"
else:
    text = info['RemainingCapacity']
    icon = "(-)"

print("{} {}".format(icon, text))


