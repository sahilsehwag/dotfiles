#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})
[[ ! -L ~/.ideavimrc ]] && ln -sv $script_directory/.ideavimrc ~/.ideavimrc
