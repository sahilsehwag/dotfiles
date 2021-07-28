nnoremap <LocalLeader>wl :call RunInNewBuffer('BlogList', 'wordpress')<CR>
nnoremap <LocalLeader>wn :call RunInNewBuffer('BlogNew',	'wordpress')<CR>
nnoremap <LocalLeader>wd :BlogSave draft<CR>
nnoremap <LocalLeader>wP :BlogSave publish<CR>
nnoremap <LocalLeader>wD :BlogPreview draft<CR>
nnoremap <LocalLeader>wp :BlogPreview publish<CR>
nnoremap <LocalLeader>wc :BlogCode python<CR>
nnoremap <LocalLeader>wu :BlogUpload<space><CR>
