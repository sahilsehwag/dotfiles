#!/usr/bin/env bash
type pip3 &> /dev/null && pip3 install fonttools

[[ ! -d $DOTFILES_REPOS/operator-mono ]] && git clone --depth 1 https://github.com/coderJianXun/Operator-Mono $DOTFILES_REPOS/operator-mono
[[ ! -d $DOTFILES_REPOS/operator-mono-lig ]] && git clone --depth 1 https://github.com/kiliman/operator-mono-lig $DOTFILES_REPOS/operator-mono-lig

cp -a $DOTFILES_REPOS/operator-mono/src/Operator\ Mono/. $DOTFILES_REPOS/operator-mono-lig/original/

cd $DOTFILES_REPOS/operator-mono-lig
npm install
./build.sh
cd ./build

if [[ "$OSTYPE" == "darwin"* ]]; then
	cp -a ./. ~/Library/Fonts
	sudo cp -a ./. /Library/Fonts
fi
