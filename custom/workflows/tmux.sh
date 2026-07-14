# ==========================================
# SESSIONS
# ==========================================

# Bootstrap personal tmux layout: sessions zen + work.
# zen windows: zen | kanata (runs kanata) | dots (dotfiles cwd)
tstart() {
  local dots_dir="${DOTFILES_ROOT:-$HOME/Documents/projects/personal/dotfiles}"
  local kanata_dir="$dots_dir/packages/kanata"

  if ! command -v tmux >/dev/null 2>&1; then
    echo "tstart: tmux is not installed" >&2
    return 1
  fi

  # --- zen session ---
  if ! tmux has-session -t zen 2>/dev/null; then
    tmux new-session -d -s zen -n zen -c "$HOME"
    tmux new-window -t zen: -n kanata -c "$kanata_dir"
    tmux send-keys -t zen:kanata "sudo kanata --cfg config.kbd" Enter
    tmux new-window -t zen: -n dots -c "$dots_dir"
    tmux select-window -t zen:zen
  fi

  # --- work session ---
  if ! tmux has-session -t work 2>/dev/null; then
    tmux new-session -d -s work -n work -c "$HOME"
  fi

  # Attach (or switch if already inside tmux)
  if [[ -n "${TMUX:-}" ]]; then
    tmux switch-client -t zen
  else
    tmux attach-session -t zen
  fi
}
