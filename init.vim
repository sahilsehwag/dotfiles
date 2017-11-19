"VIM-PLUG
call plug#begin()
	"DEVELOPMENT
		Plug 'chiel92/vim-autoformat'
		Plug 'SirVer/ultisnips'
		Plug 'honza/vim-snippets'
		Plug 'Valloric/YouCompleteMe'
		Plug '0x84/vim-coderunner'
		Plug 'metakirby5/codi.vim'
		Plug 'vim-syntastic/syntastic'
		Plug 'scrooloose/nerdcommenter'
		Plug 'rizzatti/dash.vim'
		Plug 'mattn/emmet-vim'
		Plug 'vim-scripts/AutoComplPop'
		"Plug 'rhysd/devdocs.vim'
		"Plug 'airblade/vim-gitgutter'
		"Plug 'mhinz/vim-signify'
		"Plug 'majutsushi/tagbar'
		"Plug 'ervandew/supertab'
	"FILESYSTEM
		Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
		Plug 'junegunn/fzf.vim'
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
			Plug 'Julian/vim-textobj-variable-segment'
		Plug 'chaoren/vim-wordmotion'
		Plug 'machakann/vim-swap'
		"Plug 'terryma/vim-multiple-cursors'
		"Plug 'terryma/vim-expand-region'
	"WRITTING
		Plug 'reedes/vim-pencil'
		Plug 'panozzaj/vim-autocorrect'
		Plug 'davidbeckingsale/writegood.vim'
		"Plug 'dbmrq/vim-ditto'
		Plug 'reedes/vim-lexical'
	"SEARCHING
		Plug 'easymotion/vim-easymotion'
		Plug 'haya14busa/incsearch.vim'
		Plug 'haya14busa/incsearch-fuzzy.vim'
		Plug 'haya14busa/incsearch-easymotion.vim'
		Plug 'haya14busa/vim-easyoperator-line'
		Plug 'haya14busa/vim-easyoperator-phrase'
		Plug 'aykamko/vim-easymotion-segments'
		Plug 'bronson/vim-visual-star-search'
		"Plug 'vim-scripts/MultipleSearch'
		"Plug 'henrik/vim-indexed-search'
		Plug 'lambdalisue/lista.nvim'
		Plug 'osyo-manga/vim-hopping'
			"Plug 'haya14busa/vim-over'
		"Plug 'osyo-manga/vim-anzu'
	"LOOK&FEEL
		Plug 'vim-airline/vim-airline'
		Plug 'vim-airline/vim-airline-themes'
		Plug 'edkolev/tmuxline.vim'
		Plug 'edkolev/promptline.vim'
		Plug 'bling/vim-bufferline'
		Plug 'flazz/vim-colorschemes'
		Plug 'rafi/awesome-vim-colorschemes'
		Plug 'chriskempson/base16-vim'
		Plug 'ryanoasis/vim-devicons'
		Plug 'itchyny/vim-highlighturl'
		Plug 'gcavallanti/vim-noscrollbar'
		Plug 'KeitaNakamura/neodark.vim'
		Plug 'sindresorhus/focus'
		Plug 'KabbAmine/yowish.vim'
		Plug 'ayu-theme/ayu-vim'
		Plug 'tyrannicaltoucan/vim-quantum'
		Plug 'raphamorim/lucario'
		Plug 'paranoida/vim-airlineish'
		"Plug 'zefei/vim-colortuner'
		"Plug 'itchyny/lightline.vim'
		"Plug 'augustold/vim-airline-colornum'
		"Plug 'Yggdroot/indentLine'
	"EXTENDING VIM
		"Plug 'vim-scripts/repmo.vim'
		Plug 'tpope/vim-eunuch'
		Plug 'dohsimpson/vim-macroeditor'
		"Plug 'vimlab/split-term.vim'
		Plug 'zirrostig/vim-schlepp'
		Plug 'kana/vim-submode'
		Plug 'vim-scripts/vim-easy-submode'
		Plug 'szw/vim-maximizer'
		Plug 'tpope/vim-repeat'
		Plug 'kshenoy/vim-signature'
		Plug 'joeytwiddle/sexy_scroller.vim'
			"Plug 'terryma/vim-smooth-scroll'
		Plug 'inside/vim-search-pulse'
		Plug 'pseewald/vim-anyfold'
		Plug 'arecarn/vim-fold-cycle'
		Plug 'rhysd/clever-f.vim'
		Plug 'okcompute/vim-ctrlp-session'
		Plug 'jiangmiao/auto-pairs'
		Plug 'haya14busa/vim-operator-flashy'
		"Plug 'reedes/vim-wheel'
		"Plug 'tpope/vim-speeddating'
		"Plug 'severin-lemaignan/vim-minimap'
	"LANGUAGES
		"LINTERS
		"BEAUTIFIERS
		"AUTOCOMPILATION
			Plug 'coachshea/jade-vim'
		"AUTOCOMPLETION
			"Plug 'dNitro/vim-pug-complete'
		"SYNTAX
			Plug 'plasticboy/vim-markdown'
			Plug 'digitaltoad/vim-pug'
			Plug 'chrisbra/csv.vim'
			"Plug 'lervag/vimtex'
				"Plug 'vim-latex/vim-latex'
	"MISCELLANOUS
		Plug 'alpertuna/vim-header'
		Plug 'sbdchd/vim-shebang'
		Plug 'vim-utils/vim-read'
		Plug 'antoyo/vim-licenses'
		Plug 'vim-scripts/WholeLineColor'
		Plug 'tyru/open-browser.vim'
		Plug 'junegunn/goyo.vim'
		Plug 'junegunn/limelight.vim'
		Plug 'mtth/scratch.vim'
		Plug 'mhinz/vim-startify'
		Plug 'suan/vim-instant-markdown'
		Plug 'tpope/vim-capslock'
		"Plug 'natw/keyboard_cat.vim'
		Plug 'MrPeterLee/VimWordpress'
			"Plug 'vim-scripts/blogit.vim'
			"Plug 'PotHix/Vimpress'
			"Plug 'vim-scripts/VimRepress'
			"Plug 'vim-scripts/Vimpress'
		"Plug 'vim-scripts/autoscroll.vim'
		"Plug 'fadein/vim-FIGlet'
		"Plug 'chrisbra/changesPlugin'
		"Plug 'guns/xterm-color-table.vim'
		"Plug 'vim-scripts/ScrollColors'
		"Plug 'vim-scripts/DrawIt'
		"Plug 'gorodinskiy/vim-coloresque'
		"Plug 'hecal3/vim-leader-guide'
	"LIBRARIES|UTILITIES
		Plug 'kana/vim-textobj-user'
		Plug 'kana/vim-operator-user'
		Plug 'mattn/webapi-vim'
