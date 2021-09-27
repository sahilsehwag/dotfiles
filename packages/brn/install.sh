#!usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

[[ ! -d $SCRIPTS_REPOS/brn ]] && git clone https://github.com/nimaipatel/brn.git  $SCRIPTS_REPOS/brn
cd $SCRIPTS_REPOS/brn
sudo make install
