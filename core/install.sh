#!/usr/bin/env bash
[[ -z $DOTFILES_CORE ]]   && export DOTFILES_CORE="$( cd "$( dirname "${BASH_SOURCE:-$0}" )" && pwd )"
[[ -z $DOTFILES_ROOT ]]   && export DOTFILES_ROOT="$( cd "$DOTFILES_CORE/../" && pwd )"
[[ -z $DOTFILES_REPOS ]]  && export DOTFILES_REPOS="$HOME/.cache/dotfiles/repos"
[[ -z $DOTFILES_CONFIG ]] && export DOTFILES_CONFIG="$HOME/.config/dotfiles"

#ENVIORNMENT
#CONSTANT
#interface
#__private
#_function
#module__function

source $DOTFILES_CORE/libs/install.sh
source $DOTFILES_CORE/variables.sh
source $DOTFILES_CORE/paths.sh
source $DOTFILES_CORE/pacman.sh
