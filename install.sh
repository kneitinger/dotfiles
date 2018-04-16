#!/usr/bin/env bash

set -e

echo "** Copying files"
FILES=$(find "$PWD" -name ".*" -not -name ".git" -not -name ".gitignore" -not -name ".travis.yml")

for file in $FILES; do
    ln -sfn "$file" "$HOME/$(basename "$file")"
done
ln -sfn "bin" "$HOME/bin"

# Leave virtual environment if in one
deactivate || true

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
