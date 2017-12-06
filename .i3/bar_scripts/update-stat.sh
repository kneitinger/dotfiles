#!/usr/bin/env bash

UPDATES=( $(checkupdates | wc -l) + $(cower -u -q 2> /dev/null | wc -l) )

if [ $UPDATES != 0 ]; then
    echo "  $UPDATES"
fi
