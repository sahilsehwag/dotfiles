#!usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

[[ ! -d $SCRIPTS_REPOS/NvChad ]] && git clone https://github.com/NvChad/NvChad.git $SCRIPTS_REPOS/NvChad
cd $SCRIPTS_REPOS/NvChad && git pull

echo "vim.o.rtp = vim.o.rtp .. ',$REPOS/NvChad'" > /tmp/nvchad

cat ./init.lua >> /tmp/nvchad
cp /tmp/nvchad $SCRIPTS_REPOS/NvChad/init.lua

echo "source $script_directory/init.sh" >> $SCRIPTS_CONFIG/init.sh
