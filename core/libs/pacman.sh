#!/usr/bin/env bash
declare -A F__pacmans
declare __F_idx=-1

let __F_idx++
F__pacmans[$__F_idx,'cmd']='brew'
F__pacmans[$__F_idx,'install']='brew install'
F__pacmans[$__F_idx,'uninstall']='brew uninstall'
F__pacmans[$__F_idx,'update']='brew upgrade'
F__pacmans[$__F_idx,'search']='brew search'
F__pacmans[$__F_idx,'show']='brew info'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='port'
F__pacmans[$__F_idx,'install']='port install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='scoop'
F__pacmans[$__F_idx,'install']='scoop install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='choco'
F__pacmans[$__F_idx,'install']='choco install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='pacman'
F__pacmans[$__F_idx,'install']='pacman -Sy'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='yay'
F__pacmans[$__F_idx,'install']='yay -Sy'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

#let __F_idx++
#F__pacmans[$__F_idx,'cmd']='abs'
#F__pacmans[$__F_idx,'install']='abs install'
#F__pacmans[$__F_idx,'uninstall']='false'
#F__pacmans[$__F_idx,'update']='false'
#F__pacmans[$__F_idx,'search']='false'
#F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='apt'
F__pacmans[$__F_idx,'install']='apt install -y'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='apt-get'
F__pacmans[$__F_idx,'install']='apt-get install -y'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='dpkg'
F__pacmans[$__F_idx,'install']='dpkg install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='dnf'
F__pacmans[$__F_idx,'install']='dnf install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='yum'
F__pacmans[$__F_idx,'install']='yum install -y'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

#let __F_idx++
#F__pacmans[$__F_idx,'cmd']='urpmi'
#F__pacmans[$__F_idx,'install']='urpmi install'
#F__pacmans[$__F_idx,'uninstall']='false'
#F__pacmans[$__F_idx,'update']='false'
#F__pacmans[$__F_idx,'search']='false'
#F__pacmans[$__F_idx,'show']='false'

#let __F_idx++
#F__pacmans[$__F_idx,'cmd']='zypp'
#F__pacmans[$__F_idx,'install']='zypp install'
#F__pacmans[$__F_idx,'uninstall']='false'
#F__pacmans[$__F_idx,'update']='false'
#F__pacmans[$__F_idx,'search']='false'
#F__pacmans[$__F_idx,'show']='false'

#let __F_idx++
#F__pacmans[$__F_idx,'cmd']='up2date'
#F__pacmans[$__F_idx,'install']='up2date install'
#F__pacmans[$__F_idx,'uninstall']='false'
#F__pacmans[$__F_idx,'update']='false'
#F__pacmans[$__F_idx,'search']='false'
#F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='rpm'
F__pacmans[$__F_idx,'install']='rpm install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='pkg'
F__pacmans[$__F_idx,'install']='pkg install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='pkgin'
F__pacmans[$__F_idx,'install']='pkgin install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='emerge'
F__pacmans[$__F_idx,'install']='emerge -av'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='nix-env'
F__pacmans[$__F_idx,'install']='nix-env -i'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='apk'
F__pacmans[$__F_idx,'install']='apk add'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='xbps'
F__pacmans[$__F_idx,'install']='xbps-install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='yarn'
F__pacmans[$__F_idx,'install']='yarn global add'
F__pacmans[$__F_idx,'uninstall']='yarn remove'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='npm'
F__pacmans[$__F_idx,'install']='npm install -g'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='conda'
F__pacmans[$__F_idx,'install']='conda install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='pip'
F__pacmans[$__F_idx,'install']='pip install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='go'
F__pacmans[$__F_idx,'install']='go install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='cargo'
F__pacmans[$__F_idx,'install']='cargo install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='luarocks'
F__pacmans[$__F_idx,'install']='luarocks install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='gem'
F__pacmans[$__F_idx,'install']='gem install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'

let __F_idx++
F__pacmans[$__F_idx,'cmd']='stack'
F__pacmans[$__F_idx,'install']='stack install'
F__pacmans[$__F_idx,'uninstall']='false'
F__pacmans[$__F_idx,'update']='false'
F__pacmans[$__F_idx,'search']='false'
F__pacmans[$__F_idx,'show']='false'


F_pkg_install() {
	for package in "$@" ; do
		type $package &> /dev/null && continue

		for (( i=0; i<=$__F_idx; i++ )); do
			type $package &> /dev/null && break

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

			local pacman=${F__pacmans[$i,'cmd']}
			local operation=${F__pacmans[$i,'search']}

			if type $pacman &> /dev/null ; then
				if eval "$operation $package" &> /tmp/hop.log ; then
					#cat /tmp/hop.log
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

			local pacman=${F__pacmans[$i,'cmd']}
			local operation=${F__pacmans[$i,'show']}

			if type $pacman &> /dev/null ; then
				if eval "$operation $package" &> /tmp/hop.log ; then
					#cat /tmp/hop.log
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
