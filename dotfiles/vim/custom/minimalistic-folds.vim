function! Minimal(config) abort
	let fs = v:foldstart

	while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
	endwhile

	if fs > v:foldend
		let l:line = getline(v:foldstart)
	else
		let l:line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
	endif

	let l:width = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
	let l:noOfLinesInFold = 1 + v:foldend - v:foldstart
	let l:totalLines = line("$")

	let prefixComponent = ""
	let percentageComponent = ""
	let levelComponent = ""
	let sizeComponent = ""

	if a:config.prefix == v:true
		let prefixComponent = "  "
	endif

	if a:config.size == v:true
		let sizeComponent = " " . l:noOfLinesInFold . " Lines "
	endif

	if a:config.percentage == v:true
		let percentageComponent = printf("(%.1f", (l:noOfLinesInFold * 1.0) / l:totalLines * 100) . "%) "
	endif

	if a:config.level == v:true
		let levelComponent = '[' . v:foldlevel . ']'
	endif

	let expansionString = repeat(" ", l:width - strwidth(l:line . prefixComponent . levelComponent . sizeComponent . percentageComponent) + 2)
	return l:line . prefixComponent . levelComponent . expansionString . sizeComponent . percentageComponent
endf


let foldConfig = {
	\'prefix'     : v:true,
	\'size'       : v:true,
	\'level'      : v:true,
	\'percentage' : v:true
\}

set foldtext=Minimal(foldConfig)
