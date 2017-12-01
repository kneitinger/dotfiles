#!/usr/bin/env bash

if pidof spotify >/dev/null 2>&1; then
    INFO=$(xwininfo -tree -root \
        | grep '".*-.*".*spotify' \
        | grep -o '".*-[^:]*"' \
        | tr -d '"')
    echo "[$INFO]"
fi
