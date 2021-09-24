#!usr/bin/env bash
script_directory="$( cd "$( dirname "$0" )" && pwd )"
[[ ! -L ~/ ]] && ln -sv $script_directory/ ~/.config/karabiner

brew list karabiner-elements || brew install karabiner-elements
