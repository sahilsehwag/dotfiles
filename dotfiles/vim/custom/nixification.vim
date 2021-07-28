"TODO:LINUX
"VARIABLES
	let g:linuxing_enable_default_mappings = 1
"DEFAULTS
	if ExistsAndTrue('g:linuxing_enable_default_mappings')
		vnoremap <Leader>lus :sort							 <CR>
		vnoremap <Leader>luu :<C-u>'<,'>sort \| '<,'>!uniq <CR>
		vnoremap <Leader>luc :<C-u>'<,'>!bc					 <CR>
	endif
