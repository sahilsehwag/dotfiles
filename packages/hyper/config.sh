#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")

if ! F_isSoftlink "$HOME/.hyper.js"; then
	ln -sv "$script_directory/.hyper.js" "$HOME/.hyper.js"
fi
