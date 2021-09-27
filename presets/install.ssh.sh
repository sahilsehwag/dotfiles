#!/usr/bin/env bash
source $SCRIPTS_CORE/install.sh
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

source $script_dir/install.base.sh

tools=()

F_install ${tools[@]}
