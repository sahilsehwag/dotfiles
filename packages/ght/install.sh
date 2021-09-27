#!/usr/bin/env sh

F_install go

F_isDir $SCRIPTS_REPOS/github-tui || git clone https://github.com/skanehira/github-tui $SCRIPTS_REPOS/github-tui
cd $SCRIPTS_REPOS/github-tui && git pull
go install ./cmd/ght
