"CONFIGURATION
	"let g:fzf_layout = {'window': 'new | wincmd J | resize 1 | call animate#window_percent_height(0.5)'}
"MAPPINGS
	nnoremap <silent> <up>    :call animate#window_delta_height(10)<CR>
	nnoremap <silent> <down>  :call animate#window_delta_height(-10)<CR>
	nnoremap <silent> <left>  :call animate#window_delta_width(10)<CR>
	nnoremap <silent> <right> :call animate#window_delta_width(-10)<CR>
