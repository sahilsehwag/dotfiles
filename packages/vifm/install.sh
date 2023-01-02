#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

[[ ! -L "$HOME/.config/vifm" ]]               && ln -sv "$script_directory/"                       "$HOME/.config/vifm"
[[ ! -d "$HOME/.config/vifm/colors" ]]        && git clone https://github.com/vifm/vifm-colors     "$HOME/.config/vifm/colors"
[[ ! -d "$HOME/.config/vifm/vifm_devicons" ]] && git clone https://github.com/cirala/vifm_devicons "$HOME/.config/vifm/vifm_devicons"

F_pkg_install vifm
