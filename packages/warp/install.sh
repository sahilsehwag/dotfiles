#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if [[ "$OSTYPE" == "darwin"* ]]; then
	brew list warp || brew install warp
fi

[[ ! -L ~/.warp ]] && ln -sv $script_directory/ ~/.warp
[[ ! -d ~/.warp/themes ]] && git clone https://github.com/warpdotdev/themes.git ~/.warp/themes
