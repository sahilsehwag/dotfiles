#ENVIORNENT VARIABLES
	export GOPATH='~/.config/go'
#CUSTOM VARIABLES
	PLATFORM='mac'
	EDITOR=nvim
	VISUAL=nvim
#CONFIGURATION
	export TERM='xterm-256color'
	export ZSH=~/.oh-my-zsh
	export SSH_KEY_PATH="~/.ssh/rsa_id"

	ZSH_THEME="powerlevel9k/powerlevel9k"
	HYPHEN_INSENSITIVE="true"
	ENABLE_CORRECTION="true"

	plugins=(fasd vi-mode colored-man-pages)
	source $ZSH/oh-my-zsh.sh
#POWERLEVEL9K SETTINGS
	#PROMPTS
		POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh time public_ip dir vcs root_indicator)
		POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vi_mode status background_jobs)
	#DIRECTORY
		POWERLEVEL9K_DIR_HOME_FOREGROUND='015'
		POWERLEVEL9K_DIR_HOME_BACKGROUND='033'
		POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='015'
		POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='033'
		POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='015'
		POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='033'
	#VI MODE
		POWERLEVEL9K_VI_INSERT_MODE_STRING='INSERT'
		POWERLEVEL9K_VI_COMMAND_MODE_STRING='NORMAL'
		#POWERLEVEL9K_VI_INSERT_FOREGROUND=''
		POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='048'
		#POWERLEVEL9K_VI_COMMAND_FOREGROUND=''
		POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='069'
#APPLICATIONS
	#FZF
		[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
		export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
		export FZF_DEFAULT_OPTS=$'
			--height 50%
			--reverse
			--margin 0,0,0,2
			--color fg:-1,bg:-1,hl:33,fg+:254,bg+:235,hl+:33
			--color info:136,prompt:136,pointer:230,marker:230,spinner:136
			--preview \'
				(highlight -O ansi -l {} ||
				coderay {} ||
				cat {} ||
				tree -C {}) 2> /dev/null | head -500
				\'
			--preview-window right:50%:hidden
			--bind ?:toggle-preview
		'

		export FZF_COMPLETION_TRIGGER=''
	#FUCK
		type "thefuck" > /dev/null && eval $(thefuck --alias fuck)
#ALIASES
	source ~/aliases/.fzf
	source ~/aliases/.tmux
	source ~/aliases/.fasd

	alias d2u='find -type f | xargs dos2unix'
	alias python=python3
	alias pip=pip3
	alias vim='nvim'

	if [[ $(uname) ~= Darwin ]]; then
		alias ctags="`brew --prefix`/bin/ctags"
		alias ctagsg='ctags -R --exclude=.git --exclude=log *'
		alias emacs='/usr/local/bin/emacs'
		alias vis='/usr/local/bin/vis'
		alias ls='exa'
		alias r='/usr/local/bin/r'
		alias pe='path-extractor'
		alias processing-java='/usr/local/bin/processing-java'
	fi
#FUNCTIONS
	new() {
		if [[ "$@" == */ ]] then
			mkdir -p $@
		else
			for f in "$@"; do mkdir -p "$(dirname "$f")"; done
			touch "$@"
		fi
	}
	codi() {
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
	processing(){
		rm -rf /tmp/processing
		mkdir /tmp/processing
		processing-java --output=/tmp/processing/ --force --sketch=$1 --run
	}
#TEMPORARY
#PATH
	if [[ $(uname) ~= Darwin ]]; then
		export PATH="/usr/local/sbin:$PATH"
		export PATH="$PATH:~/.npm-packages/bin:~/node_modules/.bin"
	fi
