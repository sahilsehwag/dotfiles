#VARIABLES
	alias fzf='fzf-tmux'
#SETUP
	[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
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
	'

	export FZF_COMPLETION_TRIGGER=''
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
		alias fch='fdcmd cd ~'
		alias fcd='fdcmd cd $jatDrive'
		alias fcc='fdcmd cd'
	#EDITOR
		alias fvh='ffcmd $jatEditor ~'
		alias fvd='ffcmd $jatEditor $jatDrive'
		alias fvc='ffcmd $jatEditor'
	#EXPLORER
		alias feh='fdcmd $jatExplorer ~'
		alias fed='fdcmd $jatExplorer $jatDrive'
		alias fec='fdcmd $jatExplorer'
	#RANDOM
#GIT
	#fgbc() {
		#local branches branch
		#branches=$(git branch -vv) &&
		#branch=$(echo "$branches" | fzf +m) &&
		#git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
	#}
	#fgbC() {
		#local commits commit
		#commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
		#commit=$(echo "$commits" | fzf --tac +s +m -e) &&
		#git checkout $(echo "$commit" | sed "s/ .*//")
	#}
	#fgs() {
		#local out q k sha
			#while out=$(
					#git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
					#fzf --ansi --no-sort --query="$q" --print-query \
					#--expect=ctrl-d,ctrl-b);
		#do
			#mapfile -t out <<< "$out"
			#q="${out[0]}"
			#k="${out[1]}"
			#sha="${out[-1]}"
			#sha="${sha%% *}"
			#[[ -z "$sha" ]] && continue
			#if [[ "$k" == 'ctrl-d' ]]; then
				#git diff $sha
			#elif [[ "$k" == 'ctrl-b' ]]; then
				#git stash branch "stash-$sha" $sha
				#break;
			#else
				#git stash show -p $sha
			#fi
		#done
	#}
	#fgshow() {
		#git log --graph --color=always \
			#--format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
			#fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
			#--bind "ctrl-m:execute:
			#(grep -o '[a-f0-9]\{7\}' | head -1 |
			#xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
			#{}
		#FZF-EOF"
	#}
#PREINSTALLED
	#FILESYSTEM
	#PROCESS
		fkill() {
			local pid
			pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

			if [ "x$pid" != "x" ]
			then
				echo $pid | xargs kill -${1:-9}
			fi
		}
#APPLICATIONS
