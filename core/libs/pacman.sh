#!/usr/bin/env bash
declare -A F__pacmans
declare __F_idx=-1

# os field matches OS_KERNEL from core/libs/os.sh:
#   macos | linux | freebsd | openbsd | netbsd | windows | any

# --- macOS ---

let __F_idx++
F__pacmans[$__F_idx,'cmd']='brew'
F__pacmans[$__F_idx,'os']='macos'
F__pacmans[$__F_idx,'install']='brew install'
F__pacmans[$__F_idx,'uninstall']='brew uninstall'
F__pacmans[$__F_idx,'update']='brew upgrade'
F__pacmans[$__F_idx,'search']='brew search'
F__pacmans[$__F_idx,'show']='brew info'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='port'
F__pacmans[$__F_idx,'os']='macos'
F__pacmans[$__F_idx,'install']='port install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

# --- Windows ---

let __F_idx++
F__pacmans[$__F_idx,'cmd']='scoop'
F__pacmans[$__F_idx,'os']='windows'
F__pacmans[$__F_idx,'install']='scoop install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='choco'
F__pacmans[$__F_idx,'os']='windows'
F__pacmans[$__F_idx,'install']='choco install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

# --- Linux (Arch) ---

let __F_idx++
F__pacmans[$__F_idx,'cmd']='pacman'
F__pacmans[$__F_idx,'os']='linux'
F__pacmans[$__F_idx,'install']='pacman -Sy'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='yay'
F__pacmans[$__F_idx,'os']='linux'
F__pacmans[$__F_idx,'install']='yay -Sy'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

# --- Linux (Debian) ---

let __F_idx++
F__pacmans[$__F_idx,'cmd']='apt'
F__pacmans[$__F_idx,'os']='linux'
F__pacmans[$__F_idx,'install']='apt install -y'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='apt-get'
F__pacmans[$__F_idx,'os']='linux'
F__pacmans[$__F_idx,'install']='apt-get install -y'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='dpkg'
F__pacmans[$__F_idx,'os']='linux'
F__pacmans[$__F_idx,'install']='dpkg -i'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

# --- Linux (RHEL/Fedora) ---

let __F_idx++
F__pacmans[$__F_idx,'cmd']='dnf'
F__pacmans[$__F_idx,'os']='linux'
F__pacmans[$__F_idx,'install']='dnf install -y'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='yum'
F__pacmans[$__F_idx,'os']='linux'
F__pacmans[$__F_idx,'install']='yum install -y'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='rpm'
F__pacmans[$__F_idx,'os']='linux'
F__pacmans[$__F_idx,'install']='rpm -i'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

# --- Linux (SUSE) ---

let __F_idx++
F__pacmans[$__F_idx,'cmd']='zypper'
F__pacmans[$__F_idx,'os']='linux'
F__pacmans[$__F_idx,'install']='zypper install -y'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

# --- Linux (Alpine) ---

let __F_idx++
F__pacmans[$__F_idx,'cmd']='apk'
F__pacmans[$__F_idx,'os']='linux'
F__pacmans[$__F_idx,'install']='apk add'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

# --- Linux (Void) ---

let __F_idx++
F__pacmans[$__F_idx,'cmd']='xbps-install'
F__pacmans[$__F_idx,'os']='linux'
F__pacmans[$__F_idx,'install']='xbps-install -y'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

# --- Linux (Gentoo) ---

let __F_idx++
F__pacmans[$__F_idx,'cmd']='emerge'
F__pacmans[$__F_idx,'os']='linux'
F__pacmans[$__F_idx,'install']='emerge -av'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

# --- FreeBSD ---

let __F_idx++
F__pacmans[$__F_idx,'cmd']='pkg'
F__pacmans[$__F_idx,'os']='freebsd'
F__pacmans[$__F_idx,'install']='pkg install -y'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

# --- NetBSD ---

let __F_idx++
F__pacmans[$__F_idx,'cmd']='pkgin'
F__pacmans[$__F_idx,'os']='netbsd'
F__pacmans[$__F_idx,'install']='pkgin install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

# --- Cross-platform (language toolchains) ---
# These are installed on top of any OS, so os=any skips the OS gate.

