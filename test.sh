#!/usr/bin/env bash

# Taken from Jess Frazelle at:
# https://github.com/jessfraz/dotfiles/blob/master/test.sh

set -e

# find all executables and run `shellcheck`
#find . -type f -not -iwholename '*.git*' -exec shellcheck {} \;

while read -r file; do
  shellcheck -s bash "$file"
  echo "[ok] $file shellcheck pass"
done < ./test_includes
