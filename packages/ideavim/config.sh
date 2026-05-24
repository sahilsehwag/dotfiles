#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if ! F_isSoftlink ~/.ideavimrc; then
	ln -sv $script_directory/.ideavimrc ~/.ideavimrc
fi
