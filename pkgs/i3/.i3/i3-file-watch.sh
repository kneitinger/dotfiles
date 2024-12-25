#!/usr/bin/env bash

cd "$HOME/.i3" || exit

# i3-conf-gen.sh creates a lockfile to ensure exclusivity. Since
# i3-file-watch.sh is ran on startup, it can safely remove that directory
# if it happens to exist.
rm -f /tmp/i3-conf-gen.lock

inotifywait -m -r -e modify  --format '%w%f' ./core ./"$HOSTNAME" | while read -r FILE
do
  echo "$FILE changed, regenerating .i3/config"
  ./i3-conf-gen.sh

done
