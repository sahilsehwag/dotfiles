#!/usr/bin/env bash
script_directory="$( cd "$( dirname "$0" )" && pwd )"

if F_isSoftlink "$HOME/.config/sketchybar"; then
	#ln -sv "$script_directory/configs/catapuccin/" "$HOME/.config/sketchybar"
	#ln -sv "$script_directory/configs/minimal/" "$HOME/.config/sketchybar"
	ln -sv "$script_directory/configs/bubbles/"    "$HOME/.config/sketchybar"
fi

F_install hack-nerd-font
brew install --cask sf-symbols
curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.3/sketchybar-app-font.ttf -o "$HOME/Library/Fonts/sketchybar-app-font.ttf"

brew tap FelixKratz/formulae
brew install sketchybar
brew services start sketchybar
