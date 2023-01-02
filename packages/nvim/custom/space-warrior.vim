"SPACE-WARRIOR
	"TODO:VISUAL-MODE
	"TODO:DELETE-EMPTY-LINES
	"TODO:COLLAPSE-n-EMPTY-LINES
	"VARIABLES
		let g:space_warrior_enable_default_mappings          = 1
		let g:space_warrior_highlight_trailing_whitespaces   = 0
		let g:space_warrior_highlight_leading_spaces         = 0
		let g:space_warrior_highlight_leading_tabs           = 0
		let g:space_warrior_highlight_listchars              = 0
		let g:space_warrior_highlight_consecutive_blanklines = 0
	"FUNCTIONS
		function! ConvertSpaces2Tabs()
			let l:et                                         = &expandtab
			setlocal noexpandtab
			%retab!
			if l:et
				setlocal expandtab
			else
				setlocal noexpandtab
			endif
		endfunction

		function! ConvertTabs2Spaces()
			let l:et = &expandtab
			setlocal expandtab
			%retab!
			if l:et
				setlocal expandtab
			else
				setlocal noexpandtab
			endif
		endfunction

		function! StripTrailingWhitespace()
			execute ':%s/\s\+$//e'
			execute ':%s/\t\+$//e'
		endfunction
	"COMMANDS
		command! SWSpaces2Tabs				 :execute ConvertSpaces2Tabs()
		command! SWTabs2Spaces				 :execute ConvertSpaces2Tabs()
		command! SWStripTrailingWhitespace :execute StripTrailingWhitespace()
	"AUTOCOMMANDS
		augroup SPACE_WARRIOR
			"TODO:DISABLE FOR LARGE-FILES
			autocmd!
			"autocmd BufWritePre *
				"\ call StripTrailingWhitespace() |
				"\ call ConvertTabs2Spaces()
		augroup end
	"MAPPINGS
		nmap <silent> <Plug>(sw-spaces-2-tabs)				 :SWSpaces2Tabs<CR>
		nmap <silent> <Plug>(sw-tabs-2-spaces)				 :SWTabs2Spaces<CR>
		nmap <silent> <Plug>(sw-strip-trailing-whitespace) :SWStripTrailingWhitespace<CR>
	"HIGHLIGHTS
		"TODO:FIX
		"LEADING-TABS TODO:FIX
			if ExistsAndTrue('g:space_warrior_highlight_leading_tabs')
				highlight LeadingTabs ctermbg=135
				call matchadd('LeadingTabs', '^\t\+', 100)
			endif
		"LEADING-SPACES TODO:FIX
			if ExistsAndTrue('g:space_warrior_highlight_leading_spaces')
				highlight LeadingSpaces ctermbg=135
				call matchadd('LeadingSpaces', '^ \+', 100)
			endif
		"TRAILING-WHITESPACES TODO:FIX
			if ExistsAndTrue('g:space_warrior_highlight_trailing_whitespaces')
				"highlight TrailingWhitespace ctermfg=135
				"call matchadd('TrailingWhitespace', '\s\+$', 100)
				highlight TrailingTabs ctermbg=135
				call matchadd('TrailingTabs', '\t\+$', 100)
				highlight TrailingSpaces ctermbg=135
				call matchadd('TrailingSpaces', ' \+$', 100)
			endif
		"CONSECUTIVE-BLANKLINES TODO:FIX
			if ExistsAndTrue('g:space_warrior_highlight_consecutive_blanklines')
				highlight ConsecutiveBlankLines ctermbg=135
				call matchadd('ConsecutiveBlankLines', '\(^$\n\)\{2,}', 100)
			endif
		"LISTCHARS
			if ExistsAndTrue('g:space_warrior_highlight_listchars')
				highlight EndOfBuffer ctermfg=245 guifg=#658595
				highlight NonText		ctermfg=135 guifg=#af5fff
				highlight Whitespace	ctermfg=135 guifg=#af5fff
			endif
	"DEFAULTS
		if ExistsAndTrue('g:space_warrior_enable_default_mappings')
			nmap <Leader>xt <Plug>(sw-spaces-2-tabs)
			nmap <Leader>xs <Plug>(sw-tabs-2-spaces)
			nmap <Leader>xw <Plug>(sw-strip-trailing-whitespace)
			vmap <Leader>xt <Plug>(sw-spaces-2-tabs)
			vmap <Leader>xs <Plug>(sw-tabs-2-spaces)
			vmap <Leader>xw <Plug>(sw-strip-trailing-whitespace)

			nmap <Leader>xb :g:^$\n\{3,}:d<CR>
			nmap <Leader>xr :%retab!<CR>

			"temporary namespace mappings
			nmap <Leader>etw :let g:space_warrior_highlight_trailing_whitespaces = !g:space_warrior_highlight_trailing_whitespaces<CR>
			nmap <Leader>ets :let g:space_warrior_highlight_leading_spaces		 = !g:space_warrior_highlight_leading_spaces<CR>
			nmap <Leader>ett :let g:space_warrior_highlight_leading_tabs		 = !g:space_warrior_highlight_leading_tabs<CR>
			nmap <Leader>etl :let g:space_warrior_highlight_listchars			 = !g:space_warrior_highlight_listchars<CR>
		endif
