#!usr/bin/env bash
script_directory="$( cd "$( dirname "$0" )" && pwd )"

[[ ! -L ~/.config/vifm ]] && ln -sv $script_directory/ ~/.config/vifm

if [[ "$OSTYPE" == "darwin"* ]]; then
	/bin/sh -x $script_directory/scripts/install.mac.sh
fi
