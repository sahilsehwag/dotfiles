#!usr/bin/env bash
script_directory=$(F_getScriptDir ${BASH_SOURCE:-$0})

if [[ ! -d ~/.terminfo ]]; then
	[[ ! -L ~/.terminfo ]] && ln -sv $script_directory/.terminfo/ ~/.terminfo
else
	[[ ! -L ~/xterm-256color-italic.terminfo ]] && ln -sv $script_directory/xterm-256color-italic.terminfo ~/xterm-256color-italic.terminfo
	[[ ! -L ~/tmux-256color.terminfo ]] && ln -sv $script_directory/tmux-256color.terminfo ~/tmux-256color.terminfo
  
	tic -x xterm-256color-italic.terminfo
	tic -x tmux-256color.terminfo
fi
