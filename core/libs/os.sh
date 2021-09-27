#!usr/bin/env bash

F_isMac() {
	if [[ "$OSTYPE" == "darwin"* ]]; then
		return 0
	else
		return 1
	fi
}

F_isLinux() {
	if [[ "$OSTYPE" == "linux-gnu"* ]]; then
		return 0
	else
		return 1
	fi
}

F_isWindows() {
	if [[ "$OSTYPE" == "msys"* ]]; then
		return 0
	else
		return 1
	fi
}

F_isCygwin() {
	if [[ "$OSTYPE" == "cygwin"* ]]; then
		return 0
	else
		return 1
	fi
}

F_isWSL() {
	if [[ $(uname -r) =~ 'WSL' ]]; then
		return 0
	else
		return 1
	fi
}

F_isRedhat() {
	if [[ "$(gcc --version | grep ubuntu)" =~ "Red Hat" ]]; then
		return 0
	else
		return 1
	fi
}

F_isDebian() {
	if F_isInstalled apt; then
		return 0
	else
		return 1
	fi
}

F_isBSD() {
	if [[ "$OSTYPE" == "bsd"* ]]; then
		return 0
	else
		return 1
	fi
}

F_isFreeBSD() {
	if [[ "$OSTYPE" == "freebsd"* ]]; then
		return 0
	else
		return 1
	fi
}

F_isUbuntu() {
	if [[ "$(gcc --version | grep ubuntu)" =~ "ubuntu" ]]; then
		return 0
	else
		return 1
	fi
}

# F_isCentOS() {
# 	if [[ "$(gcc --version | grep ubuntu)" =~ "centos" ]]; then
# 		return 0
# 	else
# 		return 1
# 	fi
# }

# F_isArch() {
# 	if [[ "$OSTYPE" == "linux-arch"* ]]; then
# 		return 0
# 	else
# 		return 1
# 	fi
# }

F_isSolaris() {
	if [[ "$OSTYPE" == "solaris"* ]]; then
		return 0
	else
		return 1
	fi
}
