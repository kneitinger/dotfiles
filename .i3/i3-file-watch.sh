#!/usr/bin/env bash

cd "$HOME/.i3" || exit

inotifywait -m -r -e modify  --format '%w%f' ./core ./"$HOSTNAME" | while read -r FILE
do
  echo "$FILE changed, regenerating .i3/config"
  ./i3-conf-gen.sh

done
