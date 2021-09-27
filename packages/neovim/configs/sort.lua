require'sort'.setup{
  delimiters = {
		',',
		'|',
		';',
		':',
		's', -- Space
		't', -- Tab
	}
}

vim.cmd([[
  nnoremap <silent> <leader>xs <Cmd>Sort<CR>
  vnoremap <silent> <leader>xS <Esc><Cmd>Sort<CR>
]])
