#!/usr/bin/env bash
# shellcheck disable=SC1117
# shellcheck disable=SC2034
# shellcheck disable=SC1090
# shellcheck disable=SC1091
# shellcheck disable=SC2230

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return;;
esac

# Start ssh-agent if on non-Mac and no ssh-agent is running
if [ "$(uname)" != "Darwin" ]; then
    if ! pgrep -u "$USER" ssh-agent > /dev/null; then
        ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
    fi
    if [[ ! "$SSH_AUTH_SOCK" ]]; then
        source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
    fi
fi

# Declare beautiful colors
RED="\e[31m"    # color1
L_RED="\e[91m"  # color9
GRN="\e[32m"    # color2
L_GRN="\e[92m"  # color10
YLW="\e[33m"    # color3
L_YLW="\e[93m"  # color11
PUR="\e[34m"    # color4
L_PUR="\e[94m"  # color12
PNK="\e[35m"    # color5
L_PNK="\e[95m"  # color13
CYN="\e[36m"    # color6
L_CYN="\e[96m"  # color14
GRY="\e[37m"    # color7
L_GRY="\e[97m"  # color15

BLD="\e[1m"
ITL="\e[3m"
RST="\e[0m"

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
                s+="\001${GRN}\002+"
            fi;

            # Check for unstaged changes.
            if ! git diff-files --quiet --ignore-submodules --; then
                s+="\001${PUR}\002!"
            fi;

            # Check for untracked files.
            if [ -n "$(git ls-files --others --exclude-standard)" ]; then
                s+="\001${RED}\002?"
            fi;

            # Check for stashed files.
            if git rev-parse --verify refs/stash &>/dev/null; then
                s+="\001${YLW}\002\$"
            fi
        fi

        # Get the short symbolic ref.
        # If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
        # Otherwise, just give up.
        branch=" $(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
            git rev-parse --short HEAD 2> /dev/null || \
            echo '(unknown)')"

        [ -n "${s}" ] && s=" (${s}\001${L_GRY}\002)"

        echo -e "on\001${GRN}\002${branch}\001${L_GRY}\002${s} "
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

# Disable fancy prompt for console
case $TERM in
    xterm*|rxvt*)
        PS1="\[${BLD}${ITL}\]"
        PS1+="\[${RED}\]\$(prompt_err)"
        PS1+="\[${L_YLW}\]\u\[${L_GRY}\] at \[${PNK}\]\h\[${L_GRY}\] in "
        PS1+="\[${CYN}\]\W "
        if [ "$(uname)" != "Darwin" ]; then
            PS1+="\[${L_GRY}\]\$(prompt_git)"
        fi
        PS1+="\[${RST}${BLD}${L_PUR}\]\$ \[${RST}\]"
        ;;
    *)
        PS1="[\u@\h:\w] \$ "
        ;;
esac

for file in ~/.{aliases,path,exports,additional,bash_completion.d/*}; do
    if [[ -r "$file" ]] && [[ -f "$file" ]]; then
        source "$file"
    fi
done
unset file

case $(uname) in
    Linux)
        source /etc/profile.d/autojump.bash
        ;;
    FreeBSD)
        [[ -s "$HOME/.autojump/etc/profile.d/autojump.sh" ]] \
            && source "$HOME/.autojump/etc/profile.d/autojump.sh"
        ;;
    Darwin)
        [ -f "$(brew --prefix)/etc/profile.d/autojump.sh" ] && . "$(brew --prefix)/etc/profile.d/autojump.sh"
        ;;
esac

case $(uname) in
    Linux)
        BASHC_FILE=/usr/share/bash-completion/bash_completion
        ;;
    FreeBSD)
        BASHC_FILE=/usr/local/share/bash-completion/bash_completion.sh
        ;;
    Darwin)
        BASHC_FILE=$(brew --prefix)/etc/profile.d/bash_completion.sh
        ;;
esac

[[ -n $PS1 && -f "$BASHC_FILE" ]] && \
    source "$BASHC_FILE"

# Alt-h for manpage
bind '"\eh": "\C-a\eb\ed\C-y\e#man \C-y\C-m\C-p\C-p\C-a\C-d\C-e"'

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

# If this is an xterm set the title to user@host: dir
case "$TERM" in
xterm*|rxvt*)
    # Append and reload history. Use of preexisting PROMPT_COMMAND (if defined)
    # is to enable autojump
    PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a; history -n; "
    # If not in command, set title. e.g. "leaf@janeway: ~"
    PROMPT_COMMAND+='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

    # Show the currently running command in the terminal title:
    # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
    show_command_in_title_bar()
    {
        case "$BASH_COMMAND" in
            *\\033]0*) ;; # Consume escapes
            *) echo -ne "\033]0;${BASH_COMMAND}\007" ;;
        esac
    }
    trap show_command_in_title_bar DEBUG
    ;;
*)
    PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a; history -n" ;;
esac

