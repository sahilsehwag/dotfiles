#!/usr/bin/env bash
source $DOTFILES_CORE/install.sh
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

source $script_directory/install.minimal.sh

shells=(fish elvish nushell oil ngs)
utils=(direnv miller)
tools=(pandoc)
guis=(alacritty warp hyper)
dev=(k9s)
gui=(espanso)
ai=(cursor windsurf windsurf@next claude gemini opencode codex cursor-agent)
mac=(
	aerospace #yabai
	#kindavim #svim #macos wide vim emulation
	notion
	alfred
	vscode
	google-chrome
	google-drive
	keycastr
	vlc
)

F_install ${shells[@]} ${utils[@]} ${tools[@]} ${guis[@]}

if F_isMac; then
	F_install ${mac[@]}
fi
