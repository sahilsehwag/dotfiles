require'windex'.setup{
	-- KEYMAPS:
	default_keymaps = false, -- Enable default keymaps.
	extra_keymaps = false,  -- Enable extra keymaps.
	arrow_keys = false,     -- Default window movement keymaps use arrow keys instead of 'h,j,k,l'.

	-- OPTIONS:
	numbered_term = false,  -- Enable line numbers in the terminal.
	save_buffers = false,   -- Save all buffers before switching tmux panes.
	warnings = true,        -- Enable warnings before some actions such as closing tmux panes.
}

-- MAXIMIZE:
-- Toggle maximizing the current window:
vim.keymap.set('n', '<Leader>wm', "<Cmd>lua require('windex').toggle_nvim_maximize()<CR>")

-- TERMINAL:
-- Toggle the terminal:
-- not working
vim.keymap.set({ 'n', 't' }, '<C-`', "<Cmd>lua require('windex').toggle_terminal()<CR>")

-- Enter normal mode within terminal:
--vim.keymap.set('t', '<C-n>', '<C-Bslash><C-n>')

-- MOVEMENT:

-- Move between nvim windows and tmux panes:
--vim.keymap.set('n', '<Leader>k', "<Cmd>lua require('windex').switch_window('up')<CR>")
--vim.keymap.set('n', '<Leader>j', "<Cmd>lua require('windex').switch_window('down')<CR>")
--vim.keymap.set('n', '<Leader>h', "<Cmd>lua require('windex').switch_window('left')<CR>")
--vim.keymap.set('n', '<Leader>l', "<Cmd>lua require('windex').switch_window('right')<CR>")

-- Save and close the nvim window or kill the tmux pane in the direction selected:
vim.keymap.set('n', '<Leader>wdk', "<Cmd>lua require('windex').close_window('up')<CR>")
vim.keymap.set('n', '<Leader>wdj', "<Cmd>lua require('windex').close_window('down')<CR>")
vim.keymap.set('n', '<Leader>wdh', "<Cmd>lua require('windex').close_window('left')<CR>")
vim.keymap.set('n', '<Leader>wdl', "<Cmd>lua require('windex').close_window('right')<CR>")

-- Switch to previous nvim window or tmux pane:
--vim.keymap.set('n', '<Leader>;', "<Cmd>lua require('windex').previous_window()<CR>")
