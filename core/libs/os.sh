#!/usr/bin/env bash

# Populated once at source time — query with F_is* functions below
OS_KERNEL=""        # macos | linux | freebsd | openbsd | netbsd | dragonfly | solaris | aix | haiku | windows | unknown
OS_DISTRO=""        # (linux) from /etc/os-release ID, lowercased
OS_DISTRO_LIKE=""   # (linux) from /etc/os-release ID_LIKE, lowercased
OS_ENV=""           # wsl | "" (native)
OS_ARCH=""          # x86_64 | arm64 | i386 | armv7l | ...
OS_MACOS_VERSION="" # (macos) major version number, e.g. "15"

_F_detect_os() {
	case "$OSTYPE" in
		darwin*)              OS_KERNEL="macos" ;;
		linux*)               OS_KERNEL="linux" ;;
		freebsd*)             OS_KERNEL="freebsd" ;;
		openbsd*)             OS_KERNEL="openbsd" ;;
		netbsd*)              OS_KERNEL="netbsd" ;;
		dragonfly*)           OS_KERNEL="dragonfly" ;;
		solaris*)             OS_KERNEL="solaris" ;;
		aix*)                 OS_KERNEL="aix" ;;
		haiku*)               OS_KERNEL="haiku" ;;
		msys*|cygwin*|mingw*) OS_KERNEL="windows" ;;
		*)                    OS_KERNEL="unknown" ;;
	esac

	OS_ARCH="$(uname -m 2>/dev/null)"
	[[ "$OS_ARCH" == "aarch64" ]] && OS_ARCH="arm64"

	if [[ "$OS_KERNEL" == "macos" ]]; then
		OS_MACOS_VERSION="$(sw_vers -productVersion 2>/dev/null | cut -d. -f1)"
	fi

	if [[ "$OS_KERNEL" == "linux" && -f /etc/os-release ]]; then
		local _id _id_like
		_id="$(source /etc/os-release && echo "${ID,,}")"
		_id_like="$(source /etc/os-release && echo "${ID_LIKE,,}")"
		OS_DISTRO="$_id"
		OS_DISTRO_LIKE="$_id_like"
	fi

	if grep -qiE "microsoft|WSL" /proc/version 2>/dev/null; then
		OS_ENV="wsl"
	fi
}

_F_detect_os

# =============================================================================
# Kernel / platform
# =============================================================================

F_isMac()       { [[ "$OS_KERNEL" == "macos" ]]; }
F_isLinux()     { [[ "$OS_KERNEL" == "linux" ]]; }
F_isWindows()   { [[ "$OS_KERNEL" == "windows" ]]; }
F_isCygwin()    { [[ "$OSTYPE" == cygwin* ]]; }
F_isSolaris()   { [[ "$OS_KERNEL" == "solaris" ]]; }
F_isAIX()       { [[ "$OS_KERNEL" == "aix" ]]; }
F_isHaiku()     { [[ "$OS_KERNEL" == "haiku" ]]; }
F_isWSL()       { [[ "$OS_ENV" == "wsl" ]]; }

# BSD family
F_isBSD()       { [[ "$OS_KERNEL" == freebsd || "$OS_KERNEL" == openbsd || "$OS_KERNEL" == netbsd || "$OS_KERNEL" == dragonfly ]]; }
F_isFreeBSD()   { [[ "$OS_KERNEL" == "freebsd" ]]; }
F_isOpenBSD()   { [[ "$OS_KERNEL" == "openbsd" ]]; }
F_isNetBSD()    { [[ "$OS_KERNEL" == "netbsd" ]]; }
F_isDragonFly() { [[ "$OS_KERNEL" == "dragonfly" ]]; }

# =============================================================================
# Architecture
# =============================================================================

F_isX86_64()     { [[ "$OS_ARCH" == "x86_64" ]]; }
F_isArm64()      { [[ "$OS_ARCH" == "arm64" ]]; }
F_isArm32()      { [[ "$OS_ARCH" == armv* ]]; }
F_isX86()        { [[ "$OS_ARCH" == i*86 ]]; }
F_isMacSilicon() { F_isMac && F_isArm64; }

# =============================================================================
# macOS version (major only)
# =============================================================================

F_isMacOSVersion() { [[ "$OS_MACOS_VERSION" == "$1" ]]; }
F_isSequoia()   { F_isMacOSVersion "15"; }  # macOS 15
F_isSonoma()    { F_isMacOSVersion "14"; }  # macOS 14
F_isVentura()   { F_isMacOSVersion "13"; }  # macOS 13
F_isMonterey()  { F_isMacOSVersion "12"; }  # macOS 12
F_isBigSur()    { F_isMacOSVersion "11"; }  # macOS 11

# =============================================================================
# Linux distro
#
# F_isDistro "ubuntu"       — exact match on /etc/os-release ID
# F_isDistroFamily "debian" — matches ID or anything in ID_LIKE (catches derivatives)
# =============================================================================

F_isDistro()       { [[ "$OS_DISTRO" == "$1" ]]; }
F_isDistroFamily() { [[ "$OS_DISTRO" == "$1" || "$OS_DISTRO_LIKE" == *"$1"* ]]; }

# Debian family — ID_LIKE=debian on all derivatives
F_isDebian()     { F_isDistroFamily "debian"; }
F_isUbuntu()     { F_isDistro "ubuntu"; }
F_isMint()       { F_isDistro "linuxmint"; }
F_isPopOS()      { F_isDistro "pop"; }
F_isElementary() { F_isDistro "elementary"; }
F_isKali()       { F_isDistro "kali"; }
F_isParrot()     { F_isDistro "parrot"; }
F_isRaspbian()   { F_isDistro "raspbian"; }
F_isZorin()      { F_isDistro "zorin"; }
F_isMXLinux()    { F_isDistro "mx"; }

# RHEL family — ID_LIKE=rhel on derivatives
F_isRedhat()     { F_isDistroFamily "rhel"; }
F_isFedora()     { F_isDistro "fedora"; }
F_isCentOS()     { F_isDistro "centos"; }
F_isRocky()      { F_isDistro "rocky"; }
F_isAlmaLinux()  { F_isDistro "almalinux"; }
F_isOracle()     { F_isDistro "ol"; }
F_isScientific() { F_isDistro "scientific"; }

# Arch family — ID_LIKE=arch on derivatives
F_isArch()        { F_isDistroFamily "arch"; }
F_isManjaro()     { F_isDistro "manjaro"; }
F_isEndeavourOS() { F_isDistro "endeavouros"; }
F_isGaruda()      { F_isDistro "garuda"; }
F_isArtix()       { F_isDistro "artix"; }

# SUSE family — ID_LIKE=suse on all variants
F_isSUSE()       { F_isDistroFamily "suse"; }
F_isOpenSUSE()   { [[ "$OS_DISTRO" == opensuse* ]]; }

# Gentoo family — ID_LIKE=gentoo on derivatives (e.g. Funtoo)
F_isGentoo()     { F_isDistroFamily "gentoo"; }

# Standalone distros (no notable ID_LIKE derivatives)
F_isAlpine()     { F_isDistro "alpine"; }
F_isVoid()       { F_isDistro "void"; }
F_isNixOS()      { F_isDistro "nixos"; }
F_isSlackware()  { F_isDistro "slackware"; }
F_isMageia()     { F_isDistro "mageia"; }
F_isSolus()      { F_isDistro "solus"; }
F_isClearLinux() { F_isDistro "clear-linux-os"; }
