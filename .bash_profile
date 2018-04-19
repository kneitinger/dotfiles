#!/usr/bin/env bash

PATH=~/bin:~/.local/bin:~/.cargo/bin:~/.cabal/bin:/opt:$PATH

# Include modularized config files
for file in ~/.{aliases,path,exports,additional}; do
  if [[ -r "$file" ]] && [[ -f "$file" ]]; then
    # shellcheck source=/dev/null
    source "$file"
  fi
done
unset file

export SSH_AUTH_SOCK=~/.ssh/ssh-agent.$HOSTNAME.sock
ssh-add -l 2>/dev/null >/dev/null
if [ $? -ge 2 ]; then
  ssh-agent -a "$SSH_AUTH_SOCK" >/dev/null
fi

