"VIM-PLUG
call plug#begin()
	"DEVELOPMENT
		"Plug 'airblade/vim-gitgutter'
	"CODING
		Plug 'scrooloose/nerdcommenter'
	"FILESYSTEM
		Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
		Plug 'junegunn/fzf.vim'
		Plug 'easymotion/vim-easymotion'
		Plug 'scrooloose/nerdtree'
	"EDITING
		"OPERATORS
			Plug 'tpope/vim-surround'
		"OBJECTS
			Plug 'wellle/targets.vim'
			Plug 'michaeljsmith/vim-indent-object'
			Plug 'coderifous/textobj-word-column.vim'

			Plug 'kana/vim-textobj-line'
			Plug 'junegunn/vim-after-object'
		Plug 'chaoren/vim-wordmotion'
		Plug 'junegunn/vim-easy-align'

		Plug 'terryma/vim-multiple-cursors'
		"Plug 'christoomey/vim-titlecase'

		Plug 'kana/vim-textobj-user'
		Plug 'kana/vim-operator-user'
	"SEARCHING
	"LOOK&FEEL
		Plug 'vim-airline/vim-airline'
		Plug 'vim-airline/vim-airline-themes'
		Plug 'flazz/vim-colorschemes'
		Plug 'ryanoasis/vim-devicons'
	"EXTENDING VIM
		Plug 'tpope/vim-repeat'
		Plug 'kshenoy/vim-signature'
		Plug 'joeytwiddle/sexy_scroller.vim'
		Plug 'inside/vim-search-pulse'
		Plug 'pseewald/vim-anyfold'
		Plug 'arecarn/vim-fold-cycle'
		Plug 'rhysd/clever-f.vim'
		Plug 'haya14busa/vim-over'
		Plug 'okcompute/vim-ctrlp-session'
		Plug 'jiangmiao/auto-pairs'
		"Plug 'gorodinskiy/vim-coloresque'
	"MISCELLANOUS
		Plug 'mhinz/vim-startify'
		"Plug 'tpope/vim-capslock'
		"Plug 'vim-scripts/ScrollColors'
call plug#end()


"PREFERENCES
	set nocompatible
	set number
	set relativenumber
	set autoindent
	set shiftwidth=4
	set hls
	set incsearch
	set ignorecase
	set smartcase
	set tabstop=4
	set showcmd
	set paste
	set hidden
	colorscheme Monokai
"CONFIGURATION
	"PYTHON BINARIES
		let g:python_host_prog = '/usr/bin/python3'
"MAPPINGS
	"NOTE: t=tabs b=buffers w=windows s=sessions c=registers/clipboards r=replace? n=navigation j=jumping f=find z|m?=miscellanous c=code/programming
	"LEADER MAPPING
		let mapleader = " "
		nmap <SPACE> <LEADER>
	"TAB MAPPINGS
		nnoremap <LEADER>tn :tabnew<CR>
		nnoremap <LEADER>td :tabclose<CR>
		nnoremap <LEADER>tn :tabnext<CR>
		nnoremap <LEADER>tp :tabprevious<CR>

		nnoremap <LEADER>th :tabmove -<CR>
		nnoremap <LEADER>tl :tabmove +<CR>
		nnoremap <LEADER>tl :tabmove -<CR>
		nnoremap <LEADER>tr :tabmove +<CR>
	"BUFFER MAPPINGS
		nnoremap H :bprevious<CR>
		nnoremap L :bnext<CR>
		nnoremap <LEADER>bn :e 
		nnoremap <LEADER>ba :badd 
		nnoremap <LEADER>bd :bdelete<CR>
		nnoremap <LEADER>bfd :bdelete!<CR>
	"WINDOW(SPLITS) MAPPINGS
		nnoremap <Leader>wh :sp 
		nnoremap <Leader>wv :vsp 
		nnoremap <Leader>wo :only<CR>

		nnoremap <C-J> <C-W><C-J>
		nnoremap <C-K> <C-W><C-K>
		nnoremap <C-L> <C-W><C-L>
		nnoremap <C-H> <C-W><C-H>
"PLUGIN CONFIGURATIONS
	"SEXY-SCROLLER
		let g:SexyScoller_ScrollTime = 10
		let g:SexyScroller_CursorTime = 5
		let g:SexyScroller_MaxTime = 500
		let g:SexyScroller_EasingStyle = 1
	"VIM-AFTER-OBJECT
		autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')
	"VIM-SEARCH-PULSE
		let g:vim_search_pulse_mode = 'cursor_line'
	"VIM-ANYFOLD
		let anyfold_activate=1
		let anyfold_identify_comments=0
		set foldlevel=0
	"VIM-FOLD-CYCLE
		let g:fold_cycle_default_mapping = 0
		nmap <Tab> <Plug>(fold-cycle-open)
		nmap <S-Tab> <Plug>(fold-cycle-close)
	"CLEVER-F.VIM
		let g:clever_f_ignore_case=1
		let g:clever_f_smart_case=1
		"let g:clever_f_mark_char_color='cssColor66ffcc'
	"VIM-AIRLINE
		let g:airline_powerline_fonts = 1
		let g:airline#extensions#tabline#enabled = 1
		let g:airline_theme='powerlineish'
			"powerlineish 
			"solarized light 
			"solarized dark 
		"let g:airline#extensions#tabline#left_sep = ' '
		"let g:airline#extensions#tabline#left_alt_sep = '|'
	"VIM-TITLECASE
		let g:titlecase_map_keys = 0
	"VIM-SESSION
		let g:session_autosave = 'yes'
		let g:session_autoload = 'yes'
		let g:session_default_name = 'default'
		let g:session_default_to_last = 'yes'
"PLUGIN MAPPINGS
	"EASYMOTION
		let g:EasyMotion_smartcase = 1
		nmap <LEADER>j <Plug>(easymotion-prefix)

		nmap <LEADER>jl <Plug>(easymotion-overwin-line)
		nmap <LEADER>jw <Plug>(easymotion-overwin-w)
		nmap <LEADER>je <Plug>(easymotion-bd-e)
		"nmap <LEADER>jf <Plug>(easymotion-overwin-f)
		"map <LEADER>js <Plug>(easymotion-overwin-f2)
	"FZF
		nnoremap <LEADER>no :FZF --no-reverse .<CR>
		nnoremap <LEADER>nh :History<CR>
		nnoremap <LEADER>nc :FZF --no-reverse %:p:h<CR>

		nnoremap <LEADER>nn :FZF --no-reverse /mnt/c/Users/sehwa/OneDrive<CR>
	"CTRLP
	"NERDTREE
		nnoremap <LEADER>nt :NERDTreeToggle<CR>
		"nnoremap <LEADER>nc :NERDTree %<CR>
	"VIM-CTRLP-SESSION
		nnoremap <LEADER>sn :Session 
		nnoremap <LEADER>sl :SLoad 
		nnoremap <LEADER>sd :SDelete 
		nnoremap <LEADER>sq :SQuit<CR>
		nnoremap <LEADER>sp :CtrlPSession<CR>
"VIMSCRIPT CODE
	"AUTORELOAD .vimrc
		augroup myvimrc
			au!
			au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
		augroup END
	"FILETYPE=jproperties FOR .txt FILES
		autocmd BufNewFile,BufRead *.txt set syntax=jproperties
