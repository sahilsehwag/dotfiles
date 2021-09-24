#!usr/bin/env bash
script_directory="$( cd "$( dirname "$0" )" && pwd )"
/bin/sh -x $script_directory/libs/install.sh
/bin/sh -x $script_directory/core/install.sh
/bin/sh -x $script_directory/setup/install.sh
/bin/sh -x $script_directory/dotfiles/install.sh
