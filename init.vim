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
		Plug 'vifm/neovim-vifm'
	"EDITING
		"OPERATORS
			Plug 'tpope/vim-surround'
			Plug 'junegunn/vim-easy-align'
			Plug 'thinca/vim-textobj-between'
			Plug 'christoomey/vim-titlecase'
		"TARGETS
		"OBJECTS
			Plug 'wellle/targets.vim'
			Plug 'michaeljsmith/vim-indent-object'
			Plug 'coderifous/textobj-word-column.vim'
			Plug 'junegunn/vim-after-object'
			Plug 'kana/vim-textobj-line'
			Plug 'glts/vim-textobj-comment'
		"CUSTOM
			Plug 'kana/vim-textobj-user'
			Plug 'kana/vim-operator-user'
		Plug 'chaoren/vim-wordmotion'
		Plug 'machakann/vim-swap'
		"Plug 'terryma/vim-multiple-cursors'
	"SEARCHING
		Plugin 'haya14busa/incsearch.vim'
		Plugin 'haya14busa/incsearch-fuzzy.vim'
		Plugin 'haya14busa/incsearch-easymotion.vim'
		Plug 'haya14busa/vim-easyoperator-line'
		Plug 'haya14busa/vim-easyoperator-phrase'
	"LOOK&FEEL
		Plug 'vim-airline/vim-airline'
		Plug 'vim-airline/vim-airline-themes'
		Plug 'flazz/vim-colorschemes'
		"Plug 'ryanoasis/vim-devicons'
	"EXTENDING VIM
		Plug 'milsen/vim-operator-substitute'
		Plug 'zirrostig/vim-schlepp'
		Plug 'kana/vim-submode'
		Plug 'vim-scripts/vim-easy-submode'
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
		"Plug 'haya14busa/vim-operator-flashy'
		"Plug 'gorodinskiy/vim-coloresque'
		"Plug 'hecal3/vim-leader-guide'
	"MISCELLANOUS
		Plug 'mhinz/vim-startify'
		"Plug 'guns/xterm-color-table.vim'
		"Plug 'tpope/vim-capslock'
		"Plug 'vim-scripts/ScrollColors'
call plug#end()


"PREFERENCES
	set nocompatible
	set nowrap
	set number
	set relativenumber
	set autoindent
	set shiftwidth=4
	set hls
	set incsearch
	set ignorecase
	set smartcase
	set tabstop=4
	set hidden
	set directory=~/.config/nvim/temp
	set nobackup
	colorscheme Monokai
"CONFIGURATION
	"PYTHON BINARIES
		let g:python_host_prog = '/usr/bin/python3'
