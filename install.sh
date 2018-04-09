#!/usr/bin/env bash

FILES=$(find "$PWD" -name ".*" -not -name ".git" -not -name ".gitignore" -not -name ".travis.yml")

for file in $FILES; do
    ln -sfn "$file" "$HOME/$(basename "$file")"
done

"$HOME/.i3/install-venv.sh"
"$HOME/.i3/i3-conf-gen.sh"

mkdir -p "$HOME"/.fonts
curl -L -o "$HOME"/.fonts/FontAwesome.otf \
    https://github.com/FortAwesome/Font-Awesome/raw/41b9ed01103e6820c3cb043ba7ddab30ecd3f4c0/fonts/FontAwesome.otf
curl -L -o "$HOME"/.fonts/monaco.ttf \
    https://github.com/todylu/monaco.ttf/raw/master/monaco.ttf
fc-cache -f ~/.fonts
