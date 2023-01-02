#!/usr/bin/env bash
F__initPkg() {
	F_isDir $DOTFILES_CONFIG || mkdir $DOTFILES_CONFIG

	local initScript="$DOTFILES_CONFIG/init.sh"
	F_isFile $initScript || touch $initScript

	for package in "$@"; do
		if F_isInstalled $package; then
			if ! cat $initScript | grep "/$package/" &> /dev/null; then
				local path1="$DOTFILES_ROOT/packages/$package/init.sh"
				local path2="$DOTFILES_ROOT/packages/$package/scripts/init.sh"

				if F_isFile $path1; then
					echo "source $path1" >> $initScript
				elif F_isFile $path2; then
					echo "source $path2" >> $initScript
				fi
			fi
		fi
	done
}

F_install() {
	for package in "$@"; do
		if ! F_isInstalled $package; then
			local script_path="$DOTFILES_ROOT/packages/$package/install.sh"
			if F_isFile $script_path; then
				source $script_path
			else
				F_pkg_install $package
			fi
		fi
		F__initPkg $package
	done
}

F_uninstall() {
	for package in "$@"; do
		F_pkg_uninstall $package
		F_delLines $package $DOTFILES_CONFIG/init.sh
	done
}
