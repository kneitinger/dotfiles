#!/usr/bin/env bash

set -e

# Allow nvim/vim to happily coexist
if [[ ! -d "$HOME"/.config/nvim ]]; then
    mkdir -p "$HOME"/.config/nvim
fi

echo "set runtimepath+=~/.vim,~/.vim/after" > "$HOME"/.config/nvim/init.vim
echo "set packpath+=~/.vim" >> "$HOME"/.config/nvim/init.vim
echo "source ~/.vimrc" >> "$HOME"/.config/nvim/init.vim

# Create various history directories
if [[ ! -d "$HOME"/.vim/cache ]]; then
    mkdir -p "$HOME"/.vim/cache/undo
    mkdir -p "$HOME"/.vim/cache/backup
    mkdir -p "$HOME"/.vim/cache/swap
fi

ln -sf "$HOME"/.vim/vimrc "$HOME"/.vimrc

# Create neovim virtual env
if which pip3 > /dev/null 2>&1; then
    python3 -m ensurepip --user
fi

python3 -m venv "$HOME"/.vim/.venv
cd "$HOME"/.vim/.venv

# shellcheck disable=SC1091
source bin/activate
pip3 install neovim
deactivate

nvim -c "UpdateRemotePlugins" -c "q"

