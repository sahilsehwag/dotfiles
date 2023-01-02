--LINES
vim.opt.number				 = true
vim.opt.relativenumber = true

--SWAP|BACKUP|UNDO
vim.opt.undofile		= true
vim.opt.backup			= false
vim.opt.writebackup = false
vim.opt.undodir			= vim.fn.glob('~/.config/nvim/tmp/undofiles')
vim.opt.directory		= vim.fn.glob('~/.config/nvim/tmp/swapfiles')
vim.opt.swapfile		= false

--SEARCH
vim.opt.hls				 = false
vim.opt.incsearch  = true
vim.opt.ignorecase = true
vim.opt.smartcase  = true
vim.opt.gdefault	 = true

--INDENTATION
vim.opt.autoindent	= true
vim.opt.smartindent = true
vim.opt.smarttab		= true
vim.opt.shiftwidth	= 2
vim.opt.tabstop			= 2
vim.opt.expandtab		= false

--FOLDING
vim.opt.foldlevel			 = 0
vim.opt.foldignore		 = ''
vim.opt.foldlevelstart = 99
vim.cmd [[
	augroup FOLD_LEVEL
		au!
		au FileType text set foldlevelstart=0
		au FileType vim set foldlevelstart=0
	augroup END
]]

--SEARCH-FILES
--using ":find" to find files recursively in current "cd", by using patterns
vim.opt.path = {
	'.',
	'**',
}
vim.opt.wildmenu = true
vim.opt.wildmode = {
	'longest:full',
	'full',
}
vim.opt.wildignore = {
	'*.a',
	'*.o',

	'*.bmp',
	'*.gif',
	'*.ico',
	'*.jpg',
	'*.png',

	'.DS_Store',
	'.git',
	'.hg',
	'.svn',

	'*~',
	'*.swp',
	'*.tmp',

	'node_modules',
	'package-lock.json',
	'yarn-lock.json',
}
vim.opt.wildignorecase = true

--COMMANDS
vim.opt.ttimeout		= true
vim.opt.ttimeoutlen = 100
vim.opt.timeoutlen	= 500

--COMMANDLINE
vim.opt.cmdheight		 = 1
vim.opt.cmdwinheight = 10

--BUFFER
vim.opt.wrap = false
vim.opt.hidden = true
vim.opt.fileformats = {
	'unix',
	'mac',
	'dos',
}
vim.opt.ruler = false

--WINDOW
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.signcolumn = 'yes:1'

--LIST
vim.opt.list = false
vim.opt.shortmess = 'filmnrwxoOTWAIcFS'
vim.opt.listchars = {
	tab      = '  ',
	eol      = '¬',
	trail    = '•',
	--extends  = '➞',
	extends  = '…',
	--precedes = '←',
	precedes = '…',
	nbsp     = '␣',
}
vim.opt.fillchars = {
	fold  = ' ',
	stl   = ' ',
	stlnc = ' ',
	vert  = '│',
	eob   = '~',
	--diff  = '╱',
	diff  = '─',
}

--CURSOR
vim.opt.cursorcolumn = false
vim.opt.cursorline	 = false
vim.opt.startofline  = false

--STATUSLINE
vim.opt.showcmd		 = true
vim.opt.showmode	 = false
vim.opt.cmdheight  = 0
vim.opt.ruler			 = false
vim.opt.laststatus = 0
--vim.cmd [[
--	augroup NOSHOWMODE
--		au!
--		au BufEnter * set noshowmode
--		some plugin is overriding the --showmode-- when entering new buffer
--	augroup END
--]]

--EXTERNALIZED
vim.cmd [[
	if has('nvim') && IsWindows()
		autocmd VimEnter * GuiPopupmenu 0
		autocmd VimEnter * GuiTabline 0
	endif
]]

--FILETYPE
vim.cmd [[
	augroup CONFIGURATIONS
		au!
		au Filetype python set tabstop=2 | set shiftwidth=2 | set noexpandtab
		au Filetype markdown,mkdc set tabstop=2 | set shiftwidth=2 | set noexpandtab
		au Filetype sh,bash set tabstop=2 | set shiftwidth=2 | set expandtab
		au Filetype scala set tabstop=2 | set shiftwidth=2 | set noexpandtab
		au Filetype lua set tabstop=2 | set shiftwidth=2 | set noexpandtab
		au BufEnter *.csx set filetype=csx | set syntax=cs

		au BufEnter *.tsx,*.jsx syntax match SpecialKey /L/ conceal cchar=λ

		"FILETYPE=jproperties FOR TEXT FILES
		autocmd BufNewFile,BufRead *.txt set syntax=jproperties
		autocmd Filetype text set syntax=jproperties
		autocmd BufEnter *.vifm,vifmrc set syntax=vim
		autocmd BufEnter *.vifm,vifmrc set filetype=vim
	augroup END
]]

--TERMINAL
vim.cmd [[
	augroup BETTER_TERMINAL
		autocmd!
		if has('nvim')
			autocmd TermOpen *
				\ setlocal nonumber norelativenumber |
				\ startinsert
		endif
	augroup END
]]

--COLORS
vim.cmd [[
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
]]

--CONCEAL
vim.opt.conceallevel = 2

--RANDOM
--FIX:
--vim.cmd [[ scriptencoding utf-8 ]]
vim.opt.scrolloff = 3
vim.opt.compatible = false --disabling vi compatibility features|mappings…
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamed'
vim.opt.nf = "alpha,octal,hex,bin"
--vim.opt.updatetime = 50
vim.g.loaded_netrwPlugin = 0

--SERACH-TAGS
--regex patterns to specify modules/files,
--in which vim can search for specified text/symbol
--use "ij" command to search and jump
--vim.opt.include =

--regex patterns to specify the syntax of symbol-definition,
--so that we jump to first symbol definition match, instead of any first match
--use "ij" command to search and jump
--vim.opt.define =

--which suffixes/extension to add, when jumping/searching using "gf"
--vim.opt.suffixesadd =

--PYTHON
--vim.g.loaded_python_provider	= 1
--vim.g.loaded_python3_provider = 1
vim.cmd [[
	if IsNix()
		"let g:python_host_prog	= '/usr/bin/python'
		let g:python3_host_prog = '/usr/local/bin/python3'
		"let g:python3_host_prog = '/Users/sahilsehwag/neovim/bin/python3'
	elseif IsWindows()
		"FIX:
		let g:python_host_prog	= "C:/Users/138100/scoop/apps/anaconda3/current/envs/pynvim2/python.exe"
		let g:python3_host_prog = "C:/Users/138100/scoop/apps/anaconda3/current/envs/pynvim/python.exe"
	endif
]]

--NODE
vim.cmd [[
	let $PATH = fnamemodify(g:config.executables.node, ':p:h') . ':' . $PATH
]]

--MSWIN
vim.cmd [[
	if IsWindows()
		nnoremap <Leader>mm :source $VIMRUNTIME/mswin.vim<CR>
	endif
]]