let __F_idx++
F__pacmans[$__F_idx,'cmd']='nix-env'
F__pacmans[$__F_idx,'os']='any'
F__pacmans[$__F_idx,'install']='nix-env -i'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='yarn'
F__pacmans[$__F_idx,'os']='any'
F__pacmans[$__F_idx,'install']='yarn global add'
F__pacmans[$__F_idx,'uninstall']='yarn remove'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='npm'
F__pacmans[$__F_idx,'os']='any'
F__pacmans[$__F_idx,'install']='npm install -g'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='conda'
F__pacmans[$__F_idx,'os']='any'
F__pacmans[$__F_idx,'install']='conda install -y'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='pip'
F__pacmans[$__F_idx,'os']='any'
F__pacmans[$__F_idx,'install']='pip install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='go'
F__pacmans[$__F_idx,'os']='any'
F__pacmans[$__F_idx,'install']='go install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='cargo'
F__pacmans[$__F_idx,'os']='any'
F__pacmans[$__F_idx,'install']='cargo install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='luarocks'
F__pacmans[$__F_idx,'os']='any'
F__pacmans[$__F_idx,'install']='luarocks install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='gem'
F__pacmans[$__F_idx,'os']='any'
F__pacmans[$__F_idx,'install']='gem install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='stack'
F__pacmans[$__F_idx,'os']='any'
F__pacmans[$__F_idx,'install']='stack install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

# Returns true if the pacman at index $1 is eligible on the current OS
_F_pacman_os_ok() {
	local os=${F__pacmans[$1,'os']}
	[[ "$os" == "any" || "$os" == "$OS_KERNEL" ]]
}

F_pkg_install() {
	for package in "$@" ; do
		type $package &> /dev/null && continue

		for (( i=0; i<=$__F_idx; i++ )); do
			type $package &> /dev/null && break
			_F_pacman_os_ok $i || continue

			local pacman=${F__pacmans[$i,'cmd']}
			local operation=${F__pacmans[$i,'install']}

			if type $pacman &> /dev/null ; then
				if [[ $pacman == 'go' ]]; then
					eval "$operation $package@latest"
				else
					eval "$operation $package"
				fi
			fi
		done
	done
}

F_pkg_update() {
	for package in "$@" ; do
		! type $package &> /dev/null && continue
		local current_version=$($package --version)

		for (( i=0; i<=$__F_idx; i++ )); do
			[[ $($package --version) != $current_version ]] && break
			_F_pacman_os_ok $i || continue

			local pacman=${F__pacmans[$i,'cmd']}
			local operation=${F__pacmans[$i,'update']}

			if type $pacman &> /dev/null ; then
				eval "$operation $package"
			fi
		done
	done
}

F_pkg_uninstall() {
	for package in "$@" ; do
		! type $package &> /dev/null && continue

		for (( i=0; i<=$__F_idx; i++ )); do
			! type $package &> /dev/null && break
			_F_pacman_os_ok $i || continue

			local pacman=${F__pacmans[$i,'cmd']}
			local operation=${F__pacmans[$i,'uninstall']}

			if type $pacman &> /dev/null ; then
				eval "$operation $package"
			fi
		done
	done
}

F_pkg_search() {
	for package in "$@" ; do
		for (( i=0; i<=$__F_idx; i++ )); do
			type $package &> /dev/null && break
			_F_pacman_os_ok $i || continue

			local pacman=${F__pacmans[$i,'cmd']}
			local operation=${F__pacmans[$i,'search']}

			if type $pacman &> /dev/null ; then
				if eval "$operation $package" &> /tmp/hop.log ; then
					eval "$operation $package"
					break
				fi
			fi
		done
	done
}

F_pkg_show() {
	for package in "$@" ; do
		! type $package &> /dev/null && continue

		for (( i=0; i<=$__F_idx; i++ )); do
			type $package &> /dev/null && break
			_F_pacman_os_ok $i || continue

			local pacman=${F__pacmans[$i,'cmd']}
			local operation=${F__pacmans[$i,'show']}

			if type $pacman &> /dev/null ; then
				if eval "$operation $package" &> /tmp/hop.log ; then
					eval "$operation $package"
					break
				fi
			fi
		done
	done
}

# TODO:
F_pkg_isInstalled() {
	local package=$1
}
