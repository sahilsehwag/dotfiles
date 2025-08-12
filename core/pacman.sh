#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

F_isInstalled() {
	local package="$1"

	local path1="$DOTFILES_ROOT/packages/$package/is_installed.sh"
	local path2="$DOTFILES_ROOT/packages/$package/scripts/is_installed.sh"

	if F_isFile $path1; then
		source $path1
		return $?
	elif F_isFile $path2; then
		source $path2
		return $?
	else
		F_isBinaryInstalled $package
		return $?
	fi
}

F_config() {
	local package="$1"

	local path1="$DOTFILES_ROOT/packages/$package/config.sh"
	local path2="$DOTFILES_ROOT/packages/$package/scripts/config.sh"

	if F_isFile $path1; then
		source $path1
	elif F_isFile $path2; then
		source $path2
	else
		F_log "No config script found for package: $package"
	fi
}

F_init() {
	F_isDir $DOTFILES_CONFIG || mkdir $DOTFILES_CONFIG

	local package="$1"

	local initScript="$DOTFILES_CONFIG/init.sh"
	F_isFile $initScript || touch $initScript

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
}

F_install() {
	for package in "$@"; do
		if ! F_isInstalled $package; then
			local path1="$DOTFILES_ROOT/packages/$package/install.sh"
			local path2="$DOTFILES_ROOT/packages/$package/scripts/install.sh"

			if F_isFile $path1; then
				source $script_path
			elif F_isFile $path2; then
				source $script_path
			else
				F_pkg_install $package
			fi
		fi

		F_init $package
		F_config $package
	done
}

F_uninstall() {
	for package in "$@"; do
		F_pkg_uninstall $package
		F_delLines $package $DOTFILES_CONFIG/init.sh
	done
}
