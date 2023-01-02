#!/usr/bin/env sh

F_install go

F_isDir $DOTFILES_REPOS/github-tui || git clone https://github.com/skanehira/github-tui $DOTFILES_REPOS/github-tui
cd $DOTFILES_REPOS/github-tui && git pull
go install ./cmd/ght
