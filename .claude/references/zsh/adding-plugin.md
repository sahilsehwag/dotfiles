# Adding a Plugin to the zsh Setup

zsh plugins are managed through **Oh My Zsh** (OMZ). Configuration lives in `.zshrc`.

## Key files

```
packages/zsh/
├── .zshrc (symlinked from ~/)   # main config; OMZ plugins list lives here
├── plugins/
│   └── zsh-abbr.sh              # custom abbreviation definitions
└── install.sh                   # symlink installer
```

## Adding an Oh My Zsh plugin

In `.zshrc`, find the `plugins=(…)` array and add the plugin name:

```zsh
plugins=(
    zsh-vi-mode
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-interactive-cd
    zsh-fzf-history-search
    fzf-tab
    colored-man-pages
    command-not-found
    zsh-abbr
    new-plugin-name    # ← add here
)
```

OMZ sources this after `source $ZSH/oh-my-zsh.sh`.

## Plugin sources

| type | install location | notes |
|---|---|---|
| Built-in OMZ plugin | `$ZSH/plugins/<name>/` | already available, just add to list |
| Community plugin | `$ZSH_CUSTOM/plugins/<name>/` | clone there first |
| Homebrew / system | installed globally | may need a `source` line instead |

For community plugins (e.g. `zsh-syntax-highlighting`):

```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Then add the name to the `plugins=(…)` array.

## Adding custom abbreviations

Abbreviations (via `zsh-abbr`) live in `packages/zsh/plugins/zsh-abbr.sh`. Add a line:

```zsh
abbr -g <shorthand>="<expansion>"
```

Then source the file (or reload: `exec zsh`).

## Adding standalone config/functions

For scripts that don't fit a plugin, source them directly in `.zshrc`:

```zsh
source $DOTFILES_ROOT/packages/zsh/scripts/my-script.sh
```

Or use the `$DOTFILES_CONFIG/init.sh` loader if the dotfiles core already handles it.

## Reload

```sh
exec zsh       # full reload
source ~/.zshrc  # lighter reload (may miss some initializations)
```
