#!/usr/bin/env bash


set -e

if which pip3 > /dev/null 2>&1; then
    python3 -m ensurepip --user
fi

python3 -m venv "$HOME"/.i3/.venv
cd "$HOME"/.i3/.venv

# shellcheck disable=SC1091
source bin/activate

pip3 install colour     \
             i3ipc      \
             i3pystatus \
             netifaces  \
             pytz

if [ "$(uname)" == "Linux" ]; then
    pip3 install basiciw
fi

deactivate
