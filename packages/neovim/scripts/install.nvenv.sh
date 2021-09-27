#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

[[ ! -d $SCRIPTS_REPOS/nvenv ]] && git clone https://github.com/NTBBloodbath/nvenv $SCRIPTS_REPOS/nvenv
cd $SCRIPTS_REPOS/nvenv

if [[ "$OSTYPE" == "darwin"* ]]; then
	! type curl &> /dev/null && brew install curl
	! type jq		&> /dev/null && brew install jq
	! type tar	&> /dev/null && brew install tar
	! type v		&> /dev/null && brew install vlang

	make macos
  cp ./bin/nvenv_osx ~/.local/bin/nvenv
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
	make linux
	cp ./bin/nvenv_linux ~/.local/bin/nvenv
fi

if type nvenv &> /dev/null; then
	nvenv setup

	nvenv install stable
	nvenv install nightly

	nvenv use stable
fi
