local actions = require('telescope.actions')
local action_layout = require('telescope.actions.layout')

require('telescope').setup({
	defaults = {
    layout_strategy = 'vertical',
		layout_config = {
			vertical = {
        width = 0.75,
      },
			horizontal = {
        height = 1,
      },
		},
		mappings = {
			i = {
				--['<esc>'] = actions.close,
			},
			n = {
        ['<C-p>'] = action_layout.toggle_preview,
			},
    },
	},
})

--MAPPINGS
vim.cmd('nnoremap <silent> <Leader>f. <CMD>Telescope<CR>')

vim.cmd('nnoremap <silent> <Leader>bl <CMD>Telescope buffers<CR>')
vim.cmd('nnoremap <silent> <Leader>bf <CMD>Telescope filetypes<CR>')

--vim.cmd('nnoremap <silent> <Leader>v; <CMD>Telescope commands<CR>')
--vim.cmd('nnoremap <silent> <Leader>v: <CMD>Telescope command_history<CR>')
--vim.cmd('nnoremap <silent> <Leader>v/ <CMD>Telescope search_history<CR>')
vim.cmd('nnoremap <silent> <Leader>v? <CMD>Telescope help_tags<CR>')
