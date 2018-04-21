#!/usr/bin/env bash

set -e

BLD='\e[1m'
RST='\e[0m'

print_header() {
    echo -e "${BLD}*** $1 ***${RST}"
}

print_header "Copying Files"
FILES=$(find "$PWD" -maxdepth 1 -name ".*" -not -name ".git" -not -name ".gitignore" -not -name ".travis.yml" -o -name "bin")

for file in $FILES; do
    echo "$file -> $HOME/$(basename "$file")"
    ln -sfn "$file" "$HOME/$(basename "$file")"
done

print_header "Bootstrapping pip and installing virtualenvwrapper"

deativate 2> /dev/null || true

if ! which pip3 > /dev/null 2>&1; then
    python3 -m ensurepip --user
fi
pip3 install --user virtualenvwrapper


print_header "Installing i3 files and compiling config"
"$HOME/.i3/install-venv.sh"
"$HOME/.i3/i3-conf-gen.sh"

print_header "Installing fonts"
mkdir -p "$HOME"/.fonts
curl -L -o /tmp/fantasque_mono.tar.gz \
    https://github.com/belluzj/fantasque-sans/releases/download/v1.7.2/FantasqueSansMono-Normal.tar.gz
mkdir -p /tmp/fantasque_mono && tar xzf /tmp/fantasque_mono.tar.gz -C /tmp/fantasque_mono
cp /tmp/fantasque_mono/TTF/* ~/.fonts
rm -rf /tmp/fantasque_mono*

fc-cache -f ~/.fonts

# Install vim
print_header "Installing Vim files"

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
pip3 install -U pip
pip3 install neovim
deactivate

nvim -c "PlugInstall" -c "q" -c "q"
nvim -c "UpdateRemotePlugins" -c "q"
