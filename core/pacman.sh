#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

# Check if a package is installed.
# Resolution order:
#   1. packages/<name>/is_installed.sh  — custom check script
#   2. packages.txt                     — recorded by a prior F_install run
#   3. meta_binary from metadata.sh     — if set, check that binary on PATH
#   4. binary on PATH                   — package folder name via F_isBinaryInstalled
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
		local meta_binary=""
		local _mp="$DOTFILES_ROOT/packages/$package/metadata.sh"
		[[ ! -f "$_mp" ]] && _mp="$DOTFILES_ROOT/packages/$package/scripts/metadata.sh"
		[[ -f "$_mp" ]] && source "$_mp"
		F_isBinaryInstalled "${meta_binary:-$package}"
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
		else
			local _mdp="$DOTFILES_ROOT/packages/$package/metadata.sh"
			[[ ! -f "$_mdp" ]] && _mdp="$DOTFILES_ROOT/packages/$package/scripts/metadata.sh"
			if [[ -f "$_mdp" ]]; then
				local meta_depends
				meta_depends=$(source "$_mdp" 2>/dev/null; echo "$meta_depends")
				[[ -n "$meta_depends" ]] && F_install $meta_depends
			fi
		fi

		if ! F_isInstalled $package; then
			local path1="$DOTFILES_ROOT/packages/$package/install.sh"
			local path2="$DOTFILES_ROOT/packages/$package/scripts/install.sh"

			if F_isFile $path1; then
				source $path1
			elif F_isFile $path2; then
				source $path2
			else
				F_meta_install $package
			fi

			grep -q "^$package$" "$packages" || echo "$package" >> "$packages"
		fi

		F_init $package
		F_config $package
	done
}

# metadata.sh — optional per-package file that covers simple install cases without a custom install.sh.
#
# Variables (all optional):
#   meta_display      — human-friendly display name shown in F_list / F_info
#   meta_description  — one-line description of what the package does (F_info only)
#   meta_url          — project homepage (F_info only)
#   meta_tags         — space-separated categories, e.g. "cli dev fonts" (F_list + F_info)
#   meta_os           — space-separated list of OSes ("any" | "macos" | "linux" | "windows"); default: any
#   meta_binary       — executable name on PATH (defaults to package folder name when absent)
#   meta_version_cmd  — command that prints the version; default: "$binary --version" (F_list + F_info)
#   meta_cask         — set to "yes" to use "brew install --cask" instead of "brew install"
#   meta_sudo         — set to "yes" to prepend sudo to the install command
#   meta_depends      — space-separated packages to install first (alternative to deps.sh for simple cases)
#   meta_<pacman>     — package name to pass to that package manager (hyphens in pacman name become _)
#                       e.g. meta_brew="ripgrep"  meta_apt="batcat"  meta_apt_get="batcat"
#
# When F_install has no install.sh, F_meta_install reads metadata.sh and tries each registered
# pacman that has a meta_<pacman> entry.  Falls back to F_pkg_install if none match.
# On success, records the winning pacman to $DOTFILES_CONFIG/state/<pkg> for F_list.

# Load a package's metadata.sh into the caller's scope.
F_meta_load() {
	local package="$1"
	local path1="$DOTFILES_ROOT/packages/$package/metadata.sh"
	local path2="$DOTFILES_ROOT/packages/$package/scripts/metadata.sh"
	if F_isFile "$path1"; then
		source "$path1"
	elif F_isFile "$path2"; then
		source "$path2"
	else
		return 1
	fi
}

