function! MinimalFoldText()
	let fs = v:foldstart

	while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
	endwhile

	if fs > v:foldend
		let line = getline(v:foldstart)
	else
		let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
	endif

	let width = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
	let foldSize = 1 + v:foldend - v:foldstart
	let lineCount = line("$")

	let foldSizeStr = " " . foldSize . " Lines "
	let foldLevelStr = repeat("", v:foldlevel)
	let foldPercentage = printf("(%.1f", (foldSize * 1.0) / lineCount * 100) . "%) "
	let expansionString = repeat(" ", width - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage) + 2)
	return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf

set foldtext=MinimalFoldText()
