#!/usr/bin/env bash
source $DOTFILES_CORE/install.sh
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

source $script_dir/install.default.sh

utils=(
	entr
	fx
	jless
	ripgrep-all
	#pdfgrep
	htmlq
	xsv
)

F_install ${utils[@]}
