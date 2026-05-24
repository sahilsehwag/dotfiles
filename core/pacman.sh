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
		local can_path1="$DOTFILES_ROOT/packages/$package/can_install.sh"
		local can_path2="$DOTFILES_ROOT/packages/$package/scripts/can_install.sh"
		if F_isFile $can_path1; then
			source $can_path1 || continue
		elif F_isFile $can_path2; then
			source $can_path2 || continue
		fi

		local deps_path1="$DOTFILES_ROOT/packages/$package/deps.sh"
		local deps_path2="$DOTFILES_ROOT/packages/$package/scripts/deps.sh"
		if F_isFile $deps_path1; then
			source $deps_path1
		elif F_isFile $deps_path2; then
			source $deps_path2
		fi

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

# Uninstall packages, remove config symlinks, and remove their init entries.
F_uninstall() {
	for package in "$@"; do
		local uninstall_path1="$DOTFILES_ROOT/packages/$package/uninstall.sh"
		local uninstall_path2="$DOTFILES_ROOT/packages/$package/scripts/uninstall.sh"

		if F_isFile $uninstall_path1; then
			source $uninstall_path1
		elif F_isFile $uninstall_path2; then
			source $uninstall_path2
		else
			F_pkg_uninstall $package
		fi

		local deconfig_path1="$DOTFILES_ROOT/packages/$package/deconfig.sh"
		local deconfig_path2="$DOTFILES_ROOT/packages/$package/scripts/deconfig.sh"
		if F_isFile $deconfig_path1; then
			source $deconfig_path1
		elif F_isFile $deconfig_path2; then
			source $deconfig_path2
		fi

		F_delLines $package $DOTFILES_CONFIG/init.sh
	done
}

# Run a package's health check script.
F_health() {
	for package in "$@"; do
		local path1="$DOTFILES_ROOT/packages/$package/health.sh"
		local path2="$DOTFILES_ROOT/packages/$package/scripts/health.sh"

		if F_isFile $path1; then
			source $path1
		elif F_isFile $path2; then
			source $path2
		else
			F_log "No health script for package: $package"
		fi
	done
}

# List packages recorded in packages.txt with runtime status.
# Columns:
#   INSTALLED  — is_installed.sh result, or binary-on-PATH check (skips packages.txt record)
#   CONFIGURED — is_configed.sh result; n/a if the package has no idempotency check
#   HEALTHY    — health.sh exit code; n/a if no health script exists
_F_list_inst() {
	local pkg="$1" dir="$2"
	if F_isFile "$dir/is_installed.sh"; then
		(source "$dir/is_installed.sh") >/dev/null 2>&1 && echo "✅" || echo "❌"
	elif F_isFile "$dir/scripts/is_installed.sh"; then
		(source "$dir/scripts/is_installed.sh") >/dev/null 2>&1 && echo "✅" || echo "❌"
	else
		F_isBinaryInstalled "$pkg" >/dev/null 2>&1 && echo "✅" || echo "❌"
	fi
}

_F_list_check() {
	local dir="$1" script="$2"
	if F_isFile "$dir/$script"; then
		(source "$dir/$script") >/dev/null 2>&1 && echo "✅" || echo "❌"
	elif F_isFile "$dir/scripts/$script"; then
		(source "$dir/scripts/$script") >/dev/null 2>&1 && echo "✅" || echo "❌"
	else
		echo "—"
	fi
}

F_list() {
	local packages="$DOTFILES_CONFIG/packages.txt"
	if ! F_isFile $packages; then
		F_log "No packages.txt found at $packages"
		return 1
	fi

	{	printf "PACKAGE\tINSTALLED\tCONFIGURED\tHEALTHY\n"
		printf "-------\t---------\t----------\t-------\n"
		while IFS= read -r package; do
			[[ -z "$package" ]] && continue
			printf "%s\t%s\t%s\t%s\n" \
				"$package" \
				"$(_F_list_inst "$package" "$DOTFILES_ROOT/packages/$package")" \
				"$(_F_list_check "$DOTFILES_ROOT/packages/$package" "is_configed.sh")" \
				"$(_F_list_check "$DOTFILES_ROOT/packages/$package" "health.sh")"
		done < "$packages"
	} | column -t -s $'\t'
}
