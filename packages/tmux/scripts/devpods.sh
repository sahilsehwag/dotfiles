#!/usr/bin/env bash

SCRIPT="$(realpath "$0")"

list_devpods() {
	devpod ps --json 2>/dev/null \
		| jq -r '.[] | "\(.devpodName)\t\(.state)\t\(.flavor)\t\(.region)\t\(.region_dns)"'
}

fqdn() {
	local name="$1" region_dns="$2"
	printf '%s.%s' "$name" "$region_dns"
}

case "$1" in
	ssh)
		name="$2" region_dns="$3"
		fqdn="$(fqdn "$name" "$region_dns")"
		tmux new-window -n "dp:$name" "ssh $fqdn"
		;;

	info)
		name="$2"
		tmux new-window -n "info:$name" "devpod info $name; read"
		;;

	start)
		name="$2"
		tmux new-window -n "start:$name" "devpod start $name; read"
		;;

	stop)
		name="$2"
		tmux new-window -n "stop:$name" "devpod stop $name; read"
		;;

	restart)
		name="$2"
		tmux new-window -n "restart:$name" "devpod restart $name; read"
		;;

	delete)
		name="$2"
		tmux new-window -n "rm:$name" "devpod delete -f $name; read"
		;;

	create)
		tmux new-window -n "dp:create" "devpod create"
		;;

	*)
		raw="$(list_devpods)"
		if [[ -z "$raw" ]]; then
			tmux display-message "devpods: no devpods found (is 'devpod' installed?)"
			exit 0
		fi

		# Format: <padded display>\t<name>\t<region_dns>
		# --with-nth=1 shows only the display; actions read {2} and {3}
		printf '%s\n' "$raw" \
			| awk -F'\t' '
				{
					lines[NR] = $0
					if (length($1) > mw1) mw1 = length($1)
					if (length($2) > mw2) mw2 = length($2)
					if (length($3) > mw3) mw3 = length($3)
					if (length($4) > mw4) mw4 = length($4)
				}
				END {
					for (i = 1; i <= NR; i++) {
						split(lines[i], f, "\t")
						display = sprintf("%-*s  %-*s  %-*s  %-*s", mw1, f[1], mw2, f[2], mw3, f[3], mw4, f[4])
						printf "%s\t%s\t%s\n", display, f[1], f[5]
					}
				}' \
			| fzf-tmux -p -w80% \
				--delimiter='\t' \
				--with-nth=1 \
				--prompt="Devpods > " \
				--header="enter:ssh  ctrl-i:info  ctrl-s:start  ctrl-x:stop  ctrl-r:restart  ctrl-d:delete  ctrl-n:create" \
				--bind="enter:execute($SCRIPT ssh {2} {3})+abort" \
				--bind="ctrl-i:execute($SCRIPT info {2})+abort" \
				--bind="ctrl-s:execute($SCRIPT start {2})+abort" \
				--bind="ctrl-x:execute($SCRIPT stop {2})+abort" \
				--bind="ctrl-r:execute($SCRIPT restart {2})+abort" \
				--bind="ctrl-d:execute($SCRIPT delete {2})+abort" \
				--bind="ctrl-n:execute($SCRIPT create)+abort" \
		|| true
		;;
esac
