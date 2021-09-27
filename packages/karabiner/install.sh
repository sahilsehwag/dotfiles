#!usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})
[[ ! -L ~/ ]] && ln -sv $script_directory/ ~/.config/karabiner

brew list karabiner-elements || brew install karabiner-elements
