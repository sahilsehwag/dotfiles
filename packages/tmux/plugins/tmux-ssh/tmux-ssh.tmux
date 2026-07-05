#!/usr/bin/env bash
# TPM entry point — sourced by tmux on load

PLUGIN_DIR="$(cd "$(dirname "$0")" && pwd)"
BIN="$PLUGIN_DIR/bin"

# Export plugin dir so bin/ commands are discoverable
tmux set-environment -g TMUX_SSH_PLUGIN_DIR "$PLUGIN_DIR"

# Default keybindings (user can override with @ssh_split_h_key etc.)
SPLIT_H=$(tmux show-option -gv @ssh_split_h_key 2>/dev/null || echo '%')
SPLIT_V=$(tmux show-option -gv @ssh_split_v_key 2>/dev/null || echo '"')
WINDOW=$(tmux show-option -gv @ssh_window_key 2>/dev/null || echo 'c')

tmux bind "$SPLIT_H" run-shell "$BIN/tmux-ssh split -h"
tmux bind "$SPLIT_V" run-shell "$BIN/tmux-ssh split -v"
tmux bind "$WINDOW" run-shell "$BIN/tmux-ssh window"

# Popup shortcut (no default — user sets @ssh_popup_key)
POPUP=$(tmux show-option -gv @ssh_popup_key 2>/dev/null || echo '')
[ -n "$POPUP" ] && tmux bind "$POPUP" run-shell "$BIN/tmux-ssh popup"
