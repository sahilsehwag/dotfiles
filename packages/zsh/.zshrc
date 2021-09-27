#CORE
	if [[ -d ~/.dotfiles ]]; then
		export SCRIPTS_ROOT=~/.dotfiles
		export SCRIPTS_CORE=$SCRIPTS_ROOT/core

		source $SCRIPTS_CORE/install.sh
		source $SCRIPTS_CONFIG/init.sh

		source $SCRIPTS_ROOT/custom/install.sh
	fi
#VARIABLES
	#ENVIORNMENT
		export EDITOR=nvim
		source $HOME/shell-tokens.sh
	#META
		if [[ "$OSTPYPE" == "darwin"* ]]; then
			jatPlatform=mac
		elif [[ "$OSTPYPE" == "linux-gnu"* ]]; then
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
#FUNCTIONS
	#RANDOM
		function ban() {
			if type bat &> /dev/null; then
				nocorrect man "$@" | bat
			else
				nocorrect man "$@"
			fi
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
#ZSH|OhMyZsh
	#CONFIGURATION
		#export TERM='xterm-256color'
		export TERM='xterm-256color-italic'
		export ZSH=~/.oh-my-zsh
		export SSH_KEY_PATH="~/.ssh/rsa_id"

		if [[ -f $HOME/.config/promptline.sh ]]  then
			source $HOME/.config/promptline.sh
		else
			#ZSH_THEME="spaceship"
			#ZSH_THEME="powerlevel9k/powerlevel9k"
			ZSH_THEME="powerlevel10k/powerlevel10k"
		fi

		HYPHEN_INSENSITIVE="true"
		ENABLE_CORRECTION="true"
		ZSH_DISABLE_COMPFIX="true"

		plugins=(
			fzf-tab
			vi-mode
			zsh-syntax-highlighting
			zsh-interactive-cd
			zsh-fzf-history-search	#CTRL-R FOR HISTORY SEARCH
			web-search
			colored-man-pages
			command-not-found
			zsh-abbr
			#zsh-autosuggestions
			#zsh_reload
		)
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
#ALIASES
	type procs					&> /dev/null && alias ps='procs'
	type dos2unix				&> /dev/null && alias d2u='find -type f | xargs dos2unix'
	type nvim						&> /dev/null && alias v='nvim'

	#shortcuts
	alias c='clear'

	#hack|resetting-term for ssh
	alias ssh='TERM=xterm-256color ssh'
#ABBREVIATIONS
	#source $ZSH_CUSTOM/configs/zsh-abbr.sh
#RANDOM
	#COMMAND-NOT-FOUND
		if [[ "$OSTPYPE" == "darwin"* ]]; then
			HB_CNF_HANDLER="$(brew --prefix)/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
			if [ -f "$HB_CNF_HANDLER" ]; then
				source "$HB_CNF_HANDLER";
			fi
		fi
#TEMPORAL
	if F_isFile ~/Documents/projects/sahilsehwag/github/ush/install.sh
	then
		source ~/Documents/projects/sahilsehwag/github/ush/install.sh
	fi
