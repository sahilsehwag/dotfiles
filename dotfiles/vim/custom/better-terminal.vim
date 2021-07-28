"TODO:BETTER-TERMINAL
augroup BETTER_TERMINAL
	autocmd!
	if has('nvim')
		autocmd TermOpen *
					\ setlocal nonumber norelativenumber |
					\ startinsert
	endif
augroup END
