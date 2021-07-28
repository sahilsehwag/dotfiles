"CONFIGURATION
	let g:airline_powerline_fonts = 1
	"let g:airline_theme = 'gruvbox'
	let g:airline_theme = 'codedark'
	function! AirlineInit()
		let g:airline_section_c = airline#section#create(['%{expand("%:.")}'])
	endfunction
	autocmd User AirlineAfterInit call AirlineInit()
"BUFFERLINE
"TABLINE
	let g:airline#extensions#tabline#enabled	= 1
	let g:airline#extensions#tabline#fnamemod = ':t'
"TMUXLINE
	let airline#extensions#tmuxline#color_template = 'normal'
"CUSTOMIZATION
	let g:airline#extensions#default#layout = [
		\ [ 'a', 'b', 'c' ],
		\ [ 'x', 'y', 'z', 'error', 'warning' ]
		\ ]
	let g:airline#extensions#default#section_truncate_width = {
		\ 'b': 79,
		\ 'x': 60,
		\ 'y': 88,
		\ 'z': 45,
		\ 'warning': 80,
		\ 'error': 80,
		\ }
	let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
"EXTENSIONS
	let g:airline#extensions#fugitiive#enabled = 1
	let g:airline#extensions#fzf#enabled = 1
	let g:airline#extensions#hunks#enabled = 1
	let g:airline#extensions#nvimlsp#enabled = 1
	let g:airline#extensions#vista#enabled = 1
		let g:airline#extensions#nvimlsp#error_symbol = '  '
		let g:airline#extensions#nvimlsp#warning_symbol = '  '
	let g:airline#extensions#whitespace#enabled = 1
		let g:airline#extensions#whitespace#mixed_indent_algo = 0
		let g:airline#extensions#whitespace#symbol = ''
		let g:airline#extensions#whitespace#checks = ['indent', 'trailing', 'mixed-indent-file, long']
		let g:airline#extensions#whitespace#trailing_format = 'T[%s]'
		let g:airline#extensions#whitespace#mixed_indent_format = 'MI[%s]'
		let g:airline#extensions#whitespace#long_format = 'L[%s]'
		let g:airline#extensions#whitespace#mixed_indent_file_format = 'MIF[%s]'
		let g:airline#extensions#whitespace#trailing_regexp = '\s$'
