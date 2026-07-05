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

		# Route through tmux-ssh (portal mode) if the plugin is present:
		# create the window, tag it with @ssh_host so splits/windows/popups
		# spawn fresh SSH sessions into the devpod. Fall back to plain ssh.
		if [[ -x "$HOME/.config/tmux/plugins/tmux-ssh/bin/tmux-ssh" ]]; then
			win="$(tmux new-window -P -F '#{window_id}' -n "dp:$name" "ssh $fqdn")"
			tmux set-window-option -t "$win" @ssh_host "$fqdn"
		else
			tmux new-window -n "dp:$name" "ssh $fqdn"
		fi
		;;

	ssh-tmux)
		# Open the devpod straight into a REMOTE tmux session and mark the
		# window for relay mode (@ssh_tmux=1). Splits/windows/popups are then
		# relayed into the remote tmux, which owns cwd/layout natively.
		name="$2" region_dns="$3"
		fqdn="$(fqdn "$name" "$region_dns")"

		if [[ -x "$HOME/.config/tmux/plugins/tmux-ssh/bin/tmux-ssh" ]]; then
			win="$(tmux new-window -P -F '#{window_id}' -n "dp:$name" \
				"ssh $fqdn -t 'tmux new-session -A -s main'")"
			tmux set-window-option -t "$win" @ssh_host "$fqdn"
			tmux set-window-option -t "$win" @ssh_tmux "1"
		else
			tmux new-window -n "dp:$name" "ssh $fqdn -t 'tmux new-session -A -s main'"
		fi
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
		# Open an interactive gum wizard in a new window. The window is the TTY
		# gum needs; it stays open on completion/error via the wizard's own read.
		tmux new-window -n "dp:create" "$SCRIPT create-wizard"
		;;

	create-wizard)
		# Interactive create flow driven by gum. Runs inside a tmux window.
		if ! command -v gum >/dev/null 2>&1; then
			printf '\n  gum is required for the create wizard. Install it and retry.\n'
			printf '  (brew install gum)\n\n'
			read -r _
			exit 1
		fi

		printf '\n  Create a new devpod\n\n'

		name=$(gum input --prompt "Name: " --placeholder "e.g. sahilsehwag-web") || exit 0
		if [ -z "$name" ]; then
			printf '\n  Cancelled: a name is required (empty name provisions a random pod).\n\n'
			read -r _
			exit 0
		fi

		flavor=$(gum choose --header "Flavor:" \
			base go java android web ml uberone base-arm) || exit 0

		region=$(gum choose --header "Region:" \
			india oregon virginia netherlands brazil) || exit 0

		channel=$(gum choose --header "Release channel:" \
			stable rc dev none) || exit 0

		# Build the command
		args=(--name "$name" --flavor "$flavor" --region "$region" --release-channel "$channel")

		printf '\n  Will run: '
		gum style --foreground 75 "devpod create ${args[*]}"
		printf '\n'

		if ! gum confirm "Create this devpod?"; then
			printf '\n  Cancelled.\n\n'
			read -r _
			exit 0
		fi

		printf '\n'
		devpod create "${args[@]}"
		printf '\n  [done — press enter to close]\n'
		read -r _
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
				--header="enter:ssh  ctrl-t:ssh+tmux  ctrl-i:info  ctrl-s:start  ctrl-x:stop  ctrl-r:restart  ctrl-d:delete  ctrl-n:create" \
				--bind="enter:execute($SCRIPT ssh {2} {3})+abort" \
				--bind="ctrl-t:execute($SCRIPT ssh-tmux {2} {3})+abort" \
				--bind="ctrl-i:execute($SCRIPT info {2})+abort" \
				--bind="ctrl-s:execute($SCRIPT start {2})+abort" \
				--bind="ctrl-x:execute($SCRIPT stop {2})+abort" \
				--bind="ctrl-r:execute($SCRIPT restart {2})+abort" \
				--bind="ctrl-d:execute($SCRIPT delete {2})+abort" \
				--bind="ctrl-n:execute($SCRIPT create)+abort" \
		|| true
		;;
esac
