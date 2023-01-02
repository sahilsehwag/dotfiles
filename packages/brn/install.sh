#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

[[ ! -d $DOTFILES_REPOS/brn ]] && git clone https://github.com/nimaipatel/brn.git  $DOTFILES_REPOS/brn
cd $DOTFILES_REPOS/brn
sudo make install
