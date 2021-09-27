#!usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if F_isMac; then
	#F_isDir "~/Library/Application Support/lazygit" && rm -rf "~/Library/Application Support/lazygit"
	#F_isSymlink "~/Library/Application Support/lazygit" || ln -sv $script_directory/ ~/Library/Application\ Support/lazygit

	ln -sv $script_directory/config.yml ~/Library/Application\ Support/lazygit/config.yml
elif isLinux; then
	F_isSymlink ~/.config/lazygit || ln -sv $script_directory/ ~/.config/lazygit
else
	echo "Unsupported OS"
	exit 1
fi

F_pkg_install lazygit
