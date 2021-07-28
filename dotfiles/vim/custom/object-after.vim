"TEXT-OBJECT
	function! TextObjectAfter(targetChar)
		"GETTING COLUMN NUMBER OF CHARACTER AFTER THE targetChar
			execute 'normal! 0' . v:count . 'f' . a:targetChar
			let targetCharCol = virtcol('.')
			let targetCharNormCol = getpos('.')[2]
		"IF CHARACTER AFTER targetChar IS SPACE THEN SKIP OVER THE SPACE CHARACTER
			if getline('.')[targetCharNormCol] == ' '
				execute 'normal! ' . string(targetCharCol+2) . '|v$h'
			else
				execute 'normal! ' . string(targetCharCol+1) . '|v$h'
			endif
	endfunction

	function! TextObjectAfterAnyChar()
		"GETTING TARGET CHAR
			call inputsave()
			let targetChar = getchar()
			call inputrestore()
		"GETTING COLUMN NUMBER OF CHARACTER AFTER THE targetChar
			execute 'normal! 0' . v:count . 'f' . nr2char(targetChar)
			let targetCharCol = virtcol('.')
			let targetCharNormCol = getpos('.')[2]
		"IF CHARACTER AFTER targetChar IS SPACE THEN SKIP OVER THE SPACE CHARACTER
			if getline('.')[targetCharNormCol] == ' '
				execute 'normal! ' . string(targetCharCol+2) . '|v$h'
			else
				execute 'normal! ' . string(targetCharCol+1) . '|v$h'
			endif
	endfunction
"MAPPINGS
	vnoremap <silent> a= :<C-u>call TextObjectAfter('=')<CR>
	onoremap <silent> a= :<C-u>call TextObjectAfter('=')<CR>

	vnoremap <silent> a: :<C-u>call TextObjectAfter(':')<CR>
	onoremap <silent> a: :<C-u>call TextObjectAfter(':')<CR>

	vnoremap <silent> a- :<C-u>call TextObjectAfter('-')<CR>
	onoremap <silent> a- :<C-u>call TextObjectAfter('-')<CR>

	onoremap <silent> ga :<C-u>call TextObjectAfterAnyChar()<CR>
