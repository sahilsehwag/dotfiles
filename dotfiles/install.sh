#!usr/bin/env bash
script_directory="$( cd "$( dirname "$0" )" && pwd )"

/bin/sh -x $script_directory/terminfo/install.sh
/bin/sh -x $script_directory/zsh/install.sh
/bin/sh -x $script_directory/tmux/install.sh
/bin/sh -x $script_directory/kmonad/install.sh
/bin/sh -x $script_directory/fzf/install.sh
/bin/sh -x $script_directory/vim/install.sh
/bin/sh -x $script_directory/emacs/install.sh
/bin/sh -x $script_directory/vifm/install.sh
/bin/sh -x $script_directory/lazygit/install.sh
/bin/sh -x $script_directory/iterm/install.sh
/bin/sh -x $script_directory/bat/install.sh
/bin/sh -x $script_directory/ideavim/install.sh
