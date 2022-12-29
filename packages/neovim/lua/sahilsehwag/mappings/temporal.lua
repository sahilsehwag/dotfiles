F.vim.nmap('<Leader>zc', ':set shortmess+=F<cr>')
F.vim.nmap('<Leader>zl', ':set laststatus=3<cr>')
F.vim.nmap('<Leader>fsd', ":execute('!fd \\-E$ -x rm')<cr>")

F.vim.nmap('<Leader>id', ':lua vim.notify(vim.fn.getcwd())<CR>')
F.vim.nmap('<Leader>if', ':lua vim.notify(vim.fn.expand("%"))<CR>')

vim.cmd [[
	nnoremap <silent> z, :execute(match(getline('.'), ',$') == -1 ? 's/\(.\)$/\1,' : 's/,$//')<CR>
]]

F.vim.nmap('<Leader>lfE', ':source %<CR>')
