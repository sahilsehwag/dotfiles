#!/usr/bin/env bash
[[ -d $SCRIPTS_REPOS/mani ]] || git clone https://github.com/alajmo/mani ~/$SCRIPTS_REPOS/mani
cd ~/$SCRIPTS_REPOS/mani
make build && ./dist/mani
