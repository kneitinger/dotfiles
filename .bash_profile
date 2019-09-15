#!/usr/bin/env bash

PATH=~/bin:~/.local/bin:~/.cargo/bin:~/.cabal/bin:/opt:~/go/bin:$PATH

# Include modularized config files
for file in ~/.{aliases,path,exports,additional} ~/.bash_completions/*; do
  if [[ -r "$file" ]] && [[ -f "$file" ]]; then
    # shellcheck source=/dev/null
    source "$file"
  fi
done
unset file

# Use system keyring to manage ssh if on MacOS
if [ "$(uname)" != "Darwin" ]; then
    eval "$(ssh-agent)"
fi

if shopt -q login_shell; then
    # shellcheck disable=SC1090
    source "$HOME/.bashrc"
fi
