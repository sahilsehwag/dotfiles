# Adding a Plugin to the Neovim Setup

The setup uses a custom meta package manager called **plugman** (built on top of vim-plug). It is not lazy.nvim or packer — always translate external configs into the plugman format.

## Directory layout

```
packages/nvim/
├── init.vim                          # entry point, sources init.base.vim
├── init.base.vim                     # wires everything together; runs configs/plugman.lua
├── configs/plugman.lua               # invokes plugman with the resolved plugin list + config
├── configs/<name>.lua|vim            # per-plugin config files
└── lua/sahilsehwag/configs/plugins.lua  # all plugin definitions (~2900+ lines)
```

## Two-tier registration in `plugins.lua`

Every plugin needs two entries.

### 1. Add to a mode list (simple string)

Inside `modes = { default = { … }, ide = { … }, … }`, add the GitHub slug as a string under the appropriate mode:

```lua
modes = {
    default = {
        -- system
        "junegunn/fzf",
        "nvim-telescope/telescope.nvim",
        "dmtrKovalenko/fff.nvim",   -- ← add here
    },
}
```

### 2. Add a detailed entry in `plugins = {}`

Below the modes table, in the flat `plugins = {}` map:

```lua
plugins = {
    ["dmtrKovalenko/fff.nvim"] = {
        url          = "dmtrKovalenko/fff.nvim",
        is_enabled   = function() return vim.fn.has("nvim-0.9") == 1 end,
        post_install = ":lua require('fff.download').download_or_build_binary()",
        config       = "fff.lua",   -- references configs/fff.lua
    },
}
```

**Key fields:**

| field | purpose |
|---|---|
| `url` | GitHub `user/repo` (same as the key) |
| `is_enabled` | optional guard; return false to skip |
| `post_install` | vim command or `:lua …` run after install |
| `config` | filename in `configs/` (lua or vim) |
| `dependencies.pre` | plugins that must load before this one |
| `dependencies.post` | plugins that must load after this one |
| `lazyload` | lazyload spec if supported |

## Config file (`configs/<name>.lua`)

Create `configs/<name>.lua` (or `.vim`). It is sourced after the plugin loads.

Conventions:
- Call `require('plugin').setup({…})` at the top.
- Use **project namespace keymaps** (`<Leader>p*`) for project/file-finder commands.
- Use `<Leader>` prefixes matching existing conventions — check `configs/fzf-vim.vim` and other configs for what's already claimed before picking keys.

Example (`configs/fff.lua`):

```lua
require('fff').setup({ debug = { enabled = true, show_scores = true } })

local map = function(lhs, rhs, desc)
    vim.keymap.set('n', lhs, rhs, { noremap = true, silent = true, desc = desc })
end

map('<Leader>pf', function() require('fff').find_files() end, 'FFF: find files')
map('<Leader>p/', function() require('fff').live_grep() end,  'FFF: live grep')
map('<Leader>p?', function()
    require('fff').live_grep({ grep = { modes = { 'fuzzy', 'plain' } } })
end, 'FFF: live fuzzy grep')
map('<Leader>pw', function()
    require('fff').live_grep({ query = vim.fn.expand('<cword>') })
end, 'FFF: search current word')
```

## Key binding namespaces (don't stomp these)

| prefix | owner |
|---|---|
| `<Leader>p*` | project / file-finder commands (fzf-vim, fff, telescope, smart-open) |
| `<Leader>b*` | buffer commands |
| `<Leader>g*` | git commands |
| `<Leader>l*` | LSP commands |

Check `configs/fzf-vim.vim` for existing `<Leader>p*` bindings — new plugins that claim the same keys will overwrite based on load order.

## Translating from lazy.nvim

| lazy.nvim field | plugman equivalent |
|---|---|
| `build = function() … end` | `post_install = ":lua …"` |
| `dependencies = { … }` | `dependencies = { pre = { … } }` |
| `config = function() … end` | inline `config = function() … end` or `config = "name.lua"` |
| `keys = { … }` | define keymaps inside the config file |
| `ft = …` | `lazyload = { … }` if supported, otherwise unconditional |
| `enabled = …` | `is_enabled = function() … end` |
