#!/usr/bin/env bash
source $SCRIPTS_CORE/install.sh
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

source $script_directory/install.base.sh

dev=(mani git-workspace gh glab)
utils=(gnu-sed plocate moreutils)
tools=(mcfly)

F_install ${utils[@]} ${tools[@]} ${dev[@]}
