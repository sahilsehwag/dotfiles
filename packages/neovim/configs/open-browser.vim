"CONFIGURATION
	"if something' not working run :VimProcInstall"
	let g:netrw_nogx = 1
	let g:openbrowser_search_engines = {
		\'duckduckgo'  : 'http://duckduckgo.com/?q={query}',
		\'github'      : 'http://github.com/search?q={query}',
		\'google'      : 'http://google.com/search?q={query}',
		\'wikipedia'   : 'http://en.wikipedia.org/wiki/{query}',
		\'vim'         : 'http://www.google.com/cse?cx=partner-pub-3005259998294962%3Abvyni59kjr1&ie=ISO-8859-1&q={query}&sa=Search&siteurl=www.vim.org%2F#gsc.tab=0&gsc.q={query}&gsc.page=1',
		\'askubuntu'   : 'http://askubuntu.com/search?q={query}',
		\'flipkart'    : 'https://www.flipkart.com/search?q={query}&otracker=start&as-show=off&as=off',
		\'wikivoyage'  : 'https://en.wikivoyage.org/wiki/{query}',
		\'wiktionary'  : 'https://en.wiktionary.org/wiki/{query}',
		\'wikinews'    : 'https://en.wikinews.org/wiki/{query}',
		\'wikisource'  : 'https://en.wikisource.org/wiki/{query}',
		\'wikibooks'   : 'https://en.wikibooks.org/wiki/{query}',
		\'wikidata'    : 'https://en.wikidata.org/wiki/{query}',
		\'wikispecies' : 'https://species.wikimedia.org/wiki/{query}',
		\'wikiquote'   : 'https://en.wikiquote.org/wiki/{query}',
	\ }
"FUNCTIONS
	function! OpenUnderCursor()
		let l:word = GetWORDUnderCursor()

		if l:word !~  '^http'
			let l:word = 'https://' . l:word
		endif

		execute 'OpenBrowser ' . l:word
	endfunction
"OPERATORS
	"OPERATOR-BROWSER
		function! OperatorOpenBrowser(visual, ...)
			let [lineStart, columnStart] = getpos(a:0 ? "'<" : "'[")[1:2]
			let [lineEnd, columnEnd]	 = getpos(a:0 ? "'>" : "']")[1:2]
			let lines					 = getline(lineStart, lineEnd)

			if len(lines) == 0
				return
			endif

			if a:visual == 'block' || a:visual == "\<c-v>"
				call PEchoError('Operator not defined for VISUAL-BLOCK mode')
				return
			elseif a:visual == 'line' || a:visual ==# 'V'
				execute 'OpenBrowserSmartSearch ' . join(lines, '\n')
			elseif a:visual == 'char' || a:visual ==# 'v'
				let lines[-1] = lines[-1][: columnEnd - (&selection == 'inclusive' ? 1 : 2)]
				let lines[0]  = lines[0][columnStart - 1:]
				execute 'OpenBrowserSmartSearch ' . join(lines, '\n')
			endif
		endfunction

		nnoremap <silent> gb :set opfunc=OperatorOpenBrowser<CR>g@
		vnoremap <silent> gb :<C-U>call OperatorOpenBrowser(visualmode(), 1)<CR>

		nnoremap <silent> gbb :call OpenUnderCursor()<CR>
"MAPPINGS
	"CUSTOM
		nmap <Leader>fwG :execute ":OpenBrowserSearch " GetWordUnderCursor() <CR>
		vmap <Leader>fwG :<C-w>execute ":OpenBrowserSearch " GetSelectedText()[0] <CR>

		nmap <Leader>fwg :execute ":OpenBrowserSearch -github " GetWordUnderCursor() <CR>
		vmap <Leader>fwg :<C-w>execute ":OpenBrowserSearch -github " GetSelectedText()[0] <CR>

		nmap <Leader>fwd :execute ":OpenBrowserSearch -duckduckgo " GetWordUnderCursor() <CR>
		vmap <Leader>fwd :<C-w>execute ":OpenBrowserSearch -duckduckgo " GetSelectedText()[0] <CR>

		nmap <Leader>fww :execute ":OpenBrowserSearch -wikipedia " GetWordUnderCursor() <CR>
		vmap <Leader>fww :<C-w>execute ":OpenBrowserSearch -wikipedia " GetSelectedText()[0] <CR>

		nmap <Leader>fwv :execute ":OpenBrowserSearch -vim " GetWordUnderCursor() <CR>
		vmap <Leader>fwv :<C-w>execute ":OpenBrowserSearch -vim " GetSelectedText()[0] <CR>
