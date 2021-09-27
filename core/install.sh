#!usr/bin/env bash
[[ ! -z $SCRIPTS_CORE ]] || export SCRIPTS_CORE="$( cd "$( dirname "${BASH_SOURCE:-$0}" )" && pwd )"
[[ ! -z $SCRIPTS_ROOT ]] || export SCRIPTS_ROOT="$( cd "$SCRIPTS_CORE/../" && pwd )"
[[ ! -z $SCRIPTS_REPOS ]] || export SCRIPTS_REPOS="$HOME/.repos"
[[ ! -z $SCRIPTS_CONFIG ]] || export SCRIPTS_CONFIG="$HOME/.config/scripts"

#ENVIORNMENT
#CONSTANT
#interface
#__private
#_function
#module__function

source $SCRIPTS_CORE/libs/install.sh
source $SCRIPTS_CORE/variables.sh
source $SCRIPTS_CORE/paths.sh
source $SCRIPTS_CORE/pacman.sh
