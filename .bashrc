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

# Function by Jessie Frazelle
# https://github.com/jessfraz/dotfiles/blob/master/.bash_prompt
prompt_git() {
	local s=''
	local branch=''

	# Check if the current directory is in a Git repository.
	if [ "$(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}")" == '0' ]; then

		# check if the current directory is in .git before running git checks
		if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

			if [[ -O "$(git rev-parse --show-toplevel)/.git/index" ]]; then
				git update-index --really-refresh -q &> /dev/null
			fi;

			# Check for uncommitted changes in the index.
			if ! git diff --quiet --ignore-submodules --cached; then
				s+='+'
			fi;

			# Check for unstaged changes.
			if ! git diff-files --quiet --ignore-submodules --; then
				s+='!'
			fi;

			# Check for untracked files.
			if [ -n "$(git ls-files --others --exclude-standard)" ]; then
				s+='?'
			fi;

			# Check for stashed files.
			if git rev-parse --verify refs/stash &>/dev/null; then
				s+='$'
			fi

		fi

		# Get the short symbolic ref.
		# If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
		# Otherwise, just give up.
		branch="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
			git rev-parse --short HEAD 2> /dev/null || \
			echo '(unknown)')"

		[ -n "${s}" ] && s=" [${s}]"

        echo -e "(\001${GREEN}\002${branch}\001${WHITE}\002)\001${BLUE}\002${s}"
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
PS1+="\[${RED}\]\$(prompt_err)\[${WHITE}\]"
PS1+="[\[${BLUE}\]\u\[${WHITE}\]: \[${PURP}\]\W\[${WHITE}\]]"
PS1+="\$(prompt_git)"
PS1+=" \[${WHITE}\]\$\[${RESET}\] "

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
