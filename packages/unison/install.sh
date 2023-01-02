#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if F_isMac
then
	brew tap unisonweb/unison
	brew install unison-language

	if ! F_isInstalled unison
	then
		mkdir unisonlanguage
		curl -L https://github.com/unisonweb/unison/releases/download/release%2FM4f/ucm-macos.tar.gz --output unisonlanguage/ucm.tar.gz
		tar -xzf unisonlanguage/ucm.tar.gz -C unisonlanguage
		./unisonlanguage/ucm
	fi
elif F_isLinux
then
	mkdir unisonlanguage
	curl -L https://github.com/unisonweb/unison/releases/download/release%2FM4f/ucm-linux.tar.gz --output unisonlanguage/ucm.tar.gz
	tar -xzf unisonlanguage/ucm.tar.gz -C unisonlanguage
	./unisonlanguage/ucm
fi
