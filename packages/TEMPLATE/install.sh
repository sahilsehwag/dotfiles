#!usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

#MAC
if type brew &> /dev/null; then
	type package &> /dev/null || brew install package
elif type port &> /dev/null; then
	type package &> /dev/null || port install package

#WINDOWS
elif type scoop &> /dev/null; then
	type package &> /dev/null || scoop install package
elif type choco &> /dev/null; then
	type package &> /dev/null || choco install package

#ARCH
elif type pacman &> /dev/null; then
	type package &> /dev/null || pacman -Sy package
elif type yay &> /dev/null; then
	type package &> /dev/null || yay -Sy package
#elif type abs &> /dev/null; then
	#type package &> /dev/null || abs -Sy package

#DEBIAN|UBUTU|DEVUN|PARROT-OS
elif type apt &> /dev/null; then
	type package &> /dev/null || apt install package
elif type apt-get &> /dev/null; then
	type package &> /dev/null || apt-get install package
elif type dpkg &> /dev/null; then
	type package &> /dev/null || dpkg install package

#CENTOS
elif type dnf &> /dev/null; then
	type package &> /dev/null || dnf install package

#REDHAT
elif type yum &> /dev/null; then
	type package &> /dev/null || yum install package
#elif type urpmi &> /dev/null; then
	#type package &> /dev/null || urpmi install package
#elif type zypp &> /dev/null; then
	#type package &> /dev/null || zypp install package
elif type rpm &> /dev/null; then
	type package &> /dev/null || rpm install package
#elif type up2date &> /dev/null; then
	#type package &> /dev/null || up2date install package

#BSD
#FreeBSD|DragonFlyBSD
elif type pkg &> /dev/null; then
	type package &> /dev/null || pkg install package
#NetBSD
elif type pkgin &> /dev/null; then
	type package &> /dev/null || pkgin install package

#GENTOO|PORTRAGE
elif type emerge &> /dev/null; then
	type package &> /dev/null || emerge --ask --verbose package

#NIX
elif type nix-env &> /dev/null; then
	type package &> /dev/null || nix-env -i package

#ALPINE
elif type apk &> /dev/null; then
	type package &> /dev/null || apk install package

#NODE
elif type yarn &> /dev/null; then
	type package &> /dev/null || yarn install package
elif type npm &> /dev/null; then
	type package &> /dev/null || npm install package

#PYTHON
elif type conda &> /dev/null; then
	type package &> /dev/null || conda install package
elif type pip &> /dev/null; then
	type package &> /dev/null || pip install package

#GO
elif type go &> /dev/null; then
	type package &> /dev/null || go install package@latest

#RUST
elif type cargo &> /dev/null; then
	type package &> /dev/null || cargo install package

#LUA
elif type luarocks &> /dev/null; then
	type package &> /dev/null || luarocks install package

#RUBY
elif type gem &> /dev/null; then
	type package &> /dev/null || gem install package

#SCALA
#JAVA
#PHP

fi