call plug#end()


"PREFERENCES
	"INDENTATION
		set autoindent
		set shiftwidth=4
		set tabstop=4
		set noexpandtab
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
		set noshowcmd
		set noruler
		set noshowmode
		set cursorline
		set splitbelow
		set nocompatible
		set fillchars=fold:\ ,
		set mouse=a
		set nowrap
		set hidden
		colorscheme Monokai
		set clipboard=unnamed
"CONFIGURATION
	"PYTHON BINARIES
		let g:python_host_prog = 'python2'
		let g:python3_host_prog = 'python3'
		"let g:loaded_python3_provider=1
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
		"BETTER o|O @TODO
			"NORMAL MODE OPENER
				"nnoremap <CR> :normal! o<ESC>
		"BETTER PASTES
			"PASTE SWAP @FIX
				nnoremap p :normal! ]p <CR>
				nnoremap P :normal! [p <CR>
				nnoremap ]p :normal! p <CR>
				nnoremap [p :normal! P <CR>
				"vnoremap p :<C-u>normal! ]pgvd <CR>
				"vnoremap P :<C-u>normal! [pgvd <CR>
				"vnoremap ]p :<C-u>normal! pgvd <CR>
				"vnoremap [p :<C-u>normal! Pgvd <CR>
			"FORMATTED PASTE + <<|>> @FIX
				nnoremap >p :normal! ]p>> <CR>
				nnoremap <p :normal! ]p<< <CR>
				nnoremap >P :normal! [p>> <CR>
				nnoremap <P :normal! [p<< <CR>
			"NEWLINE PASTE + ==
				nnoremap ]P :normal! o<esc>p==
				nnoremap [P :normal! O<Esc>P==
	"LEADER MAPPING
		let mapleader = " "
		let maplocalleader = ","
		nnoremap ; :
	"COMMAND MAPPINGS
		"TAB MAPPINGS
			nnoremap <LEADER>ta :tabnew<CR>
			nnoremap <LEADER>tc :tabclose<CR>
			nnoremap <LEADER>tn :tabnext<CR>
			nnoremap <LEADER>tp :tabprevious<CR>
			nnoremap <LEADER>th :tabmove -<CR>
			nnoremap <LEADER>tl :tabmove +<CR>
		"BUFFER MAPPINGS
			nnoremap H           :bprevious<CR>
			nnoremap L           :bnext<CR>
			nnoremap <LEADER>bn  :enew<CR>
			nnoremap <LEADER>ba  :badd<space>
			nnoremap <LEADER>bd  :bdelete<CR>
			nnoremap <LEADER>bfd :bdelete!<CR>
			nnoremap <LEADER>bl  :bnext<CR>
			nnoremap <LEADER>bh  :bprevious<CR>
			nnoremap <LEADER>br  :e<CR>
			nnoremap <LEADER>bfr :e!<CR>
			nnoremap <Leader>bv  :view<CR>
			nnoremap <Leader>bfv :view!<CR>
			nnoremap <LEADER>bw  :write<CR>
			nnoremap <LEADER>bfw :write!<CR>
			nnoremap <Leader>bc  :bp<bar>sp<bar>bn<bar>bd<CR>
		"WINDOW MAPPINGS
			nnoremap <Leader>wh :sp<CR>
			nnoremap <Leader>wv :vsp<CR>
			nnoremap <Leader>wo :only<CR>
			nnoremap <Leader>wc :close<CR>
			nnoremap <Leader>wn :vnew<CR>
			nnoremap <Leader>wN :new<CR>

			nnoremap <C-J> <C-W><C-J>
			nnoremap <C-K> <C-W><C-K>
			nnoremap <C-L> <C-W><C-L>
			nnoremap <C-H> <C-W><C-H>
	"VIM MAPPINGS
		nnoremap <LEADER>vc  : edit ~/.config/nvim/init.vim<CR>
		nnoremap <LEADER>vs  : source ~/.config/nvim/init.vim<CR>
		nnoremap <LEADER>vt  : terminal<CR>
		nnoremap <Leader>vi  : PlugInstall<CR>
		nnoremap <Leader>vu  : PlugClean<CR>
		nnoremap <Leader>vw  : call AutoSaveToggle()<CR>
		nnoremap <LEADER>vq  : q<CR>
		nnoremap <LEADER>vfq : q!<CR>

		nnoremap <Leader>va  : call AutoCorrect()<CR>
		nnoremap <Leader>vp  : PencilToggle<CR>
		nnoremap <Leader>vd  : Goyo<CR>
		nnoremap <Leader>vl  : Limelight!!<CR>
		nnoremap <Leader>vf  : Autoformat<CR>
		vnoremap <Leader>vf  : Autoformat<CR>
		nnoremap <Leader>vF  : call AutoFormatToggle()<CR>
		nnoremap <LEADER>vS  : Startify<CR>
	"FILETYPE MAPPINGS
		"TEXT
		"PUG
			"FUNCTIONS
				function! Pug(range)
					call RunNpmCommand('pug', '-P', a:range, 'pug-cli')
				endfunction
			"MAPPINGS
				augroup PUG
					au!
					au FileType jade,pug map <buffer> <LocalLeader>cw : JadeWatch html vertical<CR>
					au FileType jade,pug nmap <buffer> <LocalLeader>cc : <C-u> call Pug('')<CR>
					au FileType jade,pug vmap <buffer> <LocalLeader>cc : <C-u> call Pug("'<,'>")<CR>
					au FileType jade,pug nmap <buffer> <LocalLeader>cb : <C-u> call Pug('%')<CR>
				augroup END
		"HTML
			"FUNCTIONS
				function! Html2Pug(range)
					call RunNpmCommand('html2pug', '-f', a:range, 'html2pug')
				endfunction
			"MAPPINGS
				augroup HTML
					au!
					au FileType html nmap <buffer> <LocalLeader>cj :call Html2Pug('%')<CR>
					au FileType html vmap <buffer> <LocalLeader>cj :call Html2Pug("'<,'>")<CR>
				augroup END
		"CSS
		"PYTHON
		"C++/C
		"JAVA
		"XML
			augroup XML
				au!
				au FileType xml nmap <buffer> <LocalLeader>cj :call RunNpmCommand('x2j', '', '%', 'x2j-cli')<CR>
				au FileType xml vmap <buffer> <LocalLeader>cj :call RunNpmCommand('x2j', '', "'<,'>", 'x2j-cli')<CR>
			augroup END
		"JAVASCRIPT
		"MARKDOWN
			augroup MARKDOWN
				au!
				au FileType markdown nmap <buffer> <LocalLeader>ch :call RunNpmCommand('', "%", 'gh-markdown-cli')<CR>
				au FileType markdown vmap <buffer> <LocalLeader>ch :call RunNpmCommand('mdown', '', "'<,'>", 'gh-markdown-cli')<CR>
			augroup END
		"WORDPRESS
			augroup WORDPRESS
				au!
				au BufEnter wordpress set filetype=jade
				au BufEnter wordpress map <buffer> <LocalLeader>ch :<C-u>call Pug('12,$')<CR>
				au BufEnter wordpress map <buffer> <LocalLeader>cj :<C-u>call Html2Pug('12,$')<CR>
			augroup END
	"INSERT MAPPINGS
		"ABBREVIATIONS @TODO
			abbreviate chk ✓
			abbreviate crs ✖
	"OTHER MAPPINGS
		"TEXT
		"UNIX|LINUX WRAPPERS
			"FILESYSTEM
				nnoremap <silent> <Leader>ld :execute "DeleteFile " . glob('%')<CR>
			"FZF
				nnoremap <Leader>lnf : call fzf#run(fzf#wrap({'source': 'find ~ -type d', 'sink': 'NewFile'          }))<CR>
				nnoremap <Leader>lnd : call fzf#run(fzf#wrap({'source': 'find ~ -type d', 'sink': 'NewDirectory'     }))<CR>
				nnoremap <Leader>ldf : call fzf#run(fzf#wrap({'source': 'find ~ -type f', 'sink': 'DeleteFile'       }))<CR>
				nnoremap <Leader>ldd : call fzf#run(fzf#wrap({'source': 'find ~ -type d', 'sink': 'DeleteDirectory'  }))<CR>
				nnoremap <Leader>ldD : call fzf#run(fzf#wrap({'source': 'find ~ -type d', 'sink': 'DeleteDirectory!' }))<CR>
			"UTILITIES
				vnoremap <Leader>lus :sort                         <CR>
				vnoremap <Leader>luu :<C-u>'<,'>sort \| '<,'>!uniq <CR>
				vnoremap <Leader>luc :<C-u>'<,'>!bc                <CR>
		"FIND & REPLACE
			"REPLACE CHARACTER @TODO
	"MISCELLANOUS MAPPINGS
		"QUICK EXIT MAPPINGS
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
			"CONFIGURATION
				let g:fzf_action = {
					\ 'ctrl-t': 'tab split',
					\ 'ctrl-h': 'split',
					\ 'ctrl-v': 'vsplit',
					\ 'ctrl-a': 'badd',
					\ 'ctrl-r': 'Read',
					\ 'ctrl-p': 'view',
					\ }
			"COMMANDS
			"MAPPINGS
				"INBUILT
					nnoremap <LEADER>n/ :History/<CR>
					nnoremap <LEADER>nb :Buffers<CR>
					nnoremap <LEADER>nB :TagbarToggle<CR>
					nnoremap <LEADER>ng :Ag<CR>
					nnoremap <LEADER>nh :History<CR>
					nnoremap <LEADER>nH :History:<CR>
					nnoremap <LEADER>nk :Helptags<CR>
					nnoremap <LEADER>nl :Lines<CR>
					nnoremap <LEADER>nL :BLines<CR>
					nnoremap <LEADER>nn :Files<CR>
					nnoremap <LEADER>nN :FZF %:p:h<CR>
					nnoremap <LEADER>nt :Tags<CR>
					nnoremap <LEADER>nT :BTags<CR>

					nnoremap <Leader>nc :Colors<CR>
					nnoremap <Leader>nC :Commands<CR>
					nnoremap <Leader>nF :Filetypes<CR>
					nnoremap <Leader>nS :Snippets<CR>
					nnoremap <Leader>nm :Maps<CR>
				"FREQUENT
					nnoremap <LEADER>nd : Files ~/Google Drive<CR>
					nnoremap <LEADER>nu : Files ~<CR>
					nnoremap M          : History<CR>
				"FILESYSTEM
					nnoremap <Leader>nf  : call fzf#run(fzf#wrap({'source': 'find ~ -type d',                    'sink': 'VifmToggle' }))<CR>
					nnoremap <Leader>nw  : call fzf#run(fzf#wrap({'source': 'find ~ -type d',                    'sink': 'SaveAs'     }))<CR>
					nnoremap <Leader>nW  : call fzf#run(fzf#wrap({'source': 'find ~ -type d',                    'sink': 'SaveAs!'    }))<CR>
					nnoremap <Leader>nr  : call fzf#run(fzf#wrap({'source': 'ag --hidden --ignore .git -g "" ~', 'sink': 'Read!'      }))<CR>
				"COMPLETION
		"VIFM
			nnoremap <LEADER>nf :VifmToggle %:p:h<CR>
			nnoremap <LEADER>nF :VifmToggle .<CR>
	"DEVELOPMENT
		"FUGUTIVE
			nnoremap <Leader>gc :Commits<CR>
			nnoremap <Leader>gC :BCommits<CR>
			nnoremap <Leader>gf :GFiles<CR>
			nnoremap <Leader>gF :GFiles?<CR>

			nnoremap <Leader>gb :Gbrowser<CR>
		"UTIL-SNIPS
			let g:UltiSnipsExpandTrigger="<CR>"
			let g:UltiSnipsJumpForwardTrigger="<C-b>"
			let g:UltiSnipsJumpBackwardTrigger="<C-z>"
		"AUTOCOMPLPOP
			let g:acp_enableAtStartup = 0

			augroup AutoComplPop
				autocmd!
				autocmd BufEnter *.txt :AcpEnable
				autocmd BufLeave *.txt :AcpDisable
			augroup END
		"AUTOFORMAT
			let g:formatterpath = ['/usr/local/bin/autopep8']
		"YOUCOMPLETEME
			"CONFIGURATION
                let g:ycm_python_binary_path = 'python3'
                let g:ycm_add_preview_to_completeopt = 0

                "let g:ycm_key_list_select_completion = ['<SPACE>', '<Down>']
                "let g:ycm_key_list_previous_completion = ['<S-SPACE>', '<Up>']
                "let g:ycm_key_list_stop_completion = ['<CR>']

                "let g:ycm_autoclose_preview_window_after_completion = 1
                "let g:ycm_autoclose_preview_window_after_insertion = 1
                "set splitbelow
			"MAPPINGS
				nnoremap <Leader>jd :YcmCompleter GoToDeclaration<CR>
				nnoremap <Leader>jD :YcmCompleter GoToDefinition<CR>
				nnoremap <Leader>jj :YcmCompleter GoTo<CR>
				nnoremap <Leader>ji :YcmCompleter GoToImplementation<CR>
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
		"REPMO
			let repmo_key = ";"
			let repmo_revkey = ","
		"MACRO-EDITOR
			nnoremap <Leader>zm :execute "MacroEdit " nr2char(getchar()) <CR>
		"AUTOCOMPLPOP
			let g:acp_enableAtStartup = 0

			augroup AutoComplPop
				autocmd!
				autocmd BufEnter *.txt :AcpEnable
				autocmd BufLeave *.txt :AcpDisable
			augroup END
		"VIM-WHEEL
			let g:wheel#map#up   = '<D-k>'
			let g:wheel#map#down = '<D-j>'
			let g:wheel#map#mouse = 1
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
			let g:SexyScroller_MaxTime = 200
			let g:SexyScroller_EasingStyle = 1
		"VIM-SESSION
			let g:session_autosave = 'yes'
			let g:session_autoload = 'yes'
			let g:session_default_name = 'default'
			let g:session_default_to_last = 'yes'
		"VIM-CTRLP-SESSION
			nnoremap <LEADER>sn :Session<space>
			nnoremap <LEADER>sl :SLoad<space>
			nnoremap <LEADER>sd :SDelete<space>
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
			Submode n h :bnext<CR>
			Submode n l :bprevious<CR>
			SubmodeDefineEnd

			SubmodeDefine tabs
			Submode n <enter> <Leader>t. :tabnext<CR>
			Submode n n :tabnext<CR>
			Submode n p :tabprevious<CR>
			Submode n h :tabmove +1<CR>
			Submode n l :tabmove -1<CR>
			SubmodeDefineEnd


			SubmodeDefine windows
			Submode n <enter> <Leader>w. <C-W><C-L>
			Submode n h <C-W><C-H>
			Submode n j <C-W><C-J>
			Submode n k <C-W><C-K>
			Submode n l <C-W><C-L>

			Submode n <S-h> <C-W><S-H>
			Submode n <S-j> <C-W><S-J>
			Submode n <S-k> <C-W><S-K>
			Submode n <S-l> <C-W><S-L>

			Submode n r <C-W><C-R>
			Submode n R <C-W><S-R>
			SubmodeDefineEnd
		"VIM-NOSCROLLBAR
			function! Noscrollbar(...)
				let w:airline_section_z = '%{noscrollbar#statusline(20," ", "█")}'
				"let w:airline_section_z = '%{noscrollbar#statusline(20," ", "▌")}'
				"let w:airline_section_z = '%{noscrollbar#statusline(20," ", "▐")}'
			endfunction
			call airline#add_statusline_func('Noscrollbar')
	"EDITING
		"VIM-OPERATOR-SUBSTITUTE
			let g:operator#substitute#default_flags     = "g"
			let g:operator#substitute#default_delimiter = ";"
			"MAPPINGS
				map gr <Plug>(operator-substitute)
				map &  <Plug>(operator-substitute-repeat)
				map g& <Plug>(operator-substitute-repeat-no-flags)
				map gR <Plug>(operator-substitute)$
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
		"VIM-EASYHOPERATOR-PHRASE
			omap gp  <Plug>(easyoperator-phrase-select)
			xmap gp  <Plug>(easyoperator-phrase-select)
		"VIM-EASYOPERATOR-LINE
			omap gp  <Plug>(easyoperator-line-select)
			xmap gp  <Plug>(easyoperator-line-select)
	"WRITTING
		"VIM-PENCIL
			nnoremap <Leader>vp :PencilToggle<CR>
		"VIM-AUTOCORRECT
			nnoremap <Leader>va :call AutoCorrect()<CR>
		"LEXICAL
			nnoremap <Leader><Leader>s :set spell!<CR>
			let g:lexical#spell = 1
			let g:lexical#spell_key = '<leader>zs'
			let g:lexical#spelllang = ['en_us', 'en_ca',]
			"let g:lexical#dictionary = ['/usr/share/dict/words',]
			let g:lexical#thesaurus = ['~/.config/nvim/spell/mthesaurus.txt/',]
			let g:lexical#spellfile = ['~/.config/spell/en.utf-8.add',]
	"LOOK & FEEL
		"VIM-AIRLINE
			"CONFIGURATION
				let g:airline_powerline_fonts = 1
				let g:airline_theme           = 'powerlineish'
			"BUFFERLINE
				"let g:airline#extensions#bufferline#enabled = 1
				"let g:airline#extensions#bufferline#overwrite_variables = 1
			"TABLINE
				let g:airline#extensions#tabline#enabled = 1
				"let g:airline#extensions#tabline#left_sep = ' '
				"let g:airline#extensions#tabline#left_alt_sep = '|'
				"let g:airline#extensions#tabline#right_sep = ' '
				"let g:airline#extensions#tabline#right_alt_sep = '|'
				"let g:airline#extensions#tabline#show_splits = 1
				"let g:airline#extensions#tabline#show_close_button = 1
				"let g:airline#extensions#tabline#close_symbol = '✖ '
			"TMUXLINE
				"let airline#extensions#tmuxline#color_template = 'normal'
				"let airline#extensions#tmuxline#color_template = 'insert'
				"let airline#extensions#tmuxline#color_template = 'visual'
				"let airline#extensions#tmuxline#color_template = 'replace'
			"CUSTOMIZATION
				let g:airline#extensions#default#layout = [
					\ [ 'a', 'b', 'c' ],
					\ [ 'x', 'y', 'z', 'error', 'warning']
					\ ]
				let g:airline#extensions#default#section_truncate_width = {
					\ 'b': 79,
					\ 'x': 60,
					\ 'y': 88,
					\ 'z': 45,
					\ 'warning': 80,
					\ 'error': 80,
					\ }
				let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
			"EXTRAS
				let g:airline#extensions#wordcount#enabled = 0
				"let g:airline#extensions#wordcount#filetypes = []
				"let g:airline#extensions#whitespace#enabled = 1
				"let g:airline#extensions#whitespace#mixed_indent_algo = 0
				"let g:airline#extensions#whitespace#symbol = '!'
				"let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing', 'long', 'mixed-indent-file' ]
				"let g:airline#extensions#whitespace#trailing_format = 'trailing[%s]'
				"let g:airline#extensions#whitespace#mixed_indent_format = 'mixed-indent[%s]'
				"let g:airline#extensions#whitespace#long_format = 'long[%s]'
				"let g:airline#extensions#whitespace#mixed_indent_file_format = 'mix-indent-file[%s]'
				"let g:airline#extensions#whitespace#trailing_regexp = '\s$'
		"VIM-BUFFERLINE
			let g:bufferline_echo = 0
			"let g:bufferline_active_buffer_left = '['
			"let g:bufferline_active_buffer_right = ']'
			"let g:bufferline_modified = '+'
			"let g:bufferline_rotate = 0
			let g:bufferline_show_bufnr = 0
			"let g:bufferline_fname_mod = ':t'
			"let g:bufferline_inactive_highlight = 'StatusLineNC'
			"let g:bufferline_solo_highlight = 0
			"let g:bufferline_pathshorten = 0
		"NEODARK.VIM
			let g:neodark#use_256color         = 1
			let g:neodark#solid_vertsplit      = 1
			let g:neodark#background           = '#202020'
			"let g:lightline                    = {}
			"let g:lightline.colorscheme        = 'neodark'
			"let g:neodark#terminal_transparent = 1
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
		"INCSEARCH-EASYMOTION-FUZZY
			function! s:config_easyfuzzymotion(...) abort
				return extend(copy({
					\   'converters': [incsearch#config#fuzzy#converter()],
					\   'modules': [incsearch#config#easymotion#module()],
					\   'keymap': {"\<CR>": '<Over>(easymotion)'},
					\   'is_expr': 0,
					\   'is_stay': 1
					\ }), get(a:, 1, {}))
			endfunction

			noremap <silent><expr> <Leader>fg/ incsearch#go(<SID>config_easyfuzzymotion())
		"VIM-OVER
			nmap <LEADER>fr :OverCommandLine<CR>
		"LISTA
			nmap <Leader>ff :Lista<CR>
			nmap <Leader>fF :ListaCursorWord<CR>
		"VIM-HOPPING
			nmap <Leader>fr :HoppingStart<CR>
		"VIM-ANZU
			"nmap n <Plug>(incsearch-nohl-n)<Plug>(anzu-mode-n)
			"nmap N <Plug>(incsearch-nohl-N)<Plug>(anzu-mode-N)
			"nmap * <Plug>(anzu-star-with-echo)
			"nmap # <Plug>(anzu-sharp-with-echo)
	"MISCELLANOUS
		"GOYO
			let g:goyo_width = "75%"
			"let g:goyo_height = "90%"
			let g:goyo_linenr = 1
		"WHOLELINECOLOR
			let g:wholelinecolor_leader = ','
			highlight WLCBlackBackground  ctermbg=233 guibg=#121212
			highlight WLCRedBackground    ctermbg=52  guibg=#882323
			highlight WLCBlueBackground   ctermbg=17  guibg=#003366
			highlight WLCPurpleBackground ctermbg=53  guibg=#732c7b
			highlight WLCGreyBackground   ctermbg=238 guibg=#464646
			highlight WLCGreenBackground  ctermbg=22  guibg=#005500
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
			"CONFIGURATION
				let g:netrw_nogx = 1
				let g:openbrowser_search_engines = {
					\ 'askubuntu': 'http://askubuntu.com/search?q={query}',
					\ 'duckduckgo': 'http://duckduckgo.com/?q={query}',
					\ 'github': 'http://github.com/search?q={query}',
					\ 'google': 'http://google.com/search?q={query}',
					\ 'vim': 'http://www.google.com/cse?cx=partner-pub-3005259998294962%3Abvyni59kjr1&ie=ISO-8859-1&q={query}&sa=Search&siteurl=www.vim.org%2F#gsc.tab=0&gsc.q={query}&gsc.page=1',
					\ 'flipkart': 'https://www.flipkart.com/search?q={query}&otracker=start&as-show=off&as=off',
					\ 'wikipedia': 'http://en.wikipedia.org/wiki/{query}',
					\ 'wikivoyage': 'https://en.wikivoyage.org/wiki/{query}',
					\ 'wiktionary': 'https://en.wiktionary.org/wiki/{query}',
					\ 'wikinews': 'https://en.wikinews.org/wiki/{query}',
					\ 'wikisource': 'https://en.wikisource.org/wiki/{query}',
					\ 'wikibooks': 'https://en.wikibooks.org/wiki/{query}',
					\ 'wikidata': 'https://en.wikidata.org/wiki/{query}',
					\ 'wikispecies': 'https://species.wikimedia.org/wiki/{query}',
					\ 'wikiquote': 'https://en.wikiquote.org/wiki/{query}',
				\ }
			"SMART SEARCH
				nmap <Leader>fo <Plug>(openbrowser-smart-search)
				vmap <Leader>fo <Plug>(openbrowser-smart-search)
			"SEARCH WORD UNDER CURSOR
				nmap <Leader>fs <Plug>(openbrowser-search)
				vmap <Leader>fs <Plug>(openbrowser-search)
			"OPEN URI UNDER CURSOR
				nmap <Leader>fl <Plug>(openbrowser-open)
				vmap <Leader>fl <Plug>(openbrowser-open)
				nmap <Leader>fL :call ConvertAndOpenUnderCursor()

				function! ConvertAndOpenUnderCursor()
					let l:word = GetWORDUnderCursor()
					let l:word = 'https://' . l:word
					execute 'OpenBrowser ' . l:word
				endfunction
			"CUSTOM MAPPINGS
				"GITHUB
					nmap <Leader>fgg :execute ":OpenBrowserSearch -github " GetWordUnderCursor() <CR>
					vmap <Leader>fgg :<C-w>execute ":OpenBrowserSearch -github " GetSelectedText() <CR>
				"DUCKDUCKGO
					nmap <Leader>fgd :execute ":OpenBrowserSearch -duckduckgo " GetWordUnderCursor() <CR>
					vmap <Leader>fgd :<C-w>execute ":OpenBrowserSearch -duckduckgo " GetSelectedText() <CR>
				"FLIPKART
					nmap <Leader>fgf :execute ":OpenBrowserSearch -flipkart " GetWordUnderCursor() <CR>
					vmap <Leader>fgf :<C-w>execute ":OpenBrowserSearch -flipkart " GetSelectedText() <CR>
				"WIKIPEDIA
					nmap <Leader>fww :execute ":OpenBrowserSearch -wikipedia " GetWordUnderCursor() <CR>
					vmap <Leader>fww :<C-w>execute ":OpenBrowserSearch -wikipedia " GetSelectedText() <CR>

					nmap <Leader>fwd :execute ":OpenBrowserSearch -wiktionary " GetWordUnderCursor() <CR>
					vmap <Leader>fwd :<C-w>execute ":OpenBrowserSearch -wiktionary " GetSelectedText() <CR>

					nmap <Leader>fwv :execute ":OpenBrowserSearch -wikivoyage " GetWordUnderCursor() <CR>
					vmap <Leader>fwv :<C-w>execute ":OpenBrowserSearch -wikivoyage " GetSelectedText() <CR>

					nmap <Leader>fwn :execute ":OpenBrowserSearch -wikinews " GetWordUnderCursor() <CR>
					vmap <Leader>fwn :<C-w>execute ":OpenBrowserSearch -wikinwes " GetSelectedText() <CR>

					nmap <Leader>fws :execute ":OpenBrowserSearch -wikisource " GetWordUnderCursor() <CR>
					vmap <Leader>fws :<C-w>execute ":OpenBrowserSearch -wikisource " GetSelectedText() <CR>

					nmap <Leader>fwb :execute ":OpenBrowserSearch -wikibooks " GetWordUnderCursor() <CR>
					vmap <Leader>fwb :<C-w>execute ":OpenBrowserSearch -wikibooks " GetSelectedText() <CR>

					nmap <Leader>fwD :execute ":OpenBrowserSearch -wikidata " GetWordUnderCursor() <CR>
					vmap <Leader>fwD :<C-w>execute ":OpenBrowserSearch -wikidata " GetSelectedText() <CR>

					nmap <Leader>fwS :execute ":OpenBrowserSearch -wikispecies " GetWordUnderCursor() <CR>
					vmap <Leader>fwS :<C-w>execute ":OpenBrowserSearch -wikispecies " GetSelectedText() <CR>

					nmap <Leader>fwq :execute ":OpenBrowserSearch -wikiquote " GetWordUnderCursor() <CR>
					vmap <Leader>fwq :<C-w>execute ":OpenBrowserSearch -wikiquote " GetSelectedText() <CR>
		"VIM-WORDPRESS
			nnoremap <LocalLeader>wl :call RunInNewBuffer('BlogList', 'wordpress')<CR>
			nnoremap <LocalLeader>wn :call RunInNewBuffer('BlogNew',  'wordpress')<CR>
			nnoremap <LocalLeader>wd :BlogSave draft<CR>
			nnoremap <LocalLeader>wP :BlogSave publish<CR>
			nnoremap <LocalLeader>wD :BlogPreview draft<CR>
			nnoremap <LocalLeader>wp :BlogPreview publish<CR>
			nnoremap <LocalLeader>wc :BlogCode python<CR>
			nnoremap <LocalLeader>wu :BlogUpload<space><CR>
		"AUTOSCROLL
			let g:AutoScrollSpeed = 100
		"VIM-FIGLET
			nnoremap <Leader>zf :FIGlet<CR>
			nnoremap <Leader>zF :FIGlet -f<space>
			vnoremap <Leader>zf :FIGlet<CR>
			vnoremap <Leader>zF :FIGlet -f<space>
		"VIM-HIGHLIGHTURL
			let g:highlighturl_ctermfg = ''
			let g:highlighturl_guifg = ''
			let g:highlighturl_underline = 0
		"VIM-LEADER-GUIDE
			"nnoremap <SPACE> :LeaderGuide '<LEADER>'<CR>
			"nnoremap ; :LeaderGuide '<LOCALLEADER>'<CR>
			"vnoremap <SPACE> :LeaderGuideVisual '<LEADER>'<CR>
			"vnoremap ; :LeaderGuideVisual '<LOCALLEADER>'<CR>

			"DON'T UNCOMMENT THESE
			"nmap <SPACE>. <Plug>leaderguide-global
			"nmap ;. <Plug>leaderguide-buffer
		"VIM-HEADER
			let g:header_auto_add_header = 0
			"let g:header_alignment = 1
			let g:header_field_filename = 0
			let g:header_field_modified_by = 0
			let g:header_field_author = 'Sahil Sehwag'
			let g:header_field_author_email = 'sehwagsahil002@gmail.com'

			map <Leader>zh :AddHeader<CR>
			map <Leader>zH :AddMinHeader<CR>
			map <Leader>zlm :AddMITLicense<CR>
			map <Leader>zla :AddApacheLicense<CR>
			map <Leader>zlg :AddGNULicense<CR>
"VIMSCRIPT CODE
	"HELPERS
		"EXTERNAL
			"PACKAGE MANAGERS
				function! InstallPackage(pacman, package, flags)
					if executable(a:pacman) == 1
						execute '!' a:pacman ' install ' a:flags ' ' a:package
					else
						echom a:pacman ' NOT INSTALLED'
					endif
				endfunction

				function! RunCommand(cmd, flags, range, pacman, package, installFlags)
					if executable(a:cmd) == 0
						echom "INSTALLING " a:cmd " USING " a:pacman "..."
						call InstallPackage(a:pacman, a:package, a:installFlags)
					else
						execute a:range '!' a:cmd ' ' a:flags
					endif
				endfunction

				function! RunNpmCommand(cmd, flags, range, package)
					call RunCommand(a:cmd, a:flags, a:range, 'npm', a:package, '-g')
				endfunction

				function! RunPipCommand(cmd, flags, range, package)
					call RunCommand(a:cmd, a:flags, a:range, 'pip', a:package, '')
				endfunction
			"UNIX|LINUX
				"COMMANDS
					command! -nargs=1		NewFile         : call NewFile         (<q-args>)
					command! -nargs=1		NewDirectory    : call NewDiretory     (<q-args>)
					command! -nargs=1 -bang DeleteDirectory : call DeleteDirectory (<q-args>, <bang>0)
					command! -nargs=1		DeleteFile      : call DeleteFile	   (<q-args>)
				"FUNCTIONS
					function! NewFile(path)
						let l:filename = input('Enter New Filename: ')
						let l:file = a:path . '/' . l:filename

						if empty(l:filename)
							call Pechoerr('No Filename Specified')
						else
							execute "e " . l:file
						endif
					endfunction

					function! NewDirectory(path)
						let l:dirname = input('Enter New Directory Name: ')
						let l:dir = a:path . '/' . l:dirname

						if empty(l:dirname)
							call Pechoerr('No Directory Name Specified')
						else
							execute "!mkdir " . l:dir
						endif
					endfunction

					function! DeleteDirectory(path, bang)
						if !empty(a:path)
							if bang == 0
								execute "!rmdir " . a:path
							else
								execute "!rm -rf " . a:path
							endif
						endif
					endfunction

					function! DeleteFile(file)
						execute "bdelete!"
						silent execute "!rm " . a:file | redraw!
						call Pechoerr("File " . a:file ." Deleted Successfully")
					endfunction
		"VIM
			"FILESYSTEM
				"COMMANDS
					command! -nargs=1 -bang SaveAs  : call SaveAs  (<q-args>, <bang>0)
					command! -nargs=1 -bang Read    : call Read    (<q-args>, <bang>0)
				"FUNCTIONS
					function! SaveAs(path, bang)
						let l:filename = input('Enter New Filename: ')
						let l:file = a:path . '/' . l:filename

						if empty(l:filename)
							call Pechoerr('No Filename Specified')
						elseif a:bang == 0
							if empty(glob(l:file))
								execute "w " . a:path ."/" . l:filename
							else
								call Pechoerr('File Already Exists')
							endif
						else
							execute "w! " . a:path ."/" . l:filename
						endif
					endfunction

					function! Read(file, bang)
						if empty(a:file)
							call Pechoerr('No File Specified')
						elseif empty(glob(a:file))
							call Pechoerr("File Doesn't Exists")
						else
							if a:bang == 0
								execute "read " . a:file
							else
								normal die
								execute "0read " . a:file
							endif
						endif
					endfunction
			"TEXT
				function! GetWordUnderCursor()
					execute 'normal! "ayiw'
					let value = @a
					return value
				endfunction

				function! GetWORDUnderCursor()
					execute 'normal! "ayiW'
					let value = @a
					return value
				endfunction

				function! GetSelectedText()
					normal! gvy
					return @"
				endfunction

				function! StripTrailingWhitespace()
					execute ':%s/\s\+$//e'
					execute ':%s/\t\+$//e'
				endfunction
			"INTERFACE
				function! RunInNewBuffer(command, filename)
					execute "edit! " a:filename
					execute a:command
				endfunction
			"META
				function! Pechoerr(msg)
					echohl ErrorMsg
					echom a:msg
					call getchar()
					echohl None
				endfunction

				function! PEchoSuccess(msg)
					echohl MoreMsg
					echom a:msg
					call getchar()
					echohl None
				endfunction

				function! PEchoWarning(msg)
					echohl WildMenu
					echom "WARNING: " . a:msg
					call getchar()
					echohl None
				endfunction

				function! PEchoInfo(msg)
					echohl StorageClass
					echom "INFO: " . a:msg
					call getchar()
					echohl None
				endfunction

				function! Prompt(msg)
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
		"AT @TODO
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
		"BEFORE @TODO
		"LANGUAGES @TODO
			"PYTHON
			"CLANG
	"TOGGLES
		"AUTOSAVE
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
		"AUTOFORMAT
			let g:autoformat = 0

			function! AutoFormatToggle()
				if g:autoformat == 0
					echom "AutoFormat Mode Enabled"
					let g:autoformat = 1

					augroup AutoFormatGroup
						autocmd!
						au InsertLeave * Autoformat
					augroup END
				elseif g:autoformat == 1
					echom "AutoFormat Mode Disabled"
					let g:autoformat = 0

					augroup AutoFormatGroup
						autocmd!
					augroup END
				endif
			endfunction
	"MISCELLANOUS
		"AUTOMATIC vimrc SOURCING
			"augroup myvimrc
				"au!
				"au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,init.vim so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
			"augroup END
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
		"REMOVE STUFF
			"REMOVE EMPTY LINES
				nnoremap <Leader><Leader>e :g/^$/d<CR>
			"REMOVE TRAILING WHITESPACE
				nnoremap <Leader><Leader>w :call StripTrailingWhitespace()<CR>
		"SCRATCH.vim @TODO
"ONI CONFIGURATION
	if exists('g:gui_oni')
		"LOOK & FEEL
			let g:airline_powerline_fonts               = 0
			let g:airline_theme                         = 'wombat'
			let g:airline#extensions#bufferline#enabled = 1
		"MISCELLANOUS
			let g:vim_search_pulse_disable_auto_mappings = 1
			unmap n
			unmap N
			unmap *
			unmap #
			unmap g*
			unmap g#
	endif
