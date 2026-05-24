# Dotfiles — Claude Reference

Personal dotfiles for macOS/Linux covering nvim, tmux, zsh, and other tools.

## On-demand references

Load these when working on a specific area. They document conventions, plugin systems, and patterns that would otherwise require reading the full config files.

| topic | file |
|---|---|
| core/ — full system reference | `.claude/references/core/system.md` |
| nvim — adding a plugin | `.claude/references/nvim/adding-plugin.md` |
| tmux — adding a plugin | `.claude/references/tmux/adding-plugin.md` |
| zsh — adding a plugin | `.claude/references/zsh/adding-plugin.md` |

## Package layout

```
packages/
├── nvim/    custom plugman setup (meta manager on top of vim-plug)
├── tmux/    TPM-based config + local plugins in plugins/
├── zsh/     Oh My Zsh config, custom abbreviations in plugins/
├── alacritty/
├── lazygit/
└── vscode/
```

## Conventions

- Key bindings: always check existing mappings before claiming a key — conflicts resolve by load order with no warning.
- nvim project namespace: `<Leader>p*` for project/file-finder commands.
- Config files live alongside their package (not scattered in home).
