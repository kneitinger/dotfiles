#!/usr/bin/env bash

# Exit upon error
set -e

BLD='\e[1m'
RST='\e[0m'

print_header() {
    echo -e "${BLD}*** $1 ***${RST}"
}

on_vagrant () {
    [ -d /vagrant ]
}

configure_i3 () {
    print_header "Installing i3 files and compiling config"

    if [ ! -d '/nix' ]; then
        PIP_PKGS=(colour i3ipc i3pystatus netifaces pytz)
        if [ "$(uname)" == "Linux" ]; then
            PIP_PKGS+=(basiciw)
        fi
        create_venv .i3/.venv "${PIP_PKGS[@]}"
    fi

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

ensure_venv () {
    print_header "Bootstrapping pip and installing virtualenvwrapper"
    deactivate 2> /dev/null || true

    if ! pip3 -V > /dev/null 2>&1; then
        python3 -m ensurepip --user
    fi
    pip3 install --upgrade --user pip
}

create_venv () {
    if [[ "$1" = /* ]]; then
        VENV_PATH="$1" 
    else
        VENV_PATH="$HOME/$1"
    fi

    shift
    PACKAGES=("$@")
    python3 -m venv "$VENV_PATH"
    cd "$VENV_PATH"
    # shellcheck disable=SC1091
    source bin/activate
    pip3 install -U pip
    pip3 install -U "${PACKAGES[@]}"
    deactivate
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
  if [ ! -d '/nix' ]; then
      create_venv .vim/.venv neovim black vint
  fi

  nvim -c "PlugInstall" -c "q" -c "q"
  nvim -c "UpdateRemotePlugins" -c "q"

  # Make VimWiki notes directory
  mkdir -p "$HOME"/notes
  ln -sf "$HOME"/.vim/Vimwiki/style.css "$HOME"/notes/style.css
}

symlink_files () {
    print_header "Copying Files"
    ALL_FILE_EXCLUDES=".git .gitignore .travis.yml"
    MAC_FILE_EXCLUDES=".Xresources .fonts.conf .i3 .screenlayout .urxvt .xinitrc .xmodmap*"
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
}


symlink_files
if [ ! -d '/nix' ]; then
    ensure_venv
    create_venv "$HOME/.venv/core" ipython
    [ "$(uname)" != 'Darwin' ] && configure_xorg_fonts
fi
[ "$(uname)" != 'Darwin' ] && configure_i3
configure_vim
