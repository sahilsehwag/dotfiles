"CONFIGURATION
	let bufferline = {}
	let bufferline.icon_close_tab_modified = '●'
	let bufferline.no_name_title = v:null
"MAPPINGS
	nnoremap <silent> <Leader>` :BufferLast<CR>
	nnoremap <silent> <Leader>1 :BufferGoto 1<CR>
	nnoremap <silent> <Leader>2 :BufferGoto 2<CR>
	nnoremap <silent> <Leader>3 :BufferGoto 3<CR>
	nnoremap <silent> <Leader>4 :BufferGoto 4<CR>
	nnoremap <silent> <Leader>5 :BufferGoto 5<CR>
	nnoremap <silent> <Leader>6 :BufferGoto 6<CR>
	nnoremap <silent> <Leader>7 :BufferGoto 7<CR>
	nnoremap <silent> <Leader>8 :BufferGoto 8<CR>
	nnoremap <silent> <Leader>9 :BufferGoto 9<CR>
	nnoremap <silent> <Leader>bg :BufferPick<CR>
	nnoremap <silent> <C-S-b> :BufferPick<CR>

	nnoremap <silent> <Leader>bcc :BufferClose<CR>
	nnoremap <silent> <Leader>bcC :BufferClose!<CR>
	nnoremap <silent> <Leader>bcA :bufdo BufferClose<CR>
	nnoremap <silent> <Leader>bcA :bufdo BufferClose!<CR>
	nnoremap <silent> <Leader>bco :BufferCloseAllButCurrent<CR>
	nnoremap <silent> <Leader>bch :BufferCloseBuffersLeft<CR>
	nnoremap <silent> <Leader>bcl :BufferCloseBuffersRight<CR>

	"nnoremap <silent> <Leader>bd :BufferClose<CR>
	"nnoremap <silent> <Leader>bD :BufferDelete<CR>
	nnoremap <silent> <C-S-d> :BufferClose<CR>

	nnoremap <silent> <C-n> :BufferNext<CR>
	nnoremap <silent> <C-p> :BufferPrevious<CR>

	nnoremap <silent> <C--> :BufferMovePrevious<CR>
	nnoremap <silent> <C-=> :BufferMoveNext<CR>
