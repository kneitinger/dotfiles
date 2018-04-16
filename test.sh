#!/usr/bin/env bash

# Taken from Jess Frazelle at:
# https://github.com/jessfraz/dotfiles/blob/master/test.sh

set -e

while read -r file; do
  shellcheck -s bash "$file"
  echo "[ok] $file shellcheck pass"
done < ./test_includes

FILES=$(find ./bin -type f -not -path "*/.*" -not -name "README.md")

for file in $FILES; do
    if file "$file" | grep Bourne 1> /dev/null; then
        shellcheck -s bash "$file"
        echo "[ok] $file shellcheck pass"
    fi
done
