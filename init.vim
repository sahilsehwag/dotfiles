"VIMSCRIPT
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

				function! ConvertSpaces2Tabs()
					let l:et = &expandtab
					setlocal noexpandtab
					%retab!
					if l:et
						setlocal expandtab
					else
						setlocal noexpandtab
					endif
				endfunction

				function! ConvertTabs2Spaces()
					let l:et = &expandtab
					setlocal expandtab
					%retab!
					if l:et
						setlocal expandtab
					else
						setlocal noexpandtab
					endif
				endfunction
			"INTERFACE
				function! RunInNewBuffer(command, filename)
					execute "edit! " a:filename
					execute a:command
				endfunction

				function! ScratchBuffer(type, ...)
					if a:type == 'e'
						enew
					elseif a:type == 's'
						new
					elseif a:type == 'v'
						vnew
					endif

					setlocal buftype=nofile
					setlocal bufhidden=hide
					setlocal noswapfile
					setlocal nobuflisted

					if exists('a:1')
						Filetypes
					endif
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

				function! ExistsAndTrue(name)
					if exists(a:name)
						return eval(a:name)
					return 0
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
"PYTHON
	"PLUGINS
"COMMANDS
"CONFIGURATION
	"VARIABLES
		"PERFORMANCE
			let loaded_netrwPlugin = 0
		"VIM
		"INTERFACE
			let g:highlight_trailing_whitespaces = 1
			let g:highlight_leading_spaces       = 1
			let g:highlight_leading_tabs         = 0
			let g:highlight_listchars            = 1
		"DEVELOPMENT
			let g:repls = {
						\ 'python'     : 'python3',
						\ 'javascript' : 'node',
						\ 'ruby'       : 'irb',
						\ 'php'        : 'php',
						\ 'scala'      : 'scala',
						\ 'perl'       : 'perl',
						\ 'lisp'       : 'sbcl',
						\ 'sqlite'     : 'sqlite',
						\ 'mysql'      : 'mysql',
						\ 'mongo'      : 'mongo',
						\ 'redis'      : 'redis-cli',
						\ 'typescript' : 'ts-node',
						\ 'haskell'    : 'ghci',
						\ 'sh'         : 'bash',
						\ 'bash'       : 'bash',
						\ 'zsh'        : 'zsh',
						\ 'fish'       : 'fsh',
						\ 'dosbatch'   : 'cmd',
						\}
			let g:languages = {}
			"INTERPRETED LANGUAGES
				let g:languages.python = {
					\'extension'     : 'py',
					\'repl'          : 'ipython',
					\'execute'       : 'python3',
					\'execute-flags' : '',
				\}
				let g:languages.javascript = {
					\'extension'     : 'js',
					\'repl'          : 'node',
					\'execute'       : 'node',
					\'execute-flags' : '',
				\}
				let g:languages.ruby = {
					\'extension'     : 'rb',
					\'repl'          : 'irb',
					\'execute'       : 'ruby',
					\'execute-flags' : '',
				\}
				let g:languages.typscript = {
					\'extension'     : 'ts',
					\'repl'          : 'ts-node',
					\'execute'       : 'tsc',
					\'execute-flags' : '',
				\}
				let g:languages.perl = {
					\'extension'     : 'pl',
					\'repl'          : 'perl',
					\'execute'       : 'perl',
					\'execute-flags' : '',
				\}
				let g:languages.php = {
					\'extension'     : 'php',
					\'repl'          : 'php',
					\'execute'       : 'php',
					\'execute-flags' : '',
				\}
				let g:languages.lisp = {
					\'extension'     : 'lsp',
					\'repl'          : 'sbcl',
					\'execute'       : '',
					\'execute-flags' : '',
				\}
				let g:languages.lua = {
					\'extension'     : 'lua',
					\'repl'          : 'lua',
					\'execute'       : 'lua',
					\'execute-flags' : '',
				\}
			"COMPILED LANGUAGES
				let g:languages.c = {
					\'extension'     : 'c',
					\'execute'       : '',
					\'execute-flags' : '',
					\'compile'       : 'gcc',
					\'compile-flags' : '',
				\}
				let g:languages.cpp = {
					\'extension'     : 'cpp',
					\'execute'       : '',
					\'execute-flags' : '',
					\'compile'       : 'g++',
					\'compile-flags' : '-std=c++14',
				\}
				let g:languages.java = {
					\'extension'     : 'java',
					\'execute'       : 'java',
					\'execute-flags' : '',
					\'compile'       : 'javac',
					\'compile-flags' : '',
				\}
				let g:languages.scala = {
					\'extension'     : 'scala',
					\'repl'          : 'scala',
					\'execute'       : 'scala',
					\'execute-flags' : '',
					\'compile'       : 'scalac',
					\'compile-flags' : '',
				\}
				let g:languages.haskell = {
					\'extension'     : 'hs',
					\'repl'          : 'ghci',
					\'execute'       : '',
					\'execute-flags' : '',
					\'compile'       : '',
					\'compile-flags' : '',
				\}
			"SHELL
				let g:languages.zsh = {
					\'extension'     : 'zsh',
					\'repl'          : 'zsh',
					\'execute'       : 'zsh',
					\'execute-flags' : '',
				\}
				let g:languages.bash = {
					\'extension'     : 'bash',
					\'repl'          : 'bash',
					\'execute'       : 'bash',
					\'execute-flags' : '',
				\}
				let g:languages.fish = {
					\'extension'     : 'fsh',
					\'repl'          : 'fsh',
					\'execute'       : 'fsh',
					\'execute-flags' : '',
				\}
				let g:languages.sh = {
					\'extension'     : 'sh',
					\'repl'          : 'sh',
					\'execute'       : 'sh',
					\'execute-flags' : '',
				\}
				let g:languages.batch = {
					\'extension'     : 'cmd',
					\'repl'          : 'cmd',
					\'execute'       : '',
					\'execute-flags' : '',
				\}
			"DATABASES
				let g:languages.sqlite = {
					\'extension'     : 'sql',
					\'repl'          : 'sqlite',
				\}
				let g:languages.mysql = {
					\'extension'     : 'mysql',
					\'repl'          : 'mysql',
				\}
				let g:languages.redis = {
					\'extension'     : 'redis',
					\'repl'          : 'redis-cli',
				\}
				let g:languages.mongo = {
					\'extension'     : 'mongo',
					\'repl'          : 'mongo',
				\}
		"MISCELLANOUS
	"PYTHON BINARIES
		let g:python_host_prog = 'python2'
		let g:python3_host_prog = 'python3'
		"let g:loaded_python3_provider=1
	"HIGHLIGHTS
		"SEARCH HIGHLIGHTS
			if ExistsAndTrue('g:jaat_highlight_search')
				highlight Search ctermfg=49 cterm=NONE gui=NONE
				highlight IncSearchMatch ctermfg=black ctermbg=186
			endif
		"TRAILING WHITESPACES
			if ExistsAndTrue('g:highlight_trailing_whitespaces')
				"highlight TrailingWhitespace ctermbg=135
				highlight TrailingWhitespace ctermfg=135
				call matchadd('TrailingWhitespace', '\s\+$', 100)
			endif
		"CONSECUTIVE BLANKLINES
			if ExistsAndTrue('g:highlight_consecutive_blanklines')
				highlight ConsecutiveBlankLines ctermbg=135
				call matchadd('ConsecutiveBlankLines', '\(^$\n\)\{2,}', 100)
			endif
		"LEADING SPACES
			if ExistsAndTrue('g:highlight_leading_spaces')
				highlight LeadingSpaces ctermbg=135
				call matchadd('LeadingSpaces', '^ \+', 100)
			endif
		"LEADING TABS
			if ExistsAndTrue('g:highlight_leading_tabs')
				highlight LeadingTabs ctermbg=135
				call matchadd('LeadingTabs', '^\t\+', 100)
			endif
		"AUTOCOMPLETION MENU
			"highlight Pmenu ctermbg=232 ctermfg=7
			"highlight PmenuSel ctermfg=15
			highlight Pmenu ctermbg=238 gui=bold
		"INTERFACE HIGHLIGHTS
			highlight VertSplit ctermbg=None guibg=None
		"LISTCHARS
			if ExistsAndTrue('g:highlight_listchars')
				highlight EndOfBuffer ctermfg=245 guifg=#658595
				highlight NonText     ctermfg=135 guifg=#af5fff
				highlight Whitespace  ctermfg=135 guifg=#af5fff
			endif
