set shortmess+=filmnrwxoOTWAIcFS

if has('g:colors_name')
	if g:colors_name == 'mosel'
		"highlight! link VertSplit WildMenu
	endif

	if g:colors_name == 'oblivion-dark'
		runtime colorscheme-oblivion-dark.vim
	endif
endif
