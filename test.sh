#!/usr/bin/env bash

# Taken from Jess Frazelle at:
# https://github.com/jessfraz/dotfiles/blob/master/test.sh

set -e

FILES="$(find . \
    -maxdepth 3 -type f -not -iwholename '*.git*' -exec file {} \; \
    | grep 'zsh\|shell' \
    | cut -d':' -f1 \
    | sort)"

for file in $FILES; do
    shellcheck -s bash "$file"
    echo "[ok] $file shellcheck pass"
done
