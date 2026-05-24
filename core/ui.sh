#!/usr/bin/env bash
# Wrappers around gum (charmbracelet/gum) for all interactive UI patterns.
# Requires gum to be installed: brew install gum

# ── OUTPUT ────────────────────────────────────────────────────────────────────

F_ui_header() {
  gum style \
    --border rounded \
    --padding "1 2" \
    --bold \
    --foreground 212 \
    "$*"
}

F_ui_success() { gum style --bold --foreground 42 "$*"; }
F_ui_warn()    { gum style --foreground 214 "$*"; }
F_ui_error()   { gum style --foreground 196 "$*"; }
F_ui_info()    { gum style --foreground 39 "$*"; }
F_ui_dim()     { gum style --foreground 240 "$*"; }
F_ui_accent()  { gum style --bold --foreground 212 "$*"; }

# ── LOGGING ───────────────────────────────────────────────────────────────────

F_ui_log_info()  { gum log --level info  "$@"; }
F_ui_log_warn()  { gum log --level warn  "$@"; }
F_ui_log_error() { gum log --level error "$@"; }
F_ui_log_debug() { gum log --level debug "$@"; }

# ── PROMPTS ───────────────────────────────────────────────────────────────────

# F_ui_confirm "Are you sure?" → returns 0 on yes, 1 on no
F_ui_confirm() { gum confirm "$@"; }

# F_ui_input "Prompt" [placeholder] [default value]
F_ui_input() {
  local prompt="${1:-Input:}" placeholder="${2:-}" default="${3:-}"
  gum input \
    --prompt "$prompt " \
    ${placeholder:+--placeholder "$placeholder"} \
    ${default:+--value "$default"}
}

# F_ui_password "Prompt"
F_ui_password() {
  gum input --password --prompt "${1:-Password:} "
}

# F_ui_write [header] [placeholder] → opens multi-line editor, prints result
F_ui_write() {
  local header="${1:-}" placeholder="${2:-}"
  gum write \
    ${header:+--header "$header"} \
    ${placeholder:+--placeholder "$placeholder"}
}

# ── SELECTION ─────────────────────────────────────────────────────────────────

# F_ui_pick "Header" opt1 opt2 … → prints the chosen option
F_ui_pick() {
  local header="$1"; shift
  gum choose --header "$header" "$@"
}

# F_ui_pick_many "Header" opt1 opt2 … → prints newline-separated selections
F_ui_pick_many() {
  local header="$1"; shift
  gum choose --no-limit --header "$header" "$@"
}

# F_ui_filter "Header" opt1 opt2 …  (or pipe options via stdin)
F_ui_filter() {
  local header="$1"; shift
  gum filter --header "$header" "$@"
}

# F_ui_filter_many "Header" opt1 opt2 …
F_ui_filter_many() {
  local header="$1"; shift
  gum filter --no-limit --header "$header" "$@"
}

# F_ui_file [dir]  → interactive file picker, prints chosen path
F_ui_file() { gum file "${1:-.}"; }

# ── ASYNC ─────────────────────────────────────────────────────────────────────

# F_ui_spin "Loading…" cmd [args…]
F_ui_spin() {
  local title="$1"; shift
  gum spin --spinner dot --title "$title" -- "$@"
}

# F_ui_spin_step index total "Title" cmd [args…]
F_ui_spin_step() {
  local index="$1" total="$2" title="$3"; shift 3
  gum spin --spinner dot --title "[$index/$total] $title" -- "$@"
}

# ── CONTENT ───────────────────────────────────────────────────────────────────

# Pipe or pass content to scroll through
F_ui_pager() {
  if [[ -n "$1" ]]; then gum pager <"$1"; else gum pager; fi
}

# Pipe CSV rows to render as a table  (header row required)
F_ui_table() { gum table; }

# Render markdown text
F_ui_markdown() { gum format -- "$*"; }

# Render a fenced code block
F_ui_code() {
  local lang="${2:-}"
  gum format --type code ${lang:+--language "$lang"} -- "$1"
}
