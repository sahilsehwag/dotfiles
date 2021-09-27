"let g:table_mode_corner='┃'
"let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='='

function! s:isAtStartOfLine(mapping)
	let text_before_cursor = getline('.')[0 : col('.')-1]
	let mapping_pattern = '\V' . escape(a:mapping, '\')
	let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
	return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar><bar>
	\ <SID>isAtStartOfLine('\|\|\|') ?
	\ '<c-o>:TableModeEnable<cr><bar><space>' : '<bar><bar><bar>'
inoreabbrev <expr> ___
	\ <SID>isAtStartOfLine('___') ?
	\ '<c-o>:silent! TableModeDisable<cr>' : '___'
