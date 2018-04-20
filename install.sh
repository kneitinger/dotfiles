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
FA_VER="731953d9efa9e83a8f13d296de605057d0fb366d"
FA_PREF="https://github.com/FortAwesome/Font-Awesome/blob/$FA_VER/use-on-desktop"
mkdir -p "$HOME"/.fonts
curl -L -o /tmp/fantasque_mono.tar.gz \
    https://github.com/belluzj/fantasque-sans/releases/download/v1.7.2/FantasqueSansMono-Normal.tar.gz
mkdir -p /tmp/fantasque_mono && tar xzfv /tmp/fantasque_mono.tar.gz -C /tmp/fantasque_mono 
cp /tmp/fantasque_mono/TTF/* ~/.fonts
rm -rf /tmp/fantasque_mono*

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

nvim -c "PlugInstall" -c "q" -c "q"
nvim -c "UpdateRemotePlugins" -c "q"
