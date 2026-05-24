#!/usr/bin/env bash
F_install hack-nerd-font
brew install --cask sf-symbols
curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.3/sketchybar-app-font.ttf \
	-o "$HOME/Library/Fonts/sketchybar-app-font.ttf"
brew tap FelixKratz/formulae
brew install sketchybar
