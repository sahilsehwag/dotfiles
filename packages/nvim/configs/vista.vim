"CONFIGURATION
	let g:vista_default_executive =
		\ has('nvim-0.5')
		\ ? 'nvim_lsp'
		\ : 'coc'
	let g:vista_sidebar_width = 45
	let g:vista_fzf_preview = ['right:50%']
	let g:vista#renderer#enable_icon = 1
	let g:vista_echo_cursor_strategy = 'echo'
"MAPPINGS
	nnoremap <silent> <Leader>lst :Vista!!<CR>
	nnoremap <silent> <Leader>lsD :Vista finder fzf<CR>
"STATUSLINE
	function! NearestMethodOrFunction() abort
		return get(b:, 'vista_nearest_method_or_function', '')
	endfunction

	"set statusline+=%{NearestMethodOrFunction()}
	"autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
