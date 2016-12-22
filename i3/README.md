# i3 Configuration and Helper Files

Notice anything odd?  There is no `config` file in here 🤔

Thats because I became tired of constantly modifying and resyncing multiple
`configs` for my various computers, all with different key layouts, sound
servers, etc.  One ThinkPad has Print Screen in between Alt_L and Ctrl_L, the
other has Menu.  One is used for live music and has JACK keybindings, whereas
the other is used for general purpose things and has external monitor
hotkeys...the diversions go on!

To solve this, I decided to restructure my `.i3` directory in a more modular
way.

+ A script, `i3-conf-gen.sh`, compiles the various configuration modules into a
  `config` file for i3 to use.
+ Configurations used by all machines, such as theming, program launching,
  workspace names and shared keybindings are in the `core` folder, in seperate
  files that describe their purpose.
+ Any option that is machine specific goes in a folder named after the output
  of `tr "[:blank:]" "_" < /sys/devices/virtual/dmi/id/product_version | tr "[:upper:]" "[:lower:]"`.
  For example, the configurations specific to my ThinkPad T450s reside in the
  `thinkpad_t450s` directory. Files in a machine specific directory should
  correspond to on in `core`, and will be discovered when the one in `core` is
  being added to the `config`.
+ An optional script using `inotifywait` from the [`inotify-tools` package](https://github.com/rvoicilas/inotify-tools/wiki) can be set to watch for changes in the core and machine folders and recompile the `config` file automatically.

## Installation

To install, simply clone this repository and link the i3 directory to `~/.i3`
```
ln -sf dotfiles/i3 ~/.i3
cd ~/.i3
chmod +x i3-* && ./i3-conf-gen.sh
```

Optionally, edit `.xinitrc`, `.bash_profile`, or any other startup file to
launch `i3-file-watch.sh` on startup.
