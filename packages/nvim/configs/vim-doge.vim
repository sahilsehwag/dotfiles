let g:doge_enable_mappings = 0
let g:doge_comment_interactive = 1
let g:doge_comment_jump_wrap = 1
let g:doge_buffer_mappings = 1
let g:doge_comment_jump_modes = ['n', 'i', 's']
let g:doge_mapping_comment_jump_forward = '<tab>'
let g:doge_mapping_comment_jump_backward = '<s-tab>'

let g:doge_filetype_aliases = {
	\'javascript': [
		\'javascript.jsx',
		\'javascriptreact',
		\'javascript.tsx',
		\'typescriptreact',
		\'typescript',
		\'typescript.tsx',
	\],
	\'java': ['groovy'],
\}

let g:doge_javascript_settings = {
	\'destructuring_props': 1,
	\'omit_redundant_param_types': 0,
\}

let g:doge_python_settings = {
\  'single_quotes': 1,
\}

let g:doge_php_settings = {
\  'resolve_fqn': 1
\}

nnoremap <silent> <Leader>laa :DogeGenerate<cr>

