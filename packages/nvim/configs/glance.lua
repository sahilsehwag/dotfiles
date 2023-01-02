-- Lua configuration
local glance = require('glance')
local actions = glance.actions

glance.setup({
  height = 25, -- Height of the window
  zindex = 45,
  preview_win_opts = { -- Configure preview window options
    cursorline = true,
    number = true,
    wrap = true,
  },
  border = {
    enable = false, -- Show window borders. Only horizontal borders allowed
    top_char = '―',
    bottom_char = '―',
  },
  list = {
    position = 'right', -- Position of the list window 'left'|'right'
    width = 0.33, -- 33% width relative to the active window, min 0.1, max 0.5
  },
  theme = { -- This feature might not work properly in nvim-0.7.2
    enable = true, -- Will generate colors for the plugin based on your current colorscheme
    mode = 'auto', -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
  },
  mappings = {
    list = {
      ['j'] = actions.next, -- Bring the cursor to the next item in the list
      ['k'] = actions.previous, -- Bring the cursor to the previous item in the list
      ['<Tab>'] = actions.next_location, -- Bring the cursor to the next location skipping groups in the list
      ['<S-Tab>'] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
      ['<C-u>'] = actions.preview_scroll_win(5),
      ['<C-d>'] = actions.preview_scroll_win(-5),
      ['v'] = actions.jump_vsplit,
      ['s'] = actions.jump_split,
      ['t'] = actions.jump_tab,
      ['<CR>'] = actions.jump,
      ['<C-h>'] = actions.enter_win('preview'), -- Focus preview window
      ['q'] = actions.close,
      ['esc'] = actions.close,
      -- ['<Esc>'] = false -- disable a mapping
    },
    preview = {
      ['esc'] = actions.close,
      ['<Tab>'] = actions.next_location,
      ['<S-Tab>'] = actions.previous_location,
      ['<C-l>'] = actions.enter_win('list'), -- Focus list window
    },
  },
  hooks = {},
  folds = {
    fold_closed = '',
    fold_open = '',
    folded = true, -- Automatically fold list on startup
  },
  indent_lines = {
    enable = true,
    icon = '│',
  },
  winbar = {
		enable = true, -- Available strating from nvim-0.8+
  },
})

F.vim.nmap('<Leader>lPd', '<cmd>Glance definitions<cr>')
F.vim.nmap('<Leader>lPi', '<cmd>Glance implementations<cr>')
F.vim.nmap('<Leader>lPr', '<cmd>Glance references<cr>')
F.vim.nmap('<Leader>lPt', '<cmd>Glance type_definitions<cr>')

F.vim.nmap('gp', '<cmd>Glance definitions<cr>')
F.vim.nmap('gP', '<cmd>Glance implementations<cr>')
F.vim.nmap('gr', '<cmd>Glance references<cr>')
F.vim.nmap('gt', '<cmd>Glance type_definitions<cr>')
