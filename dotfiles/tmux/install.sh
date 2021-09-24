#!usr/bin/env bash
script_directory="$( cd "$( dirname "$0" )" && pwd )"

[[ ! -L ~/.tmux.conf ]] && ln -sv $script_directory/.tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

if [[ "$OSTYPE" == "darwin"* ]]; then
	/bin/sh -x $script_directory/scripts/install.mac.sh
fi
