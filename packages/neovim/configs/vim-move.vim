"let g:move_key_modifier = 'C-S'
let g:move_map_keys = 0
let g:move_auto_indent = 1
let g:move_past_end_of_line = 1

nmap <Down> <Plug>MoveLineDown
nmap <Up> <Plug>MoveLineUp
nmap <Left> <Plug>MoveCharLeft
nmap <Right> <Plug>MoveCharRight

vmap <Down> <Plug>MoveBlockDown
vmap <Up> <Plug>MoveBlockUp
vmap <Left> <Plug>MoveBlockLeft
vmap <Right> <Plug>MoveBlockRight
