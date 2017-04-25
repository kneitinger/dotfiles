#!/usr/bin/env bash

set -e

echo "HOSTNAME is set to $HOSTNAME. All configs in the $HOSTNAME directory will be included"

if [ -e "$HOME"/.i3/config ]; then
  mv "$HOME"/.i3/config "$HOME"/.i3/.config_backup
fi

for conf in "$HOME"/.i3/core/*; do
  echo -e "\n" >> "$HOME"/.i3/config
  cat "$HOME/.i3/core/$conf" >> "$HOME"/.i3/config
  if [ -e "$HOSTNAME" ] && [ -e "$HOME/.i3/$HOSTNAME/$conf" ]; then
    echo -e "\n" >> "$HOME"/.i3/config
    cat "$HOME/.i3/$HOSTNAME/$conf" >> "$HOME"/.i3/config
  fi
done
