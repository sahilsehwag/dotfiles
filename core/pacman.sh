#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

# Check if a package is installed.
# Resolution order:
#   1. packages/<name>/is_installed.sh  — custom check script
#   2. packages.txt                     — recorded by a prior F_install run
#   3. binary on PATH                   — fallback via F_isBinaryInstalled
F_isInstalled() {
	local package="$1"

	local path1="$DOTFILES_ROOT/packages/$package/is_installed.sh"
	local path2="$DOTFILES_ROOT/packages/$package/scripts/is_installed.sh"

	local packages="$DOTFILES_CONFIG/packages.txt"

	if F_isFile $path1; then
		source $path1
		return $?
	elif F_isFile $path2; then
		source $path2
		return $?
	elif F_isFile $packages; then
		if grep -q "^$package$" "$packages"; then
			return 0
		else
			return 1
		fi
	else
		F_isBinaryInstalled $package
		return $?
	fi
}

# Check if a package has already been configured.
# Returns 1 (not configured) when no is_configed.sh exists,
# so F_config always runs for packages without a custom check.
F_isConfiged() {
	local package="$1"

	local path1="$DOTFILES_ROOT/packages/$package/is_configed.sh"
	local path2="$DOTFILES_ROOT/packages/$package/scripts/is_configed.sh"

	if F_isFile $path1; then
		source $path1
		return $?
	elif F_isFile $path2; then
		source $path2
		return $?
	else
		return 1
	fi
}

# Run a package's config script unless is_configed.sh reports it's already done.
F_config() {
	local package="$1"

	if F_isConfiged $package; then
		return 0
	fi

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

# Append a package's init.sh to ~/.config/dotfiles/init.sh so shells source it on startup.
# Only runs if the package is installed and hasn't been registered yet.
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

# Install packages, skipping any already installed.
# After installing, always runs F_init and F_config.
F_install() {
	local packages="$DOTFILES_CONFIG/packages.txt"
	F_isFile $packages || touch $packages

	for package in "$@"; do
		if ! F_isInstalled $package; then
			local path1="$DOTFILES_ROOT/packages/$package/install.sh"
			local path2="$DOTFILES_ROOT/packages/$package/scripts/install.sh"

			if F_isFile $path1; then
				source $path1
			elif F_isFile $path2; then
				source $path2
			else
				F_pkg_install $package
			fi

			grep -q "^$package$" "$packages" || echo "$package" >> "$packages"
		fi

		F_init $package
		F_config $package
	done
}

# Update installed packages. Skips packages that aren't installed.
F_update() {
	for package in "$@"; do
		if F_isInstalled $package; then
			local path1="$DOTFILES_ROOT/packages/$package/update.sh"
			local path2="$DOTFILES_ROOT/packages/$package/scripts/update.sh"

			if F_isFile $path1; then
				source $path1
			elif F_isFile $path2; then
				source $path2
			else
				F_pkg_update $package
			fi
		fi
	done
}

# Uninstall packages and remove their init entries.
F_uninstall() {
	for package in "$@"; do
		local path1="$DOTFILES_ROOT/packages/$package/uninstall.sh"
		local path2="$DOTFILES_ROOT/packages/$package/scripts/uninstall.sh"

		if F_isFile $path1; then
			source $path1
		elif F_isFile $path2; then
			source $path2
		else
			F_pkg_uninstall $package
		fi

		F_delLines $package $DOTFILES_CONFIG/init.sh
	done
}
