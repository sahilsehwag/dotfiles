nnoremap <silent> <Leader>wh :sp<CR>
nnoremap <silent> <Leader>wv :vsp<CR>
nnoremap <silent> <Leader>wH :new<CR>
nnoremap <silent> <Leader>wV :vnew<CR>
nnoremap <silent> <Leader>wo :only<CR>
nnoremap <silent> <Leader>wc :close<CR>
nnoremap <silent> <Leader>w= <C-w>=

nnoremap <silent> <Leader>w3v :only<bar>vsplit<bar>split<bar>wincmd h<CR>
nnoremap <silent> <Leader>w3h :only<bar>split<bar>vsplit<bar>wincmd k<CR>
nnoremap <silent> <Leader>w4d :only<bar>vsplit<bar>split<bar>wincmd h<bar>split<bar>wincmd k<CR>
nnoremap <silent> <Leader>w4v :only<bar>vsplit<bar>split<bar>split<bar>wincmd h<CR>
nnoremap <silent> <Leader>w4h :only<bar>split<bar>vsplit<bar>vsplit<bar>wincmd k<CR>
nnoremap <silent> <Leader>w5v :only<bar>vsplit<bar>split<bar>split<bar>split<bar>wincmd h<CR>
nnoremap <silent> <Leader>w5h :only<bar>split<bar>vsplit<bar>vsplit<bar>vsplit<bar>wincmd k<CR>

if has('nvim')
	nnoremap <silent> <C-h> <C-w><C-h>
	nnoremap <silent> <C-j> <C-w><C-j>
	nnoremap <silent> <C-k> <C-w><C-k>
	nnoremap <silent> <C-l> <C-w><C-l>

	"window navigation for non-floating terminals
	tnoremap <silent> <C-h> <C-\><C-n><C-w>h
	tnoremap <silent> <C-j> <C-\><C-n><C-w>j
	tnoremap <silent> <C-k> <C-\><C-n><C-w>k
	tnoremap <silent> <C-l> <C-\><C-n><C-w>l
endif
