#!usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})
develoment=$script_directory/../../base/develoment

[[ ! -L ~/.config/tagrity ]] && ln -sv $script_directory/ ~/.config/tagrity

source $development/ruby/install.sh
! type tagrity &> /dev/null && gem install tagrity

