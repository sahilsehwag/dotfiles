"TODO:LINUX
"VARIABLES
	let g:linuxing_enable_default_mappings = 1
"DEFAULTS
	if ExistsAndTrue('g:linuxing_enable_default_mappings')
		vnoremap <Leader>ns :sort							 <CR>
		vnoremap <Leader>nu :<C-u>'<,'>sort \| '<,'>!uniq <CR>
		vnoremap <Leader>nc :<C-u>'<,'>!bc					 <CR>
	endif
