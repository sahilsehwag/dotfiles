# Adding a Plugin to the tmux Setup

tmux plugins are managed with **TPM** (tmux Plugin Manager). All configuration lives in a single file.

## Key file

```
packages/tmux/
├── tmux.conf              # all config + TPM plugin declarations
├── plugins/
│   └── which-key/        # custom/local plugins live here as directories
│       ├── which-key.conf
│       └── which-key.sh
└── scripts/              # helper shell scripts
```

## Adding a TPM plugin

In `tmux.conf`, plugins are declared near the top under the `#TPM` section:

```conf
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'author/plugin-name'   # ← add here
```

Plugin options follow immediately after the declaration:

```conf
set -g @plugin 'author/plugin-name'
    set -g @plugin_option_key 'value'
    set -g @plugin_other_key  'value'
```

Use indentation (tabs) to keep options visually grouped under their plugin.

## Installing after adding

After editing `tmux.conf`:
- `prefix + I` — install new plugins (TPM)
- `prefix + U` — update all plugins
- `prefix + alt+u` — uninstall removed plugins

Or run headlessly: `~/.tmux/plugins/tpm/bin/install_plugins`

## Local/custom plugins

Custom plugins are directories under `packages/tmux/plugins/`. They are sourced manually in `tmux.conf` using `run` or `source`:

```conf
run '~/.config/tmux/plugins/which-key/which-key.sh'
```

A local plugin directory typically contains:
- `<name>.sh` — main shell script (keybindings, logic)
- `<name>.conf` — tmux config fragment

## Key binding conventions

- **Prefix bindings**: `bind <key> …` (requires `prefix` first)
- **Direct bindings**: `bind -n <key> …` (no prefix)
- **Meta bindings**: `bind -n M-<key> …` (Alt+key, no prefix)
- Check existing bindings in `tmux.conf` before claiming a key — conflicts are silent and load-order wins.

## Typical plugin option pattern (reference)

```conf
set -g @plugin 'tmux-plugins/tmux-resurrect'
    set -g @resurrect-strategy-nvim 'session'
    set -g @resurrect-capture-pane-contents 'on'
```
