!/usr/bin/env bash

F_isInstalled stack || curl -sSL https://get.haskellstack.org/ | sh
F_isInstalled stack || wget -qO- https://get.haskellstack.org/ | sh

if ! F_isInstalled stack
then
	git clone https://github.com/commercialhaskell/stack.git $DOTFILES_REPOS/stack
	cd $DOTFILES_REPOS/stack
	stack setup
	stack build
fi
