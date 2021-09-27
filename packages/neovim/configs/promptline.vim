"'$(whoami)'
if exists('*promptline#slices#cwd')
	let g:promptline_powerline_symbols = 1
	let g:promptline_preset = {
		\'a':    [ promptline#slices#cwd() ],
		\'b':    [ promptline#slices#vcs_branch() ],
		\'c':    [ promptline#slices#git_status() ],
		\'z':    [ promptline#slices#jobs() ],
		\'warn': [ promptline#slices#last_exit_code() ]
	\}
	"let g:promptline_symbols = {
		"\'left'       : '',
		"\'left_alt'   : '>',
		"\'dir_sep'    : ' / ',
		"\'truncation' : '...',
		"\'vcs_branch' : '',
		"\'space'      : ' '
	"\}
endif
