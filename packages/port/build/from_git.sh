#!/usr/bin/env bash

# not-tested
F_isDir $SCRIPTS_REPOS/port || git clone https://github.com/macports/macports-base.git $SCRIPTS_REPOS/port

cd $SCRIPTS_REPOS/port
./configure --enable-readline
make
sudo make install
make distclean
