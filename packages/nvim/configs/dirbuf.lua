require'dirbuf'.setup{
	hash_padding = 2,
	show_hidden = true,
	sort_order = 'default',
	write_cmd = 'DirbufSync',
}

F.vim.nmap('<leader>pe', '<cmd>Dirbuf %<cr>')
F.vim.nmap('<leader>pE', '<cmd>Dirbuf<cr>')
