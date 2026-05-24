#!/usr/bin/env bash

if ! F_isSoftlink "$HOME/.config/kanata"; then
	ln -sv "$DOTFILES_ROOT/packages/kanata/" "$HOME/.config/kanata"
fi
