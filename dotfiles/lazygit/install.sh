#!usr/bin/env bash
script_directory="$( cd "$( dirname "$0" )" && pwd )"

[[ ! -L ~/.config/jesseduffield/lazygit ]] && mkdir -p ~/.config/jesseduffield && ln -sv $script_directory/ ~/.config/jesseduffield/lazygit

if [[ "$OSTYPE" == "darwin"* ]]; then
	/bin/sh -x $script_directory/scripts/install.mac.sh
fi
