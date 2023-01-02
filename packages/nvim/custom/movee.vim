"TODO:MOVEE
	"FEATURE:STATE
	"FEATURE:COUNT
	"VERTICAL
		nnoremap <C-S-j> :move .+1<CR>==
		nnoremap <C-S-k> :move .-2<CR>==
		inoremap <C-S-j> <Esc>:move .+1<CR>==gi
		inoremap <C-S-k> <Esc>:move .-2<CR>==gi
		vnoremap <C-S-j> :move '>+1<CR>gv=gv
		vnoremap <C-S-k> :move '<-2<CR>gv=gv
	"HORIZONTAL
	"TODO:VISUAL-BLOCK
