#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

[[ ! -d $DOTFILES_REPOS/nvui ]] && git clone https://github.com/rohit-px2/nvui.git --recurse-submodules $DOTFILES_REPOS/nvui
cd $DOTFILES_REPOS/nvui

if [[ "$OSTYPE" == "darwin"* ]]; then
	source $script_directory/build.mac.sh
fi

cp ./build/nvui /usr/local/bin/nvui
