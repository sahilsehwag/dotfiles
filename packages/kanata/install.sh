# https://github.com/jtroo/kanata
# kmonad alternative
cargo install kanata

if ! F_isSoftLink "$HOME/.config/kanata"; then
	ln -sv "$DOTFILES_ROOT/packages/kanata/" "$HOME/.config/kanata"
fi
