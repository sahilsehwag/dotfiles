"fix border issue in CreateCenteredFloatingWindow
function! CreateCenteredFloatingWindow()
	let width  = min([&columns - 4, max([80, &columns - 20])])
	let height = min([&lines - 4, max([20, &lines - 10])])

	let top		 = ((&lines - height) / 2) - 1
	let left	 = (&columns - width) / 2
	let opts	 = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

	let top = "╭" . repeat("─", width - 2) . "╮"
	let mid = "│" . repeat(" ", width - 2) . "│"
	let bot = "╰" . repeat("─", width - 2) . "╯"
	let lines = [top] + repeat([mid], height - 2) + [bot]

	"creating new buffer for the floating window
	let s:float_buffer = nvim_create_buf(v:false, v:true)

	"setting the border(text) in buffer
	call nvim_buf_set_lines(s:float_buffer, 0, -1, v:true, lines)

	"opening the window
	call nvim_open_win(s:float_buffer, v:true, opts)

	set winhl=Normal:Floating
	let opts.row += 1
	let opts.height -= 2
	let opts.col += 2
	let opts.width -= 4

	call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
	au BufWipeout <buffer> exe 'bw ' . s:float_buffer
endfunction

