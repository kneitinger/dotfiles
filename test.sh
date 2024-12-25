#!/usr/bin/env bash

set -e

FILES=$(git ls-files | xargs file | grep '.*: .*\(zsh\|shell\)' | cut -d':' -f1 | sort)

for file in $FILES; do
    shellcheck -x -s bash "$file"
    echo "[ok] $file shellcheck pass"
done
