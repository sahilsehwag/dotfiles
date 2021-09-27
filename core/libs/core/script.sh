#!/usr/bin/env bash
F_getScriptDir() {
	#local SOURCE="${BASH_SOURCE[0]:-$0}";
	local SOURCE="$*"

	while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
		local TARGET="$( readlink -- "$SOURCE"; )";
		if [[ $TARGET == /* ]]; then
			SOURCE="$TARGET";
		else
			DIR="$( dirname -- "$SOURCE"; )";
			SOURCE="${DIR}/${TARGET}"; # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
		fi
	done

	local RDIR="$( dirname -- "$SOURCE"; )";
	local DIR="$( cd -P "$( dirname -- "$SOURCE"; )" &> /dev/null && pwd 2> /dev/null )";
	echo "$DIR"

	return $?
}