"MAPPINGS
	"NOTE: t=tabs b=buffers w=windows s=sessions c=registers/clipboards r=replace? n=navigation j=jumping f=find z|m?=miscellanous c=code/programming
	"LEADER MAPPING
		let mapleader = " "
		let maplocalleader = ","
		nnoremap ; :
	"TAB MAPPINGS
		nnoremap <LEADER>ta :tabnew<CR>
		nnoremap <LEADER>tc :tabclose<CR>
		nnoremap <LEADER>tn :tabnext<CR>
		nnoremap <LEADER>tp :tabprevious<CR>
		nnoremap <LEADER>th :tabmove -<CR>
		nnoremap <LEADER>tl :tabmove +<CR>
	"BUFFER MAPPINGS
		nnoremap H :bprevious<CR>
		nnoremap L :bnext<CR>
		nnoremap <LEADER>be :e 
		nnoremap <LEADER>ba :badd 
		nnoremap <LEADER>bd :bdelete<CR>
		nnoremap <LEADER>bfd :bdelete!<CR>
		nnoremap <LEADER>bn :bnext<CR>
		nnoremap <LEADER>bp :bprevious<CR>
		nnoremap <LEADER>bw :write<CR>
		nnoremap <LEADER>bfw :write!<CR>
	"WINDOW(SPLITS) MAPPINGS
		nnoremap <Leader>ws :sp 
		nnoremap <Leader>wv :vsp 
		nnoremap <Leader>wo :only<CR>

		nnoremap <C-J> <C-W><C-J>
		nnoremap <C-K> <C-W><C-K>
		nnoremap <C-L> <C-W><C-L>
		nnoremap <C-H> <C-W><C-H>
	"VIM MAPPINGS
		nnoremap <LEADER>vs :source ~/.config/nvim/init.vim<CR>
		nnoremap <LEADER>vrc :edit ~/.config/nvim/init.vim<CR>
		nnoremap <LEADER>vq :q<CR>
		nnoremap <LEADER>vfq :q!<CR>
	"MISCELLANOUS MAPPINGS
		"REPEAT LAST OPERATION ON A MATCH ON NEXT n MATCH
			nnoremap Q :normal n.<CR>
			"nnoremap Q @='n.'<CR>
		"MOVE COMMANDS
			nnoremap <C-DOWN> :m .+1<CR>==
			nnoremap <C-UP> :m .-2<CR>==
			inoremap <C-DOWN> <Esc>:m .+1<CR>==gi
			inoremap <C-UP> <Esc>:m .-2<CR>==gi
			vnoremap <C-DOWN> :m '>+1<CR>gv=gv
			vnoremap <C-UP> :m '<-2<CR>gv=gv
"PLUGIN CONFIGURATIONS
	"VIM-OPERATOR-SUBSTITUTE
		let g:operator#substitute#default_flags = "g"
		"let g:operator#substitute#default_delimiter = "#"
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
	"VIM-SESSION
		let g:session_autosave = 'yes'
		let g:session_autoload = 'yes'
		let g:session_default_name = 'default'
		let g:session_default_to_last = 'yes'
	"VIM-SUBMODE
		let g:submode_always_show_submode = 1
		"let g:submode_keep_leaving_key = 1
		"let g:submode_timeout = 0
		let g:submode_timeoutlen = 1000
	"VIM-EASY-SUBMODE
		call easysubmode#load()

		SubmodeDefine buffers
		Submode n <enter> <Leader>b. :bnext<CR>
		Submode n n :bnext<CR>
		Submode n p :bprevious<CR>
		SubmodeDefineEnd

		SubmodeDefine tabs
		Submode n <enter> <Leader>t.
		Submode n n :tabnext<CR>
		Submode n p :tabprevious<CR>
		Submode n h :tabmove +1<CR>
		Submode n l :tabmove -1<CR>
		SubmodeDefineEnd
