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

# shellcheck disable=SC1091
if [ "$(uname)" = 'Linux' ]; then
    source /usr/share/autojump/autojump.bash
else
    source /usr/local/share/autojump/autojump.bash
fi
