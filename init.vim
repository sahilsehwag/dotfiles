"VIM-PLUG
call plug#begin()
	"DEVELOPMENT
		Plug '0x84/vim-coderunner'
		Plug 'metakirby5/codi.vim'
		Plug 'vim-syntastic/syntastic'
		Plug 'scrooloose/nerdcommenter'
		Plug 'rizzatti/dash.vim'
		"Plug 'vim-scripts/AutoComplPop'
		"Plug 'rhysd/devdocs.vim'
		"Plug 'airblade/vim-gitgutter'
		"Plug 'mhinz/vim-signify'
		"Plug 'majutsushi/tagbar'
		"Plug 'ervandew/supertab'
	"FILESYSTEM
		Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
		Plug 'junegunn/fzf.vim'
		Plug 'easymotion/vim-easymotion'
		Plug 'vifm/neovim-vifm'
	"EDITING
		"OPERATORS
			Plug 'tommcdo/vim-exchange'
			Plug 'tpope/vim-surround'
			Plug 'junegunn/vim-easy-align'
			Plug 'thinca/vim-textobj-between'
			Plug 'christoomey/vim-titlecase'
			Plug 'milsen/vim-operator-substitute'
		"TARGETS
		"OBJECTS
			Plug 'wellle/targets.vim'
			Plug 'michaeljsmith/vim-indent-object'
			Plug 'coderifous/textobj-word-column.vim'
			"Plug 'junegunn/vim-after-object'
			Plug 'kana/vim-textobj-line'
			Plug 'glts/vim-textobj-comment'
		"CUSTOM
			Plug 'kana/vim-textobj-user'
			Plug 'kana/vim-operator-user'
		Plug 'chaoren/vim-wordmotion'
		Plug 'machakann/vim-swap'
		"Plug 'terryma/vim-multiple-cursors'
		"Plug 'terryma/vim-expand-region'
	"WRITTING
		Plug 'reedes/vim-pencil'
		Plug 'panozzaj/vim-autocorrect'
		"Plug 'dbmrq/vim-ditto'
	"SEARCHING
		Plug 'haya14busa/incsearch.vim'
		Plug 'haya14busa/incsearch-fuzzy.vim'
		Plug 'haya14busa/incsearch-easymotion.vim'
		Plug 'haya14busa/vim-easyoperator-line'
		Plug 'haya14busa/vim-easyoperator-phrase'
		Plug 'bronson/vim-visual-star-search'
	"LOOK&FEEL
		Plug 'vim-airline/vim-airline'
		Plug 'vim-airline/vim-airline-themes'
		Plug 'flazz/vim-colorschemes'
		Plug 'ryanoasis/vim-devicons'
		"Plug 'augustold/vim-airline-colornum'
	"EXTENDING VIM
		Plug 'mtth/scratch.vim'
		Plug 'vim-scripts/WholeLineColor'
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
		Plug 'haya14busa/vim-operator-flashy'
		Plug 'reedes/vim-wheel'
		Plug 'tyru/open-browser.vim'
		Plug 'junegunn/goyo.vim'
		Plug 'junegunn/limelight.vim'
		"Plug 'tpope/vim-speeddating'
		"Plug 'gorodinskiy/vim-coloresque'
		"Plug 'hecal3/vim-leader-guide'
		"Plug 'Yggdroot/indentLine'
		"Plug 'chrisbra/changesPlugin'
		"Plug 'severin-lemaignan/vim-minimap'
	"SYNTAX
		Plug 'plasticboy/vim-markdown'
		Plug 'mattn/emmet-vim'
	"MISCELLANOUS
		Plug 'mhinz/vim-startify'
		Plug 'suan/vim-instant-markdown'
		Plug 'tpope/vim-capslock'
		"Plug 'guns/xterm-color-table.vim'
		"Plug 'vim-scripts/ScrollColors'
		"Plug 'vim-scripts/DrawIt'
call plug#end()


"PREFERENCES
	"INDENTATION
		set autoindent
		set shiftwidth=4
		set tabstop=4
	"AUTOCOMPLETION
	"LINE NUMBERS
		set number
		set relativenumber
	"SWAP & BACKUP
		set directory=~/.config/nvim/temp
		set nobackup
	"SEARCHING
		set hls
		set incsearch
		set ignorecase
		set smartcase
	"MISCELLANOUS
		set nocompatible
		set fillchars=fold:\ 
		set mouse=a
		set nowrap
		set hidden
		colorscheme Monokai
		set clipboard=unnamed
