require('focus').setup({
	enable = true,

	signcolumn = true,
	--number = true,
	--relativenumber = true,
	--hybridnumber = true,

	cursorline = true,
	winhighlight = true,

	--width = 120,
	--height = 40,
	--treewidth = 20,

	excluded_filetypes = {
		'vista_kind',
		'Trouble',
		'nvimtree',
		'help',
		'nofile',
	},
	compatible_filetrees = {
		'nvimtree',
		'nerdtree',
		'chadtree',
		'fern',
	},
})

vim.cmd('hi link FocusedWindow Normal')
vim.cmd('hi link UnfocusedWindow CursorLine')

vim.cmd [[ nnoremap <silent> <Leader>wH <CMD>FocusSplitLeft<CR> ]]
vim.cmd [[ nnoremap <silent> <Leader>wJ <CMD>FocusSplitDown<CR> ]]
vim.cmd [[ nnoremap <silent> <Leader>wK <CMD>FocusSplitUp<CR> ]]
vim.cmd [[ nnoremap <silent> <Leader>wL <CMD>FocusSplitRight<CR> ]]

vim.cmd [[ nnoremap <silent> <Leader>wg <CMD>FocusToggle<CR> ]]
vim.cmd [[ nnoremap <silent> <Leader>wm <CMD>FocusMaxOrEqual<CR> ]]

vim.cmd [[ nnoremap <silent> <Leader>\ <CMD>FocusSplitNicely<CR> ]]
vim.cmd [[ nnoremap <silent> <Leader>\ <CMD>FocusMaximise<CR> ]]
vim.cmd [[ nnoremap <silent> <Leader>\ <CMD>FocusEqualise<CR> ]]
