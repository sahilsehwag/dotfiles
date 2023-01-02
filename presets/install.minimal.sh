#!/usr/bin/env bash
source $DOTFILES_CORE/install.sh
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

source $script_directory/install.base.sh

dev=(mask)
utils=(gnu-sed plocate moreutils)

F_install ${utils[@]} ${tools[@]} ${dev[@]}
