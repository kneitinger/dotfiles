#!/usr/bin/env bash

echo   $(( $(checkupdates | wc -l) + $(cower -u | wc -l) ))
