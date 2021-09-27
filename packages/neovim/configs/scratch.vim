let g:scratch_no_mappings = 1
let g:scratch_height = 0.3
let g:scratch_top = 0
let g:scratch_persistence_file = g:config.paths.tmp . '/scratch'

nnoremap <silent> <Leader>so :Scratch<CR>
nnoremap <silent> <Leader>sp :ScratchPreview<CR>
vnoremap <silent> <Leader>ss :ScratchSelection<CR>

augroup SCRATCH_ENTER
	autocmd!
	autocmd FileType scratch nnoremap <buffer> <esc> :q<CR>
	autocmd FileType scratch set syntax=jproperties
augroup END
