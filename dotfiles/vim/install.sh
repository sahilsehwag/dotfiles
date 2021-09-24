#!usr/bin/env bash
script_directory="$( cd "$( dirname "$0" )" && pwd )"

#nvim
[[ ! -L ~/.config/nvim ]] && ln -sv $script_directory/ ~/.config/nvim

#vim
mkdir -p ~/.local/share/nvim/site
ln -s ~/.local/share/nvim/site ~/.vim 
ln -s .config/nvim/init.vim .vimrc

if [[ "$OSTYPE" == "darwin"* ]]; then
	/bin/sh -x $script_directory/scripts/install.mac.sh
fi

pip3 install neovim
pip3 install pynvim

npm install -g neovim

