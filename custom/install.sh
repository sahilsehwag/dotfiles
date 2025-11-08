#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

# workflows
source $script_directory/workflows/git.sh
source $script_directory/workflows/gh.sh
source $script_directory/workflows/arc.sh
source $script_directory/workflows/uber.sh

# tools
source $script_directory/cheat.sh
source $script_directory/touch.sh
source $script_directory/vess.sh
