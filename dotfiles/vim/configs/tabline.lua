require('tabline').setup({})

vim.cmd [[
	set guioptions-=e
	set sessionoptions+=tabpages,globals

	let g:tabline_show_devicons = v:true
	let g:tabline_show_bufnr = v:false

	nnoremap <silent> <C-n> <cmd>TablineBufferNext<CR>
	nnoremap <silent> <C-p> <cmd>TablineBufferPrevious<CR>
]]
