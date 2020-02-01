#!/usr/bin/env bash

PATH=~/bin:~/.local/bin:~/.cargo/bin:~/.cabal/bin:/opt:$PATH

# Use system keyring to manage ssh if on MacOS
if [ "$(uname)" != "Darwin" ]; then
    eval "$(ssh-agent)"
fi

if shopt -q login_shell; then
    # shellcheck disable=SC1090
    source "$HOME/.bashrc"
fi
