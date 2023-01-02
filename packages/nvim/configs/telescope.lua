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

--pickers
vim.cmd("nnoremap <silent> <Leader>f. <CMD>Telescope<CR>")

--buffers
vim.cmd("nnoremap <silent> <Leader>bl <CMD>Telescope buffers<CR>")
vim.cmd("nnoremap <silent> <Leader>bf <CMD>Telescope filetypes<CR>")

--vim
vim.cmd("nnoremap <silent> <Leader>v; <CMD>Telescope commands<CR>")
vim.cmd("nnoremap <silent> <Leader>v: <CMD>Telescope command_history<CR>")
vim.cmd("nnoremap <silent> <Leader>v/ <CMD>Telescope search_history<CR>")
vim.cmd("nnoremap <silent> <Leader>v? <CMD>Telescope help_tags<CR>")

--git

--project
F.vim.nmap("<leader>pf", "<cmd>Telescope git_files<cr>")
F.vim.nmap("<leader>pg", "<cmd>Telescope git_status<cr>")