"MAPPINGS
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
	"INTERFACE MAPPINGS
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
			nnoremap <LEADER>bt  :call ScratchBuffer('e')<CR>
			nnoremap <LEADER>bT  :call ScratchBuffer('e', 1)<CR>
		"WINDOW MAPPINGS
			nnoremap <Leader>wh :sp<CR>
			nnoremap <Leader>wv :vsp<CR>
			nnoremap <Leader>wo :only<CR>
			nnoremap <Leader>wc :close<CR>
			nnoremap <Leader>wn :vnew<CR>
			nnoremap <Leader>wN :new<CR>
			nnoremap <Leader>wm :MaximizerToggle<CR>

			nnoremap <C-J> <C-W><C-J>
			nnoremap <C-K> <C-W><C-K>
			nnoremap <C-L> <C-W><C-L>
			nnoremap <C-H> <C-W><C-H>
	"INSERT MODE
		"ABBREVIATIONS @TODO
			abbreviate chk ✓
			abbreviate crs ✖
	"COMMANDLINE MODE
	"MISCELLANOUS GROUPS
		"REGISTER MAPPINGS
			nnoremap <Leader>ra "a
			nnoremap <Leader>rb "b
			nnoremap <Leader>rc "c
			nnoremap <Leader>rd "d
			nnoremap <Leader>re "e
			nnoremap <Leader>rf "f
			nnoremap <Leader>rg "g
			nnoremap <Leader>rh "h
			nnoremap <Leader>ri "i
			nnoremap <Leader>rj "j
			nnoremap <Leader>rk "k
			nnoremap <Leader>rl "l
			nnoremap <Leader>rm "m
			nnoremap <Leader>rn "n
			nnoremap <Leader>ro "o
			nnoremap <Leader>rp "p
			nnoremap <Leader>rq "q
			nnoremap <Leader>rr "r
			nnoremap <Leader>rs "s
			nnoremap <Leader>rt "t
			nnoremap <Leader>ru "u
			nnoremap <Leader>rv "v
			nnoremap <Leader>rw "w
			nnoremap <Leader>rx "x
			nnoremap <Leader>ry "y
			nnoremap <Leader>rz "z
			nnoremap <Leader>rA "a
			nnoremap <Leader>rB "b
			nnoremap <Leader>rC "c
			nnoremap <Leader>rD "d
			nnoremap <Leader>rE "e
			nnoremap <Leader>rF "f
			nnoremap <Leader>rG "g
			nnoremap <Leader>rH "h
			nnoremap <Leader>rI "i
			nnoremap <Leader>rJ "j
			nnoremap <Leader>rK "k
			nnoremap <Leader>rL "l
			nnoremap <Leader>rM "m
			nnoremap <Leader>rN "n
			nnoremap <Leader>rO "o
			nnoremap <Leader>rP "p
			nnoremap <Leader>rQ "q
			nnoremap <Leader>rR "r
			nnoremap <Leader>rS "s
			nnoremap <Leader>rT "t
			nnoremap <Leader>rU "u
			nnoremap <Leader>rV "v
			nnoremap <Leader>rW "w
			nnoremap <Leader>rX "x
			nnoremap <Leader>rY "y
			nnoremap <Leader>rZ "z
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
		"TEXT MAPPINGS
			"REMOVE CONSECUTIVE BLANK LINES (>=3)
				nmap <Leader>xb :g:^$\n\{3,}:d<CR>
			"REMOVE TRAILING WHITESPACE
				nmap <Leader>xw :call StripTrailingWhitespace()<CR>
			"SPACES => TABS
				nmap <Leader>xt :call ConvertSpaces2Tabs()<CR>
			"TABS => SPACES
				nmap <Leader>xs :call ConvertTabs2Spaces()<CR>
			"RETAB
				nmap <Leader>xr :%retab!<CR>
		"EDITOR MAPPINGS
			"TOGGLES
				map <Leader>etl :set number!<CR>
				map <Leader>etr :set relativenumber!<CR>
				map <Leader>etw :let g:highlight_trailing_whitespaces = !g:highlight_trailing_whitespaces<CR>
				map <Leader>ets :let g:highlight_leading_spaces       = !g:highlight_leading_spaces<CR>
				map <Leader>ett :let g:highlight_leading_tabs         = !g:highlight_leading_tabs<CR>
		"LINUX MAPPINGS
			"FILESYSTEM
				nnoremap <silent> <Leader>ld :execute "DeleteFile " . glob('%')<CR>
			"FZF
				nnoremap <Leader>nf  :call fzf#run(fzf#wrap({'source': 'find ~/Google\ Drive -type d', 'sink': 'VifmToggle'       }))<CR>
				nnoremap <Leader>nF  :call fzf#run(fzf#wrap({'source': 'find ~               -type d', 'sink': 'VifmToggle'       }))<CR>
				nnoremap <Leader>lnf :call fzf#run(fzf#wrap({'source': 'find ~               -type d', 'sink': 'NewFile'          }))<CR>
				nnoremap <Leader>lnd :call fzf#run(fzf#wrap({'source': 'find ~               -type d', 'sink': 'NewDirectory'     }))<CR>
				nnoremap <Leader>ldf :call fzf#run(fzf#wrap({'source': 'find ~               -type f', 'sink': 'DeleteFile'       }))<CR>
				nnoremap <Leader>ldd :call fzf#run(fzf#wrap({'source': 'find ~               -type d', 'sink': 'DeleteDirectory'  }))<CR>
				nnoremap <Leader>ldD :call fzf#run(fzf#wrap({'source': 'find ~               -type d', 'sink': 'DeleteDirectory!' }))<CR>
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
"FILETYPE
	"TEXT
		"FILETYPE=jproperties FOR TEXT FILES
		autocmd BufNewFile,BufRead *.txt set syntax=jproperties
		autocmd Filetype text set syntax=jproperties
	"MARKUP
		"MARKDOWN
			augroup MARKDOWN
				au!
				au FileType markdown nmap <buffer> <LocalLeader>ch :call RunNpmCommand('', "%", 'gh-markdown-cli')<CR>
				au FileType markdown vmap <buffer> <LocalLeader>ch :call RunNpmCommand('mdown', '', "'<,'>", 'gh-markdown-cli')<CR>
			augroup END
		"XML
			augroup XML
				au!
				au FileType xml nmap <buffer> <LocalLeader>cj :call RunNpmCommand('x2j', '', '%', 'x2j-cli')<CR>
				au FileType xml vmap <buffer> <LocalLeader>cj :call RunNpmCommand('x2j', '', "'<,'>", 'x2j-cli')<CR>
			augroup END
	"FRONTEND
		"PUG|JADE
			"FUNCTIONS
				function! Pug(range)
					call RunNpmCommand('pug', '-P', a:range, 'pug-cli')
				endfunction
			"MAPPINGS
				augroup PUG
					au!
					au FileType jade,pug map  <buffer> <LocalLeader>cw :JadeWatch html vertical<CR>
					au FileType jade,pug nmap <buffer> <LocalLeader>cc :<C-u> call Pug('')<CR>
					au FileType jade,pug vmap <buffer> <LocalLeader>cc :<C-u> call Pug("'<,'>")<CR>
					au FileType jade,pug nmap <buffer> <LocalLeader>cb :<C-u> call Pug('%')<CR>
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
	"PROGRAMMING
		"PYTHON
			augroup PYTHON
				au!
				au Filetype python set tabstop=4 | set shiftwidth=4 | set noexpandtab
			augroup END
		"C|C++
		"JAVA
		"JAVASCRIPT
	"WORDPRESS
		augroup WORDPRESS
			au!
			au BufEnter wordpress set filetype=jade
			au BufEnter wordpress map <buffer> <LocalLeader>ch :<C-u>call Pug('12,$')<CR>
			au BufEnter wordpress map <buffer> <LocalLeader>cj :<C-u>call Html2Pug('12,$')<CR>
		augroup END
