nnoremap <silent> <Leader>ban :enew<CR>
nnoremap <silent> <Leader>bas :call ScratchBuffer('e')<CR>
nnoremap <silent> <Leader>baS :call ScratchBuffer('e', 1)<CR>

nnoremap <silent> <Leader>bcc :bprevious<bar>split<bar>bnext<bar>bdelete<CR>
nnoremap <silent> <Leader>bcC :bprevious<bar>split<bar>bnext<bar>bdelete!<CR>
"nnoremap <silent> <Leader>bca :bufdo bp<bar>sp<bar>bn<bar>bd<CR>
"nnoremap <silent> <Leader>bcA :bufdo bp<bar>sp<bar>bn<bar>bd!<CR>
"nnoremap <silent> <Leader>bco :%bp<bar>sp<bar>bn<bar>bd<bar>e#<CR>
"nnoremap <silent> <Leader>bcO :%bp<bar>sp<bar>bn<bar>bd!<bar>e#<CR>

nnoremap <silent> <Leader>bdc :bdelete<CR>
nnoremap <silent> <Leader>bdC :bdelete!<CR>
nnoremap <silent> <Leader>bda :%bdelete<CR>
nnoremap <silent> <Leader>bdA :%bdelete!<CR>
nnoremap <silent> <Leader>bdo :%bdelete<bar>edit#<bar>bnext<bar>bdelete<CR>
nnoremap <silent> <Leader>bdO :%bdelete!<bar>edit#<bar>bnext<bar>bdelete!<CR>

nnoremap <silent> <Leader>bwc :write<CR>
nnoremap <silent> <Leader>bwC :write!<CR>
nnoremap <silent> <Leader>bwa :wall<CR>
nnoremap <silent> <Leader>bwA :wall!<CR>

nnoremap <silent> <Leader>bl :buffers<CR>

nnoremap <silent> <Leader>bs :call ScratchBuffer('e')<CR>
nnoremap <silent> <Leader>bS :call ScratchBuffer('e', 1)<CR>

"SHORTCUTS
nnoremap <Leader>` <C-^>
nnoremap <silent> <C-p> :bprevious<CR>
nnoremap <silent> <C-n> :bnext<CR>
nnoremap <silent> <C-s> :write<CR>
nnoremap <silent> <C-S-s> :wall<CR>
nnoremap <silent> <C-S-d> :bp<bar>sp<bar>bn<bar>bd<CR>
nnoremap <silent> <Leader><Leader>d :bp<bar>sp<bar>bn<bar>bd<CR>
