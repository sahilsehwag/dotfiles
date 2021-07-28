"TEXT
	function! g:GetWordUnderCursor()
		execute 'normal! "ayiw'
		let value = @a
		return value
	endfunction

	function! g:GetWORDUnderCursor()
		execute 'normal! "ayiW'
		let value = @a
		return value
	endfunction

	function! g:GetSelectedText()
		let [lineStart, columnStart] = getpos("'<")[1:2]
		let [lineEnd, columnEnd] = getpos("'>")[1:2]
		let lines = getline(lineStart, lineEnd)
		if len(lines) == 0
			return ''
		endif
		let lines[-1] = lines[-1][: columnEnd - (&selection == 'inclusive' ? 1 : 2)]
		let lines[0] = lines[0][columnStart - 1:]

		if ExistsAndTrue('a:1')
			return join(lines, "\n")
		else
			return lines
		endif
	endfunction
"META
	function! ExistsAndTrue(name)
		if exists(a:name)
			return eval(a:name)
		endif
		return 0
	endfunction

	function! IsNix()
		return has('unix') || has('mac') || has('macunix') || has('linux') || has('win32unix')
	endfunction

	function! IsWindows()
		return has('win32')
	endfunction
"DYNAMIC
	function! DefineMap(type, map, action)
		execute a:type . ' ' . a:map . ' ' . a:action
	endfunction

	function! DefineAbbreviation(source, target)
		execute 'iabbrev' . ' ' . a:source . ' ' . a:target
	endfunction
