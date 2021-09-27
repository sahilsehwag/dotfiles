nnoremap <Leader>vq :qall<CR>
nnoremap <Leader>vQ :qall!<CR>

nnoremap <silent> <expr> <Leader>vc ':edit '   . g:jaat_config_path . '<CR>'
nnoremap <silent> <expr> <Leader>vs ':source ' . g:jaat_config_path . '<CR>'
nnoremap <silent> <Leader>vN :messages<cr>

nnoremap <silent> <Leader>vC :edit ~/.config/nvim/general/configs/plugins.lua<CR>
