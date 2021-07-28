"CONFIGURATION
	let g:anyfold_motion						= 0
	let g:anyfold_fold_comments			= 0
	let g:anyfold_identify_comments = 0
	let g:anyfold_fold_toplevel			= 0
	let g:anyfold_comments					= []
	let g:anyfold_fold_level_str		= ''
	let g:anyfold_fold_size_str			= '%s Lines		'
"HIGHLIGHT
	"hi Folded ctermfg= ctermbg= guifg= guibg
"AUTOCOMMANDS
	if has('nvim-0.4')
		autocmd! FileType text AnyFoldActivate
		autocmd! FileType jproperties AnyFoldActivate
		autocmd! FileType help AnyFoldActivate
		autocmd! FileType markdown AnyFoldActivate
		autocmd! FileType scratch AnyFoldActivate
		autocmd! FileType lspinfo AnyFoldActivate
		"autocmd! FileType vim AnyFoldActivate
	else
		autocmd! FileType * AnyFoldActivate
	endif
