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
	endif
"INDENTATION
	set autoindent
	set smartindent
	set smarttab
	set shiftwidth=4
	set tabstop=4
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
			if has("patch-8.1.1564")
				"Always show the signcolumn, otherwise it would shift the text each time
				"diagnostics appear/become resolved.
				"Recently vim can merge signcolumn and number column into one
				set signcolumn=number
			else
				set signcolumn=yes
			endif
	"LIST
		set nolist
		set shortmess=filmnrwxoOTWAIcFS
		set listchars=tab:\ \ ,
		set listchars+=eol:¬
		set listchars+=trail:•
		set listchars+=extends:➞
		set listchars+=extends:…
		set listchars+=precedes:←
		set listchars+=precedes:…
		set listchars+=nbsp:␣
		set fillchars=fold:\ ,
		set fillchars=stl:\ ,
		set fillchars=stlnc:\ ,
		set fillchars=vert:│
	"CURSOR
		set nocursorcolumn
		set cursorline
		set nostartofline
	"COLORSCHEME
		if IsNix()
			colorscheme vscode
		elseif IsWindows()
			colorscheme solarized8_light_high
		endif
	"STATUSLINE
		set showcmd
		set noshowmode
		set noruler
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
			au Filetype python set tabstop=4 | set shiftwidth=4 | set noexpandtab
			au Filetype scala set tabstop=4 | set shiftwidth=4 | set noexpandtab
			au BufEnter *.csx set filetype=csx | set syntax=cs

			"FILETYPE=jproperties FOR TEXT FILES
			autocmd BufNewFile,BufRead *.txt set syntax=jproperties
			autocmd Filetype text set syntax=jproperties
		augroup END
"RANDOM
	let loaded_netrwPlugin = 0
	set scrolloff=10
	set nocompatible
		"disabling vi compatibility features|mappings…
	set mouse=a
	set clipboard=unnamed
	set nf="alpha,octal,hex,bin"
	set updatetime=50
		"mainly used coc.nvim
		"default is 4000ms(4s) which leads to noticeable delays and poor user experience.
