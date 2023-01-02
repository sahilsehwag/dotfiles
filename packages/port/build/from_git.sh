#!/usr/bin/env bash

# not-tested
F_isDir $DOTFILES_REPOS/port || git clone https://github.com/macports/macports-base.git $DOTFILES_REPOS/port

cd $DOTFILES_REPOS/port
./configure --enable-readline
make
sudo make install
make distclean