"PLUGIN MAPPINGS
	"INCSEARCH
		map /  <Plug>(incsearch-forward)
		map ?  <Plug>(incsearch-backward)
		map g/ <Plug>(incsearch-stay)

		let g:incsearch#auto_nohlsearch = 1
		map n <Plug>(incsearch-nohl-n)<Plug>Pulse
		map N <Plug>(incsearch-nohl-N)<Plug>Pulse
		map * <Plug>(incsearch-nohl-*)<Plug>Pulse
		map # <Plug>(incsearch-nohl-#)<Plug>Pulse
		map g* <Plug>(incsearch-nohl-g*)<Plug>Pulse
		map g# <Plug>(incsearch-nohl-g#)<Plug>Pulse
	"INCSEARCH-FUZZY
		map <LEADER>/ <Plug>(incsearch-fuzzy-/)
		map <LEADER>? <Plug>(incsearch-fuzzy-?)
		map <LEADER>s <Plug>(incsearch-fuzzy-stay)
	"INCSEARCH-EASYMOTION
		map <Leader>f/ <Plug>(incsearch-easymotion-/)
		map <Leader>f? <Plug>(incsearch-easymotion-?)
		map <Leader>fg/ <Plug>(incsearch-easymotion-stay)
	"VIM-OPERATOR-SUBSTITUTE
		map <Leader>r <Plug>(operator-substitute)
		map R <Plug>(operator-substitute)$
		map & <Plug>(operator-substitute-repeat)
		map g& <Plug>(operator-substitute-repeat-no-flags)
	"VIM-OPERATOR-FLASHY
		map y <Plug>(operator-flashy)
		map Y <Plug>(operator-flashy)$
	"VIM-TEXTOBJ-COMMENT
		let g:textobj_comment_no_default_mappings = 1
		xmap a/ <Plug>(textobj-comment-a)
		xmap i/ <Plug>(textobj-comment-i)
		omap a/ <Plug>(textobj-comment-a)
		omap i/ <Plug>(textobj-comment-i)
	"VIM-SCHLEPP
		vmap <up>    <Plug>SchleppUp
		vmap <down>  <Plug>SchleppDown
		vmap <left>  <Plug>SchleppLeft
		vmap <right> <Plug>SchleppRight

		vmap Dk <Plug>SchleppDupUp
		vmap Dj <Plug>SchleppDupDown
		vmap Dh <Plug>SchleppDupLeft
		vmap Dl <Plug>SchleppDupRight
	"VIM-EASY-ALIGN
		xmap ga <Plug>(EasyAlign)
		nmap ga <Plug>(EasyAlign)
	"EASYMOTION
		let g:EasyMotion_smartcase = 1
		nmap <LEADER>j <Plug>(easymotion-prefix)

		nmap <LEADER>jl <Plug>(easymotion-overwin-line)
		nmap <LEADER>jw <Plug>(easymotion-overwin-w)
		nmap <LEADER>je <Plug>(easymotion-bd-e)
		"nmap <LEADER>jf <Plug>(easymotion-overwin-f)
		"map <LEADER>js <Plug>(easymotion-overwin-f2)
	"FZF
		nnoremap <LEADER>nf :Files<CR>
		nnoremap <LEADER>nc :FZF %:p:h<CR>
		nnoremap <LEADER>ng :Ag<CR>
		nnoremap <LEADER>nl :Locate 

		nnoremap <LEADER>nh :History<CR>
		nnoremap <LEADER>nt :Tags<CR>

		nnoremap <LEADER>nn :Files /mnt/c/Users/sehwa/OneDrive<CR>
		nnoremap <LEADER>nu :Files ~<CR>
		nnoremap M :History<CR>
	"VIFM
		nnoremap <LEADER>nv :VifmToggle .<CR>
		nnoremap <LEADER>nV :VifmToggle %:p:h<CR>
	"CTRLP
	"VIM-CTRLP-SESSION
		nnoremap <LEADER>sn :Session 
		nnoremap <LEADER>sl :SLoad 
		nnoremap <LEADER>sd :SDelete 
		nnoremap <LEADER>sq :SQuit<CR>
		nnoremap <LEADER>sp :CtrlPSession<CR>
	"VIM-OVER
		nmap <LEADER>ro :OverCommandLine<CR>
	"VIM-LEADER-GUIDE
		"nnoremap <SPACE> :LeaderGuide '<LEADER>'<CR>
		"nnoremap ; :LeaderGuide '<LOCALLEADER>'<CR>
		"vnoremap <SPACE> :LeaderGuideVisual '<LEADER>'<CR>
		"vnoremap ; :LeaderGuideVisual '<LOCALLEADER>'<CR>
		
		"DON'T UNCOMMENT THESE
		"nmap <SPACE>. <Plug>leaderguide-global
		"nmap ;. <Plug>leaderguide-buffer
"VIMSCRIPT CODE
	"HIGHLIGHTS
		highlight Search ctermfg=49 cterm=NONE gui=NONE
		highlight IncSearchMatch ctermfg=black ctermbg=186
	"FILETYPE=jproperties FOR .txt FILES
		autocmd BufNewFile,BufRead *.txt set syntax=jproperties
	"COLORING TRAILING WHITESPACES
		highlight TrailingWhitespace ctermbg=135
		call matchadd('TrailingWhitespace', '\s\+$', 100)
