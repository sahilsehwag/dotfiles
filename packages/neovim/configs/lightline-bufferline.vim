"CONFIGURATION
	set showtabline=2
	let g:lightline#bufferline#filename_modifier = ':t'
	let g:lightline#bufferline#show_number		 = 2
	let g:lightline#bufferline#shorten_path		 = 0
	let g:lightline#bufferline#unnamed			 = '[No Name]'
	let g:lightline#bufferline#unicode_symbols	 = 0
	let g:lightline#bufferline#enable_devicons	 = 0
	let g:lightline#bufferline#number_separator = ':'
	let g:lightline#bufferline#read_only		= '[ℝ]'
	let g:lightline#bufferline#more_buffers		= '…'
	let g:lightline#bufferline#modified			= '[+]'

	let g:lightline.tabline			 = {'left': [['buffers']], 'right': [['close']]}
	let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
	let g:lightline.component_type	 = {'buffers': 'tabsel'}
"MAPPINGS
	nmap <Leader>1 <Plug>lightline#bufferline#go(1)
	nmap <Leader>2 <Plug>lightline#bufferline#go(2)
	nmap <Leader>3 <Plug>lightline#bufferline#go(3)
	nmap <Leader>4 <Plug>lightline#bufferline#go(4)
	nmap <Leader>5 <Plug>lightline#bufferline#go(5)
	nmap <Leader>6 <Plug>lightline#bufferline#go(6)
	nmap <Leader>7 <Plug>lightline#bufferline#go(7)
	nmap <Leader>8 <Plug>lightline#bufferline#go(8)
	nmap <Leader>9 <Plug>lightline#bufferline#go(9)