"PLUGINS
	call plug#begin()
	"PRODUCTIVITY
		Plug 'easymotion/vim-easymotion'
			"CONFIGURATION
				let g:EasyMotion_smartcase = 1
				nmap <LEADER>j <Plug>(easymotion-prefix)
				"hi link EasyMotionTarget Search
				let g:EasyMotion_enter_jump_first = 1
				let g:EasyMotion_space_jump_first = 1
				"let g:EasyMotion_use_upper        = 1
				let g:EasyMotion_smartcase        = 1
				"let g:EasyMotion_keys             = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;'
			"MAIN MAPPINGS
				nmap <LEADER>jl <Plug>(easymotion-overwin-line)
				nmap <LEADER>jw <Plug>(easymotion-overwin-w)
				nmap <LEADER>je <Plug>(easymotion-bd-e)
				nmap <LEADER>jf <Plug>(easymotion-overwin-f)
				nmap <LEADER>js <Plug>(easymotion-overwin-f2)
				nmap <LEADER>jj <Plug>(easymotion-j)
				nmap <LEADER>jk <Plug>(easymotion-k)
				nmap <LEADER>jJ <Plug>(easymotion-eol-j)
				nmap <LEADER>jK <Plug>(easymotion-eol-k)
				nmap <LEADER>j. <Plug>(easymotion-repeat)
				nmap <LEADER>ja <Plug>(easymotion-jumptoanywhere)
				nmap <LEADER>j/ <Plug>(easymotion-sn)
				nmap <LEADER>j? <Plug>(easymotion-tn)
			"OPERATOR MAPPINGS
				omap jw <Plug>(easymotion-bd-w)
				omap jW <Plug>(easymotion-bd-W)
				omap je <Plug>(easymotion-bd-e)
				omap jE <Plug>(easymotion-bd-E)
				omap jl <Plug>(easymotion-bd-jk)
				omap jj <Plug>(easymotion-j)
				omap jk <Plug>(easymotion-k)
				omap jJ <Plug>(easymotion-eol-j)
				omap jK <Plug>(easymotion-eol-K)
				omap jf <Plug>(easymotion-bd-f)
				omap js <Plug>(easymotion-bd-f2)
				omap jt <Plug>(easymotion-bd-t)
				omap jS <Plug>(easymotion-bd-t2)
				omap j/ <Plug>(easymotion-sn)
				xmap j? <Plug>(easymotion-tn)
				omap jn <Plug>(easymotion-bd-n)
				omap j. <Plug>(easymotion-repeat)
				omap jv <Plug>(easymotion-segments-LF)
				omap jV <Plug>(easymotion-segments-LB)
				omap jgv <Plug>(easymotion-segments-RF)
				omap jgV <Plug>(easymotion-segments-RB)
				omap ja <Plug>(easymotion-jumptoanywhere)
			"VISUAL MAPPINGS
				xmap jw <Plug>(easymotion-bd-w)
				xmap jW <Plug>(easymotion-bd-W)
				xmap je <Plug>(easymotion-bd-e)
				xmap jE <Plug>(easymotion-bd-E)
				xmap jl <Plug>(easymotion-bd-jk)
				xmap jj <Plug>(easymotion-j)
				xmap jk <Plug>(easymotion-k)
				xmap jJ <Plug>(easymotion-eol-j)
				xmap jK <Plug>(easymotion-eol-K)
				xmap jf <Plug>(easymotion-bd-f)
				xmap jt <Plug>(easymotion-bd-t)
				xmap js <Plug>(easymotion-bd-f2)
				xmap jS <Plug>(easymotion-bd-t2)
				xmap j/ <Plug>(easymotion-sn)
				xmap j? <Plug>(easymotion-tn)
				xmap jn <Plug>(easymotion-bd-n)
				xmap j. <Plug>(easymotion-repeat)
				xmap jv <Plug>(easymotion-segments-LF)
				xmap jV <Plug>(easymotion-segments-LB)
				xmap jgv <Plug>(easymotion-segments-RF)
				xmap jgV <Plug>(easymotion-segments-RB)
				xmap ja <Plug>(easymotion-jumptoanywhere)
		Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
		Plug 'junegunn/fzf.vim'
			"CONFIGURATION
				let g:fzf_action = {
					\ 'ctrl-t': 'tab split',
					\ 'ctrl-h': 'split',
					\ 'ctrl-v': 'vsplit',
					\ 'ctrl-a': 'badd',
					\ 'ctrl-r': 'Read',
					\ 'ctrl-p': 'view',
					\ }
				autocmd! FileType fzf
				autocmd  FileType fzf set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler
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
				"FILESYSTEM
					nnoremap <Leader>nf  : call fzf#run(fzf#wrap({'source': 'find ~ -type d',                    'sink': 'VifmToggle' }))<CR>
					nnoremap <Leader>nw  : call fzf#run(fzf#wrap({'source': 'find ~ -type d',                    'sink': 'SaveAs'     }))<CR>
					nnoremap <Leader>nW  : call fzf#run(fzf#wrap({'source': 'find ~ -type d',                    'sink': 'SaveAs!'    }))<CR>
					nnoremap <Leader>nr  : call fzf#run(fzf#wrap({'source': 'ag --hidden --ignore .git -g "" ~', 'sink': 'Read!'      }))<CR>
				"MAPPINGS
					nmap <LEADER>hn <plug>(fzf-maps-n)
					nmap <LEADER><TAB> <plug>(fzf-maps-n)
					xmap <LEADER><TAB> <plug>(fzf-maps-x)
					imap <LEADER><TAB> <plug>(fzf-maps-i)
					omap <LEADER><TAB> <plug>(fzf-maps-o)
				"COMPLETION
					imap        ;w <plug>(fzf-complete-word)
					imap        ;p <plug>(fzf-complete-path)
					imap        ;f <plug>(fzf-complete-file-ag)
					imap        ;l <plug>(fzf-complete-line)
					imap        ;L <plug>(fzf-complete-buffer-line)
					imap <expr> ;dp fzf#complete('find ~/Google\ Drive')
					imap <expr> ;df fzf#complete('find ~/Google\ Drive -type f')
					imap <expr> ;dd fzf#complete('find ~/Google\ Drive -type d')
		Plug 'pbogut/fzf-mru.vim'
			map M :<C-u>FZFMru<CR>
		Plug 'vifm/neovim-vifm'
			nnoremap <LEADER>nf :VifmToggle %:p:h<CR>
			nnoremap <LEADER>nF :VifmToggle .<CR>
		Plug 'cocopon/vaffle.vim'
	"DEVELOPMENT
		"VCS
			Plug 'tpope/vim-fugutive'
				nnoremap <Leader>gc :Commits<CR>
				nnoremap <Leader>gC :BCommits<CR>
				nnoremap <Leader>gf :GFiles<CR>
				nnoremap <Leader>gF :GFiles?<CR>

				nnoremap <Leader>gb :Gbrowser<CR>
			"Plug 'airblade/vim-gitgutter'
			"Plug 'mhinz/vim-signify'
		"AUTOFORMAT
			Plug 'chiel92/vim-autoformat'
				let g:formatterpath = ['/usr/local/bin/autopep8']
		"SNIPPETS
			Plug 'honza/vim-snippets'
			Plug 'SirVer/ultisnips'
				let g:UltiSnipsExpandTrigger="<CR>"
				let g:UltiSnipsJumpForwardTrigger="<C-b>"
				let g:UltiSnipsJumpBackwardTrigger="<C-z>"
		"AUTOCOMPLETION
			"Plug 'ervandew/supertab'
			Plug 'vim-scripts/AutoComplPop'
				let g:acp_enableAtStartup = 0

				augroup AutoComplPop
					autocmd!
					autocmd BufEnter *.txt :AcpEnable
					autocmd BufLeave *.txt :AcpDisable
				augroup END
			Plug 'Valloric/YouCompleteMe'
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
		"CODE EXECUTION
			Plug '0x84/vim-coderunner'
				let g:vcr_no_mappings = 1
				nnoremap <LocalLeader>cq :RunCode<CR>
				vnoremap <LocalLeader>cq :RunCode<CR>
			"Plug 'thinca/vim-quickrun'
			Plug 'metakirby5/codi.vim'
				let g:codi#width      = 80
				let g:codi#rightalign = 0
				nmap <LocalLeader>ci :Codi!!<CR>
			Plug 'arkwright/vim-whiteboard'
				"CONFIGURATIONS
					let g:whiteboard_temp_directory = '~/.config/nvim/temp'
					let g:whiteboard_interpreters = {
								\'python'     : { 'extension': 'py'     ,'command': 'python3'   },
								\'javascript' : { 'extension': 'js'     ,'command': 'node'      },
								\'php'        : { 'extension': 'php'    ,'command': 'php'       },
								\'ruby'       : { 'extension': 'rb'     ,'command': 'ruby'      },
								\'haskell'    : { 'extension': 'hs'     ,'command': 'ghci'      },
								\'scala'      : { 'extension': 'scala'  ,'command': 'scala'     },
								\'perl'       : { 'extension': 'pl'     ,'command': 'perl'      },
								\'go'         : { 'extension': 'go'     ,'command': 'gore'      },
								\'typescript' : { 'extension': 'ts'     ,'command': 'ts-node'   },
								\'sh'         : { 'extension': 'sh'     ,'command': 'bash'      },
								\'bash'       : { 'extension': 'bash'   ,'command': 'bash'      },
								\'zsh'        : { 'extension': 'zsh'    ,'command': 'zsh'       },
								\'fish'       : { 'extension': 'fsh'    ,'command': 'fsh'       },
								\'pandoc'     : { 'extension': 'pandoc' ,'command': 'pandoc'    },
								\'redis'      : { 'extension': 'redis'  ,'command': 'redis-cli' },
								\'mongo'      : { 'extension': 'mongo'  ,'command': 'mongo'     },
								\'mysql'      : { 'extension': 'mysql'  ,'command': 'mysql'     },
								\'sqlite'     : { 'extension': 'sqlite'  ,'command': 'sqlite'   },
								\'dosbatch'   : { 'extension': 'cmd'    ,'command': 'cmd'       },
								\'git'        : { 'extension': 'git'    ,'command': 'gitsome'   },
								\'lisp'       : { 'extension': 'lisp'   ,'command': 'sbcl'     }}
				"MAPPINGS
					nnoremap <LocalLeader>cs :execute "Whiteboard "  . &filetype<CR>
					nnoremap <LocalLeader>cS :execute "Whiteboard! " . &filetype<CR>
			Plug 'ujihisa/repl.vim'
				nnoremap <LocalLeader>cR :Repl<CR>
		"SYNTAX
			"Plug 'vim-syntastic/syntastic'
		"COMMENTING
			Plug 'scrooloose/nerdcommenter'
			"Plug 'tpope/vim-commentary'
			Plug 'manasthakur/vim-commentor'
				nmap gk  <Plug>Commentor
				xmap gk  <Plug>Commentor
				nmap gkk <Plug>CommentorLine
		"DOCUMENTATION
			Plug 'rizzatti/dash.vim'
				nnoremap <Leader>fd :Dash<CR>
				nnoremap <Leader>fD :Dash<space>
			"Plug 'rhysd/devdocs.vim'
				"nmap <Leader>fD :DevDocs<CR>
				"nmap <Leader>fd <Plug>(devdocs-under-cursor)
		"TAGS
			"Plug 'majutsushi/tagbar'
				nnoremap <Leader>nT :TagbarToggle<CR>
	"EDITING
		"OPERATORS
			Plug 'tommcdo/vim-exchange'
				let g:exchange_no_mappings = 1
				nmap gx  <Plug>(Exchange)
				nmap gxx <Plug>(ExchangeLine)
				xmap X   <Plug>(Exchange)
				nmap gxc <Plug>(ExchangeClear)
			Plug 'tpope/vim-surround'
			Plug 'junegunn/vim-easy-align'
				xmap ga <Plug>(EasyAlign)
				nmap ga <Plug>(EasyAlign)
			Plug 'thinca/vim-textobj-between'
			Plug 'christoomey/vim-titlecase'
			Plug 'milsen/vim-operator-substitute'
				let g:operator#substitute#default_flags     = "g"
				let g:operator#substitute#default_delimiter = ";"
				"MAPPINGS
					map gr <Plug>(operator-substitute)
					map &  <Plug>(operator-substitute-repeat)
					map g& <Plug>(operator-substitute-repeat-no-flags)
					map gR <Plug>(operator-substitute)$
			Plug 'tyru/operator-camelize.vim'
				map cp <Plug>(operator-camelize)
				map cu <Plug>(operator-decamelize)
				map cP <Plug>(operator-camelize-toggle)
			Plug 'deris/vim-operator-insert'
				nmap gI <Plug>(operator-insert-i)
				nmap gA <Plug>(operator-insert-a)
			Plug 'emonkak/vim-operator-sort'
				map gS <Plug>(operator-sort)
			Plug 'sgur/vim-operator-openbrowser'
				map gb <Plug>(operator-openbrowser)
			Plug 'gustavo-hms/vim-duplicate'
				map gd <Plug>(operator-duplicate)
			Plug 'kusabashira/vim-operator-exrange'
				map <silent> g: <Plug>(operator-exrange)
			Plug 'rjayatilleka/vim-operator-goto'
				map go <Plug>(operator-gotostart)
				map gO <Plug>(operator-gotoend)
		"TEXT-OBJECTS
			Plug 'wellle/targets.vim'
			Plug 'michaeljsmith/vim-indent-object'
			Plug 'coderifous/textobj-word-column.vim'
			Plug 'rhysd/vim-textobj-anyblock'
			Plug 'glts/vim-textobj-comment'
				let g:textobj_comment_no_default_mappings = 1
				xmap ak <Plug>(textobj-comment-a)
				xmap ik <Plug>(textobj-comment-i)
				omap ak <Plug>(textobj-comment-a)
				omap ik <Plug>(textobj-comment-i)
			Plug 'Julian/vim-textobj-variable-segment'
			Plug 'rhysd/vim-textobj-lastinserted'
			Plug 'kana/vim-textobj-lastpat'
			Plug 'saaguero/vim-textobj-pastedtext'
			Plug 'haya14busa/vim-easyoperator-line'
				omap gp  <Plug>(easyoperator-line-select)
				xmap gp  <Plug>(easyoperator-line-select)
			Plug 'haya14busa/vim-easyoperator-phrase'
				omap gp  <Plug>(easyoperator-phrase-select)
				xmap gp  <Plug>(easyoperator-phrase-select)
		"MISCELLANOUS
			Plug 'chaoren/vim-wordmotion'
			Plug 'machakann/vim-swap'
			Plug 'terryma/vim-multiple-cursors'
			Plug 'terryma/vim-expand-region'
	"WRITTING
		Plug 'reedes/vim-pencil'
			nnoremap <Leader>vp :PencilToggle<CR>
		Plug 'panozzaj/vim-autocorrect'
			nnoremap <Leader>va :call AutoCorrect()<CR>
		Plug 'davidbeckingsale/writegood.vim'
		Plug 'dbmrq/vim-ditto'
		Plug 'reedes/vim-lexical'
			nnoremap <Leader><Leader>s :set spell!<CR>
			let g:lexical#spell = 1
			let g:lexical#spell_key = '<leader>zs'
			let g:lexical#spelllang = ['en_us', 'en_ca',]
			"let g:lexical#dictionary = ['/usr/share/dict/words',]
			let g:lexical#thesaurus = ['~/.config/nvim/spell/mthesaurus.txt/',]
			let g:lexical#spellfile = ['~/.config/spell/en.utf-8.add',]
	"SEARCHING
		Plug 'haya14busa/incsearch.vim'
			map /  <Plug>(incsearch-forward)
			map ?  <Plug>(incsearch-backward)
			map g/ <Plug>(incsearch-stay)

			let g:incsearch#auto_nohlsearch = 1
			map n <Plug>(incsearch-nohl-n)
			map N <Plug>(incsearch-nohl-N)
			map * <Plug>(incsearch-nohl-*)
			map # <Plug>(incsearch-nohl-#)
			map g* <Plug>(incsearch-nohl-g*)
			map g# <Plug>(incsearch-nohl-g#)
		Plug 'haya14busa/incsearch-fuzzy.vim'
			map <LEADER>/ <Plug>(incsearch-fuzzy-/)
			map <LEADER>? <Plug>(incsearch-fuzzy-?)
			map <LEADER>s <Plug>(incsearch-fuzzy-stay)
		Plug 'haya14busa/incsearch-easymotion.vim'
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
		Plug 'aykamko/vim-easymotion-segments'
		Plug 'bronson/vim-visual-star-search'
		Plug 'lambdalisue/lista.nvim'
			nmap <Leader>ff :Lista<CR>
			nmap <Leader>fF :ListaCursorWord<CR>
		Plug 'osyo-manga/vim-hopping'
			nmap <Leader>fr :HoppingStart<CR>
		Plug 'haya14busa/vim-over'
			nmap <LEADER>fR :OverCommandLine<CR>
		"Plug 'vim-scripts/MultipleSearch'
		"Plug 'henrik/vim-indexed-search'
		Plug 'osyo-manga/vim-anzu'
			"nmap n <Plug>(incsearch-nohl-n)<Plug>(anzu-mode-n)
			"nmap N <Plug>(incsearch-nohl-N)<Plug>(anzu-mode-N)
			"nmap * <Plug>(anzu-star-with-echo)
			"nmap # <Plug>(anzu-sharp-with-echo)
	"LOOK&FEEL
		"STATUSLINE
			Plug 'vim-airline/vim-airline'
				"CONFIGURATION
					if !exists('g:gui_oni')
						let g:airline_powerline_fonts = 1
						let g:airline_theme           = 'powerlineish'
					else
						let g:airline_powerline_fonts = 0
						let g:airline_theme           = 'wombat'
					endif
				"BUFFERLINE
					if exists('g:gui_oni')
						let g:airline#extensions#bufferline#enabled = 1
						"let g:airline#extensions#bufferline#overwrite_variables = 1
					endif
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
			Plug 'vim-airline/vim-airline-themes'
			Plug 'edkolev/tmuxline.vim'
			Plug 'edkolev/promptline.vim'
			Plug 'bling/vim-bufferline'
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
			"Plug 'itchyny/lightline.vim'
		"COLORSCHEMES
			Plug 'flazz/vim-colorschemes'
			Plug 'rafi/awesome-vim-colorschemes'
			Plug 'chriskempson/base16-vim'
			Plug 'KeitaNakamura/neodark.vim'
				let g:neodark#use_256color         = 1
				let g:neodark#solid_vertsplit      = 1
				let g:neodark#background           = '#202020'
				"let g:lightline                    = {}
				"let g:lightline.colorscheme        = 'neodark'
				"let g:neodark#terminal_transparent = 1
			Plug 'sindresorhus/focus'
			Plug 'KabbAmine/yowish.vim'
			Plug 'ayu-theme/ayu-vim'
			Plug 'tyrannicaltoucan/vim-quantum'
			Plug 'raphamorim/lucario'
			Plug 'paranoida/vim-airlineish'
		Plug 'ryanoasis/vim-devicons'
		Plug 'itchyny/vim-highlighturl'
			let g:highlighturl_ctermfg = ''
			let g:highlighturl_guifg = ''
			let g:highlighturl_underline = 0
		Plug 'gcavallanti/vim-noscrollbar'
			function! Noscrollbar(...)
				let w:airline_section_z = '%{noscrollbar#statusline(20," ", "█")}'
				"let w:airline_section_z = '%{noscrollbar#statusline(20," ", "▌")}'
				"let w:airline_section_z = '%{noscrollbar#statusline(20," ", "▐")}'
			endfunction
			call airline#add_statusline_func('Noscrollbar')
		"Plug 'zefei/vim-colortuner'
		"Plug 'augustold/vim-airline-colornum'
		"Plug 'Yggdroot/indentLine'
	"EXTENDING VIM
		"Plug 'vim-scripts/repmo.vim'
			let repmo_key = ";"
			let repmo_revkey = ","
		Plug 'unblevable/quick-scope'
		Plug 'gastonsimone/vim-dokumentary'
		Plug 'tpope/vim-eunuch'
		Plug 'kopischke/vim-fetch'
		Plug 'dohsimpson/vim-macroeditor'
			nnoremap <Leader>zm :execute "MacroEdit " nr2char(getchar()) <CR>
		"Plug 'vimlab/split-term.vim'
		Plug 'zirrostig/vim-schlepp'
			vmap <up>    <Plug>SchleppUp
			vmap <down>  <Plug>SchleppDown
			vmap <left>  <Plug>SchleppLeft
			vmap <right> <Plug>SchleppRight

			vmap Dk <Plug>SchleppDupUp
			vmap Dj <Plug>SchleppDupDown
			vmap Dh <Plug>SchleppDupLeft
			vmap Dl <Plug>SchleppDupRight
		Plug 'szw/vim-maximizer'
		Plug 'tpope/vim-repeat'
		Plug 'kshenoy/vim-signature'
		Plug 'joeytwiddle/sexy_scroller.vim'
			let g:SexyScoller_ScrollTime = 10
			let g:SexyScroller_CursorTime = 5
			let g:SexyScroller_MaxTime = 200
			let g:SexyScroller_EasingStyle = 1
		"Plug 'terryma/vim-smooth-scroll'
		Plug 'inside/vim-search-pulse'
			let g:vim_search_pulse_mode = 'cursor_line'
			if exists('g:gui_oni')
				let g:vim_search_pulse_disable_auto_mappings = 1
			else
				map n <Plug>(incsearch-nohl-n)<Plug>Pulse
				map N <Plug>(incsearch-nohl-N)<Plug>Pulse
				map * <Plug>(incsearch-nohl-*)<Plug>Pulse
				map # <Plug>(incsearch-nohl-#)<Plug>Pulse
				map g* <Plug>(incsearch-nohl-g*)<Plug>Pulse
				map g# <Plug>(incsearch-nohl-g#)<Plug>Pulse
			endif
		Plug 'pseewald/vim-anyfold'
			let anyfold_activate=1
			let anyfold_identify_comments=0
			set foldlevel=0
		Plug 'arecarn/vim-fold-cycle'
			let g:fold_cycle_default_mapping = 0
			nmap <Tab> <Plug>(fold-cycle-open)
			nmap <S-Tab> <Plug>(fold-cycle-close)
		Plug 'rhysd/clever-f.vim'
			let g:clever_f_ignore_case=1
			let g:clever_f_smart_case=1
			"let g:clever_f_mark_char_color='cssColor66ffcc'
		Plug 'dominickng/fzf-session.vim'
			let g:fzf_session_path = '~/.vim-sessions'
			nnoremap <LEADER>sn :Session<space>
			nnoremap <LEADER>sl :SLoad<space>
			nnoremap <LEADER>sd :SDelete<space>
			nnoremap <LEADER>sc :SQuit<CR>
			"nnoremap <LEADER>sl :SList<CR>
			nnoremap <LEADER>ss :Sessions<CR>
		Plug 'jiangmiao/auto-pairs'
		Plug 'haya14busa/vim-operator-flashy'
			let g:operator#flashy#group = 'Visual'
			map y <Plug>(operator-flashy)
			map Y <Plug>(operator-flashy)$
		"Plug 'reedes/vim-wheel'
			let g:wheel#map#up   = '<D-k>'
			let g:wheel#map#down = '<D-j>'
			let g:wheel#map#mouse = 1
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
			Plug 'sheerun/vim-polyglot'
			Plug 'chrisbra/csv.vim'
			"Plug 'lervag/vimtex'
				"Plug 'vim-latex/vim-latex'
		"MISCELLANOUS
			Plug 'mattn/emmet-vim'
				let g:user_emmet_install_global = 0
				autocmd FileType html,css EmmetInstall
				let g:user_emmet_leader_key='<tab>'
	"MISCELLANOUS
		Plug 'alpertuna/vim-header'
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
		Plug 'itchyny/calendar.vim'
			nnoremap <Leader>zcy :Calendar -view=year<CR>
			nnoremap <Leader>zcm :Calendar -view=month<CR>
			nnoremap <Leader>zcw :Calendar -view=week<CR>
			nnoremap <Leader>zcd :Calendar -view=day<CR>
			nnoremap <Leader>zcD :Calendar -view=days<CR>
			nnoremap <Leader>zcc :Calendar -view=clock<CR>
			nnoremap <Leader>zce :Calendar -view=event<CR>
			nnoremap <Leader>zca :Calendar -view=agenda<CR>
		Plug 'shanzi/autoHEADER'
		Plug 'itchyny/dictionary.vim'
			nnoremap <Leader>zd :Dictionary<CR>
			nnoremap <Leader>zD :Dictionary -cursor-word<CR>
		Plug 'leothelocust/vim-makecols'
		Plug 'tweekmonster/startuptime.vim'
		Plug 'sbdchd/vim-shebang'
		Plug 'vim-utils/vim-read'
		Plug 'antoyo/vim-licenses'
		Plug 'vim-scripts/WholeLineColor'
			let g:wholelinecolor_leader = ','
			highlight WLCBlackBackground  ctermbg=233 guibg=#121212
			highlight WLCRedBackground    ctermbg=52  guibg=#882323
			highlight WLCBlueBackground   ctermbg=17  guibg=#003366
			highlight WLCPurpleBackground ctermbg=53  guibg=#732c7b
			highlight WLCGreyBackground   ctermbg=238 guibg=#464646
			highlight WLCGreenBackground  ctermbg=22  guibg=#005500
		Plug 'tyru/open-browser.vim'
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
				nmap <Leader>fL :call ConvertAndOpenUnderCursor()<CR>

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
		Plug 'junegunn/goyo.vim'
			let g:goyo_width = "75%"
			"let g:goyo_height = "90%"
			let g:goyo_linenr = 1
		Plug 'junegunn/limelight.vim'
		Plug 'mtth/scratch.vim'
			let g:scratch_no_mappings      = 1
			let g:scratch_height           = 0.3
			let g:scratch_top              = 0
			let g:scratch_persistence_file = glob('~/') . 'temp.scratch'

			nnoremap <LocalLeader>s :Scratch<CR>
			nnoremap <LocalLeader>S :Scratch!<CR>
			nnoremap <LocalLeader>gp :ScratchPreview<CR>
			nnoremap <LocalLeader>gs :ScratchInsert<CR>
			nnoremap <LocalLeader>gS :ScratchInsert!<CR>
			vnoremap <LocalLeader>gs :ScratchSelection<CR>
			vnoremap <LocalLeader>gS :ScratchSelection!<CR>

			augroup ScratchEnter
				autocmd!
				autocmd BufEnter __Scratch__ nnoremap <buffer> <esc> :q<CR>
			augroup END
		Plug 'mhinz/vim-startify'
		Plug 'suan/vim-instant-markdown'
		Plug 'tpope/vim-capslock'
		"Plug 'natw/keyboard_cat.vim'
		Plug 'MrPeterLee/VimWordpress'
			nnoremap <LocalLeader>wl :call RunInNewBuffer('BlogList', 'wordpress')<CR>
			nnoremap <LocalLeader>wn :call RunInNewBuffer('BlogNew',  'wordpress')<CR>
			nnoremap <LocalLeader>wd :BlogSave draft<CR>
			nnoremap <LocalLeader>wP :BlogSave publish<CR>
			nnoremap <LocalLeader>wD :BlogPreview draft<CR>
			nnoremap <LocalLeader>wp :BlogPreview publish<CR>
			nnoremap <LocalLeader>wc :BlogCode python<CR>
			nnoremap <LocalLeader>wu :BlogUpload<space><CR>
		"Plug 'vim-scripts/autoscroll.vim'
			let g:AutoScrollSpeed = 100
		"Plug 'fadein/vim-FIGlet'
			nnoremap <Leader>zf :FIGlet<CR>
			nnoremap <Leader>zF :FIGlet -f<space>
			vnoremap <Leader>zf :FIGlet<CR>
			vnoremap <Leader>zF :FIGlet -f<space>
		"Plug 'chrisbra/changesPlugin'
		"Plug 'guns/xterm-color-table.vim'
		"Plug 'vim-scripts/ScrollColors'
		"Plug 'vim-scripts/DrawIt'
		"Plug 'gorodinskiy/vim-coloresque'
		"Plug 'hecal3/vim-leader-guide'
			"nnoremap <SPACE> :LeaderGuide '<LEADER>'<CR>
			"nnoremap ; :LeaderGuide '<LOCALLEADER>'<CR>
			"vnoremap <SPACE> :LeaderGuideVisual '<LEADER>'<CR>
			"vnoremap ; :LeaderGuideVisual '<LOCALLEADER>'<CR>

			"DON'T UNCOMMENT THESE
			"nmap <SPACE>. <Plug>leaderguide-global
			"nmap ;. <Plug>leaderguide-buffer
		"Plug 'tweekmonster/nvim-api-viewer'
		"Plug 'kyuhi/vim-emoji-complete'
	"LIBRARIES|UTILITIES|DEPENDENCIES
		Plug 'kana/vim-textobj-user'
		Plug 'kana/vim-operator-user'
		Plug 'mattn/webapi-vim'
		Plug 'Shougo/vimproc.vim'
		Plug 'Shougo/vimshell.vim'
			"CONFIGURATION
				let g:vimshell_prompt = '> '
			"MAPPINGS
				nnoremap <silent> <LocalLeader>cr :execute 'VimShellInteractive ' . g:repls[&filetype]<CR>
		Plug 'lucerion/vim-buffr'
		Plug 'kana/vim-submode'
			let g:submode_always_show_submode = 1
			"let g:submode_keep_leaving_key = 1
			"let g:submode_timeout = 0
			let g:submode_timeoutlen = 1000
		Plug 'vim-scripts/vim-easy-submode'
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
		Plug 'kana/vim-arpeggio'
		Plug 'vim-scripts/tinymode.vim'
		Plug 'tyru/stickykey.vim'
		Plug 'luzhlon/popup.vim'
		Plug 'skywind3000/quickmenu.vim'
	"TODECIDE
		"Plug 'lucerion/vim-executor'
		"Plug 'vim-scripts/Omap.vim'
		"Plug 'tyru/capture.vim'
		"Plug 'JarrodCTaylor/vim-shell-executor'
		"Plug 'tommcdo/vim-express'
		"Plug 'syngan/vim-operator-evalf'
		"Plug 'neitanod/vim-sade'
	call plug#end()
"SETTINGS
	"INDENTATION
		set autoindent
		set smartindent
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
	"COMMANDLINE
		set path+=**
		if has('wildmenu')
			set wildmenu
			set wildmode=longest:full,full
			set wildignore+=*.a,*.o
			set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
			set wildignore+=.DS_Store,.git,.hg,.svn
			set wildignore+=*~,*.swp,*.tmp
			set wildignorecase
		endif
	"UI
		colorscheme Monokai
		set noshowcmd
		set noruler
		set noshowmode
		set cursorline
		set list
		set shortmess="filmnrwxoOTF"
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
		set fillchars=vert:⎪
	"BTW
		set splitbelow
		set nowrap
		set hidden
		set fileformats=unix,mac,dos
	"MISCELLANOUS
		set nocompatible
		set mouse=a
		set clipboard=unnamed
