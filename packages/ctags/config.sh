#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")

if ! F_isSoftlink "$HOME/.ctags"; then
	ln -sv "$script_directory/.ctags" "$HOME/.ctags"
fi
