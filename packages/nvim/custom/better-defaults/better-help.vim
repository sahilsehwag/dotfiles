function! FloatingWindowHelp(query) abort
	let l:buf = CreateCenteredFloatingWindow()
	call nvim_set_current_buf(l:buf)
	setlocal filetype=help
	setlocal buftype=help
	execute 'help ' . a:query
endfunction

command! -complete=help -nargs=? Help call FloatingWindowHelp(<q-args>)
