!/usr/bin/env bash

F_isInstalled stack || curl -sSL https://get.haskellstack.org/ | sh
F_isInstalled stack || wget -qO- https://get.haskellstack.org/ | sh

if ! F_isInstalled stack
then
	git clone https://github.com/commercialhaskell/stack.git $SCRIPTS_REPOS/stack
	cd $SCRIPTS_REPOS/stack
	stack setup
	stack build
fi
