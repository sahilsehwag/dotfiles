#!usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

[[ ! -L ~/.config/vifm ]] && ln -sv $script_directory/ ~/.config/vifm
[[ ! -d ~/.config/vifm/colors ]] && git clone https://github.com/vifm/vifm-colors ~/.config/vifm/colors
#[[ ! -d ~/.config/vifm/vifm_devicons ]] && git clone https://github.com/cirala/vifm_devicons ~/.config/vifm/vifm_devicons

if [[ "$OSTYPE" == "darwin"* ]]; then
	source $script_directory/scripts/install.mac.sh
fi
