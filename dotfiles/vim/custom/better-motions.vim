let g:better_motions_enable_default_mappings = 1
if ExistsAndTrue('g:better_motions_enable_default_mappings')
	"motions=g*|zz|nohl|pulse|zx

	"better-solution would/might be using autocmd! with CursorMoved
	nnoremap <silent> j gj:nohl<CR>
	nnoremap <silent> k gk:nohl<CR>
	nnoremap <silent> h h:nohl<CR>
	nnoremap <silent> l l:nohl<CR>

	nnoremap <silent> w w:nohl<CR>
	nnoremap <silent> b b:nohl<CR>
	nnoremap <silent> e e:nohl<CR>
	nnoremap <silent> ge ge:nohl<CR>

	nnoremap <silent> W W:nohl<CR>
	nnoremap <silent> B B:nohl<CR>
	nnoremap <silent> E E:nohl<CR>
	nnoremap <silent> gE gE:nohl<CR>

	nnoremap n nzz
	nnoremap N Nzz

	nnoremap <silent> <C-d> <C-d>zz
	nnoremap <silent> <C-u> <C-u>zz
	nnoremap <silent> <C-f> <C-f>zz
	nnoremap <silent> <C-b> <C-b>zz

	nnoremap 0 ^
	nnoremap ^ 0

	map [[ ?{<CR>w99[{
	map ][ /}<CR>b99]}
	map ]] j0[[%/{<CR>
	map [] k$][%?}<CR>
endif
