script_directory="$( cd "$( dirname "$0" )" && pwd )"
if [[ "$OSTYPE" == "darwin"* ]]; then
	/bin/sh -x $script_directory/scripts/__install.mac.sh
fi
/bin/sh -x $script_directory/fonts/install.sh
