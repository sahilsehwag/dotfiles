#!/usr/bin/env bash
[[ ! -d $DOTFILES_REPOS/entr ]] && git clone --depth 1 https://github.com/eradman/entr $DOTFILES_REPOS/entr
cd $DOTFILES_REPOS/entr
./configure
make test
make install
