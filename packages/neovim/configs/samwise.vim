let g:samwise_dir = g:jaat_tmp_path . 'samwise'
let g:samwise_float = v:false
let g:samwise_floating_opts = {
	\'relative': 'cursor',
	\'focusable': v:false,
	\'style': 'minimal',
	\'border': 'shadow',
	\'noautocmd': v:true
\}

nnoremap <silent> <Leader>st :SamwiseToggleBuffer<CR>
