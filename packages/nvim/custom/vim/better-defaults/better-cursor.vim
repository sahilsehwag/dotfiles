"TODO:BETTER-CURSOR
"PERSISTENT-CURSOR
	"jump to last known position in file if filetype
	"is not git commit and center(zz) around it
	augroup PERSISTENT_CURSOR
		au!
		autocmd BufReadPost *
			\ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
			\ | exe "normal! g`\"zz"
			\ | end
	augroup END
"TODO:PRESERVE-CURSOR
	"TODO:PRESERVE-OPERATOR
		"CONFIGURATION
			let g:better_cursor_default_preserve		= 1
			let g:better_cursor_operators_preserve		= []
			let g:better_cursor_operators_no_preserve = ['Op_goto_start', 'Op_goto_end']
		"FUNCTIONS
			function! ShouldPreserve() abort
				return (
					\(
						\g:better_cursor_default_preserve &&
						\index(g:better_cursor_operators_no_preserve, &operatorfunc) == -1
					\) ||
					\(
						\!g:better_cursor_default_preserve &&
						\index(g:better_cursor_operators_preserve, &operatorfunc) > -1
					\)
				\)
			endfunction

			function! PreserveOperator() abort
				"TODO:FIX works for custom-operators but not inbuilt-opreators
				"TODO:!preserve when pasting
				if !empty(&operatorfunc)
					if ShouldPreserve()
						call winrestview(w:opfuncview)
						unlet w:opfuncview
						noautocmd set operatorfunc=
					endif
				endif
			endfunction
		"AUTOCOMANDS
			"augroup PRESERVE_OPERATOR
				"autocmd!
				"autocmd OptionSet operatorfunc let w:opfuncview = winsaveview()
				"autocmd CursorMoved * call PreserveOperator()
			"augroup END
	"TODO:PRESERVE-UNDO
	"TODO:PRESERVE-PASTE
	"TODO:PRESERVE-NAVIGATION
		"TODO:PRESERVE-MOTION
		"TODO:PRESERVE-JUMPS
			"FEATURE:VERTICAL+HORIZONTAL
			"TODO:PRESERVE-SEARCH
			"TODO:PRESERVE-MARKS
"TODO:GHOST-CURSOR
	"FEATURE:INSERT→NORMAL (INSERT|APPEND)
