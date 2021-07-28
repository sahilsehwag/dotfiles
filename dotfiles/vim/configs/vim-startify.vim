"CONFIGURATION
let g:startify_change_to_vcs_root  = 1
"let g:startify_change_to_dir = 0
let g:startify_session_dir			 = g:jaat_tmp_path . 'sessions'
let g:startify_fortune_use_unicode = 1
let g:startify_session_sort			 = 1
let g:startify_custom_indices		 = []
	"let g:startify_custom_indices = map(range(1,100), 'string(v:val)')
"let g:startify_custom_header		= ''
	"let g:startify_custom_header = 'startify#pad([string])'
	"let g:startify_custom_header = 'startify#center([string])'
	"let g:startify_custom_header = 'startify#fortune#quote()'
	"let g:startify_custom_header = 'startify#fortune#boxed()'
	"let g:startify_custom_header = 'startify#fortune#cowsay()'

"AUTOCOMMANDS
autocmd User StartifyReady setl foldlevel=99

"MAPPINGS
nnoremap <silent> <Leader>vd :Startify<CR>
