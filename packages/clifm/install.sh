#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if F_isMac; then
	brew install clifm
else
	F_pkg_install clifm
fi

if ! F_isInstalled clifm; then
	! F_isDir "$DOTFILES_REPOS/clifm" && \
		git clone https://github.com/leo-arch/clifm.git "$DOTFILES_REPOS/clifm"

	(cd "$DOTFILES_REPOS/clifm"
	 sudo make install)
fi

! F_isSoftlink "$HOME/.config/clifm" && \
	ln -sv "$script_directory/" "$HOME/.config/clifm"
