#!usr/bin/env bash
script_directory="$( cd "$( dirname "$0" )" && pwd )"
[[ ! -L ~/.ideavimrc ]] && ln -sv $script_directory/.ideavimrc ~/.ideavimrc
