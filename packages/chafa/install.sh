#!/usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

echo "TODO: chafa"
exit 1

F_install automake libtool

if F_isMac; then
  F_install freetype
else
  echo "chafa: freetype dependency missing"
fi

[[ ! -d $DOTFILES_REPOS/chafa ]] && git clone https://github.com/hpjansson/chafa.git $DOTFILES_REPOS/chafa
cd $DOTFILES_REPOS/chafa
./autogen.sh
make
sudo make install
