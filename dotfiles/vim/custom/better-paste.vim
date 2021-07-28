"TODO:BETTER-PASTE
let g:better_paste_enable_default_mappings = 1

" if ExistsAndTrue('g:better_vim_enable_default_mappings') && ExistsAndTrue('g:better_paste_enable_default_mappings')
if ExistsAndTrue('g:better_paste_enable_default_mappings')
	"PASTE+SWAP
	"nnoremap p :normal! ]p <CR>
	"nnoremap P :normal! [p <CR>
	"nnoremap ]p :normal! p <CR>
	"nnoremap [p :normal! P <CR>
	"vnoremap p :<C-u>normal! ]pgvd <CR>
	"vnoremap P :<C-u>normal! [pgvd <CR>
	"vnoremap ]p :<C-u>normal! pgvd <CR>
	"vnoremap [p :<C-u>normal! Pgvd <CR>

	"PASTE+INDENT
	nnoremap >p :normal! ]p>> <CR>
	nnoremap <p :normal! ]p<< <CR>
	nnoremap >P :normal! [p>> <CR>
	nnoremap <P :normal! [p<< <CR>

	"PASTE+NEWLINE
	"nnoremap ]p :normal! o<esc>p==
	"nnoremap [p :normal! O<Esc>P==

	"PASTE+CYCLE

	"PASTE+FORMAT
endif
