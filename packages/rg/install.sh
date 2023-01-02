if ! F_isInstalled rg; then
	cargo install --features 'pcre2' ripgrep
fi
if ! F_isInstalled rg; then
	F_pkg_install ripgrep
fi
if ! F_isInstalled rg; then
	F_pkg_install rg
fi
