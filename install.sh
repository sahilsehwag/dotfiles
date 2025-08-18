#!/usr/bin/env bash
[[ -z $DOTFILES_ROOT ]] && export DOTFILES_ROOT="$HOME/.cache/dotfiles/code"
[[ -z $DOTFILES_CORE ]] && export DOTFILES_CORE="$DOTFILES_ROOT/core"
[[ -z $DOTFILES_PRESET ]] && export DOTFILES_PRESET="sahilsehwag"

if [[ ! -d "$DOTFILES_ROOT" ]]; then
	git clone https://github.com/sahilsehwag/dotfiles "$DOTFILES_ROOT"
fi

source "$DOTFILES_CORE/install.sh"
source "$DOTFILES_ROOT/presets/install.$DOTFILES_PRESET.sh"