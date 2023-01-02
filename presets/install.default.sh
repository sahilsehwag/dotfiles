#!/usr/bin/env bash
source $DOTFILES_CORE/install.sh
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

source $script_directory/install.minimal.sh

shells=(fish elvish nushell oil ngs)
utils=(direnv miller)
tools=(pandoc)
guis=(warp)
dev=(k9s)
mac=(
	alacritty
	yabai
	notion
	alfred
	visual-studio-code
	google-chrome
	google-drive
	keycastr
	vlc
)

F_install ${shells[@]} ${utils[@]} ${tools[@]} ${guis[@]} ${mac[@]}
