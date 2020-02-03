#!/usr/bin/env bash

set -e


if [ -e "$HOME"/.i3/config ]; then
  mv "$HOME"/.i3/config "$HOME"/.i3/.config_backup
fi

for conf in "$HOME"/.i3/core/*; do
  # Strip leading path
  conf=${conf##*/}

  echo -e "\\n" >> "$HOME"/.i3/config
  cat "$HOME/.i3/core/$conf" >> "$HOME"/.i3/config
  if [ -e "$HOSTNAME" ] && [ -e "$HOME/.i3/$HOSTNAME/$conf" ]; then
    echo -e "\\n" >> "$HOME"/.i3/config
    cat "$HOME/.i3/$HOSTNAME/$conf" >> "$HOME"/.i3/config
  fi
done

if notify-send -v > /dev/null 2>&1; then
    notify-send "Rebuilding i3 config for $HOSTNAME" || true
fi
echo "HOSTNAME is set to $HOSTNAME. All configs in the $HOSTNAME directory will be included"
