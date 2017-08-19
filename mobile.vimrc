"PREFERENCES
	set wrap
	set relativenumber
	set autoindent
	set shiftwidth=4
	set hls
	set incsearch
	set ignorecase
	set smartcase
	set tabstop=4
	set hidden
	set nobackup
	set noswapfile
"LEADER MAPPING
	let mapleader = " "
	let maplocalleader = ","
	nnoremap <Leader><Leader> :
"BUFFER MAPPINGS
	nnoremap <LEADER>be :e 
	nnoremap <LEADER>ba :badd 
	nnoremap <LEADER>bd :bdelete<CR>
	nnoremap <LEADER>bfd :bdelete!<CR>
	nnoremap <LEADER>bn :bnext<CR>
	nnoremap <LEADER>bp :bprevious<CR>
	nnoremap <LEADER>bw :write<CR>
	nnoremap <LEADER>bfw :write!<CR>
	nnoremap <Leader>bl :ls<CR>
"WINDOW MAPPINGS
	nnoremap <Leader>ws :sp 
	nnoremap <Leader>wv :vsp 
	nnoremap <Leader>wo :only<CR>

	nnoremap <Leader>wj <C-W><C-J>
	nnoremap <Leader>wk <C-W><C-K>
	nnoremap <Leader>wl <C-W><C-L>
	nnoremap <Leader>wh <C-W><C-H>
"TAB MAPPINGS
	nnoremap <LEADER>ta :tabnew<CR>
	nnoremap <LEADER>tc :tabclose<CR>
	nnoremap <LEADER>tn :tabnext<CR>
	nnoremap <LEADER>tp :tabprevious<CR>
	nnoremap <LEADER>th :tabmove -<CR>
	nnoremap <LEADER>tl :tabmove +<CR>
"VIM MAPPINGS
	nnoremap <LEADER>vs :source ~/.config/nvim/init.vim<CR>
	nnoremap <LEADER>vrc :edit ~/.config/nvim/init.vim<CR>
	nnoremap <LEADER>vq :q<CR>
	nnoremap <LEADER>vfq :q!<CR>
	nnoremap <Leader>vc <Esc>0i"<Esc>
	nnoremap <Leader>vu <Esc>0x
	nnoremap <Leader>vp "*p
	nnoremap <Leader>vy "*y
"ABBREVIATIONS
	inoremap ,1 ()<Esc>i
	inoremap ,2 []<Esc>i
	inoremap ,3 {}<Esc>i
	inoremap ,4 <><Esc>i
	inoremap ,5 ''<Esc>i
	inoremap ,6 ""<Esc>i
	inoremap ,7 ``<Esc>i

	inoremap ,81 <Space>=<Space>
	inoremap ,82 <Space>+=<Space>
	inoremap ,83 <Space>-=<Space>
	inoremap ,84 <Space>*=<Space>
	inoremap ,85 <Space>/=<Space>
	inoremap ,86 <Space>%=<Space>

	inoremap ,91 <Space>+<Space>
	inoremap ,92 <Space>-<Space>
	inoremap ,93 <Space>*<Space>
	inoremap ,94 <Space>/<Space>
	inoremap ,95 <Space>%<Space>

	inoremap ,01 <Space>==<Space>
	inoremap ,02 <Space>!=<Space>
	inoremap ,03 <Space><=<Space>
	inoremap ,04 <Space>>=<Space>
	inoremap ,05 <Space>&&<Space>
	inoremap ,06 <Space>\|\|<Space>
"UI
