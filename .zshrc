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

autoload -Uz compinit
compinit

#
# History settings
#
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
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
    text=$( [ $# -lt 1 ] && read -e || echo "$*" )
    printf "%%{\x1b[3m%%}%%B%s%%b" "$text"
}

color () {
    # Requires at least one arg. First arg is the desired color code
    # following args are the text to color (if omitted, stdin will be used)
    text=$( [ $# -lt 2 ] && read -e || echo "${@:2}")
    printf "%%F{$1}%s%%f" "$text"
}

precmd () { print -Pn "\e]0;$TITLE\a"; }
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
PROMPT="$(boldital $PROMPT) "

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

# vim mode
bindkey -v

# Up/Ctrl-k and Down/Ctrl-j search through history beginning with what
# has already been typed.  The -end variant means the cursor is placed at
# the end of each history item, instead of where it already was
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
bindkey "^k" history-beginning-search-backward-end
bindkey "^j" history-beginning-search-forward-end

# Home/End move cursor to the beginning and end of the line, respectively
bindkey  "^[[H" beginning-of-line
bindkey  "^[[F" end-of-line
