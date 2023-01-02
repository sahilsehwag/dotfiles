#!/usr/bin/env bash

if [[ "$OSTYPE" == "darwin"* ]]; then
	! type curl &> /dev/null && brew install curl
	! type gojq &> /dev/null && brew install gojq
	! type tar	&> /dev/null && brew install tar
	! type lua	&> /dev/null && brew install lua
fi

mkdir -p $HOME/$DOTFILES_REPOS/.neva/bin
curl -L -o $HOME/$DOTFILES_REPOS/.neva/bin/neva https://github.com/shohi/neva/raw/main/neva

cd $HOME/$DOTFILES_REPOS/.neva/bin
lua neva install nightly
