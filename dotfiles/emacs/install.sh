#!usr/bin/env bash
script_directory="$( cd "$( dirname "$0" )" && pwd )"

[[ ! -L ~/.config/emacs ]] && ln -sv $script_directory/ ~/.config/emacs 
[[ ! -L ~/.emacs.d/init.el ]] && mkdir -p ~/.emacs.d && ln -sv $script_directory/init.el ~/.emacs.d/init.el

/bin/sh -x $script_directory/scripts/install_packages.sh
if [[ "$OSTYPE" == "darwin"* ]]; then
	/bin/sh -x $script_directory/scripts/install.mac.sh
fi
