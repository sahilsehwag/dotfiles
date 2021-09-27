require'dirbuf'.setup{
	hash_padding = 2,
	show_hidden = true,
	sort_order = 'default',
	write_cmd = 'DirbufSync',
}

F.nvim.nmap('<leader>pe', '<cmd>Dirbuf %<cr>')
F.nvim.nmap('<leader>pE', '<cmd>Dirbuf<cr>')
