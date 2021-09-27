"FONTS
	"JetBrainsMono-Regular
	"Menlo(GITLAB+VSCODE)
	"Inconsolata
	"OperatorMono?
	"RobotoMono (jsonformatter)?
	"IBMPlexMono(BlexMono)?
"FOLDING
	if has('folding')
		set foldlevel=0
		set foldignore=
		set foldlevelstart=99
		augroup FOLD_LEVEL
			au!
			au FileType text set foldlevelstart=0
			au FileType vim set foldlevelstart=0
		augroup END
	endif
"INDENTATION
	set autoindent
	set smartindent
	set smarttab
	set shiftwidth=2
	set tabstop=2
	set noexpandtab
"LINES
	set number
	set relativenumber
"SWAP|BACKUP|UNDO
	set undofile
	set nobackup
	set nowritebackup
	set undodir=~/.config/nvim/tmp/undofiles
	set directory=~/.config/nvim/tmp/swapfiles
	set noswapfile
"SEARCH
	set nohls
	set incsearch
	set ignorecase
	set smartcase
	set gdefault
"SEARCH-FILES
	set path+=.,,**
		"using ":find" to find files recursively in current "cd", by using patterns
	if has('wildmenu')
		set wildmenu
		set wildmode=longest:full,full
		set wildignore+=*.a,*.o
		set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
		set wildignore+=.DS_Store,.git,.hg,.svn
		set wildignore+=*~,*.swp,*.tmp
		set wildignore+=node_modules,package-lock.json,yarn-lock.json
		set wildignorecase
	endif
"SERACH-TAGS
	"TODO
	"set include=
		"regex patterns to specify modules/files,
		"in which vim can search for specified text/symbol
		"use "ij" command to search and jump
	"set define=
		"regex patterns to specify the syntax of symbol-definition,
		"so that we jump to first symbol definition match, instead of any first match
		"use "ij" command to search and jump
	"set suffixesadd=
		"which suffixes/extension to add, when jumping/searching using "gf"
"COMMANDS
	set ttimeout
	set ttimeoutlen=100
	set timeoutlen=500
"COMMANDLINE
	set cmdheight=1
	set cmdwinheight=10
"INTERFACE
	"COLORS
		if (has("termguicolors"))
			"italics
			let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
			let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

			"wip
			let &t_Cs = "\e[4:3m"
			let &t_Ce = "\e[4:0m"
			let &t_AU = "\e[58:5:%dm"
			let &t_8u = "\e[58:2:%lu:%lu:%lum"

			"true-colors
			set termguicolors
			hi LineNr ctermbg=NONE guibg=NONE
		endif
	"BTW
		"BUFFER
			set nowrap
			set hidden
			set fileformats=unix,mac,dos
			set noruler
			"TODO:FIX
				"set colorcolumn=120
				"DAMIAN-CONVAY
				"highlight ColorColumn ctermbg=magenta
				"call matchadd('ColorColumn', '\%81v', 100)
		"WINDOW
			set splitbelow
			set splitright
			if has('nvim-0.5')
				"set signcolumn=auto:1-4
				set signcolumn=yes:1
			elseif has('patch-8.1.1564')
				"always show the signcolumn, otherwise it would shift the text each time
				"diagnostics appear/become resolved.
				"recently vim can merge signcolumn and number column into one
				set signcolumn=number
			else
				set signcolumn=yes
			endif
	"LIST
		set nolist
		set shortmess=filmnrwxoOTWAIcFS
		set listchars=tab:\ \ ,
		set listchars+=eol:¬,
		set listchars+=trail:•,
		set listchars+=extends:➞,
		set listchars+=extends:…,
		set listchars+=precedes:←,
		set listchars+=precedes:…,
		set listchars+=nbsp:␣,
		set fillchars+=fold:\ ,
		set fillchars+=stl:\ ,
		set fillchars+=stlnc:\ ,
		set fillchars+=vert:│,
		"set fillchars+=diff:─,
		set fillchars+=diff:╱,
		set fillchars+=eob:~,
	"CURSOR
		set nocursorcolumn
		set cursorline
		set nostartofline
	"STATUSLINE
		set showcmd
		set noshowmode
		set noruler
		if has('nvim-0.7')
			set laststatus=3
		endif
		"augroup NOSHOWMODE
			"au!
			"au BufEnter * set noshowmode
			"some plugin is overriding the "showmode" when entering new buffer
		"augroup END
	"EXTERNALIZED
		if has('nvim') && IsWindows()
			autocmd VimEnter * GuiPopupmenu 0
			autocmd VimEnter * GuiTabline 0
		endif
"FILESYSTEM
	"FILETYPE
		augroup CONFIGURATIONS
			au!
			au Filetype python set tabstop=2 | set shiftwidth=2 | set noexpandtab
			au Filetype sh,bash set tabstop=2 | set shiftwidth=2 | set expandtab
			au Filetype scala set tabstop=2 | set shiftwidth=2 | set noexpandtab
			au Filetype lua set tabstop=2 | set shiftwidth=2 | set noexpandtab
			au BufEnter *.csx set filetype=csx | set syntax=cs

			"FILETYPE=jproperties FOR TEXT FILES
			autocmd BufNewFile,BufRead *.txt set syntax=jproperties
			autocmd Filetype text set syntax=jproperties
		augroup END
"TERMINAL
	augroup BETTER_TERMINAL
		autocmd!
		if has('nvim')
			autocmd TermOpen *
				\ setlocal nonumber norelativenumber |
				\ startinsert
		endif
	augroup END
"RANDOM
	let loaded_netrwPlugin = 0
	set scrolloff=3
	set nocompatible
		"disabling vi compatibility features|mappings…
	set mouse=a
	set clipboard=unnamed
	set nf="alpha,octal,hex,bin"
	scriptencoding utf-8
	set updatetime=50
		"mainly used coc.nvim
		"default is 4000ms(4s) which leads to noticeable delays and poor user experience.
"CONFIGURATION
	"PYTHON
		"let g:loaded_python_provider	= 1
		"let g:loaded_python3_provider = 1

		if IsNix()
			"let g:python_host_prog	= '/usr/bin/python'
			"let g:python3_host_prog = '/usr/local/bin/python3'
			"let g:python3_host_prog = '/Users/sahilsehwag/neovim/bin/python3'
		elseif IsWindows()
			"TODO:FIX
			let g:python_host_prog	= "C:/Users/138100/scoop/apps/anaconda3/current/envs/pynvim2/python.exe"
			let g:python3_host_prog = "C:/Users/138100/scoop/apps/anaconda3/current/envs/pynvim/python.exe"
		endif
	"NODE
		let $PATH = fnamemodify(g:config.executables.node, ':p:h') . ':' . $PATH
	"MSWIN
		if IsWindows()
			nnoremap <Leader>mm :source $VIMRUNTIME/mswin.vim<CR>
		endif
