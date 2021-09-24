#!usr/bin/env bash

/bin/sh -x ../variables.sh

if [[ meta.os =~ "mac" ]]; then
	source ./macos.sh
elif [[ meta.os =~ "ubuntu" ]]; then
	source ./ubuntu.sh
elif [[ meta.os =~ "windows" ]]; then
	source ./windows.sh
fi