"CONFIGURATION
	"PYTHON BINARIES
		let g:python_host_prog = '/usr/bin/python3'
	"HIGHLIGHTS
		"SEARCH HIGHLIGHTS
			highlight Search ctermfg=49 cterm=NONE gui=NONE
			highlight IncSearchMatch ctermfg=black ctermbg=186
		"TRAILING WHITESPACES
			"highlight TrailingWhitespace ctermbg=135
			"call matchadd('TrailingWhitespace', '\s\+$', 100)
		"AUTOCOMPLETION MENU
			"highlight Pmenu ctermbg=232 ctermfg=7
			"highlight PmenuSel ctermfg=15
			highlight Pmenu ctermbg=238 gui=bold
	"FILETYPE=jproperties FOR TEXT FILES
		autocmd BufNewFile,BufRead *.txt set syntax=jproperties
"MAPPINGS
	"NOTE: t=tabs b=buffers w=windows s=sessions c=registers/clipboards r=replace? n=navigation j=jumping f=find z|m?=miscellanous c=code/programming
	"MAIN LAYOUT MAPPINGS
	"LEADER MAPPING
		let mapleader = " "
		let maplocalleader = ","
		nnoremap ; :
	"LOCAL LEADER MAPPINGS
		"NOTES
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
	"WINDOW MAPPINGS
		nnoremap <Leader>ws :sp 
		nnoremap <Leader>wv :vsp 
		nnoremap <Leader>wo :only<CR>

		nnoremap <C-J> <C-W><C-J>
		nnoremap <C-K> <C-W><C-K>
		nnoremap <C-L> <C-W><C-L>
		nnoremap <C-H> <C-W><C-H>
	"VIM MAPPINGS
		nnoremap <LEADER>vc :edit ~/.config/nvim/init.vim<CR>
		nnoremap <LEADER>vs :source ~/.config/nvim/init.vim<CR>
		nnoremap <LEADER>vt :terminal<CR>
		nnoremap <Leader>vi :PlugInstall<CR>
		nnoremap <Leader>vu :PlugClean<CR>
		nnoremap <Leader>vw :call AutoSaveToggle()<CR>
		nnoremap <LEADER>vq :q<CR>
		nnoremap <LEADER>vfq :q!<CR>

		nnoremap <Leader>va :call AutoCorrect()<CR>
		nnoremap <Leader>vp :PencilToggle<CR>
		nnoremap <Leader>vd :Goyo<CR>
		nnoremap <Leader>vl :Limelight!!<CR>
	"ABBREVIATIONS @TODO
		abbreviate chk ✓
		abbreviate crs ✖
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
"PLUGINS
	"PRODUCTIVITY
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

			nnoremap <LEADER>nn :Files ~/Google Drive<CR>
			nnoremap <LEADER>nu :Files ~<CR>
			nnoremap M :History<CR>
		"VIFM
			nnoremap <LEADER>nv :VifmToggle .<CR>
			nnoremap <LEADER>nV :VifmToggle %:p:h<CR>
	"DEVELOPMENT
		"TAGBAR
			nnoremap <Leader>nT :TagbarToggle<CR>
		"DEVDOCS
			nmap <Leader>fD :DevDocs<CR>
			nmap <Leader>fd <Plug>(devdocs-under-cursor)
		"VIM-CODERUNNER
			let g:vcr_no_mappings = 1
			nnoremap <LocalLeader>cr :RunCode<CR>
			vnoremap <LocalLeader>cr :RunCode<CR>
		"CODI
			nmap <LocalLeader>ci :Codi!!<CR>
		"DASH
			nnoremap <Leader>fd :Dash<CR>
			nnoremap <Leader>fD :Dash<space>
		"EMMET
			let g:user_emmet_install_global = 0
			autocmd FileType html,css EmmetInstall
			let g:user_emmet_leader_key='<tab>'
	"EXTENDING VIM
		"SCRATCH
			let g:scratch_no_mappings = 1
			let g:scratch_height = 0.3
			let g:scratch_top = 0
			let g:scratch_persistence_file = '~/temp.scratch'

			nnoremap <LocalLeader>s :Scratch<CR> 
			nnoremap <LocalLeader>S :Scratch!<CR> 
			nnoremap <LocalLeader>gp :ScratchPreview<CR>
			nnoremap <LocalLeader>gs :ScratchInsert<CR>
			nnoremap <LocalLeader>gS :ScratchInsert!<CR>
			vnoremap <LocalLeader>gs :ScratchSelection<CR>
			vnoremap <LocalLeader>gS :ScratchSelection!<CR>

			augroup ScratchEnter
				autocmd!
				autocmd FileType scratch nnoremap <buffer> <esc> :q<CR>
			augroup END
		"OPEN-BROWSER
			let g:netrw_nogx = 1
			"SMART SEARCH
				nmap <Leader>fo <Plug>(openbrowser-smart-search)
				vmap <Leader>fo <Plug>(openbrowser-smart-search)
			"SEARCH WORD UNDER CURSOR
				nmap <Leader>fs <Plug>(openbrowser-search)
				vmap <Leader>fs <Plug>(openbrowser-search)
			"OPEN URI UNDER CURSOR
				nmap <Leader>fl <Plug>(openbrowser-open)
				vmap <Leader>fl <Plug>(openbrowser-open)
			"CUSTOM MAPPINGS
				nmap <Leader>fg :execute ":OpenBrowserSearch -github " GetWordUnderCursor() <CR>
				vmap <Leader>fg :<C-w>execute ":OpenBrowserSearch -github " GetSelectedText() <CR>
		"VIM-WHEEL
			let g:wheel#map#up   = '<D-k>'
			let g:wheel#map#down = '<D-j>'
			let g:wheel#map#mouse = 1
		"WHOLELINECOLOR
			let g:wholelinecolor_leader = ','
			highlight WLCBlackBackground  ctermbg=233 guibg=#121212
			highlight WLCRedBackground    ctermbg=52  guibg=#882323
			highlight WLCBlueBackground   ctermbg=17  guibg=#003366
			highlight WLCPurpleBackground ctermbg=53  guibg=#732c7b
			highlight WLCGreyBackground   ctermbg=238 guibg=#464646
			highlight WLCGreenBackground  ctermbg=22  guibg=#005500
		"VIM-OPERATOR-FLASHY
			let g:operator#flashy#group = 'Visual'
			map y <Plug>(operator-flashy)
			map Y <Plug>(operator-flashy)$
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
		"SEXY-SCROLLER
			let g:SexyScoller_ScrollTime = 10
			let g:SexyScroller_CursorTime = 5
			let g:SexyScroller_MaxTime = 500
			let g:SexyScroller_EasingStyle = 1
		"VIM-SESSION
			let g:session_autosave = 'yes'
			let g:session_autoload = 'yes'
			let g:session_default_name = 'default'
			let g:session_default_to_last = 'yes'
		"VIM-CTRLP-SESSION
			nnoremap <LEADER>sn :Session 
			nnoremap <LEADER>sl :SLoad 
			nnoremap <LEADER>sd :SDelete 
			nnoremap <LEADER>sq :SQuit<CR>
			nnoremap <LEADER>sp :CtrlPSession<CR>
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
	"EDITING
		"VIM-OPERATOR-SUBSTITUTE
			let g:operator#substitute#default_flags = "g"
			"let g:operator#substitute#default_delimiter = "#"
			"MAPPINGS
				map <Leader>r <Plug>(operator-substitute)
				map R <Plug>(operator-substitute)$
				map & <Plug>(operator-substitute-repeat)
				map g& <Plug>(operator-substitute-repeat-no-flags)
		"VIM-AFTER-OBJECT
			autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')
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
	"WRITTING
		"VIM-PENCIL
			nnoremap <Leader>vp :PencilToggle<CR>
		"VIM-AUTOCORRECT
			nnoremap <Leader>va :call AutoCorrect()<CR>
	"LOOK & FEEL
		"VIM-AIRLINE
			let g:airline_powerline_fonts = 1
			let g:airline#extensions#tabline#enabled = 1
			let g:airline_theme='powerlineish'
				"powerlineish 
				"solarized light 
				"solarized dark 
			"let g:airline#extensions#tabline#left_sep = ' '
			"let g:airline#extensions#tabline#left_alt_sep = '|'
	"SEARCH & REPLACE
		"CLEVER-F.VIM
			let g:clever_f_ignore_case=1
			let g:clever_f_smart_case=1
			"let g:clever_f_mark_char_color='cssColor66ffcc'
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
		"VIM-OVER
			nmap <LEADER>fr :OverCommandLine<CR>
	"MISCELLANOS
		"VIM-LEADER-GUIDE
			"nnoremap <SPACE> :LeaderGuide '<LEADER>'<CR>
			"nnoremap ; :LeaderGuide '<LOCALLEADER>'<CR>
			"vnoremap <SPACE> :LeaderGuideVisual '<LEADER>'<CR>
			"vnoremap ; :LeaderGuideVisual '<LOCALLEADER>'<CR>
			
			"DON'T UNCOMMENT THESE
			"nmap <SPACE>. <Plug>leaderguide-global
			"nmap ;. <Plug>leaderguide-buffer
