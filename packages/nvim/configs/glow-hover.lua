require'glow-hover'.setup({
	padding   = 10,
	max_width = 100,
	border    = 'single',
	glow_path = 'glow'
})

vim.cmd [[ highlight! HoverFloatBorder ctermbg=None ctermfg=255 ]]
vim.cmd [[ nnoremap <silent> K <C-u>lua vim.lsp.buf.hover()<CR> ]]
