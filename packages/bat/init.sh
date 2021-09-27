#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
source $script_directory/integrations/install.sh
