"FUNCTIONS
	function! s:config_easyfuzzymotion(...) abort
		return extend(copy({
			\	'converters': [incsearch#config#fuzzy#converter()],
			\	'modules': [incsearch#config#easymotion#module()],
			\	'keymap': {"\<CR>": '<Over>(easymotion)'},
			\	'is_expr': 0,
			\	'is_stay': 0
			\ }), get(a:, 1, {}))
	endfunction
"MAPPINGS
	map <Leader><Leader>/ <Plug>(incsearch-easymotion-/)
	"map <Leader><Leader>/ <Plug>(incsearch-easymotion-stay)
	map <Leader><Leader>? <Plug>(incsearch-easymotion-?)
	noremap <silent><expr> <Leader><Leader>g/ incsearch#go(<SID>config_easyfuzzymotion())
