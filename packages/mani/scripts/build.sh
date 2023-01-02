#!/usr/bin/env bash
[[ -d $DOTFILES_REPOS/mani ]] || git clone https://github.com/alajmo/mani ~/$DOTFILES_REPOS/mani
cd ~/$DOTFILES_REPOS/mani
make build && ./dist/mani
