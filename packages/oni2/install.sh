#!/usr/bin/env bash

# global dependencies
F_install git node esy

# platform specific dependencies
F_isMac    && F_install libtool gettext
F_isUbuntu && F_install nasm libacl1-dev libncurses-dev
F_isRedHat && F_install libXt-devel libSM-devel libICE-devel libacl-devel ncurses-devel

# cloning|pulling -> cd -> build
F_isDir $DOTFILES_REPOS/oni2 || git clone https://github.com/onivim/oni2 $DOTFILES_REPOS/oni2
cd $DOTFILES_REPOS/oni2 && git pull

# node dependencies
npm install -g node-gyp
node-gyp install 14.15.4
node install-node-deps.js

#esy install
#esy bootstrap
#esy build

esy '@release' run -f --checkhealth
esy '@release' install
esy '@release' run --help
esy '@release' create

F_isWindows && ./scripts/windows/publish.ps1
F_isMac && cp -R _release/Onivim2.app /Applications
