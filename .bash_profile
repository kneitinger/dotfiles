#!/usr/bin/env bash

PATH=~/bin:~/.local/bin:~/.cargo/bin:~/.cabal/bin:/opt:~/go/bin:$PATH

# Include modularized config files
for file in ~/.{aliases,path,exports,additional}; do
  if [[ -r "$file" ]] && [[ -f "$file" ]]; then
    # shellcheck source=/dev/null
    source "$file"
  fi
done
unset file

eval "$(ssh-agent)"

if shopt -q login_shell; then
    # shellcheck disable=SC1090
    source "$HOME/.bashrc"
fi
