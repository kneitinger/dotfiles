#!/bin/bash

if tput setaf 1 &> /dev/null; then
  tput sgr0
  GREEN=$(tput setaf 10)
  RED=$(tput setaf 1)
  BLUE=$(tput setaf 12)
  PURP=$(tput setaf 13)
  WHITE=$(tput setaf 15)
  BOLD=$(tput bold)
  RESET=$(tput sgr0)
else
  GREEN="\033[1;32m"
  RED="\033[1;31m"
  BLUE="\033[1;34m"
  PURP="\033[1;35m"
  WHITE="\033[1;37m"
  RESET="\033[0m"
  BOLD=""
fi

prompt_git() {
  if git status &> /dev/null; then
    echo -en "(${GREEN}$(git branch | grep "\*" | cut -d\  -f2)${WHITE})"
  else
    return
  fi
}

prompt_err() {
  local LAST_ERR="$?"
  if [ "$LAST_ERR" -ne 0 ]; then
    echo "$LAST_ERR "
  fi
}

PS1="\[${BOLD}${WHITE}\]"
PS1+="${RED}\$(prompt_err)${WHITE}"
PS1+="[${BLUE}\u${WHITE}: ${PURP}\W${WHITE}]"
PS1+="\$(prompt_git)"
PS1+=" \$\[${RESET}\] "


if [[ -f "${HOME}/.bash_profile" ]]; then
	# shellcheck source=/dev/null
	source "${HOME}/.bash_profile"
fi

GPG_TTY=$(tty)
export GPG_TTY
# Start the gpg-agent if not already running
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
	gpg-connect-agent /bye >/dev/null 2>&1
	gpg-connect-agent updatestartuptty /bye >/dev/null
fi
# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
	export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
fi
