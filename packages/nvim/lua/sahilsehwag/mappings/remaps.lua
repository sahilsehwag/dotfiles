vim.cmd([[
	nmap Q <nop>
	nmap <C-r> <nop>
]])

F.vim.nmap("U", "<C-r>")

F.vim.nmap(";", ":", { silent = false })

F.vim.nmap("'", '"')
F.vim.nmap('"', "'")
