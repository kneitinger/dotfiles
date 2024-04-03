#!/usr/bin/env zsh
# shellcheck disable=SC1087
# shellcheck disable=SC1090
# shellcheck disable=SC2034
# shellcheck disable=SC2154

ZVM_INIT_MODE=sourcing

# shellcheck source=/dev/null
source "${ZDOTDIR:-$HOME}"/.antidote/antidote.zsh
antidote load

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=12"
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
zstyle ':fzf-tab:*' continuous-trigger \\
#
# Imports
#
. "$HOME/.aliases"
. "$HOME/.path"
. "$HOME/.exports"

fpath+=~/.zfunc

#
# Completion settings
#
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/leaf/.zshrc'
# Remove need to manually execute `rehash` after changes to $PATH
zstyle ':completion:*' rehash true

# Find ALL user procs when tab completeing procs
# shellcheck disable=SC2016
zstyle ':completion:*:processes' command 'NOCOLORS=1 ps -U $(whoami)|sed "/ps/d"'
zstyle ':completion:*:processes' insert-ids menu yes select
zstyle ':completion:*:processes-names' command 'NOCOLORS=1 ps xho command|sed "s/://g"'
zstyle ':completion:*:processes' sort false

if type brew &>/dev/null; then
  # shellcheck disable=SC2206
  fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
fi

autoload -Uz compinit
compinit

for f in key-bindings completion; do
  [ -f "/usr/share/fzf/$f.zsh" ] && source "/usr/share/fzf/$f.zsh"
  type brew &>/dev/null && [ -f "$(brew --prefix)/opt/fzf/shell/$f.zsh" ] && source "$(brew --prefix)/opt/fzf/shell/$f.zsh"
done

if type kubectl &>/dev/null; then
  kubectl completion zsh > "${fpath[1]}/_kubectl"
fi

#
# History settings
#
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000000

#
# OPTS
#
unsetopt autocd beep extendedglob nomatch notify

#
# Prompt construction
#

# Format helping wrappers
boldital () {
    # If args are present, they are treated as the text to format.  If no
    # args are present, stdin contents are wrapped with the formatters
    text=$( [ $# -lt 1 ] && read -re || echo "$*" )
    printf "%%{\x1b[3m%%}%%B%s%%b" "$text"
}

color () {
    # Requires at least one arg. First arg is the desired color code
    # following args are the text to color (if omitted, stdin will be used)
    text=$( [ $# -lt 2 ] && read -re || echo "${@:2}")
    printf "%%F{$1}%s%%f" "$text"
}

# shellcheck disable=SC2016
precmd () { print -n '\e]2;$TITLE\a'; }
title() { export TITLE="$*"; }

PROMPT=
# Yellow user
PROMPT+="$(color 11 %n) "
# Salmon host
PROMPT+="at $(color 13 %m) "
# Turquoise directory
PROMPT+="in $(color 14 %1~) "
PROMPT+='$'
# Entire prompt bolded and italicized
PROMPT="$(boldital "$PROMPT") "

# Right-side prompt displays timestamp and exit status of previous command
# %D -> YY-MM-DD
# %* -> HH:MM:SS (24 hr)
# %? -> previous command integer exit status
RPROMPT="%D %* (%?)"

# Undefine functions used in the prompt string generation
unfunction boldital color

#
# Bindings
#

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

# terminfo array comes from zsh bundled module "terminfo"
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Esc-Period]="\e."
key[Ctrl-J]="^j"
key[Ctrl-K]="^k"
key[Alt-H]="^[h"
key[Alt-L]="^[l"
key[Alt-U]="^[u"
key[Alt-Shift-H]="^[H"
key[Alt-Shift-L]="^[L"


safe_bind () {
  # $1 -> key (in $key array), such as "Delete"
  # $2 action, such as history-search-end
  [[ -n "${key[$1]}" ]] \
    && bindkey -- "${key[$1]}" "$2" \
    || echo "No value set for \${key[$1]}. Not mapping $2"
}

# Up/Ctrl-k and Down/Ctrl-j search through history beginning with what
# has already been typed.  The -end variant means the cursor is placed at
# the end of each history item, instead of where it already was
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
safe_bind Up history-beginning-search-backward-end
safe_bind Down history-beginning-search-forward-end
safe_bind Ctrl-K history-beginning-search-backward-end
safe_bind Ctrl-J history-beginning-search-forward-end

# Home/End move cursor to the beginning and end of the line, respectively
safe_bind Home beginning-of-line
safe_bind End end-of-line
safe_bind Alt-H backward-word
safe_bind Alt-L forward-word
safe_bind Alt-Shift-H backward-kill-word
safe_bind Alt-Shift-L kill-word

safe_bind Alt-U undo

# esc then period, for insertion of last word
safe_bind Esc-Period insert-last-word

safe_bind Delete delete-char

unfunction safe_bind

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx; }
	function zle_application_mode_stop { echoti rmkx; }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi


autoload -Uz add-zsh-hook

function xterm_title_precmd () {
	print -Pn -- '\e]2;%n@%m %~\a'
}

function xterm_title_preexec () {
  # shellcheck disable=SC2296
	print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
}

if [[ "$TERM" == alacritty* ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

for f in "$HOME"/.overrides/*; do
  source "$f"
done
