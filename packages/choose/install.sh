#!usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

#MAC
if type brew &> /dev/null; then
	type choose &> /dev/null || brew install choose-rust
elif type yay &> /dev/null; then
	type choose &> /dev/null || yay -Sy choose-rust-git
elif type dnf &> /dev/null; then
	type choose &> /dev/null || dnf copr enable atim/choose ; dnf install choose
else
	F_pkg_install choose
fi
