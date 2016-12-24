#dotfiles

## Installation
To install, simply run `install.sh` which creates symbolic links from the relevant
files in this repo to your home folder, and then builds the i3 config file.
Using symbolic links means that you don't have to change your file habits at
all.  Your `.bashrc` appears to be exactly where you would expect it, yet is
seamlessly tracked in the dotfiles repo.
Warning: the first time it is ran, it will overwrite any existing files in $HOME if they
have the same name as any file in this repo. After the first run, `install.sh`
is non=destructive and can be safely ran at any time.

## i3
Pretty proud of this. Instead of maintaining separate configurations for
machines that I use for different purposes, the file is auto generated based on
which machine it is being used on.  See [the i3 directory's README](https://github.com/kneitinger/dotfiles/tree/master/.i3)
for more details.

## Shell
The shell configuration files are for `bash`, yet designed in a modular way.
All aliases and environment variables are in separate files that would work for
`zsh` environments as well.  An additional aspect of modularity is based on the
`$MODEL` environment variable which conditionally determines settings for
different machines in an easily scalable way.

Any environment variables or startup scripts that contain personal or private
information can be stored in `~/.additional`, which is excluded from tracking,
via the repo's `.gitignore`.


## vim
Due to periodic updates of plugins used, I've opted to store my vim dotfiles in
[their own repo](https://github.com/kneitinger/vimdots) so as to not clutter up
the commit logs of this repo.

## Tests
A test script, `test.sh` which runs the `shellcheck` linter on every file listed
in `test_includes` is provided.  Upon any push to Github, this script is ran on
Travis CI.
