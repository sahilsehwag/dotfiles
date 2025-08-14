#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

if F_isMac; then
	source $script_directory/install.mac.sh
else
	F_logError "Java installation is only supported on macOS."
fi
