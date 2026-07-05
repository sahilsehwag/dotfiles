# tmux-ssh

Context-aware tmux command router for SSH sessions. One command —
`tmux-ssh` — figures out whether you're local, SSH'd into a host with a
remote tmux, or SSH'd into a host without one, and does the right thing.

## Architecture

```
tmux-ssh (router)
  ├── detects context (window vars → pane auto-detect fallback)
  ├── routes to:
  │   ├── tmux-relay   (ssh + remote tmux → send tmux cmd into remote)
  │   ├── tmux-portal  (ssh, no remote tmux → spawn fresh SSH session per view)
  │   └── native       (local → plain tmux passthrough)
  └── exposes keybindings via TPM or manual source
```

## File Structure

```
tmux-ssh/
├── tmux-ssh.tmux      # TPM entry point — sources bindings, exports plugin dir
├── bin/
│   ├── tmux-ssh       # router — the main command
│   ├── tmux-relay     # sends tmux commands into remote tmux
│   └── tmux-portal    # spawns fresh SSH session per view
├── lib/
│   └── context.sh     # shared context detection (sourced by all three)
└── README.md
```

## Routing

```
tmux-ssh split -h
  ↓
lib/context.sh resolves TSH_HOST / TSH_HAS_TMUX
  ↓
@ssh_host set + @ssh_tmux=1  →  tmux-relay  → send-keys "tmux split-window -h" into pane
@ssh_host set, no @ssh_tmux  →  tmux-portal → tmux split-window -h "ssh host -t '...'"
neither                      →  native      → tmux split-window -h
```

## Verbs

| Verb            | Behavior                                    |
| --------------- | ------------------------------------------- |
| `split -h`/`-v` | New split (horizontal / vertical)           |
| `window`        | New window                                  |
| `popup [CMD]`   | Centered 90% popup running CMD (or `$SHELL`) |
| `run CMD`       | New window running CMD                       |

## Installation

### TPM

```tmux
# ~/.tmux.conf
set -g @plugin 'yourusername/tmux-ssh'

# Optional key overrides
set -g @ssh_split_h_key '%'
set -g @ssh_split_v_key '"'
set -g @ssh_window_key  'c'
set -g @ssh_popup_key   'g'   # prefix + g → popup (e.g. lazygit)
```

### Standalone (no TPM)

```tmux
# ~/.tmux.conf
run-shell ~/.config/tmux/plugins/tmux-ssh/tmux-ssh.tmux
```

Or add `bin/` to `PATH` and call `tmux-ssh` directly:

```sh
export PATH="$HOME/.config/tmux/plugins/tmux-ssh/bin:$PATH"
```

## `ssh-attach` Shell Helper

The user-facing API that sets context. Add to `~/.zshrc`:

```bash
# Generic: attach any SSH host
ssh-attach() {
  local host="$1"
  local dir="${2:-}"
  local has_tmux="${3:-}"     # pass "1" if remote tmux is running

  tmux set-window-option "@ssh_host" "$host"
  tmux set-window-option "@ssh_dir"  "$dir"
  tmux set-window-option "@ssh_tmux" "$has_tmux"

  if [ -n "$dir" ]; then
    ssh "$host" -t "cd $dir && exec \$SHELL"
  else
    ssh "$host"
  fi

  # Clear on exit
  tmux set-window-option "@ssh_host" ""
  tmux set-window-option "@ssh_dir"  ""
  tmux set-window-option "@ssh_tmux" ""
}

# Specific aliases
opweb() {
  ssh-attach \
    "opweb.devpod-us-or" \
    "~/web-code/src/platform/gss/kwm-portals/operator-portal-web"
}

# If you run tmux inside that devpod:
opweb-tmux() {
  ssh-attach "opweb.devpod-us-or" "~/web-code/..." "1"
}
```

## Context Detection

`lib/context.sh` resolves context in two phases:

1. **Explicit window vars** — `@ssh_host`, `@ssh_dir`, `@ssh_tmux` set by
   `ssh-attach`. Most reliable.
2. **Pane auto-detect (fallback)** — if the foreground pane command is
   `ssh`, extract the host from the pane title (`user@host`). Remote dir
   and tmux presence are unknown in this mode, so it routes to `tmux-portal`.

## Out of Scope

- Session-level context (currently window-level only)
- Multi-hop SSH (`ssh bastion → ssh internal`)
- Auto-detecting the remote tmux prefix key
- Status bar integration showing current route mode
