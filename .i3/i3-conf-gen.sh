#!/usr/bin/env bash

set -e

# In some cases, this script can run multiple times, creating a config that
# is repeated once per invocation. Using mkdir as a lock, is sufficient to
# get around this
LOCKFILE=/tmp/i3-conf-gen.lock
if ! mkdir $LOCKFILE 2>/dev/null; then
    echo "i3-conf-gen is already running." >&2
    exit 1
fi
trap 'rm -r $LOCKFILE; exit' INT TERM EXIT


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
elif dunstify -? > /dev/null; then
    dunstify "Rebuilding i3 config for $HOSTNAME"
fi
echo "HOSTNAME is set to $HOSTNAME. All configs in the $HOSTNAME directory will be included"
