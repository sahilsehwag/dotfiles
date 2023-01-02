#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if [[ "$OSTYPE" == "darwin"* ]]; then
	type git-peek &> /dev/null || brew install jarred-sumner/git-peek/git-peek
	type git-peek &> /dev/null && git peek -r
	echo "DONT'T FORGET TO INSTALL THE COMPANION CHROME/FIREFOX EXTENSION"
	open https://chrome.google.com/webstore/detail/peek-%E2%80%93-github-to-local-ed/lipffmbhaajmndiglgmmcfldgolfaooj
else
	type npm &> /dev/null || F_install node
	type npm &> /dev/null && npm install -g @jarred/git-peek
fi
