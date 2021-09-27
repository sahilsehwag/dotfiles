
if exists('*CreateCenteredFloatingWindow')
	let g:peekaboo_window = 'call CreateCenteredFloatingWindow()'
else
	let g:peekaboo_window = 'vert bo 30new'
endif

let g:peekaboo_delay	= 0
let g:peekaboo_compact = 0
"let g:peekaboo_prefix = ''
"let g:peekaboo_ins_prefix = ''

