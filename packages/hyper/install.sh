if F_isMac; then
	brew install hyper
else
	F_pkg_install hyper
fi

if ! F_isSoftlink "$HOME/.hyper.js"; then
	ln -sv "$DOTFILES_ROOT/packages/hyper/.hyper.js" "$HOME/.hyper.js"
fi
