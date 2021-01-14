#VARIABLES
	#ENVIORNMENT
		export GOPATH='~/.config/go'
	#META
		if [[ $OSTYPE =~ "darwin" ]]; then
			jatPlatform=mac
		elif [[ $OSTYPE =~ "linux" ]]; then
			jatPlatform=linux
		fi
	#PATHS
		jatDrive=~/Google\ Drive
	#COMMANDS
		jatEditor=nvim
		jatExplorer=vifm
		#jatFindFiles=
		#jatFindDirs=
		#jatFindText=
#ZSH|OhMyZsh
	#CONFIGURATION
		export TERM='xterm-256color'
		export ZSH=~/.oh-my-zsh
		export SSH_KEY_PATH="~/.ssh/rsa_id"

		ZSH_THEME="powerlevel9k/powerlevel9k"
		HYPHEN_INSENSITIVE="true"
		ENABLE_CORRECTION="true"
		ZSH_DISABLE_COMPFIX="true"

		plugins=(fasd vi-mode colored-man-pages)
		source $ZSH/oh-my-zsh.sh
	#POWERLEVEL9K
		#PROMPTS
			POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh public_ip dir vcs root_indicator)
			POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vi_mode status background_jobs)
		#DIRECTORY
			POWERLEVEL9K_DIR_HOME_FOREGROUND='015'
			POWERLEVEL9K_DIR_HOME_BACKGROUND='033'
			POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='015'
			POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='033'
			POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='015'
			POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='033'
		#VIMISH
			POWERLEVEL9K_VI_INSERT_MODE_STRING='INSERT'
			POWERLEVEL9K_VI_COMMAND_MODE_STRING='NORMAL'
			#POWERLEVEL9K_VI_INSERT_FOREGROUND=''
			POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='048'
			#POWERLEVEL9K_VI_COMMAND_FOREGROUND=''
			POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='069'
#APPLICATIONS
	#TMUX
		alias tl='tmux list-sessions'
		alias tn='tmux new-session -s'
		alias tr='tmux rename-session -t'
		alias ta='tmux attach-session -t'
		alias tk='tmux kill-session -t'


		alias twn='tmux new-window -n'
		alias twk='tmux kill-window'
		alias twr='tmux rename-window -t'
		alias tws='tmux select-window -t'

		alias tpk='tmux kill-pane'
		alias td='tmux detach'

		alias tcs='tmux choose-session'
		alias tcw='tmux choose-window'
		alias tcp='tmux choose-pane'
	#FZF
		[[ -f $HOME/.config/fzf.sh ]]  && source $HOME/.config/fzf.sh
	#FASD
		alias sd='fasd -sid'
		alias sf='fasd -sif'
		alias j='fasd_cd -d'
		alias z='fasd_cd -d'
		alias zz='fasd_cd -di'
		alias v="f -e vim"
	#FUCK
		type "thefuck" > /dev/null && eval $(thefuck --alias fuck)
#FUNCTIONS
	#FILESYSTEM
		function newFile() {
			if [[ "$@" == */ ]] then
				mkdir -p $@
			else
				for f in "$@"; do mkdir -p "$(dirname "$f")"; done
				touch "$@"
			fi
		}
	#LOGGING
	#RANDOM
		function cheat() {
			type curl > /dev/null && curl cheat.sh/$1 | bat
		}

		function codi() {
			local syntax="${1:-python}"
			shift
			nvim -c \
				"let g:startify_disable_at_vimenter = 1 |\
				set bt=nofile ls=0 noru nonu nornu |\
				hi ColorColumn ctermbg=NONE |\
				hi VertSplit ctermbg=NONE |\
				hi NonText ctermfg=0 |\
				Codi $syntax" "$@"
		}

		function processing() {
			rm -rf /tmp/processing
			mkdir /tmp/processing
			processing-java --output=/tmp/processing/ --force --sketch=$1 --run
		}
#ALIASES
	type dos2unix       > /dev/null && alias d2u='find -type f | xargs dos2unix'
	type nvim           > /dev/null && alias vi='nvim'
	type nvim           > /dev/null && alias vim='nvim'
	type exa            > /dev/null && alias ls='exa'
	type path-extractor > /dev/null && alias pe='path-extractor'
	#type python3        > /dev/null && alias python=python3
	#type pip3           > /dev/null && alias pip=pip3
#RANDOM
