#!/usr/bin/env bash

# Exit upon error
set -e

BLD='\e[1m'
RST='\e[0m'

print_header() {
    echo -e "${BLD}*** $1 ***${RST}"
}

configure_i3 () {
    print_header "Installing i3 files and compiling config"

    "$HOME/.i3/i3-conf-gen.sh"
    mkdir -p "$HOME"/screenshots
}

configure_xorg_fonts () {
    print_header "Installing fonts"
    mkdir -p "$HOME"/.fonts
    curl -L -o /tmp/fantasque_mono.tar.gz \
        https://github.com/belluzj/fantasque-sans/releases/download/v1.7.2/FantasqueSansMono-Normal.tar.gz
    mkdir -p /tmp/fantasque_mono && tar xzf /tmp/fantasque_mono.tar.gz -C /tmp/fantasque_mono
    cp /tmp/fantasque_mono/TTF/* ~/.fonts
    rm -rf /tmp/fantasque_mono*

    fc-cache -f ~/.fonts
}

configure_vim () {
    # Install vim
    print_header "Installing Vim files"

  # Allow nvim/vim to happily coexist
  if [[ ! -d "$HOME"/.config/nvim ]]; then
      mkdir -p "$HOME"/.config/nvim
  fi

  {
      echo "set runtimepath+=~/.vim,~/.vim/after"
      echo "set packpath+=~/.vim"
      echo "source ~/.vimrc"
  } > "$HOME"/.config/nvim/init.vim

  # Create various history directories
  if [[ ! -d "$HOME"/.vim/cache ]]; then
      mkdir -p "$HOME"/.vim/cache/undo
      mkdir -p "$HOME"/.vim/cache/backup
      mkdir -p "$HOME"/.vim/cache/swap
  fi

  ln -sf "$HOME"/.vim/vimrc "$HOME"/.vimrc

  nvim -c "PlugInstall" -c "q" -c "q"
  nvim -c "UpdateRemotePlugins" -c "q"
}

symlink_files () {
    print_header "Copying Files"
    ALL_FFILE_EXCLUDES=".git .gitignore .config .pre-commit-config.yaml"
    MAC_FILE_EXCLUDES=".Xresources .alacritty.yml .fonts.conf .i3 .screenlayout .xinitrc .xmodmap*"
    LINUX_FILE_EXCLUDES=""
    FREEBSD_FILE_EXCLUDES=""

    case $(uname) in
        Darwin)
            EXCLUDES="$ALL_FILE_EXCLUDES $MAC_FILE_EXCLUDES"
            ;;
        Linux)
            EXCLUDES="$ALL_FILE_EXCLUDES $LINUX_FILE_EXCLUDES"
            ;;
        FreeBSD)
            EXCLUDES="$ALL_FILE_EXCLUDES $FREEBSD_FILE_EXCLUDES"
            ;;
        *)
            EXCLUDES="$ALL_FILE_EXCLUDES"
            ;;
    esac

    # TODO: convert to arrays so that this disable can be removed
    #shellcheck disable=SC2086,SC2046
    FILES=$(find "$PWD" -maxdepth 1 -name ".*" $(printf "! -name %s " $EXCLUDES) -o -name "bin")

    for file in $FILES; do
        echo "$file -> $HOME/$(basename "$file")"
        ln -sfn "$file" "$HOME/$(basename "$file")"
    done

    if [[ "$(uname)" != "Darwin" ]]; then
        FILES=$(find "$PWD/.config" -maxdepth 1 -mindepth 1)
        for file in $FILES; do
            echo "$file -> $HOME/.config/$(basename "$file")"
            ln -sfn "$file" "$HOME/.config/$(basename "$file")"
        done
    fi
}

symlink_files
[ "$(uname)" != 'Darwin' ] && configure_i3
configure_vim
