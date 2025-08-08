local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")

require("telescope").setup({
	defaults = {
		layout_strategy = "vertical",
		layout_config = {
			vertical = {
				width = 0.75,
				preview_height = 0.75,
			},
			horizontal = {
				height = 1,
				preview_height = 0.75,
			},
			center = {
				width = 0.6,
				height = 0.5,
			},
		},
		mappings = {
			i = {},
			n = {
				["<C-p>"] = action_layout.toggle_preview,
			},
		},
	},
})

local tb = require('telescope.builtin')
local opts = { silent = true }

-- General
vim.keymap.set('n', '<Leader>f.', '<CMD>Telescope<CR>', vim.tbl_extend('force', opts, { desc = 'Telescope: Open picker list' }))

-- Buffers
vim.keymap.set('n', '<Leader>bl', tb.buffers,    vim.tbl_extend('force', opts, { desc = 'Telescope: List buffers' }))
vim.keymap.set('n', '<Leader>bf', tb.filetypes,  vim.tbl_extend('force', opts, { desc = 'Telescope: Change filetype' }))

-- Vim commands/history/help
vim.keymap.set('n', '<Leader>v;', tb.commands,         vim.tbl_extend('force', opts, { desc = 'Telescope: Commands' }))
vim.keymap.set('n', '<Leader>v:', tb.command_history,  vim.tbl_extend('force', opts, { desc = 'Telescope: Command history' }))
vim.keymap.set('n', '<Leader>v/', tb.search_history,   vim.tbl_extend('force', opts, { desc = 'Telescope: Search history' }))
vim.keymap.set('n', '<Leader>v?', tb.help_tags,        vim.tbl_extend('force', opts, { desc = 'Telescope: Help tags' }))
vim.keymap.set('n', '<Leader><Tab>', tb.keymaps,       vim.tbl_extend('force', opts, { desc = 'Telescope: Keymaps' }))

-- Git
vim.keymap.set('n', '<Leader>pf', tb.git_files,   vim.tbl_extend('force', opts, { desc = 'Telescope: Git files' }))
vim.keymap.set('n', '<Leader>pg', tb.git_status,  vim.tbl_extend('force', opts, { desc = 'Telescope: Git status' }))
