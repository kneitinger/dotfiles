# i3 Configuration and Helper Files

Notice anything odd?  There is no `config` file in here 🤔

That is because I became tired of constantly modifying and resyncing multiple
`configs` for my various computers, all with different key layouts, sound
servers, etc.  One ThinkPad has Print Screen in between Alt_L and Ctrl_L, the
other has Menu.  One is used for live music and has JACK keybindings, whereas
the other is used for general purpose things and has external monitor
hotkeys...the diversions go on!

To solve this, I decided to restructure my `~/.i3` directory in a more modular
way.

+ A script, `i3-conf-gen.sh`, compiles the various configuration modules into a
  `config` file for i3 to use.
+ Configurations used by all hosts, such as theming, program launching,
  workspace names and shared keybindings are in the `core` folder in separate
  files that describe their purpose.
+ Any option that is host specific goes in a folder named after the value
  of `$HOSTNAME`. Files in a host specific directory should correspond to
  one in `core`, and will be discovered when the one in `core` is being
  concatenated to the generated config.
+ An optional script, `i3-file-watch.sh`, using `inotifywait` from the
  [`inotify-tools` package](https://github.com/rvoicilas/inotify-tools/wiki)
  can be set to watch for changes in the core and host-specific folders and
  recompile the `config` file automatically.

## Installation

If the base `dotfiles` repo's install script is run, these i3 files are
installed as well.  If you wish to use just the i3 related files, simply
clone this repository and link the .i3 directory to `~/.i3`
```
git clone git@github.com:kneitinger/dotfiles.git
cd dotfiles
ln -sfn "$PWD/dotfiles/.i3" "$HOME/.i3"
cd ~/.i3
./i3-conf-gen.sh
```

Optionally, edit `.xinitrc`, `.bash_profile`, or any other startup file to
launch `i3-file-watch.sh` on startup.
