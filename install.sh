#!/usr/bin/env bash

set -e

echo "** Copying files"
FILES=$(find "$PWD" -maxdepth 1 -name ".*" -not -name ".git" -not -name ".gitignore" -not -name ".travis.yml" -o -name "bin")

for file in $FILES; do
    ln -sfn "$file" "$HOME/$(basename "$file")"
done

deativate 2> /dev/null || true

echo "** Installing i3 files and compiling config"
"$HOME/.i3/install-venv.sh"
"$HOME/.i3/i3-conf-gen.sh"

echo "** Installing fonts"
mkdir -p "$HOME"/.fonts
curl -L -o "$HOME"/.fonts/FontAwesome.otf \
    https://github.com/FortAwesome/Font-Awesome/raw/41b9ed01103e6820c3cb043ba7ddab30ecd3f4c0/fonts/FontAwesome.otf
curl -L -o "$HOME"/.fonts/monaco.ttf \
    https://github.com/todylu/monaco.ttf/raw/master/monaco.ttf
fc-cache -f ~/.fonts

# Install vim
echo "** Installing Vim files"

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

python3 -m venv "$HOME"/.vim/.venv
cd "$HOME"/.vim/.venv

# shellcheck disable=SC1091
source bin/activate
pip3 install neovim
deactivate

nvim -c "UpdateRemotePlugins" -c "q"
