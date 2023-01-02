#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

F_pkg_install neovide
F_isInstalled neovide || source $script_directory/scripts/build.sh
source $script_directory/scripts/build.sh
