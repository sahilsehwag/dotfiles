#!/usr/bin/env bash
script_directory=$(F_getScriptDir "${BASH_SOURCE:-$0}")
F_install node python lua
! type bob &>/dev/null && F_install bob

pip3 show neovim &>/dev/null || pip3 install neovim
pip3 show pynvim &>/dev/null || pip3 install pynvim
npm info neovim &>/dev/null  || npm install -g neovim

source "$script_directory/scripts/install.plug.sh"
source "$script_directory/scripts/install.packer.sh"