# Install a package using per-pacman name overrides from metadata.sh.
# Falls back to F_pkg_install when no metadata.sh exists or no manager matched.
F_meta_install() {
	local package="$1"
	local meta_display="" meta_os="any" meta_binary="" meta_cask="" meta_sudo="" meta_depends=""
	F_meta_load "$package" || { F_pkg_install "$package"; return; }

	if [[ "$meta_os" != "any" ]]; then
		local os_ok=0
		local os
		for os in $meta_os; do
			[[ "$os" == "$OS_KERNEL" ]] && { os_ok=1; break; }
		done
		[[ $os_ok -eq 0 ]] && return 0
	fi

	type "${meta_binary:-$package}" &>/dev/null && return 0

	local installed=0
	local i
	for (( i=0; i<=$__F_idx; i++ )); do
		[[ $installed -eq 1 ]] && break
		_F_pacman_os_ok $i || continue

		local pacman="${F__pacmans[$i,'cmd']}"
		local varname="meta_${pacman//-/_}"
		local pkg_name="${!varname}"

		[[ -z "$pkg_name" ]] && continue
		type "$pacman" &>/dev/null || continue

		local operation="${F__pacmans[$i,'install']}"
		[[ "$pacman" == "brew" && "$meta_cask" == "yes" ]] && operation="brew install --cask"
		[[ "$meta_sudo" == "yes" ]] && operation="sudo $operation"
		if [[ "$pacman" == "go" ]]; then
			eval "$operation $pkg_name@latest" && installed=1
		else
			eval "$operation $pkg_name" && installed=1
		fi

		if [[ $installed -eq 1 ]]; then
			local state_dir="$DOTFILES_CONFIG/state"
			[[ -d "$state_dir" ]] || mkdir -p "$state_dir"
			echo "$pacman" > "$state_dir/$package"
		fi
	done

	[[ $installed -eq 0 ]] && F_pkg_install "$package"
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
_F_list_name() {
	local dir="$1"
	local meta_display="" meta_os=""
	if F_isFile "$dir/metadata.sh"; then
		source "$dir/metadata.sh"
	elif F_isFile "$dir/scripts/metadata.sh"; then
		source "$dir/scripts/metadata.sh"
	fi
	echo "${meta_display:---}"
}

_F_list_inst() {
	local pkg="$1" dir="$2"
	if F_isFile "$dir/is_installed.sh"; then
		(source "$dir/is_installed.sh") >/dev/null 2>&1 && echo "✅" || echo "❌"
	elif F_isFile "$dir/scripts/is_installed.sh"; then
		(source "$dir/scripts/is_installed.sh") >/dev/null 2>&1 && echo "✅" || echo "❌"
	else
		local meta_binary=""
		F_isFile "$dir/metadata.sh" && source "$dir/metadata.sh"
		F_isBinaryInstalled "${meta_binary:-$pkg}" >/dev/null 2>&1 && echo "✅" || echo "❌"
	fi
}

_F_list_pacman() {
	local pkg="$1"
	local state="$DOTFILES_CONFIG/state/$pkg"
	F_isFile "$state" && cat "$state" || echo "—"
}

_F_list_version() {
	local pkg="$1" dir="$2"
	local meta_binary="" meta_version_cmd=""
	F_isFile "$dir/metadata.sh" && source "$dir/metadata.sh"
	local binary="${meta_binary:-$pkg}"
	if [[ -n "$meta_version_cmd" ]]; then
		eval "$meta_version_cmd" 2>/dev/null | head -1 | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | head -1 || echo "—"
	elif type "$binary" &>/dev/null; then
		"$binary" --version 2>&1 | head -1 | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | head -1 || echo "—"
	else
		echo "—"
	fi
}

_F_list_tags() {
	local dir="$1"
	local meta_tags=""
	F_isFile "$dir/metadata.sh" && source "$dir/metadata.sh"
	echo "${meta_tags:---}"
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

	{	printf "PACKAGE\tNAME\tINSTALLED\tCONFIGURED\tHEALTHY\tPACMAN\tVERSION\tTAGS\n"
		printf "-------\t----\t---------\t----------\t-------\t------\t-------\t----\n"
		while IFS= read -r package; do
			[[ -z "$package" ]] && continue
			local dir="$DOTFILES_ROOT/packages/$package"
			printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n" \
				"$package" \
				"$(_F_list_name "$dir")" \
				"$(_F_list_inst "$package" "$dir")" \
				"$(_F_list_check "$dir" "is_configed.sh")" \
				"$(_F_list_check "$dir" "health.sh")" \
				"$(_F_list_pacman "$package")" \
				"$(_F_list_version "$package" "$dir")" \
				"$(_F_list_tags "$dir")"
		done < "$packages"
	} | column -t -s $'\t'
}

# Show full details for a single package.
F_info() {
	local package="$1"
	local dir="$DOTFILES_ROOT/packages/$package"

	local meta_display="" meta_description="" meta_url="" meta_tags=""
	local meta_os="any" meta_binary="" meta_version_cmd=""
	local meta_cask="" meta_sudo="" meta_depends=""
	F_isFile "$dir/metadata.sh" && source "$dir/metadata.sh"

	local binary="${meta_binary:-$package}"
	local version
	if [[ -n "$meta_version_cmd" ]]; then
		version=$(eval "$meta_version_cmd" 2>/dev/null | head -1 | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | head -1)
	elif type "$binary" &>/dev/null; then
		version=$("$binary" --version 2>&1 | head -1 | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | head -1)
	fi

	printf "%-14s %s\n" "package:"     "$package"
	printf "%-14s %s\n" "name:"        "${meta_display:---}"
	printf "%-14s %s\n" "description:" "${meta_description:---}"
	printf "%-14s %s\n" "url:"         "${meta_url:---}"
	printf "%-14s %s\n" "tags:"        "${meta_tags:---}"
	printf "%-14s %s\n" "os:"          "${meta_os:-any}"
	printf "%-14s %s\n" "binary:"      "$binary"
	printf "%-14s %s\n" "version:"     "${version:---}"
	printf "%-14s %s\n" "pacman:"      "$(_F_list_pacman "$package")"
	printf "%-14s %s\n" "installed:"   "$(_F_list_inst "$package" "$dir")"
	printf "%-14s %s\n" "configured:"  "$(_F_list_check "$dir" "is_configed.sh")"
	printf "%-14s %s\n" "healthy:"     "$(_F_list_check "$dir" "health.sh")"
	[[ -n "$meta_depends" ]] && printf "%-14s %s\n" "depends:"   "$meta_depends"
	[[ "$meta_cask"  == "yes" ]] && printf "%-14s %s\n" "cask:"  "yes"
	[[ "$meta_sudo"  == "yes" ]] && printf "%-14s %s\n" "sudo:"  "yes"
}
