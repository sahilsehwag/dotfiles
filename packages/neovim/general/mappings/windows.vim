nnoremap <Leader>w; :windo norm<space>
nnoremap <Leader>w: :windo<space>

nnoremap <silent> <Leader>ws :sp<CR>
nnoremap <silent> <Leader>wS :new<CR>
nnoremap <silent> <Leader>wv :vsp<CR>
nnoremap <silent> <Leader>wV :vnew<CR>

nnoremap <silent> <Leader>wbt :wincmd T<CR>
nnoremap <silent> <Leader>wbf <nop>
nnoremap <silent> <Leader>wba :wincmd ^<CR>

nnoremap <silent> <Leader>wo :only<CR>
nnoremap <silent> <Leader>wc :close<CR>

nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>

nnoremap <silent> <C-S-h> 5:wincmd <<CR>
nnoremap <silent> <C-S-j> 5:wincmd -<CR>
nnoremap <silent> <C-S-k> 5:wincmd +<CR>
nnoremap <silent> <C-S-l> 5:wincmd ><CR>
nnoremap <silent> <Leader>w= :wincmd =<CR>
nnoremap <silent> <Leader>wm :wincmd \| \| wincmd _<CR>

nnoremap <silent> <Leader>wh :wincmd H<CR>
nnoremap <silent> <Leader>wj :wincmd J<CR>
nnoremap <silent> <Leader>wk :wincmd K<CR>
nnoremap <silent> <Leader>wl :wincmd L<CR>
nnoremap <silent> <Leader>wx :wincmd x<CR>
nnoremap <silent> <Leader>wr :wincmd r<CR>
nnoremap <silent> <Leader>wR :wincmd R<CR>

"nnoremap <silent> <Leader>w3v :only<bar>vsplit<bar>split<bar>wincmd h<CR>
"nnoremap <silent> <Leader>w3h :only<bar>split<bar>vsplit<bar>wincmd k<CR>
"nnoremap <silent> <Leader>w4d :only<bar>vsplit<bar>split<bar>wincmd h<bar>split<bar>wincmd k<CR>
"nnoremap <silent> <Leader>w4v :only<bar>vsplit<bar>split<bar>split<bar>wincmd h<CR>
"nnoremap <silent> <Leader>w4h :only<bar>split<bar>vsplit<bar>vsplit<bar>wincmd k<CR>
"nnoremap <silent> <Leader>w5v :only<bar>vsplit<bar>split<bar>split<bar>split<bar>wincmd h<CR>
"nnoremap <silent> <Leader>w5h :only<bar>split<bar>vsplit<bar>vsplit<bar>vsplit<bar>wincmd k<CR>

if has('nvim')
	tnoremap <silent> <C-h> <C-\><C-n>:wincmd h<CR>
	tnoremap <silent> <C-j> <C-\><C-n>:wincmd j<CR>
	tnoremap <silent> <C-k> <C-\><C-n>:wincmd k<CR>
	tnoremap <silent> <C-l> <C-\><C-n>:wincmd l<CR>
endif
