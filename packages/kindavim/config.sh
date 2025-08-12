#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if ! F_isSoftlink "$HOME/Documents/projects/personal/mani.yml"; then
	ln -sv $script_directory/../config/kindavim.plist "$HOME/Library/Preferences/mo.com.sleeplessmind.kindaVim.plist"
fi
