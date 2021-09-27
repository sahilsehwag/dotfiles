#!/usr/bin/env bash
#FIX: not working
F_isDir $SCRIPTS_REPOS/clifm || git clone https://github.com/leo-arch/clifm.git $SCRIPTS_REPOS/clifm
cd $SCRIPTS_REPOS/clifm
sudo make install
