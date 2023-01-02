if [[ "$OSTYPE" == "darwin"* ]]; then
	brew tap epk/epk

	# Homebrew < 2.6.0
	#brew cask install font-sf-mono-nerd-font

	# Homebrew >= 2.6.0
	brew install --cask font-sf-mono-nerd-font
fi
