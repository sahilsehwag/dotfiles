

# ========
# HOMEBREW
# ========
function brew::install() {
	if [ $1 ]; then
		brew install $1
	else
		echo "No package to install"
	fi
}

function brew::uninstall() {
	if [ $1 ]; then
		brew uninstall $1
	else
		echo "No package to uninstall"
	fi
}


# =============
# HOMEBREW-CASK
# =============
function cask::install() {
	if [ $1 ]; then
		brew --cask install $1
	else
		echo "No package to install"
	fi
}

function cask::uninstall() {
	if [ $1 ]; then
		brew --cask uninstall $1
	else
		echo "No package to uninstall"
	fi
}


# =======
# ALIASES
# =======
alias install="brew::install"
alias uninstall="brew::uninstall"

alias sinstall="cask::install"
alias suninstall="cask::uninstall"
