#!/bin/bash

PATH=/usr/lib/ccache/bin:~/bin:$(ruby -e 'print Gem.user_dir')/bin:/opt:~/.cargo/bin:$PATH

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
source /usr/share/autojump/autojump.bash

rustup -v >/dev/null 2>&1 && { rustup completions bash > ~/.bash-completion; }
