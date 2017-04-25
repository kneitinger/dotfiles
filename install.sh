#!/usr/bin/env bash

FILES=$(find "$PWD" -name ".*" -not -name ".git" -not -name ".gitignore" -not -name ".travis.yml")

for file in $FILES; do
  ln -sfn "$file" "$HOME/$(basename "$file")"
done

"$HOME/.i3/i3-conf-gen.sh"
