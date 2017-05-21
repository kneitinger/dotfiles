#! /usr/bin/env bash

# Credit to Jessie Frazelle: https://github.com/jessfraz/.vim/blob/master/update.sh

set -e

git submodule update --init --recursive
git submodule foreach git pull --recurse-submodules origin master
