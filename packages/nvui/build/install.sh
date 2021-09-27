#!usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

[[ ! -d $SCRIPTS_REPOS/nvui ]] && git clone https://github.com/rohit-px2/nvui.git --recurse-submodules $SCRIPTS_REPOS/nvui
cd $SCRIPTS_REPOS/nvui

if [[ "$OSTYPE" == "darwin"* ]]; then
	source $script_directory/build.mac.sh
fi

cp ./build/nvui /usr/local/bin/nvui
