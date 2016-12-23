#dotfiles

## Installation
To install, simply run `install.sh` which creates soft links from the relevant
files in this repo to your home folder, and then builds the i3 config file.
Warning: the first time it is ran, it will overwrite any existing files in $HOME if they
have the same name as any file in this repo. After the first run, `install.sh`
is non=destructive and can be safely ran at any time.

## i3
Pretty proud of this. Instead of maintaining separate configurations for
machines that I use for different purposes, the file is auto generated based on
which machine it is being used on.  See [the i3 directory's README](https://github.com/kneitinger/dotfiles/tree/master/.i3)
for more details.

## Xorg
_TODO!_

## Shell
_TODO!_

## vim
Due to periodic updates of plugins used, I've opted to store my vim dotfiles in
[their own repo](https://github.com/kneitinger/vimdots) so as to not clutter up
the commit logs of this repo.

## Tests
A test script, `test.sh` which runs the `shellcheck` linter on every file listed
in `test_includes` is provided.  Upon any push to Github, this script is ran on
Travis CI.
