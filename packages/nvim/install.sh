#!/usr/bin/env bash

script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")

if F_isInstalled pipx; then
	pipx show neovim &>/dev/null || pipx install neovim
	pipx show pynvim &>/dev/null || pipx install pynvim
else
	pip3 show neovim &>/dev/null || pip3 install neovim
	pip3 show pynvim &>/dev/null || pip3 install pynvim
fi

npm info neovim &>/dev/null  || npm install -g neovim

source "$script_directory/scripts/install.plug.sh"
source "$script_directory/scripts/install.packer.sh"
