#!usr/bin/env bash
[[ ! -d $SCRIPTS_REPOS/entr ]] && git clone --depth 1 https://github.com/eradman/entr $SCRIPTS_REPOS/entr
cd $SCRIPTS_REPOS/entr
./configure
make test
make install
