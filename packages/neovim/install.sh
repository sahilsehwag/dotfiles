#!usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

#nvim
[[ ! -L ~/.config/nvim ]] && ln -sv $script_directory/ ~/.config/nvim

#vim
mkdir -p ~/.local/share/nvim/site
ln -s ~/.local/share/nvim/site ~/.vim
ln -s .config/nvim/init.vim .vimrc

if [[ "$OSTYPE" == "darwin"* ]]; then
	install node python lua
	! type nvenv &> /dev/null && source $script_directory/scripts/install.nvenv.sh
	#! type neva  &> /dev/null && source $script_directory/scripts/install.neva.sh
	#! type nvim &> /dev/null && brew install nvim
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
	! type nvenv &> /dev/null && source $script_directory/scripts/install.nvenv.sh
	#! type neva  &> /dev/null && source $script_directory/scripts/install.neva.sh
fi

pip3 show neovim &> /dev/null || pip3 install neovim
pip3 show pynvim &> /dev/null || pip3 install pynvim

npm info neovim &> /dev/null || npm install -g neovim

source $script_directory/scripts/install.plug.sh
source $script_directory/scripts/install.packer.sh

