#!/usr/bin/env bash
source $SCRIPTS_CORE/install.sh
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

source $script_directory/install.minimal.sh

shells=(zsh fish elvish nushell oil ngs)
utils=(direnv miller)
tools=(pandoc)
guis=(warp)
dev=(k9s)
mac=(
	iterm2
	dash
	alfred
	vlc
	keycastr
	karabiner-elements
	notion
	visual-studio-code
	google-chrome
	google-backup-and-sync
	google-drive
)

F_install ${utils[@]} ${tools[@]} ${guis[@]} ${mac[@]}
