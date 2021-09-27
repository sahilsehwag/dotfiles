nnoremap <silent> <Leader>zc :set shortmess+=F<cr>
nnoremap <silent> <Leader>zl :set laststatus=3<cr>
nnoremap <silent> <Leader>fsd :execute('!fd \\-E$ -x rm')<cr>

nnoremap <silent> <Leader>id :lua vim.notify(vim.fn.getcwd())<CR>
nnoremap <silent> <Leader>if :lua vim.notify(vim.fn.expand('%'))<CR>

nnoremap <silent> z, :execute(match(getline('.'), ',$') == -1 ? 's/\(.\)$/\1,' : 's/,$//')<CR>

nnoremap <silent> <Leader>lfE :source %<CR>
