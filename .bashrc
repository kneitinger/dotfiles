#!/usr/bin/env bash
# shellcheck disable=SC1090

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

for file in ~/.{aliases,path,exports,additional}; do
  if [[ -r "$file" ]] && [[ -f "$file" ]]; then
    source "$file"
  fi
done
unset file

# On bash >=4.3 -1 sets infinite history, MacOS (as of 10.14.6) ships with 3.2
if [ "$(uname)" = 'Darwin' ]; then
  HISTSIZE=100000
  HISTFILESIZE=100000
else
  HISTSIZE=-1
  HISTFILESIZE=-1
fi

HISTCONTROL=ignoreboth
shopt -s histappend

PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a; history -n"

