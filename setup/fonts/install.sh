#!usr/bin/env bash
script_directory="$( cd "$( dirname "$0" )" && pwd )"
/bin/sh -x $script_directory/nerd-fonts.sh
/bin/sh -x $script_directory/powerline-fonts.sh
