#!/usr/bin/env bash
F_isDir || git clone https://github.com/pystardust/ytfzf $DOTFILES_REPOS/ytfzf
cd $DOTFILES_REPOS/ytfzf && git pull
sudo make install doc
sudo make addons
