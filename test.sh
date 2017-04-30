#!/usr/bin/env bash

# Taken from Jess Frazelle at:
# https://github.com/jessfraz/dotfiles/blob/master/test.sh

set -e

# find all executables and run `shellcheck`
FILES=$(find . -type f -not -path "*/\.*" -not -name "LICENSE" -not -name "README.md")

for file in $FILES; do
  shellcheck -s bash "$file"
  echo "[ok] $file shellcheck pass"
done
