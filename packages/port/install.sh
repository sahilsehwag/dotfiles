#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

! type port &> /dev/null && source $script_directory/build/from_git.sh
! type port &> /dev/null && source $script_directory/build/from_source.sh