"VIMSCRIPT CODE
	"HELPER FUNCTIONS
		function! GetWordUnderCursor()
			execute 'normal! "ayiw'
			let value = @a
			return value
		endfunction

		function! GetSelectedText()
			normal! gvy
			return @"
		endfunction
	"OPERATORS
	"TEXT OBJECTS
		"LINE
			vnoremap il :<C-u>normal! ^v$h<CR>
			onoremap il :<C-u>normal! ^v$h<CR>

			vnoremap al :<C-u>normal! Vh<CR>
			onoremap al :<C-u>normal! Vh<CR>
		"ENTIRE
			vnoremap ie :<C-u>normal! ggVG<CR>
			onoremap ie :<C-u>normal! ggVG<CR>
		"AFTER
			"TEXT OBJECT
				function! TextObjectAfter(targetChar)
					"GETTING COLUMN NUMBER OF CHARACTER AFTER THE targetChar
						execute 'normal! 0' . v:count . 'f' . a:targetChar
						let targetCharCol = virtcol('.')
						let targetCharNormCol = getpos('.')[2]
					"IF CHARACTER AFTER targetChar IS SPACE THEN SKIP OVER THE SPACE CHARACTER
						if getline('.')[targetCharNormCol] == ' '
							execute 'normal! ' . string(targetCharCol+2) . '|v$h'
						else
							execute 'normal! ' . string(targetCharCol+1) . '|v$h'
						endif
				endfunction

				function! TextObjectAfterAnyChar()
					"GETTING TARGET CHAR
						call inputsave()
						let targetChar = getchar()
						call inputrestore()
					"GETTING COLUMN NUMBER OF CHARACTER AFTER THE targetChar
						execute 'normal! 0' . v:count . 'f' . nr2char(targetChar)
						let targetCharCol = virtcol('.')
						let targetCharNormCol = getpos('.')[2]
					"IF CHARACTER AFTER targetChar IS SPACE THEN SKIP OVER THE SPACE CHARACTER
						if getline('.')[targetCharNormCol] == ' '
							execute 'normal! ' . string(targetCharCol+2) . '|v$h'
						else
							execute 'normal! ' . string(targetCharCol+1) . '|v$h'
						endif
				endfunction
			"MAPPINGS
				vnoremap <silent> a= :<C-u>call TextObjectAfter('=')<CR>
				onoremap <silent> a= :<C-u>call TextObjectAfter('=')<CR>

				vnoremap <silent> a: :<C-u>call TextObjectAfter(':')<CR>
				onoremap <silent> a: :<C-u>call TextObjectAfter(':')<CR>

				vnoremap <silent> a- :<C-u>call TextObjectAfter('-')<CR>
				onoremap <silent> a- :<C-u>call TextObjectAfter('-')<CR>

				onoremap <silent> ga :<C-u>call TextObjectAfterAnyChar()<CR>
	"BETTER VIM
	"AUTOMATIC vimrc SOURCING
		"augroup myvimrc
			"au!
			"au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,init.vim so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
		"augroup END
	"AUTOSAVE TOGGLE
		let g:autosave = 0

		function! AutoSaveToggle()
			if g:autosave == 0
				echom "AutoSave Mode Enabled"
				let g:autosave = 1

				augroup AutoSaveGroup
					autocmd!
					au InsertLeave * w
				augroup END
			elseif g:autosave == 1
				echom "AutoSave Mode Disabled"
				let g:autosave = 0

				augroup AutoSaveGroup
					autocmd!
				augroup END
			endif
		endfunction
	"SWAPFILE HANDLING @FIX
		"NOTE: IF SWAP FILE IS OLDER THEN DELETING IT OTHERWISE RECOVERING IT
		augroup SwapHandler
			autocmd!
			autocmd SwapExists * call SwapHandler(expand('<afile>:p'))
		augroup END

		function! SwapHandler(filename)
			if getftime(v:swapname) < getftime(a:filename)
				call delete(v:swapname)
				let v:swapchoice = 'e'
				"echom 'OLD SWAP FILE DELETED: SWAP DELETED'
			else
				let v:swapchoice = 'o'
				"echom 'SWAP FILE DETECTED: SWAP RECOVERED'
			endif
		endfunction
	"NEWLINE PASTE @FIX
		nnoremap [P :normal! O<Esc>]p<CR>
		nnoremap ]P :normal! o<Esc>]p<CR>
