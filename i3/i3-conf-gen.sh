#!/bin/sh

set -e

MODEL=$(tr "[:blank:]" "_" < /sys/devices/virtual/dmi/id/product_version | tr "[:upper:]" "[:lower:]")
echo "MODEL is set to $MODEL. All configs in the $MODEL directory will be included"

if [ -e "$HOME"/.i3/config ]; then
  mv "$HOME"/.i3/config "$HOME"/.i3/.config_backup
fi

CONFIGS=$(find "$HOME"/i3/core/* -printf "%f\n")
for conf in $CONFIGS; do
  printf "\n" >> "$HOME"/.i3/config
  cat "$HOME/i3/core/$conf" >> "$HOME"/.i3/config

  if [ -e "$MODEL" ] && [ -e "$HOME/i3/$MODEL/$conf" ]; then
    printf "\n" >> "$HOME"/.i3/config
    cat "$HOME/i3/$MODEL/$conf" >> "$HOME"/.i3/config
  fi
done
