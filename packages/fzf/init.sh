# ███████╗███████╗███████╗
# ██╔════╝╚════██║██╔════╝
# █████╗░░░░███╔═╝█████╗░░
# ██╔══╝░░██╔══╝░░██╔══╝░░
# ██║░░░░░███████╗██║░░░░░
# ╚═╝░░░░░╚══════╝╚═╝░░░░░

#ALISES
	alias fzf='fzf-tmux'
#VARIABLES
	export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
	export FZF_DEFAULT_OPTS=$'
		--height 50%
		--reverse
		--margin 0,0,0,2
		--color fg:-1,bg:-1,hl:33,fg+:254,bg+:235,hl+:33
		--color info:136,prompt:136,pointer:230,marker:230,spinner:136
		--preview \'
			(bat --color=always --style="numbers,changes,header,grid" --line-range :500 {} ||
			highlight -O ansi -l {} ||
			coderay {} ||
			cat {} ||
			tree -C {}) 2> /dev/null | head -500
			\'
		--preview-window right:50%:hidden
		--bind ?:toggle-preview
		--bind "ctrl-e:execute(nvim {})"
		--bind "ctrl-f:execute(vifm {})"
		--bind "ctrl-g:execute(lazygit {})"
		--bind "ctrl-c:execute(cd {})"
		--bind "ctrl-o:execute(open {})"
	'
	export FZF_COMPLETION_TRIGGER='**'
#SETUP
	if [ -f "$HOME/.fzf.zsh" ]; then
		source "$HOME/.fzf.zsh"
	else
		/usr/bin/env bash "$HOME/.fzf/install" && echo FZF initialization complete, reload ZSH!!!
	fi
#FILESYSTEM
	#GENERIC
		ffcmd(){
			if [ $1 ]; then
				if [ $2 ]; then
					$1 "$(find $2 -type f -name "*" | fzf)"
				else
					$1 "$(find . -type f -name "*" | fzf)"
				fi
			else
				echo "No command specified"
			fi
		}
		fdcmd(){
			if [ $1 ]; then
				if [ $2 ]; then
					$1 "$(find $2 -type d -name "*" 2> /dev/null | fzf)"
				else
					$1 "$(find . -type d -name "*" 2> /dev/null | fzf)"
				fi
			else
				echo "No command specified"
			fi
		}
	#NAVIGATION
		alias fch='fdcmd cd $HOME'
		alias fcd='fdcmd cd $jatDrive'
		alias fcc='fdcmd cd'
	#EDITOR
		alias fvh='ffcmd $jatEditor $HOME'
		alias fvd='ffcmd $jatEditor $jatDrive'
		alias fvc='ffcmd $jatEditor'
	#EXPLORER
		alias feh='fdcmd $jatExplorer $HOME'
		alias fed='fdcmd $jatExplorer $jatDrive'
		alias fec='fdcmd $jatExplorer'
	#RANDOM
