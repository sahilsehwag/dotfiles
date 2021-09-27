#!usr/bin/env bash
ROOT=~/.dotfiles
[[ -d $ROOT ]] || git clone https://github.com/sahilsehwag/dotfiles $ROOT

source $ROOT/presets/install.default.sh
