#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

[[ ! -d $DOTFILES_REPOS/NvChad ]] && git clone https://github.com/NvChad/NvChad.git $DOTFILES_REPOS/NvChad
cd $DOTFILES_REPOS/NvChad && git pull

echo "vim.o.rtp = vim.o.rtp .. ',$REPOS/NvChad'" > /tmp/nvchad

cat ./init.lua >> /tmp/nvchad
cp /tmp/nvchad $DOTFILES_REPOS/NvChad/init.lua

echo "source $script_directory/init.sh" >> $DOTFILES_CONFIG/init.sh
