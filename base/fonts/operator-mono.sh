#!usr/bin/env bash
type pip3 &> /dev/null && pip3 install fonttools

[[ ! -d $SCRIPTS_REPOS/operator-mono ]] && git clone --depth 1 https://github.com/coderJianXun/Operator-Mono $SCRIPTS_REPOS/operator-mono
[[ ! -d $SCRIPTS_REPOS/operator-mono-lig ]] && git clone --depth 1 https://github.com/kiliman/operator-mono-lig $SCRIPTS_REPOS/operator-mono-lig

cp -a $SCRIPTS_REPOS/operator-mono/src/Operator\ Mono/. $SCRIPTS_REPOS/operator-mono-lig/original/

cd $SCRIPTS_REPOS/operator-mono-lig
npm install
./build.sh
cd ./build

if [[ "$OSTYPE" == "darwin"* ]]; then
	cp -a ./. ~/Library/Fonts
	sudo cp -a ./. /Library/Fonts
fi
