#!/usr/bin/env bash
source $DOTFILES_CORE/install.sh
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

source $script_dir/install.featured.sh

tools=()

F_install ${tools[@]}
