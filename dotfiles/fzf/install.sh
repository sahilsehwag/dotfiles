#!usr/bin/env bash
script_directory="$( cd "$( dirname "$0" )" && pwd )"
[[ ! -L ~/.config/fzf.sh ]] && ln -sv $script_directory/.fzf ~/.config/fzf.sh
