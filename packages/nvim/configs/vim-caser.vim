"CONFIGURATIONS
	let g:caser_no_mappings = 1
	let g:caser_prefix = 'gc'
"MAPPINGS
	nmap <silent> gcc <Plug>CaserCamelCase
	vmap <silent> gcc <Plug>CaserVCamelCase

	nmap <silent> gcp <Plug>CaserMixedCase
	vmap <silent> gcp <Plug>CaserVMixedCase

	nmap <silent> gc. <Plug>CaserDotCase
	vmap <silent> gc. <Plug>CaserVDotCase

	nmap <silent> gc- <Plug>CaserKebabCase
	vmap <silent> gc- <Plug>CaserVKebabCase

	nmap <silent> gc_ <Plug>CaserSnakeCase
	vmap <silent> gc_ <Plug>CaserVSnakeCase

	nmap <silent> gc<space> <Plug>CaserSpaceCase
	vmap <silent> gc<space> <Plug>CaserVMixSpaceCase

	nmap <silent> gcT <Plug>CaserTitleKebabCase
	vmap <silent> gcT <Plug>CaserVTitleKebabCase

	nmap <silent> gct <Plug>CaserTitleCase
	vmap <silent> gct <Plug>CaserVTitleCase

	nmap <silent> gcs <Plug>CaserSentenceCase
	vmap <silent> gcs <Plug>CaserVSentenceCase

	nnoremap <silent> gcl gu
	vnoremap <silent> gcl gu

	nmap <silent> gcu <Plug>CaserUpperCase
	vmap <silent> gcu <Plug>CaserVUpperCase
