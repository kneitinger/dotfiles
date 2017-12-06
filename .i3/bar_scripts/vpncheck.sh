#!/usr/bin/env bash

pgrep openvpn\|l2tp > /dev/null || exit 1

echo $(nmcli c show --active | grep vpn | cut -d' ' -f1)
