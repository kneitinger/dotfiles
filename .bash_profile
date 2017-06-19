#!/usr/bin/env bash

PATH=~/bin:~/.cargo/bin:~/.cabal/bin:$PATH

# Include modularized config files
for file in ~/.{aliases,path,exports,additional}; do
  if [[ -r "$file" ]] && [[ -f "$file" ]]; then
    # shellcheck source=/dev/null
    source "$file"
  fi
done
unset file

# Disregard case-ness in pathname expansion
shopt -s nocaseglob
# Append to bash history
shopt -s histappend
# Fix typos in directories!
shopt -s cdspell

if which syncthing > /dev/null && ! pgrep -x "syncthing" > /dev/null 2>&1; then
    syncthing --gui-address="http://localhost:8384" > /dev/null 2>&1 &
fi

# shellcheck disable=SC1090
if [ -f ~/.bashrc ]; then
    source ~/.bashrc;
fi

