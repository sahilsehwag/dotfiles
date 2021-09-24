#!usr/bin/env bash
script_directory="$( cd "$( dirname "$0" )" && pwd )"
if [[ "$OSTYPE" == "darwin"* ]]; then
	/bin/sh -x $script_directory/scripts/install.mac.sh
fi
