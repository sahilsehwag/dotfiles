# ███████╗░██████╗██╗░░██╗
# ╚════██║██╔════╝██║░░██║
# ░░███╔═╝╚█████╗░███████║
# ██╔══╝░░░╚═══██╗██╔══██║
# ███████╗██████╔╝██║░░██║
# ╚══════╝╚═════╝░╚═╝░░╚═╝

#TEMPORAL
	autoload -U +X compinit && compinit
	autoload -U +X bashcompinit && bashcompinit
#CORE
	export USH_ROOT="$HOME/Documents/projects/personal/ush"
	if [ -f ~/Documents/projects/personal/ush/index.sh ]; then
		source ~/Documents/projects/personal/ush/index.sh
	fi
	if [[ -d "$HOME/Documents/projects/personal/dotfiles" ]]; then
		export DOTFILES_ROOT="$HOME/Documents/projects/personal/dotfiles"
		export DOTFILES_CORE="$DOTFILES_ROOT/core"

		source $DOTFILES_CORE/install.sh
		source $DOTFILES_CONFIG/init.sh

		source $DOTFILES_ROOT/custom/install.sh
	fi
#VARIABLES
	#ENVIORNMENT
		export EDITOR=nvim
		source "$HOME/.tokens"
		export PATH="$HOME/.local/bin:$PATH"
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
	#TMUX-SSH
		# Attach any SSH host and set tmux-ssh window context so that
		# splits/windows/popups route to the remote (relay/portal).
		#   ssh-attach <host> [remote_dir] [has_remote_tmux]
		# Pass "1" as the 3rd arg if a tmux server is running remotely.
		#
		# NOTE: remote_dir is a path ON THE POD. Quote it so your LOCAL shell
		# does not expand it, e.g.:
		#   ssh-attach pod '~/web-code' 1      (tilde expanded remotely)
		#   ssh-attach pod 'web-code'          (relative to remote $HOME)
		# Do NOT pass an unquoted $HOME/... — that expands to your Mac path.
		ssh-attach() {
			local host="$1"
			local dir="${2:-}"
			local has_tmux="${3:-}"

			if [ -n "${TMUX:-}" ]; then
				tmux set-window-option "@ssh_host" "$host"
				tmux set-window-option "@ssh_dir"  "$dir"
				tmux set-window-option "@ssh_tmux" "$has_tmux"
			fi

			if [ -n "$dir" ]; then
				# cd runs on the REMOTE. If it fails, warn but still drop into a
				# shell (in remote $HOME) instead of exiting.
				ssh "$host" -t "cd $dir 2>/dev/null || { echo \"tmux-ssh: remote dir '$dir' not found; starting in \$HOME\" >&2; }; exec \$SHELL"
			else
				ssh "$host"
			fi

			# Clear context on exit
			if [ -n "${TMUX:-}" ]; then
				tmux set-window-option "@ssh_host" ""
				tmux set-window-option "@ssh_dir"  ""
				tmux set-window-option "@ssh_tmux" ""
			fi
		}

		# Attach and land directly in a REMOTE tmux session (relay mode).
		# Sets @ssh_tmux=1 so splits/windows/popups relay into remote tmux.
		#   ssh-attach-tmux <host> [remote_dir]
		# Quote remote_dir (see ssh-attach note) — it is a path on the pod.
		ssh-attach-tmux() {
			local host="$1"
			local dir="${2:-}"

			if [ -n "${TMUX:-}" ]; then
				tmux set-window-option "@ssh_host" "$host"
				tmux set-window-option "@ssh_dir"  "$dir"
				tmux set-window-option "@ssh_tmux" "1"
			fi

			if [ -n "$dir" ]; then
				# cd on the remote, then start/attach tmux there (so its first
				# window opens in the requested dir). Falls back to remote $HOME.
				ssh "$host" -t "cd $dir 2>/dev/null; tmux new-session -A -s main"
			else
				ssh "$host" -t "tmux new-session -A -s main"
			fi

			if [ -n "${TMUX:-}" ]; then
				tmux set-window-option "@ssh_host" ""
				tmux set-window-option "@ssh_dir"  ""
				tmux set-window-option "@ssh_tmux" ""
			fi
		}
#ZSH|OhMyZsh
	#CONFIGURATION
		# export TERM='xterm-256color-italic' #xterm-256color
		export ZSH=~/.oh-my-zsh
		export SSH_KEY_PATH="~/.ssh/rsa_id"

		#spaceship, powerlevel9k/powerlevel9k
		#ZSH_THEME="powerlevel10k/powerlevel10k"

		HYPHEN_INSENSITIVE="true"
		ENABLE_CORRECTION="true"
		ZSH_DISABLE_COMPFIX="true"

		plugins=(
			#vi-mode
			zsh-vi-mode
			zsh-syntax-highlighting
			zsh-autosuggestions
			zsh-interactive-cd
			zsh-fzf-history-search # CTRL-R FOR HISTORY SEARCH
			fzf-tab
			colored-man-pages
			command-not-found
			zsh-abbr               # "abbr" to define abbreviations
		)
		F_isFile $ZSH/oh-my-zsh.sh && source $ZSH/oh-my-zsh.sh
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

#LOCAL
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
