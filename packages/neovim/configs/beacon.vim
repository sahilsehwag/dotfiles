nmap n n:Beacon<cr>
nmap N N:Beacon<cr>
nmap * *:Beacon<cr>
nmap # #:Beacon<cr>

augroup MyCursorLineGroup
	autocmd!
	au WinEnter * setlocal cursorline
	au WinLeave * setlocal nocursorline
augroup end

"let g:beacon_size = 40
"let g:beacon_show_jumps = 0
"let g:beacon_minimal_jump = 10
"let g:beacon_shrink = 0
"let g:beacon_fade = 0
"let g:beacon_ignore_buffers = [\w*git*\w]
"let g:beacon_ignore_filetypes = ['fzf']
