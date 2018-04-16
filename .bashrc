#!/usr/bin/env bash
# shellcheck disable=SC1117

# Declare beautiful colors
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

# Displays the exit code of the last run command if non-zero
prompt_err() {
  local LAST_ERR="$?"
  if [ "$LAST_ERR" -ne 0 ]; then
    echo "$LAST_ERR "
  fi
}

case $TERM in
    xterm*|rxvt*)
        PS1='\[\033]0;\u@\h:\w\007\]'
        ;;
    *)
        PS1=''
        ;;
esac

PS1+="\[${BOLD}${WHITE}\]"
PS1+="\[${RED}\]\$(prompt_err)\[${WHITE}\]"
PS1+="[\[${RESET}\]\[${BLUE}\]\u\\[${BOLD}${GREEN}\]|\[${RESET}\]\[${BLUE}\]\h\[${WHITE}\]:"
PS1+="\[${PURP}\]\W\[${BOLD}${WHITE}\]]"
PS1+="\$(prompt_git)"
PS1+=" \[${WHITE}\]\$\[${RESET}\] "

# shellcheck disable=SC1091
if [ "$(uname)" = 'Linux' ]; then
    source /usr/share/autojump/autojump.bash
else
    [[ -s /home/leaf/.autojump/etc/profile.d/autojump.sh ]] && source /home/leaf/.autojump/etc/profile.d/autojump.sh
fi

# Include modularized config files
for file in ~/.{aliases,path,exports,additional}; do
  if [[ -r "$file" ]] && [[ -f "$file" ]]; then
    # shellcheck source=/dev/null
    source "$file"
  fi
done
unset file

mkcd () {
  mkdir "$1"
  cd "$1" || exit
}


if [ "$(uname)" = 'Linux' ]; then
    BASHC_FILE=/usr/share/bash-completion/bash_completion
else
    BASHC_FILE=/usr/local/share/bash-completion/bash_completion.sh
fi

# shellcheck disable=SC1090
[[ $PS1 && -f "$BASHC_FILE" ]] && \
 	        source "$BASHC_FILE"

if [ "$(hostname)" = 'ziyal' ]; then
    export WORKON_HOME=/home/leaf/work/venv
    # shellcheck disable=SC1091
    source /usr/bin/virtualenvwrapper.sh
    if [[ $- != *i* ]]; then
        workon core
    fi

    complete -C '/home/leaf/work/venv/core/bin/aws_completer' aws
elif [ "$(hostname)" = 'janeway' ]; then
    export WORKON_HOME=/home/leaf/venvs
    # shellcheck disable=SC1091
    source /usr/bin/virtualenvwrapper.sh
elif [ "$(hostname)" = 'troi' ]; then
    VIRTUALENVWRAPPER_PYTHON=$(which python3)
    export VIRTUALENVWRAPPER_PYTHON
    export WORKON_HOME=/home/leaf/venv
    # shellcheck disable=SC1091
    source virtualenvwrapper.sh &> /dev/null
fi

shopt -s autocd

# Alt-h for manpage
bind '"\eh": "\C-a\eb\ed\C-y\e#man \C-y\C-m\C-p\C-p\C-a\C-d\C-e"'

HISTTIMEFORMAT="%y-%m-%d %T "
