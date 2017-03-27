#!/bin/bash

echo   $(( $(checkupdates | wc -l) + $(cower -u | wc -l) ))
