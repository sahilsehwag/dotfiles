#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")

if ! F_isSoftlink "$HOME/.config/vifm"; then
	ln -sv "$script_directory/" "$HOME/.config/vifm"
fi
[[ ! -d "$HOME/.config/vifm/colors" ]]        && git clone https://github.com/vifm/vifm-colors     "$HOME/.config/vifm/colors"
[[ ! -d "$HOME/.config/vifm/vifm_devicons" ]] && git clone https://github.com/cirala/vifm_devicons "$HOME/.config/vifm/vifm_devicons"
