#!/bin/sh

MODEL=$(tr "[:blank:]" "_" < /sys/devices/virtual/dmi/id/product_version | tr "[:upper:]" "[:lower:]")

cd "$HOME/.i3" || exit

inotifywait -m -r -e modify  --format '%w%f' ./core ./"$MODEL" | while read -r FILE
do
  echo "$FILE changed, regenerating .i3/config"
  ./i3-conf-gen.sh

done
