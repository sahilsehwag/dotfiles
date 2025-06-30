"LEADER
	"nnoremap ; :
	let mapleader			 = ' '
	let maplocalleader = ','

	"let g:modifier_ctrl = 'C'
	"let g:modifier_alt  = 'A'
	"let g:modifier_cmd  = 'D'

	"let g:modifier_ctrl_alt	 = 'C-A'
	"let g:modifier_ctrl_shift = 'C-S'
	"let g:modifier_alt_shift  = 'A-S'

	let g:action_leader		= 'A'
	let g:motion_leader		= 'C-A'
	let g:insert_leader		= ';'
	let g:command_leader	= ';'
	let g:terminal_leader = ';'
	let $PATH = '' . $PATH

"PYTHON-BINARIES
	"let g:loaded_python3_provider = 1
	let g:python3_host_prog = '/Users/sahilsehwag/neovim/bin/python3'
	let g:node_host_prog = '/Users/sahilsehwag/.nvm/versions/node/v12.18.3/bin/node'
"VIMSCRIPT
	"HELPERS
		"VIM
			"FILESYSTEM
				"FUNCTIONS
					function! QuoteIt(path) abort
						return '"' . a:path . '"'
					endfunction

					function! SaveAs(path, bang)
						let l:filename = input('Enter New Filename: ')
						let l:file = a:path . '/' . l:filename

						if empty(l:filename)
							call PEchoError('No Filename Specified')
						elseif a:bang == 0
							if empty(glob(l:file))
								execute "w " . a:path ."/" . l:filename
							else
								call PEchoError('File Already Exists')
							endif
						else
							execute "w! " . a:path ."/" . l:filename
						endif
					endfunction

					function! Read(file, bang)
						if empty(a:file)
							call PEchoError('No File Specified')
						elseif empty(glob(a:file))
							call PEchoError("File Doesn't Exists")
						else
							if a:bang == 0
								execute "read " . a:file
							else
								normal die
								execute "0read " . a:file
							endif
						endif
					endfunction

					function! GetCurrentDirectoryName()
						return expand('%:p:h:t')
					endfunction

					function! GetCurrentDirectoryPath()
						return expand('%:p:h')
					endfunction
				"COMMANDS
					command! -nargs=1 -bang SaveAs :call SaveAs(<q-args>, <bang>0)
					command! -nargs=1 -bang Read	 :call Read(<q-args>, <bang>0)
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
					let [lineStart, columnStart] = getpos("'<")[1:2]
					let [lineEnd, columnEnd] = getpos("'>")[1:2]
					let lines = getline(lineStart, lineEnd)
					if len(lines) == 0
						return ''
					endif
					let lines[-1] = lines[-1][: columnEnd - (&selection == 'inclusive' ? 1 : 2)]
					let lines[0] = lines[0][columnStart - 1:]

					if ExistsAndTrue('a:1')
						return join(lines, "\n")
					else
						return lines
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
				function! ExistsAndTrue(name)
					if exists(a:name)
						return eval(a:name)
					endif
					return 0
				endfunction

				function! IsNix()
					return has('unix') || has('macunix') || has('linux') || has('win32unix')
				endfunction

				function! IsWindows()
					return has('win32')
				endfunction
			"DYNAMIC
				function! DefineMap(type, map, action)
					execute a:type . ' ' . a:map . ' ' . a:action
				endfunction

				function! DefineAbbreviation(source, target)
					execute 'iabbrev' . ' ' . a:source . ' ' . a:target
				endfunction
			"RANDOM
				function! VimCD(path) abort
					cd a:path
				endfunction

				function! SuffixAbbreviation(word)
					return a:word . repeat("\<Left>", strlen(a:word)) . "\<BS>" . repeat("\<Right>", strlen(a:word))
				endfunction
		"EXTERNAL
			"PACKAGE-MANAGERS
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
				"FUNCTIONS
					function! NewFile(path)
						let l:filename = input('Enter New Filename: ')
						let l:file = a:path . '/' . l:filename

						if empty(l:filename)
							call PEchoError('No Filename Specified')
						else
							execute "e " . l:file
						endif
					endfunction

					function! NewDirectory(path)
						let l:dirname = input('Enter New Directory Name: ')
						let l:dir = a:path . '/' . l:dirname

						if empty(l:dirname)
							call PEchoError('No Directory Name Specified')
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
						call PEchoError("File " . a:file ." Deleted Successfully")
					endfunction
				"COMMANDS
					command! -nargs=1		NewFile			:call NewFile			(<q-args>)
					command! -nargs=1		NewDirectory	:call NewDiretory		(<q-args>)
					command! -nargs=1 -bang DeleteDirectory :call DeleteDirectory (<q-args>,<bang>0)
					command! -nargs=1		DeleteFile		:call DeleteFile		(<q-args>)
			"UTILITIES
				"READ-JSON
					function! ReadJSON(path)
						let l:lines = readfile(a:path)
						let l:json = json_decode(l:lines)
						return l:json
					endfunction
	"PLUGINS
		"EXTENSIONS
			"TODO:BETTER-VIM
				"CONFIGURATION
					let g:better_vim_enable_default_mappings = 1
				"TODO:BETTER-EDITING
					"TODO:BETTER-OPERATORS
						"BETTER-DELETE
							let g:better_delete_enable_default_mappings = 0
							if ExistsAndTrue('g:better_vim_enable_default_mappings') && ExistsAndTrue('g:better_delete_enable_default_mappings')
								nnoremap d "_d
								nnoremap D "_D
								nnoremap dd "_dd
								xnoremap d "_d

								nnoremap c "_c
								nnoremap C "_C
								nnoremap cc "_cc
								xnoremap c "_c

								nnoremap gd d
								nnoremap gD D
								nnoremap gdd dd
								xnoremap gd d

								nnoremap gc c
								nnoremap gC C
								nnoremap gcc cc
								xnoremap gc c
							endif
					"TODO:BETTER-OBJECTS
						"TODO:SENTECE|PARAGRAPH
					"TODO:BETTER-MOTIONS
						let g:better_motions_enable_default_mappings = 1
						if ExistsAndTrue('g:better_vim_enable_default_mappings') && ExistsAndTrue('g:better_motions_enable_default_mappings')
							"motions=g*|zz|:nohl<CR>
							"better-solution would be using autocmd! with CursorMoved
							"nnoremap <silent> j gjzz:nohl<CR>
							"nnoremap <silent> k gkzz:nohl<CR>
							"nnoremap <silent> j gj:nohl<CR>
							"nnoremap <silent> k gk:nohl<CR>

							"nnoremap <silent> h h:nohl<CR>
							"nnoremap <silent> l l:nohl<CR>
							"nnoremap <silent> w w:nohl<CR>
							"nnoremap <silent> e e:nohl<CR>
							"nnoremap <silent> b b:nohl<CR>

							nnoremap n nzz
							nnoremap N Nzz

							nnoremap <silent> <C-d> <C-d>zz
							nnoremap <silent> <C-u> <C-u>zz
							nnoremap <silent> <C-f> <C-f>zz
							nnoremap <silent> <C-b> <C-b>zz

							nnoremap 0 ^
							nnoremap ^ 0

							map [[ ?{<CR>w99[{
							map ][ /}<CR>b99]}
							map ]] j0[[%/{<CR>
							map [] k$][%?}<CR>
						endif
					"TODO:BETTER-CURSOR
						"PERSISTENT-CURSOR
							"jump to last known position in file if filetype
							"is not git commit and center(zz) around it
							augroup PERSISTENT_CURSOR
								au!
								autocmd BufReadPost *
									\ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
									\ | exe "normal! g`\"zz"
									\ | end
							augroup END
						"TODO:PRESERVE-CURSOR
							"TODO:PRESERVE-OPERATOR
								"CONFIGURATION
									let g:better_cursor_default_preserve		= 1
									let g:better_cursor_operators_preserve		= []
									let g:better_cursor_operators_no_preserve = ['Op_goto_start', 'Op_goto_end']
								"FUNCTIONS
									function! ShouldPreserve() abort
										return (
											\(
												\g:better_cursor_default_preserve &&
												\index(g:better_cursor_operators_no_preserve, &operatorfunc) == -1
											\) ||
											\(
												\!g:better_cursor_default_preserve &&
												\index(g:better_cursor_operators_preserve, &operatorfunc) > -1
											\)
										\)
									endfunction

									function! PreserveOperator() abort
										"TODO:FIX works for custom-operators but not inbuilt-opreators
										"TODO:!preserve when pasting
										if !empty(&operatorfunc)
											if ShouldPreserve()
												call winrestview(w:opfuncview)
												unlet w:opfuncview
												noautocmd set operatorfunc=
											endif
										endif
									endfunction
								"AUTOCOMANDS
									"augroup PRESERVE_OPERATOR
										"autocmd!
										"autocmd OptionSet operatorfunc let w:opfuncview = winsaveview()
										"autocmd CursorMoved * call PreserveOperator()
									"augroup END
							"TODO:PRESERVE-UNDO
							"TODO:PRESERVE-PASTE
							"TODO:PRESERVE-NAVIGATION
								"TODO:PRESERVE-MOTION
								"TODO:PRESERVE-JUMPS
									"FEATURE:VERTICAL+HORIZONTAL
									"TODO:PRESERVE-SEARCH
									"TODO:PRESERVE-MARKS
						"TODO:GHOST-CURSOR
							"FEATURE:INSERT→NORMAL (INSERT|APPEND)
					"RANDOM
						"TODO:BETTER-INDENT
				"TODO:BETTER-INTERFACE
					"TODO:BETTER-WINDOWS
						"FEATURE:MAXIMIZE
					"BETTER-LINENUMBERS
						"augroup TOGGLE_LINENUMBERS
							"autocmd!
							"autocmd InsertEnter * set norelativenumber
							"autocmd InsertLeave * set relativenumber
						"augroup end
					"TODO:BETTER-FOLDS
						"FEATURE:DONT-OPEN-ON-NON-RELATED-EDITS
						"FEATURE:OPEN-ON-RELATED-EDITS
						"FEATURE:DONT-OPEN-ON-DENTING
						"FEATURE:INDENT-LEVEL-MARKERS
						"FOLD-TEXT
						"FOLD-HIGHLIGHT
							"highlight Folded cterm=NONE
						"RANDOM
							"augroup! BETTER_FOLDS
								"au!
								"au BufWinLeave *.* mkview
								"au BufWinEnter *.* silent! loadview
							"augroup END
				"TODO:BETTER-PROGRAMMING
					"BETTER-MAKE
						augroup BETTER_MAKE
							au!
							"COMPILED
								au Filetype c setl makeprg=gcc\ %:S\ &&\ %:h:S/a.out
								au Filetype cpp setl makeprg=g++\ -std=c++14\ %:S\ &&\ %:h:S/a.out
								au Filetype scala setl makeprg=scalac\ %:S\ &&\ scala\ %:r:S
								au Filetype java setl makeprg=javac\ %:S\ &&\ java\ %:r:S
								au Filetype haskell setl makeprg=ghc\ -Wno-tabs\ %:S\ &&\ %:r:S
								au Filetype processing setl makeprg=processing-java\ --output=/tmp/processing/\ --force\ --sketch=%:h:S\ --run
								au Filetype csx setl makeprg=scriptcs\ %:r:S.csx
								if has('macunix')
									au Filetype cs setl makeprg=csc\ %:p:S\ &&\ mono\ %:r:S.exe
								elseif has('win32')
									au Filetype cs setl makeprg=csc\ %:p:S\ &&\ %:r:S.exe
								endif
							"INTERPRETED
								au Filetype python setl makeprg=python3\ %:S
								au Filetype javascript setl makeprg=node\ %:S
								au Filetype ruby setl makeprg=ruby\ %:S
								au Filetype perl setl makeprg=perl\ %:S
								au Filetype php setl makeprg=php\ %:S
								au Filetype typescript setl makeprg=tsc\ %:S
								au Filetype lua setl makeprg=lua\ %:S
							"SHELL
								au Filetype sh setl makeprg=bash\ %:S
								au Filetype zsh setl makeprg=zsh\ %:S
						augroup END
					"TODO:BETTER-QUICKFIX
						"FEATURE:MODE-VIMLINE
						"FEATURE:FUZZY
					"TODO:BETTER-TAGS
						"TODO:EXECTUABLE
							"TODO:CREATION
							"TODO:UPDATION
						"TODO:NAVIGATION
							"TODO:JUMP
							"TODO:NEXT|PREVIOUS|ROOT
				"TODO:BETTER-TERMINAL
					augroup BETTER_TERMINAL
						autocmd!
						if has('nvim')
							autocmd TermOpen *
								\ setlocal nonumber norelativenumber |
								\ startinsert
						endif
					augroup END
				"BETTER-RANDOM
					"TODO:BETTER-SWAP
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
					"TODO:BETTER-HELP
						"TOC-ON-LEFT
							"FUNCTIONS
								function ShowTOC() abort
									if !has('nvim')
										return v:false
									endif

									let l:bufname = bufname('%')
									let l:info = getloclist(0, { 'winid': 1 })

									if !empty(l:info) && getwinvar(l:info.winid, 'qf_toc') ==# l:bufname
										lopen
										return v:true
									endif

									let l:toc = []
									let l:lnum = 2
									let l:last_line = line('$') - 1

									while l:lnum && l:lnum < l:last_line
										let l:text = getline(l:lnum)

										if l:text =~# '^\%( \{3\}\)\=\S.*$'
											call add(l:toc, { 'bufnr': bufnr('%'), 'lnum': l:lnum, 'text': l:text })
										endif

										let l:lnum = nextnonblank(l:lnum + 1)
									endwhile

									call setloclist(0, l:toc, ' ')
									call setloclist(0, [], 'a', { 'title': 'Man TOC' })

									" Prepare and set options for the window.
									vertical leftabove lopen
									vert resize 35
									setlocal winfixwidth
									setlocal nonumber norelativenumber

									" Define mappings.
									nnoremap <buffer><silent> l <CR>zt
									nnoremap <buffer><silent> <CR> <CR>zt

									" Abort if there is nothing to show.
									let l:list = getloclist(0)
									if empty(l:list)
										return v:false
									endif

									let l:bufnr = l:list[0].bufnr
									setlocal modifiable
									silent 1,$delete _
									call setline(1, map(l:list, 'v:val.text'))
									setlocal nomodifiable nomodified
									let &syntax = getbufvar(l:bufnr, '&syntax')

									let w:qf_toc = l:bufname

									" Move the window to the other side.
									wincmd x
								endfunction

								function! ShowTOCOnLeft() abort
									if has('nvim')
										call ShowTOC()

										setlocal nonumber norelativenumber
										setlocal laststatus=0

										nnoremap <buffer> l <Enter>zt

										wincmd H
										vert resize 35
										wincmd p
									endif
								endfunction
							"AUTOCOMMANDS
								augroup TOC_ON_LEFT
									autocmd!
									if has('nvim')
										autocmd FileType man call ShowTOCOnLeft()
									endif
								augroup END
						"FLOATING-HELP
							if has('nvim')
								"TODO:FIX
								function! FloatingWindowHelp(query) abort
									let s:float_buffer = CreateCenteredFloatingWindow()
									call nvim_set_current_buf(l:buf)
									setlocal filetype=help
									setlocal buftype=help
									execute 'help ' . a:query
								endfunction

								command! -complete=help -nargs=? Help call FloatingWindowHelp(<q-args>)
							endif
					"TODO:BETTER-WRAP
						"COMMANDS
							command! -nargs=* Wrap set wrap linebreak nolist
			"TODO:MODALING
				"TODO:MODE
					"USE:RESET…|RESTRICTION+REPURPOSE
					"TODO:MODE-VIMLINE
					"TODO:MODE-LIST
				"TODO:STATE
					"USE:INTERACTIVE
					"<Leader><Namespace>.
				"TODO:MODIFIER
					"USE:REPETITIVE
					"ALT
				"TODO:PERSISTENT…?
				"TODO:STICKY…?
			"TODO:GRAMMAR
				"FEATURE:NUMBER∙OBJECT=N
				"FEATURE:NUMBER∙OPERATOR=Nth
				"FEATURE:DOT-WITH-COUNT(OPERATOR|OBJECT)
			"TODO:KEYPR
				"ALIAS:WHICH-KEY
			"TODO:FRIEZA
				"ALIAS:STICKY-MOTION|MOTION-LOCK
			"TODO:SCRATCH
			"TODO:BUFEX
				"TODO:RUN-COMMANDS-IN-MULTIPLE-BUFFERS
			"TODO:VISMODE
			"TODO:LIST-BUFFER
				"ALIAS:SEARCH-BUFFER
				"FEATURE:INPUT<-COMMAND|EXCOMMAND
				"TODO:SEARCH→FILTER
					"FEATURE:i→FILTER
					"FEATURE:/→FILTER
					"FEATURE:FZF
				"TODO:NOPPED+REMAP
			"TODO:STATE-BUFFER
				"ALIAS:TABLE-BUFFER
				"FEATURE:BUFFER-FOR-TRANSIENT-STATE
			"MANAGEMENT
				"TODO:BTW
				"TODO:SESSION
				"TODO:REGISTRATION
					"FEATURE:LIST-REGISTERS-IN-BUFFER?
					"FEATURE:LIST-REGISTERS-IN-POPUP?
				"TODO:MARKSMAN
				"TODO:MACROMAN
					"MACROS:RECORD=qr
					"MACROS:HISTORY=qh
					"MACROS:EDIT=qe
					"MACROS:PLAY=qp
					"MACROS:SAVE=qs
					"MACROS:LIST=ql=play|edit|delete
					"MACROS:NESTED
					"MACROS:OPERATORS=MACRO-PLAY|MACRO-NEW
			"RANDOM
				"TODO:ZOOOM
					"TODO:ZOOM-MODE
				"TODO:TOAGGLER
					"VARIABLES
						let g:toaggler_enable_default_mappings = 1
					"AUTOSAVE-TOGGLE
						"VARIABLES
							let g:toaggler_autosave = 0
							let g:toaggler_autosave_enable_default_mappings = 1
						"FUNCTIONS
							function! AutoSaveToggle()
								if g:toaggler_autosave == 0
									echom "AutoSave Mode Enabled"
									let g:toaggler_autosave = 1

									augroup AutoSaveGroup
										autocmd!
										au InsertLeave * silent write
										au TextChanged * silent write
									augroup END
								elseif g:toaggler_autosave == 1
									echom "AutoSave Mode Disabled"
									let g:autosave = 0

									augroup AutoSaveGroup
										autocmd!
									augroup END
								endif
							endfunction
						"DEFAULTS
							if ExistsAndTrue('g:toaggler_enable_default_mappings') && ExistsAndTrue('g:toaggler_autosave_enable_default_mappings')
								nnoremap <Leader>vtw :call AutoSaveToggle()<CR>
							endif
				"TODO:SOURCERER
					"augroup SOURCERER
						"au!
						"au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,init.vim so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
					"augroup END
		"EDITING
			"OPERATOR
				"TODO:HOO-RANGE
					"FEATURE:DOT=TARGET
					"FEATURE:OPERATION=PASTE|MACRO
					"FEATURE:OBJECT=MARK|REGISTER
					"FEATURE:STATE
						"FEATURE:OPERATOR-DOT
					"TODO:HOO-REPLACE
				"TODO:HOO-REPEAT
				"TODO:OPERATOR-GOTO
					"FEATURE:GOTO-START=[
					"FEATURE:GOTO-END=]
				"OPERATOR-EXRANGE
					function! OperatorExRange(visual)
						let [lineStart, columnStart] = getpos(a:0 ? "'<" : "'[")[1:2]
						let [lineEnd, columnEnd]	 = getpos(a:0 ? "'>" : "']")[1:2]
						let lines					 = getline(lineStart, lineEnd)

						if len(lines) == 0
							return
						endif

						if a:visual == 'block' || a:visual == "\<c-v>"
							call PEchoError('Operator not defined for VISUAL-BLOCK mode')
							return
						elseif a:visual == 'line' || a:visual ==# 'V'
							for line in lines
								execute line
							endfor
						elseif a:visual == 'char' || a:visual ==# 'v'
							let lines[-1] = lines[-1][: columnEnd - (&selection == 'inclusive' ? 1 : 2)]
							let lines[0]	= lines[0][columnStart - 1:]

							for line in lines
								execute line
							endfor
						endif
					endfunction

					"nnoremap <silent> g; :set opfunc=OperatorExRange<CR>g@
					"vnoremap <silent> g; :<C-U>call OperatorExRange(visualmode())<CR>

					"nnoremap <silent> g;; :execute getline('.')<CR>
					"vnoremap <silent> g;; :<C-U>execute getline('.')<CR>
			"OBJECT
				"CHAR-OBJECTS
					"TODO:OBJECT-VARIABLE
				"LINE-OBJECTS
					"OBJECT-LINE
						vnoremap il :<C-u>normal! ^v$h<CR>
						onoremap il :<C-u>normal! ^v$h<CR>

						vnoremap al :<C-u>normal! Vh<CR>
						onoremap al :<C-u>normal! Vh<CR>
					"TODO:OBJECT-BEFORE
						vnoremap b= :<C-u>normal! ^vt=<CR>
						onoremap b= :<C-u>normal! ^vt=<CR>
						vnoremap b: :<C-u>normal! ^vt:<CR>
						onoremap b: :<C-u>normal! ^vt:<CR>
						vnoremap b- :<C-u>normal! ^vt-<CR>
						onoremap b- :<C-u>normal! ^vt-<CR>
						vnoremap B= :<C-u>normal! ^vf=<CR>
						onoremap B= :<C-u>normal! ^vf=<CR>
						vnoremap B: :<C-u>normal! ^vf:<CR>
						onoremap B: :<C-u>normal! ^vf:<CR>
						vnoremap B- :<C-u>normal! ^vf-<CR>
						onoremap B- :<C-u>normal! ^vf-<CR>
					"TODO:OBJECT-BETWEEN
					"TODO:OBJECT-AFTER
						"TEXT-OBJECT
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
					"TODO:OBJECT-AT
				"BLOCK-OBJECTS
					"TODO:OBJECT-INDENT
					"TODO:OBJECT-FOLD
					"TODO:OBJECT-EDGE
						"FEATURE:PARAGRAPH-EDGE
					"OBJECT-ENTIRE
						vnoremap ie :<C-u>normal! ggVG<CR>
						onoremap ie :<C-u>normal! ggVG<CR>
				"RANDOM
					"OBJECT-VISUAL
						onoremap gv :<C-u>normal! gv<Enter>
				"TODO:LANGUAGE-OBJECTS
					"TODO:OBJECT-VARIABLE
					"TODO:OBJECT-SEGMENT
					"TODO:OBJECT-CONDINTIONAL
					"TODO:OBJECT-ITERATION
					"TODO:OBJECT-FUNCTION
					"TODO:OBJECT-PARAMETERS
					"TODO:OBJECT-ARGUMENTS
					"TODO:OBJECT-CLASS
					"TODO:OBJECT-BLOCK
			"MOTION
				"TODO:DOT-MOTION
				"TODO:OBJECT-MOTION
				"TODO:NESTED-MOTION
					"LEVEL:PARALLEL([])|DENT(<>)
					"TODO:%|[]
					"TODO:NON-STRUCTURED
						"TODO:FOLD
					"TODO:SEMI-STRUCTURED
						"TODO:INDENT
					"TODO:STRUCTURED
						"TODO:BLOCK={[()]}
				"TODO:KEYWORD-MOTION
				"TODO:IDENTIFIER-MOTION
			"RANDOM
				"TODO:HOOKS
					"TODO:HOOK-FLASH
					"TODO:HOOK-STAY|START|END
					"TODO:HOOK-BLINK
					"TODO:HOOK-ZZ?
					"TODO:HOOK-NOHL?
				"TODO:INSERT-INDENT
				"TODO:STATEFUL-ATOMS
		"SYSTEM
			"TERMINAL
				"FEATURE:TOGGLE
					"https://pastebin.com/FjdkegRH
					"https://gist.github.com/ram535/b1b7af6cd7769ec0481eb2eed549ea23
					"https://github.com/pakutoma/toggle-terminal/blob/master/autoload/toggle_terminal.vim
					"https://github.com/kutsan/dotfiles/blob/8b243cd065b90b3d05dbbc71392f1dba1282d777/.vim/autoload/kutsan/mappings.vim#L1-L52
				if has('nvim')
					"VARIABLES
						let g:terminal_enable_default_mappings = 1
						let g:terminal_program =
							\ IsWindows()
							\ ? "cmd"
							\ : "zsh"
					"FUNCTIONS
						function! Terminal(count, dir, pos, bang, cmd)
							if a:count == 0
								execute a:dir a:pos
							else
								execute a:dir . ' ' . a:count a:pos
							endif

							setl modifiable
							setl nobuflisted

							if a:bang == 0
								call termopen(a:cmd, {'on_exit': function('TerminalOnExit')})
							elseif a:bang == 1
								call termopen(a:cmd)
							endif

							let s:last_terminal_job_id = b:terminal_job_id
							startinsert
						endfunction

						function! TerminalOnExit(job_id, code, event) dict
							if a:code == 0
								bdelete!
							endif
						endfunction

						function! TerminalSend(lines)
							call jobsend(s:last_terminal_job_id, add(a:lines, ''))
						endfunction
					"COMMANDS
						command! -bang			-nargs=1 Term		call Terminal(0		 , ''			 , 'enew', <bang>0, <q-args>)
						command! -bang -count -nargs=1 HBTerm call Terminal(<count>, 'botright'  , 'new' , <bang>0, <q-args>)
						command! -bang -count -nargs=1 HTTerm call Terminal(<count>, 'topleft'	 , 'new' , <bang>0, <q-args>)
						command! -bang -count -nargs=1 VLTerm call Terminal(<count>, 'leftabove' , 'vnew', <bang>0, <q-args>)
						command! -bang -count -nargs=1 VRTerm call Terminal(<count>, 'rightbelow', 'vnew', <bang>0, <q-args>)

						command! TermSendSelected		call TerminalSend(GetSelectedText(), '\n')
						command! TermSendFile			call TerminalSend(getline(0, '$'))
						command! TermSendLine			call TerminalSend([getline('.')])
					"OPERATORS
						"OPERATOR:SEND
							function! OperatorTerminalSend(visual, ...)
								let [lineStart, columnStart] = getpos(a:0 ? "'<" : "'[")[1:2]
								let [lineEnd, columnEnd]	 = getpos(a:0 ? "'>" : "']")[1:2]
								let lines					 = getline(lineStart, lineEnd)

								if len(lines) == 0
									return
								endif

								if a:visual == 'block' || a:visual == "\<c-v>"
									call PEchoError('Operator(SEND) not defined for VISUAL-BLOCK mode')
									return
								elseif a:visual == 'line' || a:visual ==# 'V'
									call TerminalSend(lines)
								elseif a:visual == 'char' || a:visual ==# 'v'
									let lines[-1] = lines[-1][: columnEnd - (&selection == 'inclusive' ? 1 : 2)]
									let lines[0]	= lines[0][columnStart - 1:]
									call TerminalSend(lines)
								endif
							endfunction
					"MAPPINGS
						"OPERATOR
							nmap <silent> <Plug>(terminal-send-operator) :set opfunc=OperatorTerminalSend<CR>g@
							vmap <silent> <Plug>(terminal-send-operator) :<c-u>call OperatorTerminalSend(visualmode(), 1)<CR>
						"COMMANDS
							nmap <silent> <Plug>(terminal-send-line) :TermSendLine<CR>
							vmap <silent> <Plug>(terminal-send-line) :<c-u>TermSendLine<CR>
					"DEFAULTS
						if has('nvim') && ExistsAndTrue('g:terminal_enable_default_mappings')
							let g:terminal_program =
								\ IsWindows()
								\ ? "cmd"
								\ : "zsh"

							nmap <silent> gz <Plug>(terminal-send-operator)
							vmap <silent> gz <Plug>(terminal-send-operator)

							nmap <silent> gzz <Plug>(terminal-send-line)
							vmap <silent> gzz <Plug>(terminal-send-line)

							call DefineMap('nnoremap <silent> ', '<Leader>tb', ':Term '		. g:terminal_program . '<CR>')
							call DefineMap('nnoremap <silent> ', '<Leader>tv', ':VRTerm '	. g:terminal_program . '<CR>')
							call DefineMap('nnoremap <silent> ', '<Leader>th', ':15HBTerm ' . g:terminal_program . '<CR>')

							call DefineMap('nnoremap <silent> ', '<Leader>tB', ':lcd %:p:h \| Term '	 . g:terminal_program . '<CR>')
							call DefineMap('nnoremap <silent> ', '<Leader>tV', ':lcd %:p:h \| VRTerm '	 . g:terminal_program . '<CR>')
							call DefineMap('nnoremap <silent> ', '<Leader>tH', ':lcd %:p:h \| 15HBTerm ' . g:terminal_program . '<CR>')
						endif
				endif
			"VIFM
				if has('nvim')
					"TODO:VifmCurrentDirectory | VifmCurrentFileDirectory
					"TODO:path-expansion
					"TODO:robust-filename-escape
					"VARIABLES
						let g:vifm_enable_default_mappings = 1
					"FUNCTIONS
						function! Vifm(path)
							let l:vifm_tempname = tempname()

							if IsWindows() || has('win32unix')
								let l:command = 'Vifm --choose-files ' . l:vifm_tempname . ' "' . expand(a:path) . '"'
							else
								let l:command = 'Vifm --choose-files ' . l:vifm_tempname . ' ' . fnameescape(expand(a:path))
							endif

							execute 'leftabove 40vnew'
							call termopen(l:command, {'on_exit': function('VifmOnExit')})
							setl modifiable
							startinsert

							let l:vifm_job_id	= b:terminal_job_id
							let s:vifm_tempname = l:vifm_tempname
						endfunction

						function! VifmOnExit(...)
							bdelete!
							let l:lines = readfile(s:vifm_tempname)
							if len(l:lines) > 0
								for line in l:lines
									execute 'edit ' . fnameescape(line)
								endfor
							endif
						endfunction
					"COMMANDS
						command! -narg=1 Vifm :call Vifm(<q-args>)
					"DEFAULTS
						if ExistsAndTrue('g:vifm_enable_default_mappings')
						endif
				endif
			"TODO:FILESYSTEM
				"EXTENSION:FZF
				"FEATURE:FINDISH|GREPISH
			"TODO:LINUX
				"VARIABLES
					let g:linuxing_enable_default_mappings = 1
				"DEFAULTS
					if ExistsAndTrue('g:linuxing_enable_default_mappings')
						vnoremap <Leader>lus :sort							 <CR>
						vnoremap <Leader>luu :<C-u>'<,'>sort \| '<,'>!uniq <CR>
						vnoremap <Leader>luc :<C-u>'<,'>!bc					 <CR>
					endif
			"TODO:PACMAN
				"CONFIGURATION
					let g:pacman_managers = {}
					let g:pacman_managers.window = {}
					let g:pacman_managers.nix = {}
					let g:pacman_managers.programming = {}
				"FUNCTIONS
				"COMMANDS
				"MAPPINGS
				"DEFAULTS
		"PROGRAMMING
			"EXECUTIONER
				let g:executioner_enabled = 1
				if ExistsAndTrue('g:executioner_enabled')
					"CONFIGURATION
						let g:executioner_enable_default_mappings = 1
						let g:languages = {}
							"LANGUAGE
								"INTERPRETED
									let g:languages.python = {
										\'extension' : 'py',
										\'repl'		 : 'ipython',
										\'execute'	 : 'python3 %:p:S',
										\'init'		 : [
											\'import os',
											\'import sys',
											\'import re',
											\'from collections import *',
											\'import pprint',
											\'import time',
											\'import datetime',
											\'import itertools',
											\'import functools',
											\'import datetime',
											\'import numpy as np',
											\'import pandas as pd',
											\'import matplotlib.pyplot as plt',
										\],
									\}
									let g:languages.r = {
										\'extension' : 'r',
										\'repl'		 : 'r',
									\}
									let g:languages.javascript = {
										\'extension' : 'js',
										\'repl'		 : 'node',
										\'execute'	 : 'node %:p:S',
									\}
									let g:languages.ruby = {
										\'extension' : 'rb',
										\'repl'		 : 'irb',
										\'execute'	 : 'ruby %:p:S',
									\}
									let g:languages.perl = {
										\'extension' : 'pl',
										\'repl'		 : 'perl',
										\'execute'	 : 'perl %:p:S',
									\}
									let g:languages.php = {
										\'extension' : 'php',
										\'repl'		 : 'php',
										\'execute'	 : 'php %:p:S',
									\}
									let g:languages.lisp = {
										\'extension' : 'lsp',
										\'repl'		 : 'sbcl',
									\}
									let g:languages.lua = {
										\'extension' : 'lua',
										\'repl'		 : 'lua',
										\'execute'	 : 'lua %:p:S',
									\}
								"COMPILED
									let g:languages.c = {
										\'extension'		 : 'c',
										\'repl'				 : 'cling',
										\'compile'			 : 'gcc %:p:S -o %:p:r:S.out',
										\'execute'			 : '%:p:r:S.out',
										\'compile-execute' : 'gcc %:p:S -o %:p:r:S.out && %:p:r:S.out',
										\'init'		 : [
												\'#include <stdio.h>',
												\'#include <math.h>',
										\],
									\}
									let g:languages.cpp = {
										\'extension'		 : 'cpp',
										\'repl'				 : 'cling',
										\'compile'			 : 'g++ -std=c++14 %:p:S -o %:p:r:S.out',
										\'execute'			 : '%:p:r:S.out',
										\'compile-execute' : 'g++ -std=c++14 %:p:S -o %:p:r:S.out && %:p:r:S.out',
										\'init'				 : [
											\'#include <iostream>',
											\'#include <string>',
											\'using namespace std;',
										\],
									\}
									let g:languages.cs = {
										\'extension'		 : 'cs',
										\'repl'				 : 'csharp',
										\'compile'			 : 'csc %:p:s',
										\'execute'			 : 'mono %:p:r:s.exe',
										\'compile-execute' : 'csc %:p:s && mono %:p:r:s.exe',
									\}
									let g:languages.csx = {
										\'extension' : 'csx',
										\'repl'		 : 'scriptcs',
										\'execute'	 : 'scriptcs %:p:r:S.csx',
									\}
									let g:languages.java = {
										\'extension'		 : 'java',
										\'repl'				 : 'jshell',
										\'compile'			 : 'javac %:p:S',
										\'execute'			 : 'java %:p:r:S',
										\'compile-execute' : 'javac %:p:S && java %:p:r:S',
									\}
									let g:languages.scala = {
										\'extension'		 : 'scala',
										\'repl'				 : 'scala',
										\'compile'			 : 'scalac %:p:S',
										\'execute'			 : 'scala %:p:r:S',
										\'compile-execute' : 'scalac %:p:S && scala %:p:r:S',
									\}
									let g:languages.haskell = {
										\'extension'			 : 'hs',
										\'repl'						 : 'ghci',
										\'compile'				 : 'ghc -Wno-tabs %:p:S',
										\'execute'				 : '%:p:r:S',
										\'compile-execute' : 'ghc -Wno-tabs %:p:S && %:p:r:S',
									\}
									let g:languages.typescript = {
										\'extension'			 : 'ts',
										\'repl'						 : 'ts-node',
										\'compile'				 : 'tsc %:p:S',
										\'execute'				 : 'node %:p:r:S.js',
										\'compile-execute' : 'tsc %:p:S && node %:p:r:S.js',
									\}
									let g:languages.processing = {
										\'extension'			 : 'pde',
										\'compile'				 : 'processing-java --output=/tmp/processing/ --force --sketch=%:p:h:S --build',
										\'execute'				 : 'processing-java --output=/tmp/processing/ --force --sketch=%:p:h:S --run',
										\'compile-execute' : 'processing-java --output=/tmp/processing/ --force --sketch=%:p:h:S --run',
									\}
							"REPL
								"SHELL
									let g:languages.sh = {
										\'extension' : 'sh',
										\'repl'		 : 'sh',
										\'execute'	 : 'sh %:p:S',
									\}
									let g:languages.bash = {
										\'extension' : 'bash',
										\'repl'		 : 'bash',
										\'execute'	 : 'bash %:p:S',
									\}
									let g:languages.zsh = {
												\'extension' : 'zsh',
												\'repl'		 : 'zsh',
												\'execute'	 : 'zsh %:p:S',
												\}
									let g:languages.fish = {
										\'extension' : 'fsh',
										\'repl'		 : 'fsh',
										\'execute'	 : 'fsh',
									\}
									let g:languages.batch = {
										\'extension' : 'cmd',
										\'repl'		 : 'cmd',
									\}
								"DATABASE
									let g:languages.sqlite = {
										\'extension' : 'sql',
										\'repl'		 : 'sqlite',
									\}
									let g:languages.mysql = {
										\'extension' : 'mysql',
										\'repl'		 : 'mysql',
									\}
									let g:languages.redis = {
										\'extension' : 'redis',
										\'repl'		 : 'redis-cli',
									\}
									let g:languages.mongo = {
										\'extension' : 'mongo',
										\'repl'		 : 'mongo',
									\}
							"FRAMEWORKS
					"FUNCTIONS
						if has('vim')
							"TODO
						elseif has('nvim')
							"FUNCTIONS
								function! ExecutionerCommand(type, ...) abort
									if exists('a:1') && len(a:1) > 0
										let l:filetype = a:1
									else
										let l:filetype = &filetype
									endif

									if has_key(g:languages, l:filetype) == 1
										let l:lang = g:languages[l:filetype]

										if has_key(l:lang, a:type) == 1
											if a:type == 'repl'
												let s:executioner_last_repl_filetype = l:filetype
											endif

											let l:command = substitute(l:lang[a:type], '%\(:\w\)\+', '\=expand(submatch(0))', 'g')
											return l:command
										else
											call PEchoError(l:filetype . ' does not support ' . a:type . ' operation')
											return
										endif
									else
										call PEchoError(l:filetype . ' filetype is not supported')
										return
									endif
								endfunction

								function! ExecutionerInitREPL()
									let l:filetype = s:executioner_last_repl_filetype

									if has_key(g:languages, l:filetype) == 1
										let l:lang = g:languages[l:filetype]

										if has_key(l:lang, 'init') == 1
											call TerminalSend(l:lang['init'])
										endif
									else
										call PEchoError(l:filetype . ' filetype is not supported')
										return
									endif
								endfunction
						endif
					"COMMANDS
						command! -narg=? ExecutionerREPL	 :execute 'VRTerm '	 . ExecutionerCommand('repl', <q-args>) | :call ExecutionerInitREPL()
						command! ExecutionerCompile				 :execute '10HBTerm '  . ExecutionerCommand('compile')
						command! ExecutionerExecute				 :execute '20HBTerm! ' . ExecutionerCommand('execute')
						command! ExecutionerCompileExecute :execute '20HBTerm! ' . ExecutionerCommand('compile-execute')
					"MAPPINGS
						nmap <silent> <Plug>(executioner-repl)				:ExecutionerREPL<CR>
						nmap <silent> <Plug>(executioner-compile)			:ExecutionerCompile<CR>
						nmap <silent> <Plug>(executioner-execute)			:ExecutionerExecute<CR>
						nmap <silent> <Plug>(executioner-compile-execute) :ExecutionerCompileExecute<CR>
						nmap <silent> <Plug>(executioner-fzf-repl)			:call fzf#run(fzf#wrap({'source': getcompletion('', 'filetype'), 'sink': 'ExecutionerREPL'}))<CR>
					"DEFAULTS
						if ExistsAndTrue('g:executioner_enable_default_mappings')
							nmap <LocalLeader>cr <Plug>(executioner-repl)
							nmap <LocalLeader>cb <Plug>(executioner-compile)
							nmap <LocalLeader>ce <Plug>(executioner-execute)

							nmap <LocalLeader>cR <Plug>(executioner-fzf-repl)
							nmap <LocalLeader>cq <Plug>(executioner-compile-execute)
						endif
				endif
			"TODO:COMMENTFUL
			"TODO:SNIPING
			"TODO:COMMMITMENT
			"TODO:TRANSFORMERS
			"TODO:BOOTIFICATION
			"TODO:FINISH-IT
			"TODO:THE-PUNISHER
			"SPACE-WARRIOR
				"TODO:VISUAL-MODE
				"TODO:DELETE-EMPTY-LINES
				"TODO:COLLAPSE-n-EMPTY-LINES
				"VARIABLES
					let g:space_warrior_enable_default_mappings					 = 1
					let g:space_warrior_highlight_trailing_whitespaces	 = 1
					let g:space_warrior_highlight_leading_spaces				 = 1
					let g:space_warrior_highlight_leading_tabs					 = 0
					let g:space_warrior_highlight_listchars							 = 1
					let g:space_warrior_highlight_consecutive_blanklines = 1
				"FUNCTIONS
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

					function! StripTrailingWhitespace()
						execute ':%s/\s\+$//e'
						execute ':%s/\t\+$//e'
					endfunction
				"COMMANDS
					command! SWSpaces2Tabs				 :execute ConvertSpaces2Tabs()
					command! SWTabs2Spaces				 :execute ConvertSpaces2Tabs()
					command! SWStripTrailingWhitespace :execute StripTrailingWhitespace()
				"AUTOCOMMANDS
					augroup SPACE_WARRIOR
						"TODO:DISABLE FOR LARGE-FILES
						autocmd!
						"autocmd BufWritePre *
							"\ call StripTrailingWhitespace() |
							"\ call ConvertTabs2Spaces()
					augroup end
				"MAPPINGS
					nmap <silent> <Plug>(sw-spaces-2-tabs)				 :SWSpaces2Tabs<CR>
					nmap <silent> <Plug>(sw-tabs-2-spaces)				 :SWTabs2Spaces<CR>
					nmap <silent> <Plug>(sw-strip-trailing-whitespace) :SWStripTrailingWhitespace<CR>
				"HIGHLIGHTS
					"TODO:FIX
					"LEADING-TABS TODO:FIX
						if ExistsAndTrue('g:space_warrior_highlight_leading_tabs')
							highlight LeadingTabs ctermbg=135
							call matchadd('LeadingTabs', '^\t\+', 100)
						endif
					"LEADING-SPACES TODO:FIX
						if ExistsAndTrue('g:space_warrior_highlight_leading_spaces')
							highlight LeadingSpaces ctermbg=135
							call matchadd('LeadingSpaces', '^ \+', 100)
						endif
					"TRAILING-WHITESPACES TODO:FIX
						if ExistsAndTrue('g:space_warrior_highlight_trailing_whitespaces')
							"highlight TrailingWhitespace ctermfg=135
							"call matchadd('TrailingWhitespace', '\s\+$', 100)
							highlight TrailingTabs ctermbg=135
							call matchadd('TrailingTabs', '\t\+$', 100)
							highlight TrailingSpaces ctermbg=135
							call matchadd('TrailingSpaces', ' \+$', 100)
						endif
					"CONSECUTIVE-BLANKLINES TODO:FIX
						if ExistsAndTrue('g:space_warrior_highlight_consecutive_blanklines')
							highlight ConsecutiveBlankLines ctermbg=135
							call matchadd('ConsecutiveBlankLines', '\(^$\n\)\{2,}', 100)
						endif
					"LISTCHARS
						if ExistsAndTrue('g:space_warrior_highlight_listchars')
							highlight EndOfBuffer ctermfg=245 guifg=#658595
							highlight NonText		ctermfg=135 guifg=#af5fff
							highlight Whitespace	ctermfg=135 guifg=#af5fff
						endif
				"DEFAULTS
					if ExistsAndTrue('g:space_warrior_enable_default_mappings')
						nmap <Leader>xt <Plug>(sw-spaces-2-tabs)
						nmap <Leader>xs <Plug>(sw-tabs-2-spaces)
						nmap <Leader>xw <Plug>(sw-strip-trailing-whitespace)
						vmap <Leader>xt <Plug>(sw-spaces-2-tabs)
						vmap <Leader>xs <Plug>(sw-tabs-2-spaces)
						vmap <Leader>xw <Plug>(sw-strip-trailing-whitespace)

						nmap <Leader>xb :g:^$\n\{3,}:d<CR>
						nmap <Leader>xr :%retab!<CR>

						"temporary namespace mappings
						nmap <Leader>etw :let g:space_warrior_highlight_trailing_whitespaces = !g:space_warrior_highlight_trailing_whitespaces<CR>
						nmap <Leader>ets :let g:space_warrior_highlight_leading_spaces		 = !g:space_warrior_highlight_leading_spaces<CR>
						nmap <Leader>ett :let g:space_warrior_highlight_leading_tabs		 = !g:space_warrior_highlight_leading_tabs<CR>
						nmap <Leader>etl :let g:space_warrior_highlight_listchars			 = !g:space_warrior_highlight_listchars<CR>
					endif
			"TODO:NOISE-FREE
			"TODO:GRAMMAR
		"DEVELOPMENT
			"TODO:PROJECTINATOR
				"FEATURE:PERSISTENCE
				"CONFIGURATION
					let g:projectinator_enable = 1
					let g:projectinator_enable_default_mappings = 1
				"FUNCTIONS
					function! GetProjectRoot() abort
						if executable('git')
							let l:root = system('git rev-parse --show-toplevel')
							return l:root
						else
							call PEchoError('"git" not installed')
						endif
					endfunction

					function! SetProjectRoot() abort
						execute 'cd ' . GetProjectRoot()
					endfunction
				"COMMANDS
					command! ProjectinatorOpenProject :call fzf#run(fzf#wrap({
						\ 'source'	: g:jaat_find_directories_command . ' ' . g:jaat_home_path,
						\ 'sink'	: 'cd',
						\ 'options' : '--prompt "open-project> "'
					\}))<CR>

					command! ProjectinatorOpenFile :call fzf#run(fzf#wrap({
						\ 'source'	: g:jaat_find_files_command,
						\ 'sink'	: 'edit',
						\ 'options' : '--prompt "open-project-file> "'
					\}))<CR>

					command! ProjectinatorSearchText :call fzf#run(fzf#wrap({
						\ 'source'	: g:jaat_find_lines_command,
						\ 'sink'	: 'edit',
						\ 'options' : '--prompt "search-project> "'
					\}))<CR>
				"DEFAULTS
					if ExistsAndTrue('g:projectinator_enable_default_mappings')
						nnoremap <silent> <Leader>po :ProjectinatorOpenProject<CR>
						nnoremap <silent> <Leader>pf :ProjectinatorOpenFile<CR>
						nnoremap <silent> <Leader>pt :ProjectinatorSearchText<CR>

						nnoremap <silent> <A-f> :ProjectinatorOpenFile<CR>
					endif
			"TODO:PACKMAN
			"TODO:FRAMEWORKS
		"LIBRARIES
			"TODO:LOGGER
			"TODO:ECHOES
				"TODO:FIX HIGHLIGHTS
				function! PEcho(msg)
					echohl WildMenu
					echom "INFO: " . a:msg
					call getchar()
					echohl None
				endfunction

				function! PEchoSuccess(msg)
					echohl MoreMsg
					echom "SUCCESS: " . a:msg
					call getchar()
					echohl None
				endfunction

				function! PEchoWarning(msg)
					echohl WildMenu
					echom "WARNING: " . a:msg
					call getchar()
					echohl None
				endfunction

				function! PEchoError(msg)
					echohl ErrorMsg
					echomsg "ERROR: " . a:msg
					call getchar()
					echohl None
				endfunction
			"TODO:ANSWER-ME-GODDAMN-IT
				function! Prompt(msg)
				endfunction
			"TODO:OUTPUT
			"TODO:TUNER
		"RANDOM
			"SYMBOLIC
				"VARIABLES
					let g:symbolic_leader =
						\ exists('g:insert_leader')
						\ ? g:insert_leader
						\ : ';'
					let g:symbolic_enable_default_mappings = 1
					let g:symbolic_use_imap = 1
					let g:symbolic_pairs = {}
						let g:symbolic_pairs.miscellanous = [
							\["chk"  , "✓" ],
							\["crs"  , "✖" ],
							\[".."	 , "…" ],
							\["..."  , "⋯" ],
							\["deg"  , "°" ],
							\["8"	 , "∞" ],
							\["-8"	 , "-∞"],
							\["-"	 , "―" ],
							\["tf"	 , "∴" ],
							\["ie"	 , "∵" ],
							\["ang"  , "∠" ],
							\["rang" , "∟" ],
							\["perp" , "⊥" ],
							\["cong" , "≅" ],
							\["&"	 , "∧" ],
							\["\\|"  , "∨" ],
							\["!"	 , "¬" ],
							\["'"	 , "′" ],
							\["''"	 , "″" ],
							\["T"	 , "⊤" ],
							\["iT"	 , "⊥" ],
							\["-\\|" , "⊣" ],
							\["\\|-" , "⊢" ],
							\["\\|=" , "⊨" ],
						\]
						let g:symbolic_pairs.arrows = [
							\["->u"		, "↑"],
							\["->d"		, "↓"],
							\["<-"		, "←"],
							\["->"		, "→"],
							\["<->"		, "↔"],
							\["<.."		, "⇠"],
							\["..>"		, "⇢"],
							\["..>u"	, "⇡"],
							\["..>d"	, "⇣"],
							\["<--"		, "⟵"],
							\["-->"		, "⟶"],
							\["<-->"	, "⟷"],
							\["<="		, "⇐"],
							\["=>"		, "⇒"],
							\["<=>"		, "⇔"],
							\["<=="		, "⟸"],
							\["==>"		, "⟹"],
							\["<==>"	, "⟺"],
							\["\\|>"	, "↦"],
							\["<\\|"	, "↤"],
							\["\\|->" , "⟼" ],
							\["<-\\|" , "⟻"],
							\["<=\\|" , "⟽"],
							\["\\|=>" , "⟾" ],
						\]
						let g:symbolic_pairs.operators = [
							\["<-"		, "≤"],
							\["<<"		, "≪"],
							\["<<<"		, "⋘"],
							\[">-"		, "≥"],
							\[">>"		, "≫"],
							\[">>>"		, "⋙"],
							\["!="		, "≠"],
							\["*"		, "×"],
							\["/"		, "÷"],
							\["sum"		, "∑"],
							\["prod"	, "∏"],
							\["cprod" , "∐"],
							\["srt"		, "√"],
							\["crt"		, "∛"],
							\["qrt"		, "∜"],
							\["~"		, "≈"],
							\["="		, "≡"],
							\["prop"	, "∝"],
							\["floor" , "⌊⌋"],
							\["ceil"	, "⌈⌉"],
							\["+-"		, "±"],
							\["-+"		, "∓"],
							\["."		, "∙"],
							\["<="		, "≦"],
							\[">="		, "≧"],
							\["ox"		, "⨂"],
							\["o+"		, "⨁"],
							\["o-"		, "⊖"],
							\["o."		, "⨀"],
							\["o*"		, "⊛"],
						\]
						let g:symbolic_pairs.alphabets = [
							\["C", "ℂ"],
							\["E", "𝔼"],
							\["N", "ℕ"],
							\["P", "ℙ"],
							\["Q", "ℚ"],
							\["R", "ℝ"],
							\["U", "𝕌"],
							\["Z", "ℤ"],
						\]
						let g:symbolic_pairs.greek = [
							\["alpha"  , "𝛂"],
							\["beta"	 , "𝛃"],
							\["gamma"  , "𝛄"],
							\["Gamma"  , "Γ"],
							\["delta"  , "𝛅"],
							\["Delta"  , "∆"],
							\["nabla"  , "∇"],
							\["epsi"	 , "𝛆"],
							\["zeta"	 , "ζ"],
							\["eta"		 , "𝛈"],
							\["theta"  , "𝛉"],
							\["Theta"  , "Θ"],
							\["iota"	 , "ι"],
							\["kappa"  , "𝛞"],
							\["lambda" , "𝛌"],
							\["Lambda" , "Λ"],
							\["mu"		 , "𝛍"],
							\["nu"		 , "𝛎"],
							\["xi"		 , "ξ"],
							\["Xi"		 , "Ξ"],
							\["pi"		 , "𝛑"],
							\["Pi"		 , "Π"],
							\["rho"		 , "𝛒"],
							\["sigma"  , "𝛔"],
							\["Sigma"  , "Σ"],
							\["tau"		 , "𝛕"],
							\["upsi"	 , "𝛖"],
							\["Upsi"	 , "ϒ"],
							\["phi"		 , "φ"],
							\["Phi"		 , "𝛟"],
							\["chi"		 , "𝛘"],
							\["psi"		 , "Ψ"],
							\["Psi"		 , "𝛙"],
							\["omega"  , "𝛚"],
							\["Omega"  , "Ω"],
							\["a"		 , "𝛂"],
							\["b"		 , "𝛃"],
							\["e"		 , "𝛆"],
							\["E"		 , "Σ"],
							\["n"		 , "𝛈"],
							\["o"		 , "𝛉"],
							\["i"		 , "ι"],
							\["u"		 , "𝛍"],
							\["v"		 , "𝛎"],
							\["p"		 , "𝛒"],
							\["T"		 , "𝛕"],
							\["w"		 , "𝛚"],
							\["x"		 , "𝛞"],
						\]
						let g:symbolic_pairs.set = [
							\["uu"	 , "∪"],
							\["ud"	 , "∩"],
							\["ur="  , "⊆"],
							\["ur"	 , "⊂"],
							\["nur"  , "⊄"],
							\["ul="  , "⊇"],
							\["ul"	 , "⊃"],
							\["nul"  , "⊅"],
							\["sphi" , "∅"],
							\["bt"	 , "∈"],
							\["nbt"  , "∉"],
							\["fa"	 , "∀"],
							\["te"	 , "∃"],
							\["tne"  , "∄"],
						\]
						let g:symbolic_pairs.calculas = [
							\["f1"	, "∫"],
							\["f2"	, "∬"],
							\["f3"	, "∭"],
							\["f4"	, "⨌"],
							\["of1" , "∮"],
							\["of1" , "∯"],
							\["of1" , "∰"],
							\["pd"	, "𝛛"],
						\]
						let g:symbolic_pairs.relational_algebra = [
							\["lj", "⋉"],
							\["rj", "⋊"],
							\["fj", "⋈"],
						\]
						let g:symbolic_pairs.scripts = [
							\["0u"		 , "⁰"],
							\["1u"		 , "¹"],
							\["2u"		 , "²"],
							\["3u"		 , "³"],
							\["4u"		 , "⁴"],
							\["5u"		 , "⁵"],
							\["6u"		 , "⁶"],
							\["7u"		 , "⁷"],
							\["8u"		 , "⁸"],
							\["9u"		 , "⁹"],
							\["0d"		 , "₀"],
							\["1d"		 , "₁"],
							\["2d"		 , "₂"],
							\["3d"		 , "₃"],
							\["4d"		 , "₄"],
							\["5d"		 , "₅"],
							\["6d"		 , "₆"],
							\["7d"		 , "₇"],
							\["8d"		 , "₈"],
							\["9d"		 , "₉"],
							\["+u"		 , "⁺"],
							\["-u"		 , "⁻"],
							\["(u"		 , "⁽"],
							\[")u"		 , "⁾"],
							\["=u"		 , "⁼"],
							\["+d"		 , "₊"],
							\["-d"		 , "₋"],
							\["(d"		 , "₍"],
							\[")d"		 , "₎"],
							\["=d"		 , "₌"],
							\["au"		 , "ᵃ"],
							\["bu"		 , "ᵇ"],
							\["cu"		 , "ᶜ"],
							\["du"		 , "ᵈ"],
							\["eu"		 , "ᵉ"],
							\["fu"		 , "ᶠ"],
							\["gu"		 , "ᵍ"],
							\["hu"		 , "ʰ"],
							\["iu"		 , "ⁱ"],
							\["ju"		 , "ʲ"],
							\["ku"		 , "ᵏ"],
							\["lu"		 , "ˡ"],
							\["mu"		 , "ᵐ"],
							\["nu"		 , "ⁿ"],
							\["ou"		 , "ᵒ"],
							\["pu"		 , "ᵖ"],
							\["qu"		 , "⁺"],
							\["ru"		 , "ʳ"],
							\["su"		 , "ˢ"],
							\["tu"		 , "ᵗ"],
							\["uu"		 , "ᵘ"],
							\["vu"		 , "ᵛ"],
							\["wu"		 , "ʷ"],
							\["xu"		 , "ˣ"],
							\["yu"		 , "ʸ"],
							\["zu"		 , "ᶻ"],
							\["Au"		 , "ᴬ"],
							\["Bu"		 , "ᴮ"],
							\["Cu"		 , "⁺"],
							\["Du"		 , "ᴰ"],
							\["Eu"		 , "ᴱ"],
							\["Fu"		 , "⁺"],
							\["Gu"		 , "ᴳ"],
							\["Hu"		 , "ᴴ"],
							\["Iu"		 , "ᴵ"],
							\["Ju"		 , "ᴶ"],
							\["Ku"		 , "ᴷ"],
							\["Lu"		 , "ᴸ"],
							\["Mu"		 , "ᴹ"],
							\["Nu"		 , "ᴺ"],
							\["Ou"		 , "ᴼ"],
							\["Pu"		 , "ᴾ"],
							\["Qu"		 , "⁺"],
							\["Ru"		 , "ᴿ"],
							\["Su"		 , "⁺"],
							\["Tu"		 , "ᵀ"],
							\["Uu"		 , "ᵁ"],
							\["Vu"		 , "ⱽ"],
							\["Wu"		 , "ᵂ"],
							\["Xu"		 , "⁺"],
							\["Yu"		 , "⁺"],
							\["Zu"		 , "⁺"],
							\["ad"		 , "ₐ"],
							\["bd"		 , "⁺"],
							\["cd"		 , "⁺"],
							\["dd"		 , "⁺"],
							\["ed"		 , "ₑ"],
							\["fd"		 , "⁺"],
							\["gd"		 , "⁺"],
							\["hd"		 , "⁺"],
							\["id"		 , "ᵢ"],
							\["jd"		 , "ⱼ"],
							\["kd"		 , "⁺"],
							\["ld"		 , "⁺"],
							\["md"		 , "⁺"],
							\["nd"		 , "⁺"],
							\["od"		 , "ₒ"],
							\["pd"		 , "⁺"],
							\["qd"		 , "⁺"],
							\["rd"		 , "ᵣ"],
							\["sd"		 , "⁺"],
							\["td"		 , "⁺"],
							\["ud"		 , "ᵤ"],
							\["vd"		 , "ᵥ"],
							\["wd"		 , "⁺"],
							\["xd"		 , "ₓ"],
							\["yd"		 , "⁺"],
							\["zd"		 , "⁺"],
							\["Ad"		 , "⁺"],
							\["Bd"		 , "⁺"],
							\["Cd"		 , "⁺"],
							\["Dd"		 , "⁺"],
							\["Ed"		 , "⁺"],
							\["Fd"		 , "⁺"],
							\["Gd"		 , "⁺"],
							\["Hd"		 , "⁺"],
							\["Id"		 , "⁺"],
							\["Jd"		 , "⁺"],
							\["Kd"		 , "⁺"],
							\["Ld"		 , "⁺"],
							\["Md"		 , "⁺"],
							\["Nd"		 , "⁺"],
							\["Od"		 , "⁺"],
							\["Pd"		 , "⁺"],
							\["Qd"		 , "⁺"],
							\["Rd"		 , "⁺"],
							\["Sd"		 , "⁺"],
							\["Td"		 , "⁺"],
							\["Ud"		 , "⁺"],
							\["Vd"		 , "⁺"],
							\["Wd"		 , "⁺"],
							\["Xd"		 , "⁺"],
							\["Yd"		 , "⁺"],
							\["Zd"		 , "⁺"],
							\["alphau" , "ᵅ"],
							\["betau"  , "ᵝ"],
							\["epsiu"  , "ᵋ"],
							\["deltau" , "ᵟ"],
							\["thetau" , "ᶿ"],
							\["phiu"	 , "ᶲ"],
							\["Phiu"	 , "ᵠ"],
							\["betad"  , "ᵦ"],
							\["phid"	 , "ᵩ"],
						\]
				"FUNCTIONS
					function! SymbolicDefineMaps()
						for group in values(g:symbolic_pairs)
							for pair in group
								call DefineMap('inoremap', g:symbolic_leader . pair[0], pair[1])
							endfor
						endfor
					endfunction

					"TODO:FIX
					function! SymbolicDefineAbbreviations()
						for group in values(g:symbolic_pairs)
							for pair in group
								call DefineAbbreviation(g:symbolic_leader . pair[0], pair[1])
							endfor
						endfor
					endfunction
				"DEFAULTS
					if ExistsAndTrue('g:symbolic_enable_default_mappings')
						if ExistsAndTrue('g:symbolic_use_imap')
							call SymbolicDefineMaps()
						else
							call SymbolicDefineAbbreviations()
						endif
					endif
			"NOTES
				"TODO:TYPISTA
				"TODO:SUGAR
				"TODO:TAG-OF-WAR
			"TASKS
				"TODO:TODOS
					"TODO:CALENDER
				"TODO:SCRATCH
			"TODO:COLORTUNER
				"FEATURE:INTERFACE
				"FEATURE:SYNTAX
				"FEATURE:HIGHLIGHT
				"FEATURE:COLORWHEEL
			"TODO:WRAPIT.vim
	"EXTENSIONS
		"FZF
			"TODO:FZF-MENU
				"USE:FZF|FZF_PREFIX
				"INTEGRATE:MODE-VIMLINE
				"INTEGRATE:MODE-LIST
			"TODO:FZF-PANE
			"TODO:FZF-SWITCH
				"TODO:BUFFERS
				"TODO:TABS
				"TODO:SESSION
				"TODO:PROJECT
				"TODO:BOOKMARK
			"TODO:FZF-FLOAT
				if has('nvim')
					function! CreateCenteredFloatingWindow()
						let width  = min([&columns - 4, max([80, &columns - 20])])
						let height = min([&lines - 4, max([20, &lines - 10])])

						let top		 = ((&lines - height) / 2) - 1
						let left	 = (&columns - width) / 2
						let opts	 = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

						let top = "╭" . repeat("─", width - 2) . "╮"
						let mid = "│" . repeat(" ", width - 2) . "│"
						let bot = "╰" . repeat("─", width - 2) . "╯"
						let lines = [top] + repeat([mid], height - 2) + [bot]

						"creating new buffer for the floating window
						let s:float_buffer = nvim_create_buf(v:false, v:true)

						"setting the border(text) in buffer
						call nvim_buf_set_lines(s:float_buffer, 0, -1, v:true, lines)

						"opening the window
						call nvim_open_win(s:float_buffer, v:true, opts)

						set winhl=Normal:Floating
						let opts.row += 1
						let opts.height -= 2
						let opts.col += 2
						let opts.width -= 4

						call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
						au BufWipeout <buffer> exe 'bw ' . s:float_buffer
					endfunction

					"let g:fzf_layout = {'window': 'call CreateCenteredFloatingWindow()'}
					"let g:fzf_layout = {'window': {'width': 0.9, 'height':0.6}}
				endif
			"TODO:FZF-EMOJIS
				"CONFIGURATION
				"FUNCTIONS
					function! FZFEmojisLoad(path)
						let l:emojis = ReadJSON(glob(a:path))
						let l:strings = []

						for emoji in l:emojis
							let l:sno	 = string(emoji['sno']) . '.	'
							let l:symbol = '[' . emoji['symbol'] . ' ]' . repeat(' ', 4)
							let l:name	 = emoji['name'] . repeat(' ', 8)
							let l:tags	 = ':' . join(emoji['tags'], ' | ') . ':'

							if emoji['symbol'] == '🥰'
							else
								let l:string = l:sno . l:symbol . l:name
								let l:strings = add(l:strings, l:string)
							endif
						endfor

						let s:fzf_emojis = l:emojis
						return l:strings
					endfunction

					function! FZFEmojisInsert(string)
						let l:id = split(str2nr(a:string), ':')[0]
						execute 'normal! a' . s:fzf_emojis[l:id]['symbol']
					endfunction
				"COMMANDS
					command! -narg=1 FZFEmojisInsert call FZFEmojisInsert(<q-args>)
					command! FZFEmojis :call fzf#run(fzf#wrap({'source': FZFEmojisLoad('~/unicode-emojis.json'), 'sink': 'FZFEmojisInsert'}))<CR>
				"MAPPINGS
					" imap :ej <ESC>:FZFEmojis<CR>
		"FLOATERM
			if executable('vifm')
				command! -nargs=1 Vifm :execute 'FloatermNew ' g:jaat_explorer_command . ' ' . shellescape(<q-args>)

				nnoremap <silent> <Leader>aE :execute 'FloatermNew ' . g:jaat_explorer_command . ' ' . shellescape(getcwd())<CR>
				nnoremap <silent> <Leader>ae :execute 'FloatermNew ' . g:jaat_explorer_command<CR>
			endif

			if executable('glow')
				command! -nargs=1 Glow :execute 'FloatermNew --autoclose=0 glow ' . shellescape(<q-args>)

				nnoremap <silent> <Leader>am :FloatermNew glow<CR>
				nnoremap <silent> <Leader>aM :execute 'FloatermNew --autoclose=0 glow ' . expand('%:p:S')<CR>
			endif

			if executable('ytfzf')
				command! -nargs=? YtFzf FloatermNew ytfzf <q-args>
				command! -nargs=? YtFzfMusic FloatermNew ytfzf -m <q-args>

				nnoremap <silent> <Leader>ay :YtFzf<CR>
				nnoremap <silent> <Leader>aY :YtFzfMusic<CR>
			endif

			if has('mac')
				command! -nargs=1 Typora :execute 'FloatermNew open -a Typora ' . shellescape(<q-args>)
			endif

			if executable('lazygit')
				nnoremap <silent> <Leader>ag :FloatermNew lazygit<CR>
				nnoremap <silent> <Leader>aG :FloatermNew --cwd=/ lazygit<CR>
			endif

			if executable('mitype')
				command! MiType :FloatermNew mitype
				nnoremap <silent> <Leader>at :MiType<CR>
			endif

			if executable('bat')
				command! -nargs=1 Bat :FloatermNew bat <q-args>
			endif

			"if executable('delta')
			"  command! -nargs=2 Delta :FloatermNew delta <q-args>
			"endif

			if executable('open')
				command! -nargs=1 Open :FloatermNew open <q-args>
			endif

			if executable('slack-term')
				command! Slack :FloatermNew slack-term
			endif

			if executable('lazynpm')
				command! Slack :FloatermNew lazynpm
			endif

			if executable('man') && executable('bat')
				command! -nargs=1 Man :FloatermNew man <q-args> | bat
			elseif executable('man') && executable('less')
				command! -nargs=1 Man :FloatermNew man <q-args> | less
			endif
		"FZF-FLOATERM
		"TODO:TABULARIZE
	"RANDOM
		"TODO:I-KNOW-VIM
			"MODES
"VARIABLES
	"PATHS
		let g:jaat_tmp_path = glob('~/.config/nvim/tmp/')
		let g:jaat_root_path =
			\ IsNix()
			\ ? shellescape(expand('/'))
			\ : shellescape(expand('D:'))
		let g:jaat_home_path = expand('~')
		let g:jaat_drive_path =
			\ IsNix()
			\ ? shellescape(expand('~/Google Drive'))
			\ : shellescape(expand(''))
		let g:jaat_nvim_path =
			\ IsNix()
			\ ? fnameescape(expand('~/.config/nvim/init.vim'))
			\ : fnameescape(expand('~/AppData/Local/nvim/init.vim'))
		let g:jaat_vim_path = expand('~/.vimrc')
		let g:jaat_config_path =
			\ has('vim')
			\ ? g:jaat_vim_path
			\ : g:jaat_nvim_path
	"COMMANDS
		"SHELL
		"GREPISH
			let g:jaat_grep_command = 'grep -rHnas --color --exclude-dir=".git" --exclude-dir="node_modules" -i . *'
				"TODO:FIX
			let g:jaat_ag_command	= 'ag --nogroup -s .+'
			let g:jaat_rg_command = 'rg --hidden --follow --no-ignore-vcs --ignore -g "!{node_modules/*,.git/*}"'
		"FINDISH
			let g:jaat_fd_command_files			= "fd -tf --hidden --exclude .git --exclude node_modules '.*'"
			let g:jaat_fd_command_directories = "fd -td --hidden --exclude .git --exclude node_modules '.*'"

			let g:jaat_find_command_files		= 'find -type f -iname'
			let g:jaat_find_command_directories = 'find -type d -iname'
		"EXPLORER
			let g:jaat_vifm_command = 'vifm'
			let g:jaat_ranger_command = 'ranger'
		let g:jaat_shell_command =
			\ IsWindows()
			\ ? "cmd"
			\ : executable('zsh')
			\ ? "zsh"
			\ : executable('fish')
			\ ? "fish"
			\ : executable('bash')
			\ ? "bash"
			\ : "sh"
		let g:jaat_explorer_command =
			\ executable('vifm')
			\ ? g:jaat_vifm_command
			\ : executable('ranger')
			\ ? g:jaat_ranger_command
			\ : ''
		let g:jaat_find_lines_command =
			\ executable('rg')
			\ ? g:jaat_rg_command
			\ : executable('ag')
			\ ? g:jaat_ag_command
			\ : g:jaat_grep_command
		let g:jaat_find_files_command =
			\ executable('fd')
			\ ? g:jaat_fd_command_files
			\ : g:jaat_find_command_files
		let g:jaat_find_directories_command =
			\ executable('fd')
			\ ? g:jaat_fd_command_directories
			\ : g:jaat_find_command_directories
	"CONFIGURATION
		let g:jaat_small_window_height	= 10
		let g:jaat_medium_window_height = 15
		let g:jaat_large_window_height	= 20
		let g:jaat_float_window_height	= 0.8
		let g:jaat_float_window_width		= 0.8
	let g:config = {
		\'paths': {
			\'tmp': glob('~/.config/nvim/tmp'),
			\'lists': glob('~/.config/nvim/tmp/lists'),
			\'drive': shellescape(expand('~/Google Drive')),
			\'plugins': expand('~/.config/nvim/plugged'),
			\'configs': 'plugins',
		\},
		\'configs': {
			\'plugins': 'general/plugins',
			\'languages': 'general/languages',
			\'projects': 'general/projects',
			\'frameworks': 'general/frameworks',
			\'editor': has('vim')
				\ ? glob('~/.vimrc')
				\ : glob('~/.conifg/nvim/init.vim'),
		\},
		\'commands' : {
			\'terminal': 'terminal',
			\'window': 'e',
		\},
		\'executabes': {
			\'shell':
				\ IsWindows()
				\ ? "cmd"
				\ : executable('zsh')
				\ ? "zsh"
				\ : executable('fish')
				\ ? "fish"
				\ : executable('bash')
				\ ? "bash"
				\ : "sh",
			\'lines':
				\ executable('rg')
				\ ? 'rg --hidden --follow --no-ignore-vcs --ignore -g "!{node_modules/*,.git/*}"'
				\ : executable('ag')
				\ ? 'ag --nogroup -s .+'
				\ : 'grep -rHnas --color --exclude-dir=".git" --exclude-dir="node_modules" -i . *',
			\'files':
				\ executable('fd')
				\ ? "fd -tf --hidden --exclude .git --exclude node_modules '.*'"
				\ : 'find -type f -iname',
			\'dirs':
				\ executable('fd')
				\ ? "fd -td --hidden --exclude .git --exclude node_modules '.*'"
				\ : 'find -type d -iname',
			\'explorer':
				\ executable('vifm')
				\ ? 'vifm'
				\ : executable('ranger')
				\ ? 'ranger'
				\ : '',
		\},
	\}
"MAPPINGS
	"NOPS
		map Q <nop>
		map <C-r> <nop>
	"REMAPS
		nnoremap U <C-r>
		noremap ' "
		noremap " '
	"LEADER
		"BASICS
			nnoremap <Leader>vq :qall<CR>
			nnoremap <Leader>vQ :qall!<CR>
		"EDITING
			"OPERATORS
			"OBJECTS
			"MOTIONS
			"JUMPS
				"TODO:DECIDE
					execute 'nnoremap <' . g:action_leader . '-o> <C-o>'
					execute 'nnoremap <' . g:action_leader . '-i> <C-i>'
					execute 'nnoremap <' . g:action_leader . '-[> <C-t>'
					execute 'nnoremap <' . g:action_leader . '-]> <C-]>'
		"INTERFACE
			"TABS
				nnoremap <silent> <Leader>Ta :tabnew		<CR>
				nnoremap <silent> <Leader>Td :tabclose		<CR>
				nnoremap <silent> <Leader>Tn :tabnext		<CR>
				nnoremap <silent> <Leader>Tp :tabprevious <CR>
				nnoremap <silent> <Leader>TN :tabmove -		<CR>
				nnoremap <silent> <Leader>TP :tabmove +		<CR>
			"BUFFERS
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
				nnoremap <silent> <Leader>bda :bufdo bdelete<CR>
				nnoremap <silent> <Leader>bdA :bufdo bdelete!<CR>
				nnoremap <silent> <Leader>bdo :%bdelete<bar>edit#<bar>bnext<bar>bdelete<CR>
				nnoremap <silent> <Leader>bdO :%bdelete!<bar>edit#<bar>bnext<bar>bdelete!<CR>

				"nnoremap <silent> <Leader>bd :bp<bar>sp<bar>bn<bar>bd<CR>
				"nnoremap <silent> <Leader>bD :bdelete<CR>
				nnoremap <silent> <C-S-d> :bp<bar>sp<bar>bn<bar>bd<CR>
				nnoremap <silent> <Leader><Leader>d :bp<bar>sp<bar>bn<bar>bd<CR>

				nnoremap <silent> <Leader>bwc :write<CR>
				nnoremap <silent> <Leader>bwa :wall<CR>
				nnoremap <silent> <Leader>bwC :write!<CR>
				nnoremap <silent> <Leader>bwA :wall!<CR>
				nnoremap <silent> <C-s> :w<CR>
				nnoremap <silent> <C-S-s> :wall<CR>

				nnoremap <Leader>` <C-^>
				nnoremap <silent> <C-p> :bprevious<CR>
				nnoremap <silent> <C-n> :bnext<CR>
			"WINDOWS
				nnoremap <silent> <Leader>wh :sp<CR>
				nnoremap <silent> <Leader>wv :vsp<CR>
				nnoremap <silent> <Leader>wH :new<CR>
				nnoremap <silent> <Leader>wV :vnew<CR>
				nnoremap <silent> <Leader>wo :only<CR>
				nnoremap <silent> <Leader>wc :close<CR>
				nnoremap <silent> <Leader>w= <C-w>=

				nnoremap <silent> <Leader>w3v :only<bar>vsplit<bar>split<bar>wincmd h<CR>
				nnoremap <silent> <Leader>w3h :only<bar>split<bar>vsplit<bar>wincmd k<CR>
				nnoremap <silent> <Leader>w4d :only<bar>vsplit<bar>split<bar>wincmd h<bar>split<bar>wincmd k<CR>
				nnoremap <silent> <Leader>w4v :only<bar>vsplit<bar>split<bar>split<bar>wincmd h<CR>
				nnoremap <silent> <Leader>w4h :only<bar>split<bar>vsplit<bar>vsplit<bar>wincmd k<CR>
				nnoremap <silent> <Leader>w5v :only<bar>vsplit<bar>split<bar>split<bar>split<bar>wincmd h<CR>
				nnoremap <silent> <Leader>w5h :only<bar>split<bar>vsplit<bar>vsplit<bar>vsplit<bar>wincmd k<CR>

				if has('nvim')
					nnoremap <silent> <C-h> <C-w><C-h>
					nnoremap <silent> <C-j> <C-w><C-j>
					nnoremap <silent> <C-k> <C-w><C-k>
					nnoremap <silent> <C-l> <C-w><C-l>

					"window navigation for non-floating terminals
					tnoremap <silent> <C-h> <C-\><C-n><C-w>h
					tnoremap <silent> <C-j> <C-\><C-n><C-w>j
					tnoremap <silent> <C-k> <C-\><C-n><C-w>k
					tnoremap <silent> <C-l> <C-\><C-n><C-w>l
				endif
			"TERMINAL
				if has('nvim')
					"MAPPINGS
						"<esc>
						execute 'tnoremap <silent> <' . g:action_leader . '-[> <C-\><C-n>'

						"vim-registers
						tnoremap <silent> <expr> <A-'> '<C-\><C-N>"'.nr2char(getchar()).'pi'
					"ABBREVIATIONS
						"GIT
							execute 'tnoremap <silent> ' . g:terminal_leader . 'g; git '
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gi git init<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gC git clone '

							"working-directory|staging-area
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gas git status<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gad git diff **/** \| delta \| bat<C-LEFT><C-LEFT><LEFT><LEFT><LEFT><LEFT>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gaD git rerere diff **/** \| delta \| bat<C-LEFT><C-LEFT><LEFT><LEFT><LEFT><LEFT>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gaa git add **/**<LEFT>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gau git restore --staged **/**<LEFT>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gaD git restore **/**<LEFT>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gac git clean -d -f<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gar git reset --hard HEAD<CR>'

							"remote
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gr; git remote '
							execute 'tnoremap <silent> ' . g:terminal_leader . 'grp git pull<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'grP git push<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'grl git remote show<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gra git remote add '
							execute 'tnoremap <silent> ' . g:terminal_leader . 'grd git remote remove '
							execute 'tnoremap <silent> ' . g:terminal_leader . 'grr git remote rename '
							execute 'tnoremap <silent> ' . g:terminal_leader . 'grg git remote get-url '
							execute 'tnoremap <silent> ' . g:terminal_leader . 'grs git remote set-url '

							"stash
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gs; git stash '
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gss git stash<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gsl git stash list<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gsa git stash apply<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gsp git stash pop<CR>'

							"commits
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gcl git log --oneline<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gcL git log --graph<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gcm git commit -m ""<LEFT>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gca git commit --amend'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gcu git reset --mixed HEAD^<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gcd git reset --hard HEAD^<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gcr git reset --'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gcs git show	\| delta \| bat<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gcS git show	\| delta \| bat<C-LEFT><C-LEFT><LEFT><LEFT><LEFT>'

							"branch
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gbl git branch<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gbn git branch '
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gbN git checkout -b '
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gbc git checkout '
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gbC git checkout -<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gbm git merge '
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gbM git merge --no-ff '
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gbr git rebase '
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gbR git rebase -i '
						"SHELL
							execute 'tnoremap <silent> ' . g:terminal_leader . 'sc clear<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'sq exit<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'sp <space>\|<space>'
						"NPM
							execute 'tnoremap <silent> ' . g:terminal_leader . 'ni npm install --save '
							execute 'tnoremap <silent> ' . g:terminal_leader . 'nd npm install --save-dev '
							execute 'tnoremap <silent> ' . g:terminal_leader . 'ns npm run start<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'nt npm run test<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'nb npm run build<CR>'
					"VISH
						"CONFIGURATION
							"let g:modes	 = ['N','I']
							"let g:vi_mode = 'I'
						"FUNCTIONS
						"MAPPINGS
							if IsWindows()
								execute 'tnoremap <silent> <' . g:action_leader . '-w> <C-RIGHT>'
								execute 'tnoremap <silent> <' . g:action_leader . '-b> <C-LEFT>'
								execute 'tnoremap <silent> <' . g:action_leader . '-0> <HOME>'
								execute 'tnoremap <silent> <' . g:action_leader . '-9> <END>'
							endif
				endif
			"COMMANDMODE
				"GIT
					"TODO:FIX
					execute 'cnoremap <silent> ' . g:command_leader . 'gi :!git init<CR>'
					execute 'cnoremap <silent> ' . g:command_leader . 'gC :!git clone '

					execute 'cnoremap <silent> ' . g:command_leader . 'ga !git add **<LEFT>'
					execute 'cnoremap <silent> ' . g:command_leader . 'gd :!git diff ** \| delta<C-LEFT><LEFT><LEFT><LEFT><LEFT>'
					execute 'cnoremap <silent> ' . g:terminal_leader . 'gad FloatermNew git diff **/** \| delta \| bat<C-LEFT><C-LEFT><C-LEFT><LEFT><LEFT><LEFT><LEFT>'
					execute 'cnoremap <silent> ' . g:command_leader . 'gs :!git status<CR>'
					execute 'cnoremap <silent> ' . g:command_leader . 'gD :!git checkout -- '

					execute 'cnoremap <silent> ' . g:command_leader . 'grp :!git pull '
					execute 'cnoremap <silent> ' . g:command_leader . 'grP :!git push '

					execute 'cnoremap <silent> ' . g:command_leader . 'gSs :!git stash<CR>'
					execute 'cnoremap <silent> ' . g:command_leader . 'gSl :!git stash list<CR>'
					execute 'cnoremap <silent> ' . g:command_leader . 'gSa :!git stash apply<CR>'
					execute 'cnoremap <silent> ' . g:command_leader . 'gSp :!git stash pop<CR>'

					execute 'cnoremap <silent> ' . g:command_leader . 'gcm :!git commit -m ""<LEFT>'
					execute 'cnoremap <silent> ' . g:command_leader . 'gca :!git commit --amend'
					execute 'cnoremap <silent> ' . g:command_leader . 'gcl :!git log<CR>'

					execute 'cnoremap <silent> ' . g:command_leader . 'gbl :!git branch<CR>'
					execute 'cnoremap <silent> ' . g:command_leader . 'gbn :!git branch '
					execute 'cnoremap <silent> ' . g:command_leader . 'gbc :!git checkout '
					execute 'cnoremap <silent> ' . g:command_leader . 'gbC :!git checkout -b '
					execute 'cnoremap <silent> ' . g:command_leader . 'gbN :!git checkout -b '
				"VIM
		"MODE:INSERT
		"MODE:COMMAND
		"SOURCE
			nnoremap <silent> <expr> <Leader>vc ':edit '	 . g:jaat_config_path . '<CR>'
			nnoremap <silent> <expr> <Leader>vs ':source ' . g:jaat_config_path . '<CR>'
		"PLUGINS
			nnoremap <silent> <Leader>vpl :PlugStatus<CR>
			nnoremap <silent> <Leader>vpi :PlugInstall<CR>
			nnoremap <silent> <Leader>vpu :PlugUpdate<CR>
			nnoremap <silent> <Leader>vpU :PlugClean<CR>
	"LOCALLEADER
		"CODING
			nnoremap <silent> <LocalLeader>cm :make<CR>
		"MESS
			"TEXT
			"MARKUP
				"MARKDOWN
					"@TODO:FIX
					augroup MARKDOWN
						au!
						"au FileType markdown nmap <buffer> <LocalLeader>ch :call RunNpmCommand('mdown', '', "%", 'gh-markdown-cli')<CR>
						"au FileType markdown vmap <buffer> <LocalLeader>ch :call RunNpmCommand('mdown', '', "'<,'>", 'gh-markdown-cli')<CR>
					augroup END
				"XML
					augroup XML
						au!
						au FileType xml nmap <buffer> <LocalLeader>cj :call RunNpmCommand('x2j', '', '%', 'x2j-cli')<CR>
						au FileType xml vmap <buffer> <LocalLeader>cj :call RunNpmCommand('x2j', '', "'<,'>", 'x2j-cli')<CR>
					augroup END
				"MATH
					augroup MATH
						au!
						"OPERATORS
							"ALGEBRIC
								au FileType math iabbrev <buffer> is =
									au FileType math iabbrev <buffer> equal =
									au FileType math iabbrev <buffer> equals =
									au FileType math iabbrev <buffer> equalsto =
								au FileType math iabbrev <buffer> add +
								au FileType math iabbrev <buffer> sub -
								au FileType math iabbrev <buffer> lt <
								au FileType math iabbrev <buffer> gt >
								au FileType math iabbrev <buffer> le ≤
									au FileType math iabbrev <buffer> <= ≤
								au FileType math iabbrev <buffer> ge ≥
									au FileType math iabbrev <buffer> >= ≥
								au FileType math iabbrev <buffer> ne ≠
									au FileType math iabbrev <buffer> != ≠
								au FileType math iabbrev <buffer> == ⇔
								au FileType math iabbrev <buffer> . ∙
								au FileType math iabbrev <buffer> \ ÷
									au FileType math iabbrev <buffer> div ÷
							"SET
								au FileType math iabbrev <buffer> su ∪
								au FileType math iabbrev <buffer> si ∩
						"FUNCTIONS
							"CALCULAS
								au FileType math iabbrev <buffer> int ∫
								au FileType math iabbrev <buffer> int2 ∬
								au FileType math iabbrev <buffer> int3 ∭
								au FileType math iabbrev <buffer> int4 ⨌
								au FileType math iabbrev <buffer> diff 𝛛
							"ALGEBRIC
								au FileType math iabbrev <buffer> sqrt √
								au FileType math iabbrev <buffer> cbrt ∛
								au FileType math iabbrev <buffer> qdrt ∜
						"SYMBOLS
							"MATH
								au FileType math iabbrev <buffer> inf ∞
								au FileType math iabbrev <buffer> ninf -∞
								au FileType math iabbrev <buffer> pm ±
								au FileType math iabbrev <buffer> mp ∓
							"NUMBERS
								au FileType math iabbrev <buffer> 0u ⁰<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 1u ¹<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 2u ²<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 3u ³<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 4u ⁴<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 5u ⁵<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 6u ⁶<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 7u ⁷<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 8u ⁸<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 9u ⁹<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 0d ₀<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 1d ₁<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 2d ₂<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 3d ₃<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 4d ₄<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 5d ₅<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 6d ₆<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 7d ₇<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 8d ₈<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 9d ₉<ESC>F<SPACE>xa
							"LATIN
								au FileType math iabbrev <buffer> alpha 𝛂
								au FileType math iabbrev <buffer> beta 𝛃
								au FileType math iabbrev <buffer> gamma 𝛄
								au FileType math iabbrev <buffer> delta 𝛅
								au FileType math iabbrev <buffer> epsi 𝛆
								au FileType math iabbrev <buffer> eta 𝛈
								au FileType math iabbrev <buffer> theta 𝛉
								au FileType math iabbrev <buffer> lambda 𝛌
								au FileType math iabbrev <buffer> mu 𝛍
								au FileType math iabbrev <buffer> nu 𝛎
								au FileType math iabbrev <buffer> pi 𝛑
								au FileType math iabbrev <buffer> rho 𝛒
								au FileType math iabbrev <buffer> sigma 𝛔
								au FileType math iabbrev <buffer> tau 𝛕
								au FileType math iabbrev <buffer> upsi 𝛖
								au FileType math iabbrev <buffer> phi 𝛟
								au FileType math iabbrev <buffer> chi 𝛘
								au FileType math iabbrev <buffer> psi 𝛙
								au FileType math iabbrev <buffer> omega 𝛚
								au FileType math iabbrev <buffer> kpi 𝛞
						"RANDOM
							au FileType math iabbrev <buffer> tf ∴
								au FileType math iabbrev <buffer> therefore ∴
							au FileType math iabbrev <buffer> ie ∵
							au FileType math iabbrev <buffer> ... ⋯
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
							au FileType jade,pug map	<buffer> <LocalLeader>cw :JadeWatch html vertical<CR>
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
			"WORDPRESS
				augroup WORDPRESS
					au!
					au BufEnter wordpress set filetype=jade
					au BufEnter wordpress map <buffer> <LocalLeader>ch :<C-u>call Pug('12,$')<CR>
					au BufEnter wordpress map <buffer> <LocalLeader>cj :<C-u>call Html2Pug('12,$')<CR>
				augroup END
	"RANDOM
		nnoremap <silent> <Leader>vn :nohl<CR>
"PLUGINS
	"VARIABLES
		let s:plugins = [
			\'tpope/vim-capslock',
			\'tpope/vim-repeat',
			\'Houl/repmo-vim',
			\'vim-scripts/repmo.vim',
			\'axlebedev/footprints',
			\'sunjon/Shade.nvim',
			\'mvllow/modes.nvim',
			\'rcarriga/nvim-notify'
			\'JRasmusBm/vim-peculiar',
			\'haya14busa/vim-operator-flashy',
			\'tpope/vim-surround',
			\'junegunn/vim-easy-align',
			\'svermeulen/vim-subversive',
			\'tommcdo/vim-exchange',
			\'arthurxavierx/vim-caser',
			\'gustavo-hms/vim-duplicate',
			\'rjayatilleka/vim-operator-goto',
			\'deris/vim-operator-insert',
			\'wellle/targets.vim',
			\'michaeljsmith/vim-indent-object',
			\'Julian/vim-textobj-variable-segment',
			\'saaguero/vim-textobj-pastedtext',
			\'rhysd/vim-textobj-lastinserted',
			\'coderifous/textobj-word-column.vim',
			\'rhysd/vim-textobj-anyblock',
			\'thinca/vim-textobj-between',
			\'sgur/vim-textobj-parameter',
			\'haya14busa/vim-easyoperator-line',
			\'haya14busa/vim-easyoperator-phrase',
			\'glts/vim-textobj-comment',
			\'chaoren/vim-wordmotion',
			\'haya14busa/vim-edgemotion',
			\'inside/vim-search-pulse',
			\'haya14busa/vim-asterisk',
			\'bronson/vim-visual-star-search',
			\'rhysd/clever-f.vim',
			\'justinmk/vim-sneak',
			\'haya14busa/incsearch.vim',
			\'haya14busa/incsearch-fuzzy.vim',
			\'lambdalisue/reword.vim',
			\'easymotion/vim-easymotion',
			\'haya14busa/incsearch-easymotion.vim',
			\'lambdalisue/lista.nvim',
			\'osyo-manga/vim-hopping',
			\'andymass/vim-matchup',
			\'machakann/vim-swap',
			\'AndrewRadev/splitjoin.vim',
			\'jiangmiao/auto-pairs',
			\'terryma/vim-multiple-cursors',
			\'dkarter/bullets.vim',
			\'mhinz/vim-startify',
			\'mbbill/undotree',
			\'abdalrahman-ali/vim-remembers',
			\['wfxr/minimap.vim', "{'do': ':!cargo install --locked code-minimap'}"],
			\'windwp/nvim-spectre',
			\'kevinhwang91/nvim-hlslens',
			\'mtth/scratch.vim',
			\'el-iot/buffer-tree-explorer',
			\['Iron-E/nvim-libmodal', "{ 'branch': 'master' }"],
			\'Iron-E/vim-libmodal',
			\'karb94/neoscroll.nvim',
			\'dstein64/nvim-scrollview',
			\'Xuyuanp/scrollbar.nvim',
			\'psliwka/vim-smoothie',
			\'joeytwiddle/sexy_scroller.vim',
			\'lukas-reineke/indent-blankline.nvim',
			\'norcalli/nvim-colorizer.lua',
			\'itchyny/vim-cursorword',
			\'ayosec/hltermpaste.vim',
			\'kazhala/close-buffers.nvim',
			\'nacro90/numb.nvim',
			\'camspiers/animate.vim',
			\'szw/vim-maximizer',
			\'blueyed/vim-diminactive',
			\'folke/which-key.nvim',
			\'liuchengxu/vim-which-key',
			\'pseewald/vim-anyfold',
			\'arecarn/vim-fold-cycle',
			\'kshenoy/vim-signature',
			\'kevinhwang91/nvim-bqf',
			\'NTBBloodbath/color-converter.nvim',
			\'amadeus/vim-convert-color-to',
			\'markonm/traces.vim',
			\'junegunn/vim-peekaboo',
			\['glepnir/galaxyline.nvim' , "{'branch': 'main'}"],
			\'vim-airline/vim-airline',
			\'vim-airline/vim-airline-themes',
			\'augustold/vim-airline-colornum',
			\'itchyny/lightline.vim',
			\'mengelbrecht/lightline-bufferline',
			\'akinsho/nvim-bufferline.lua',
			\'romgrk/barbar.nvim',
			\'edkolev/tmuxline.vim',
			\'edkolev/promptline.vim',
			\'Mofiqul/vscode.nvim',
			\'tomasiser/vim-code-dark',
			\'folke/tokyonight.nvim',
			\'ghifarit53/tokyonight-vim',
			\'flazz/vim-colorschemes',
			\'rafi/awesome-vim-colorschemes',
			\'chriskempson/base16-vim',
			\'KeitaNakamura/neodark.vim',
			\'folke/zen-mode.nvim',
			\'folke/twilight.nvim',
			\'junegunn/goyo.vim',
			\'junegunn/limelight.vim',
			\'kyazdani42/nvim-web-devicons',
			\'ryanoasis/vim-devicons',
			\'itchyny/vim-highlighturl',
			\['junegunn/fzf', "{'dir': '~/.fzf', 'do': { -> fzf#install() }}"],
			\'junegunn/fzf.vim',
			\['yuki-ycino/fzf-preview.vim', "{ 'branch': 'release/rpc' }"],
			\'dominickng/fzf-session.vim',
			\'pbogut/fzf-mru.vim',
			\'voldikss/vim-floaterm',
			\'kyazdani42/nvim-tree.lua',
			\'luochen1990/rainbow',
			\'p00f/nvim-ts-rainbow',
			\'sheerun/vim-polyglot',
			\'jparise/vim-graphql',
			\'chrisbra/csv.vim',
			\'folke/lsp-colors.nvim',
			\'folke/todo-comments.nvim',
			\'plasticboy/vim-markdown',
			\'tpope/vim-fugitive',
			\'rhysd/git-messenger.vim',
			\'rhysd/conflict-marker.vim',
			\'ttys3/nvim-blamer.lua',
			\'lewis6991/gitsigns.nvim',
			\'nvim-lua/plenary.nvim',
			\'sindrets/diffview.nvim',
			\'airblade/vim-gitgutter',
			\'neovim/nvim-lspconfig',
			\'alexaandru/nvim-lspupdate',
			\'folke/trouble.nvim',
			\'RishabhRD/nvim-lsputils',
			\'RishabhRD/popfix',
			\'glepnir/lspsaga.nvim',
			\'kosayoda/nvim-lightbulb',
			\'ray-x/lsp_signature.nvim',
			\'onsails/lspkind-nvim',
			\'jose-elias-alvarez/nvim-lsp-ts-utils',
			\'folke/lua-dev.nvim',
			\'neoclide/coc.nvim', {'branch': 'release'},
			\'Shougo/neco-vim',
			\'neoclide/coc-neco',
			\'rmagatti/goto-preview',
			\'liuchengxu/vista.vim',
			\['nvim-treesitter/nvim-treesitter', "{'do': ':TSUpdate'}"],
			\'nvim-treesitter/playground',
			\'nvim-treesitter/nvim-treesitter-textobjects',
			\'singlexyz/treesitter-frontend-textobjects',
			\'mfussenegger/nvim-ts-hint-textobject',
			\'romgrk/nvim-treesitter-context',
			\'haringsrob/nvim_context_vt'
			\'nvim-treesitter/nvim-treesitter-refactor',
			\'p00f/nvim-ts-rainbow',
			\'windwp/nvim-ts-autotag',
			\'JoosepAlviste/nvim-ts-context-commentstring',
			\'s1n7ax/nvim-comment-frame',
			\'scrooloose/nerdcommenter',
			\'tpope/vim-dadbod',
			\'kristijanhusak/vim-dadbod-ui',
			\'L3MON4D3/LuaSnip',
			\'hrsh7th/vim-vsnip',
			\'hrsh7th/vim-vsnip-integ',
			\'rafamadriz/friendly-snippets',
			\'SirVer/ultisnips',
			\'honza/vim-snippets',
			\'hrsh7th/nvim-compe',
			\['tzachar/compe-tabnine', "{ 'do': './install.sh' }"],
			\'mattn/emmet-vim',
			\['kkoomen/vim-doge', "{ 'do': { -> doge#install() } }"],
			\'metakirby5/codi.vim',
			\'arkwright/vim-whiteboard',
			\['iamcco/markdown-preview.nvim', "{ 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}"],
			\'suan/vim-instant-markdown',
			\['glacambre/firenvim', "{ 'do': { _ -> firenvim#install(0) } }"],
			\'reedes/vim-pencil',
			\'panozzaj/vim-autocorrect',
			\'davidbeckingsale/writegood.vim',
			\'dbmrq/vim-ditto',
			\'reedes/vim-lexical',
			\'tyru/open-browser.vim',
			\'kana/vim-operator-user',
			\'kana/vim-textobj-user',
			\'MunifTanjim/nui.nvim',
			\'Shougo/vimproc.vim',
			\'gastonsimone/vim-dokumentary',
			\'vim-scripts/DrawIt',
			\'alpertuna/vim-header',
			\'itchyny/calendar.vim',
			\'shanzi/autoHEADER',
			\'itchyny/dictionary.vim',
			\'leothelocust/vim-makecols',
			\'sbdchd/vim-shebang',
			\'vim-utils/vim-read',
			\'antoyo/vim-licenses',
			\'vim-scripts/WholeLineColor',
			\'kopischke/vim-fetch',
			\'svermeulen/vim-macrobatics',
			\'unblevable/quick-scope',
			\'haya14busa/vim-signjk-motion',
			\'haya14busa/vim-over',
			\'zirrostig/vim-schlepp',
			\'dohsimpson/vim-macroeditor',
			\'osyo-manga/vim-anzu',
			\'tommcdo/vim-ninja-feet',
		\]
		let s:configs = [
		\]
	"INSTALLED
		call plug#begin()
			"DEFAULTS
			"EDITOR
				"MODES
					if has('nvim-0.4')
						Plug 'Iron-E/nvim-libmodal', { 'branch': 'master' }
					elseif has('vim')
						Plug 'Iron-E/vim-libmodal'
					else
						"Plug 'kana/vim-submode'
							"let g:submode_always_show_submode = 1
							"let g:submode_keep_leaving_key = 1
							"let g:submode_timeout = 0
							"let g:submode_timeoutlen = 1000
						"Plug 'vim-scripts/vim-easy-submode'
							" call easysubmode#load()

							" SubmodeDefine buffers
							" Submode n <enter> <Leader>b. :bnext<CR>
							" Submode n h :bnext<CR>
							" Submode n l :bprevious<CR>
							" SubmodeDefineEnd

							" SubmodeDefine tabs
							" Submode n <enter> <Leader>t. :tabnext<CR>
							" Submode n n :tabnext<CR>
							" Submode n p :tabprevious<CR>
							" Submode n h :tabmove +1<CR>
							" Submode n l :tabmove -1<CR>
							" SubmodeDefineEnd


							" SubmodeDefine windows
							" Submode n <enter> <Leader>w. <C-W><C-L>
							" Submode n h <C-W><C-H>
							" Submode n j <C-W><C-J>
							" Submode n k <C-W><C-K>
							" Submode n l <C-W><C-L>

							" Submode n <S-h> <C-W><S-H>
							" Submode n <S-j> <C-W><S-J>
							" Submode n <S-k> <C-W><S-K>
							" Submode n <S-l> <C-W><S-L>

							" Submode n r <C-W><C-R>
							" Submode n R <C-W><S-R>
							" SubmodeDefineEnd
					endif
				"BUFFER
					"SCROLLBAR"
						if has('nvim-0.5')
							Plug 'dstein64/nvim-scrollview'
						elseif has('nvim')
							Plug 'Xuyuanp/scrollbar.nvim'
								runtime plugins/scrollbar.vim
						endif
					"SMOOTHSCROLL
						if has('nvim-0.5')
							Plug 'karb94/neoscroll.nvim'
						elseif has('nvim-0.3') || v:version >= 800
							Plug 'psliwka/vim-smoothie'
								runtime plugins/vim-smoothie.vim
						else
							"Plug 'joeytwiddle/sexy_scroller.vim'
								"runtime plugins/sexy_scroller.vim
						endif
					"INDENTLINE"
						if has('nvim-0.5')
							Plug 'lukas-reineke/indent-blankline.nvim'
								runtime plugins/indent-blankline.vim
						elseif has('conceal')
							"Plug 'Yggdroot/indentLine'
								"runtime plugins/indentLine.vim
						endif
					"COLOR-HIGHLIGHTER
						if has('nvim')
							Plug 'norcalli/nvim-colorizer.lua'
						endif
					"CHANGE-HIGHLIGHER
						" Plug 'axlebedev/footprints'
					"MODE-HIGHLIGHT
						Plug 'mvllow/modes.nvim'
					Plug 'itchyny/vim-cursorword'
					Plug 'lukas-reineke/headlines.nvim'
					" Plug 'dm1try/golden_size'
					Plug 'nacro90/numb.nvim'
					Plug 'kazhala/close-buffers.nvim'
				"WINDOW
				"TABS
					" Plug 'noscript/taberian.vim'
				Plug 'SmiteshP/nvim-gps'
				"NOTIFICATIONS
					Plug 'rcarriga/nvim-notify'
				"MAPPINGS
					if has('nvim-1')
						Plug 'folke/which-key.nvim'
					else
						Plug 'liuchengxu/vim-which-key'
					endif
				"MINIMAP
					if has('nvim-0.5') || v:version >= 820
						"Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}
							runtime plugins/minimap.vim
					endif
				"ANIMATION
						" Plug 'camspiers/animate.vim'
						"   runtime plugins/animate.vim
						" Plug 'camspiers/lens.vim'
						"   runtime plugins/lens.vim
				"FIND-REPLACE
					if has('nvim-0.5')
						Plug 'windwp/nvim-spectre'
					endif
				Plug 'kevinhwang91/nvim-bqf'
				"NOTE-TAKING
					Plug 'rexagod/samwise.nvim'
						runtime plugins/samwise.vim
					Plug 'vhyrro/neorg'
				if has('nvim-0.2.3') || v:version >= 810
					Plug 'markonm/traces.vim'
				endif
				"COLOR-CONVERTER
					if has('nvim-0.4')
						Plug 'NTBBloodbath/color-converter.nvim'
							runtime plugins/color-converter.vim
					else
						Plug 'amadeus/vim-convert-color-to'
					endif
				"HIGHLIGHT
					if has('nvim-0.5') || v:version >= 810
						Plug 'ayosec/hltermpaste.vim'
					endif
				Plug 'abdalrahman-ali/vim-remembers'
					runtime plugins/vim-remembers.vim
				Plug 'tpope/vim-repeat'
				Plug 'tpope/vim-capslock'
					runtime plugins/vim-capslock.vim
				Plug 'szw/vim-maximizer'
					runtime plugins/vim-maximizer.vim
				Plug 'mbbill/undotree'
					runtime plugins/undotree.vim
				"Plug 'junegunn/vim-peekaboo'
					"runtime plugins/vim-peekaboo.vim
				Plug 'el-iot/buffer-tree-explorer'
					runtime plugins/buffer-tree-explorer.vim
				Plug 'mtth/scratch.vim'
					runtime plugins/scratch.vim
				"Plug 'blueyed/vim-diminactive'
					"runtime plugins/vim-diminactive.vim
				if has('folding')
					Plug 'pseewald/vim-anyfold'
						runtime plugins/vim-anyfold.vim
					"Plug 'arecarn/vim-fold-cycle'
						"runtime plugins/vim-fold-cycle.vim
				endif
				if has('signs')
					Plug 'kshenoy/vim-signature'
				endif
			"UI
				Plug 'MunifTanjim/nui.nvim'
			"EDITING
				"GENERAL
					Plug 'vim-scripts/repmo.vim'
						runtime plugins/repmo.vim
				"OPERATORS
					Plug 'JRasmusBm/vim-peculiar'
						runtime plugins/vim-peculiar.vim
					Plug 'haya14busa/vim-operator-flashy'
						runtime plugins/vim-operator-flashy.vim
					Plug 'tpope/vim-surround'
					Plug 'junegunn/vim-easy-align'
						runtime plugins/vim-easy-align.vim
					Plug 'tommcdo/vim-exchange'
						runtime plugins/vim-exchange.vim
					Plug 'svermeulen/vim-subversive'
						runtime plugins/vim-subversive.vim
					Plug 'deris/vim-operator-insert'
						runtime plugins/operator-insert.vim
					Plug 'gustavo-hms/vim-duplicate'
						runtime plugins/vim-duplicate.vim
					Plug 'rjayatilleka/vim-operator-goto'
						runtime plugins/vim-operator-goto.vim
				"OBJECTS
					Plug 'wellle/targets.vim'
					Plug 'michaeljsmith/vim-indent-object'
					Plug 'Julian/vim-textobj-variable-segment'
					Plug 'saaguero/vim-textobj-pastedtext'
						runtime plugins/vim-textobj-pastedtext.vim
					Plug 'rhysd/vim-textobj-lastinserted'
					Plug 'coderifous/textobj-word-column.vim'
					Plug 'rhysd/vim-textobj-anyblock'
					Plug 'thinca/vim-textobj-between'
					Plug 'sgur/vim-textobj-parameter'
						runtime plugins/vim-textobj-parameter.vim
					Plug 'haya14busa/vim-easyoperator-line'
						runtime plugins/vim-easyoperator-line.vim
					Plug 'haya14busa/vim-easyoperator-phrase'
						runtime plugins/vim-easyoperator-phrase.vim
					Plug 'glts/vim-textobj-comment'
						runtime plugins/vim-textobj-comment.vim
				"MOTIONS
					Plug 'chaoren/vim-wordmotion'
					Plug 'haya14busa/vim-edgemotion'
						"runtime plugins/vim-edgemotion.vim
				"SEARCH
					"Plug 'romainl/vim-cool'
						"TODO:DECIDE|CHECK-IF-NEEDED
					if !exists('g:vscode')
						Plug 'inside/vim-search-pulse'
							runtime plugins/vim-search-pulse.vim
					endif
					"Plug 'haya14busa/vim-asterisk'
						"runtime plugins/vimasterisk.vim
					Plug 'bronson/vim-visual-star-search'
					Plug 'rhysd/clever-f.vim'
						runtime plugins/clever-f.vim
					"Plug 'justinmk/vim-sneak'
						"runtime plugins/vim-sneak.vim
					Plug 'haya14busa/incsearch.vim'
						runtime plugins/incsearch.vim
					Plug 'haya14busa/incsearch-fuzzy.vim'
						runtime plugins/incsearch-fuzzy.vim
					Plug 'easymotion/vim-easymotion'
						runtime plugins/vim-easymotion.vim
					Plug 'haya14busa/incsearch-easymotion.vim'
						runtime plugins/incsearch-easymotion.vim
					Plug 'lambdalisue/reword.vim'
					if has('nvim') && IsNix()
						Plug 'lambdalisue/lista.nvim'
							runtime plugins/lista.vim
						Plug 'osyo-manga/vim-hopping'
							runtime plugins/vim-hopping.vim
					endif
				"JUMP
					if v:version >= 740
						"Plug 'andymass/vim-matchup'
					endif
					if has('nvim')
						Plug 'ironhouzi/starlite-nvim'
							runtime plugins/starlite-nvim.vim
					else
						Plug 'ironhouzi/vim-stim'
					endif
					if has('nvim-0.5')
						Plug 'kwkarlwang/bufjump.nvim'
					endif
				"COMMANDS
				"RANDOM
					Plug 'Rasukarusan/nvim-select-multi-line'
						" runtime plugins/nvim-select-multi-line.vim
					Plug 'AndrewRadev/splitjoin.vim'
					Plug 'machakann/vim-swap'
						runtime plugins/vim-swap.vim
					"Plug 'jiangmiao/auto-pairs'
						"runtime plugins/auto-pairs.vim
					"Plug 'terryma/vim-expand-region'
						"runtime plugins/vim-expand-region.vim
					Plug 'terryma/vim-multiple-cursors'
						runtime plugins/vim-multiple-cursors.vim
					Plug 'dkarter/bullets.vim'
						runtime plugins/bullets.vim
					Plug 'jbyuki/venn.nvim'
			"SYSTEM
				Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': { -> fzf#install() }}
					runtime plugins/fzf.vim
				Plug 'junegunn/fzf.vim'
					runtime plugins/fzf-vim.vim
				Plug 'nvim-telescope/telescope.nvim'
				Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release/rpc' }
					runtime plugins/fzf-preview.vim
				Plug 'dominickng/fzf-session.vim'
					runtime plugins/fzf-session.vim
				Plug 'pbogut/fzf-mru.vim'
					runtime plugins/fzf-mru.vim
				Plug 'voldikss/vim-floaterm'
					runtime plugins/vim-floaterm.vim
				if has('nvim-0.5')
					Plug 'kyazdani42/nvim-tree.lua'
				endif
			"LOOK&FEEL
				"STATUSLINE
					if IsNix()
						if has('nvim-1')
							Plug 'hoob3rt/lualine.nvim'
						elseif has('nvim-0.5')
							Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
							" Plug 'Avimitin/nerd-galaxyline'
						else
							Plug 'vim-airline/vim-airline'
								runtime plugins/vim-airline.vim
							Plug 'vim-airline/vim-airline-themes'
							"Plug 'augustold/vim-airline-colornum'
						endif
					elseif IsWindows()
						Plug 'itchyny/lightline.vim'
							runtime plugins/lightline.vim
						Plug 'mengelbrecht/lightline-bufferline'
							runtime plugins/lightline-bufferline.vim
					endif
				"TABLINE
					"Plug 'bling/vim-bufferline'
						runtime plugins/vim-bufferline.vim
					Plug 'edkolev/tmuxline.vim'
						runtime plugins/tmuxline.vim
					" Plug 'edkolev/promptline.vim'
						" runtime plugins/promptline.vim
					if has('nvim-10')
						Plug 'kdheepak/tabline.nvim'
					elseif has('nvim-10')
						Plug 'romgrk/barbar.nvim'
							runtime plugins/barbar.vim
					else
						Plug 'akinsho/nvim-bufferline.lua'
					endif
				"COLORSCHEMES
					Plug 'Pocco81/Catppuccino.nvim'
					Plug 'EdenEast/nightfox.nvim'
					Plug 'Shadorain/shadotheme'
					Plug 'Mangeshrex/uwu.vim'
						" runtime plugins/uwu.vim
					Plug 'yashguptaz/calvera-dark.nvim'
					"Plug 'flazz/vim-colorschemes'
					Plug 'rafi/awesome-vim-colorschemes'
					"Plug 'chriskempson/base16-vim'
					"Plug 'pineapplegiant/spaceduck'
					"Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
					"VSCODE
						if has('nvim-0.5')
							Plug 'Mofiqul/vscode.nvim'
								let g:vscode_style = "dark"
						else
							Plug 'tomasiser/vim-code-dark'
						endif
					"TOKYONIGHT
						if has('nvim-0.5')
							Plug 'folke/tokyonight.nvim'
								" runtime plugins/tokyonight.vim
						else
							Plug 'ghifarit53/tokyonight-vim'
								" runtime plugins/tokyonight-vim.vim
						endif
					"Plug 'KeitaNakamura/neodark.vim'
							runtime plugins/neodark.vim
					"MATERIAL
						if has('vim')
							"Plug 'kaicataldo/material.vim', { 'branch': 'main' }
								"let g:material_terminal_italics = 1
								"let g:material_theme_style = 'default'
						elseif has('nvim')
							"Plug 'marko-cerovac/material.nvim'
								"Plug 'tjdevries/colorbuddy.nvim'
								"let g:material_style = 'deep ocean'
						endif
					"Plug 'sindresorhus/focus'
					"Plug 'KabbAmine/yowish.vim'
					"Plug 'ayu-theme/ayu-vim'
					"Plug 'tyrannicaltoucan/vim-quantum'
					"Plug 'raphamorim/lucario'
					"Plug 'paranoida/vim-airlineish'
					"Plug 'i3d/vim-jimbothemes'
					"Plug 'arzg/vim-corvine'
					"REFERENCE
						"TYPE:LIGHT
							"*SOLARIZED8-LIGHT*|CORVINE-LIGHT=1
							"XCODE=1
						"TYPE:DARK:HIGH
							"SPACE-DUCK=1
							"VIM-MATERIAL=1
							"BASE16-MATERIAL-VIVID|DARKER=1
						"TYPE:DARK:MEDIUM
							"MONOKAI|MOLOKAI|MONOKAIN|BEEKAI=1
						"TYPE:DARK:LOW
							"ONEDARK=1:TUI
							"SOLARIZED8-*
							"MATERIAL|MATERIAL-BOX|MATERIAL-THEME
						"TYPE:DULL
							"CORVINE=2:TUI
							"NEODARK
						"RANDOM
							"*MATERIAL*
				"FOCUS
					if has('nvim-0.5')
						Plug 'folke/zen-mode.nvim'
						Plug 'folke/twilight.nvim'
					else
						Plug 'junegunn/goyo.vim'
							runtime plugins/goyo.vim
						Plug 'junegunn/limelight.vim'
							runtime plugins/limelight.vim
					endif
				"RANDOM
					if has('nvim-0.5')
						Plug 'folke/lsp-colors.nvim'
					endif
					Plug 'ryanoasis/vim-devicons'
					Plug 'kyazdani42/nvim-web-devicons'
					Plug 'mhinz/vim-startify'
						runtime plugins/vim-startify.vim
					" Plug 'glepnir/dashboard-nvim'
						" runtime plugins/dashboard-nvim.vim
					"Plug 'itchyny/vim-highlighturl'
						"let g:highlighturl_ctermfg		= ''
						"let g:highlighturl_guifg		= ''
						"let g:highlighturl_underline = 0
				"DISABLED
					"Plug 'haya14busa/vim-keeppad'
					"Plug 'zefei/vim-colortuner'
			"MANAGEMENT
			"PROGRAMMING
				"SYNTAX
					Plug 'sheerun/vim-polyglot'
					Plug 'chrisbra/csv.vim'
					Plug 'jparise/vim-graphql'
					Plug 'plasticboy/vim-markdown'
						runtime plugins/vim-markdown.vim
					if has('nvim-0.5')
						Plug 'folke/todo-comments.nvim'
					endif
					"Plug 'vim-syntastic/syntastic'
					"Plug 'coachshea/jade-vim'
				"LSP
					if has('nvim-0.5')
						"source ~/.config/nvim/general/lsp.vim
						luafile ~/.config/nvim/general/lsp.lua
						Plug 'neovim/nvim-lspconfig'
						Plug 'williamboman/nvim-lsp-installer'
						"Plug 'RishabhRD/nvim-lsputils'
							"Plug 'RishabhRD/popfix'
						Plug 'glepnir/lspsaga.nvim'
						Plug 'hrsh7th/nvim-compe'
							Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }
						Plug 'ray-x/lsp_signature.nvim'
						Plug 'onsails/lspkind-nvim'
						"Plug 'kosayoda/nvim-lightbulb'
						Plug 'nvim-lua/lsp-status.nvim'
						Plug 'folke/lua-dev.nvim'
						"Plug 'creativenull/diagnosticls-nvim'
						Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
						Plug 'folke/trouble.nvim'
					elseif version >= 800 || has('nvim-0.4')
						Plug 'neoclide/coc.nvim', {'branch': 'release'}
							runtime plugins/coc.vim
						Plug 'Shougo/neco-vim'
						Plug 'neoclide/coc-neco'
					endif
					Plug 'liuchengxu/vista.vim'
						runtime plugins/vista.vim
				"TREESITTER
					if has('nvim-0.5')
						Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
						Plug 'nvim-treesitter/playground'
						Plug 'nvim-treesitter/nvim-treesitter-textobjects'
						Plug 'nvim-treesitter/nvim-treesitter-refactor'
						Plug 'p00f/nvim-ts-rainbow'
						Plug 'windwp/nvim-ts-autotag'
						Plug 'David-Kunz/treesitter-unit'
						Plug 'JoosepAlviste/nvim-ts-context-commentstring'
						" Plug 'romgrk/nvim-treesitter-context'
						Plug 'haringsrob/nvim_context_vt'
						Plug 'singlexyz/treesitter-frontend-textobjects'
						Plug 'mfussenegger/nvim-ts-hint-textobject'
							omap <silent> gt <cmd>lua require('tsht').nodes()<CR>
							vnoremap <silent> gt <cmd>lua require('tsht').nodes()<CR>
						"Plug 'theHamsta/nvim-treesitter-pairs'
						"Plug 'winston0410/smart-cursor.nvim'
					endif
				"SNIPPETS
					if has('nvim-0.5')
						Plug 'L3MON4D3/LuaSnip'
					endif
					if (has('nvim-0.4.4') || v:version >= 800) && v:false
						"Plug 'hrsh7th/vim-vsnip'
						"Plug 'hrsh7th/vim-vsnip-integ'
						"Plug 'rafamadriz/friendly-snippets'
					elseif has('nvim-0.5') && v:false
						"Plug 'norcalli/snippets.nvim'
					else
						Plug 'SirVer/ultisnips'
							runtime plugins/ultisnips.vim
						Plug 'honza/vim-snippets'
						"Plug 'epilande/vim-react-snippets'
					endif
				"COMPLETION
					Plug 'mattn/emmet-vim'
						runtime plugins/vim-emmet.vim
				"VCS:GIT
					Plug 'tpope/vim-fugitive'
						runtime plugins/vim-fugitive.vim
					Plug 'rhysd/git-messenger.vim'
						runtime plugins/git-messenger.vim
					Plug 'ruifm/gitlinker.nvim'
					Plug 'rhysd/conflict-marker.vim'
					if has('nvim-0.5')
						Plug 'lewis6991/gitsigns.nvim'
						Plug 'ttys3/nvim-blamer.lua'
					else
						Plug 'airblade/vim-gitgutter'
					endif
				"COMMENTS
					"Plug 'tpope/vim-commentary'
					Plug 'scrooloose/nerdcommenter'
						runtime plugins/nerdcommenter.vim
					if has('nvim-0.5')
						Plug 's1n7ax/nvim-comment-frame'
					endif
				"PLAYGROUND
					Plug 'metakirby5/codi.vim'
						runtime plugins/codi.vim
					Plug 'arkwright/vim-whiteboard'
						runtime plugins/whiteboard.vim
				"TESTING
					Plug 'roxma/nvim-yarp'
					Plug 'roxma/vim-hug-neovim-rpc'
					Plug 'vim-test/vim-test'
						runtime plugins/vim-test.vim
					Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }
						runtime plugins/vim-ultest.vim
				"DATABASE
					"Plug 'tpope/vim-dadbod'
					"Plug 'kristijanhusak/vim-dadbod-ui'
				"TAGS
					"Plug 'ludovicchabant/vim-gutentags'
				"DEBUGGING
				"DOCUMENTATION
					if has('nvim-0.5')
						Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
							runtime plugins/vim-doge.vim
						"Plug 'nvim-treesitter/nvim-tree-docs'
					endif
				"PREVIEW
					if has('nvim-0.5')
						Plug 'rmagatti/goto-preview'
					endif
				"RANDOM
					Plug 'luochen1990/rainbow'
						runtime plugins/rainbow.vim
					"Plug 'tpope/vim-abolish'
					Plug 'arthurxavierx/vim-caser'
						runtime plugins/vim-caser.vim
					if has('nvim') || (has('vim') && v:version >= 800)
						Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
							runtime plugins/markdown-preview.vim
					endif
			"CLIENTS
				if has('nvim')
					Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
				endif
			"WRITTING
				"Plug 'reedes/vim-pencil'
					runtime plugins/vim-pencil.vim
				"Plug 'panozzaj/vim-autocorrect'
					runtime plugins/vim-autocorrect.vim
				"Plug 'davidbeckingsale/writegood.vim'
				"Plug 'dbmrq/vim-ditto'
				"Plug 'reedes/vim-lexical'
					runtime plugins/vim-lexical.vim
			"RANDOM
				if has('nvim-0.2.2') || v:version >= 800
					Plug 'dstein64/vim-startuptime'
				endif
				Plug 'tyru/open-browser.vim'
					"DEPENDENCIES
						Plug 'Shougo/vimproc.vim'
					"CONFIGURATION
						"if something' not working run :VimProcInstall"
						let g:netrw_nogx = 1
						let g:openbrowser_search_engines = {
							\'askubuntu'	 : 'http://askubuntu.com/search?q={query}',
							\'duckduckgo'  : 'http://duckduckgo.com/?q={query}',
							\'github'		 : 'http://github.com/search?q={query}',
							\'google'		 : 'http://google.com/search?q={query}',
							\'vim'			 : 'http://www.google.com/cse?cx=partner-pub-3005259998294962%3Abvyni59kjr1&ie=ISO-8859-1&q={query}&sa=Search&siteurl=www.vim.org%2F#gsc.tab=0&gsc.q={query}&gsc.page=1',
							\'flipkart'		 : 'https://www.flipkart.com/search?q={query}&otracker=start&as-show=off&as=off',
							\'wikipedia'	 : 'http://en.wikipedia.org/wiki/{query}',
							\'wikivoyage'  : 'https://en.wikivoyage.org/wiki/{query}',
							\'wiktionary'  : 'https://en.wiktionary.org/wiki/{query}',
							\'wikinews'		 : 'https://en.wikinews.org/wiki/{query}',
							\'wikisource'  : 'https://en.wikisource.org/wiki/{query}',
							\'wikibooks'	 : 'https://en.wikibooks.org/wiki/{query}',
							\'wikidata'		 : 'https://en.wikidata.org/wiki/{query}',
							\'wikispecies' : 'https://species.wikimedia.org/wiki/{query}',
							\'wikiquote'	 : 'https://en.wikiquote.org/wiki/{query}',
						\ }
					"FUNCTIONS
						function! OpenUnderCursor()
							let l:word = GetWORDUnderCursor()

							if l:word !~	'^http'
								let l:word = 'https://' . l:word
							endif

							execute 'OpenBrowser ' . l:word
						endfunction
					"OPERATORS
						"OPERATOR-BROWSER
							function! OperatorOpenBrowser(visual, ...)
								let [lineStart, columnStart] = getpos(a:0 ? "'<" : "'[")[1:2]
								let [lineEnd, columnEnd]	 = getpos(a:0 ? "'>" : "']")[1:2]
								let lines					 = getline(lineStart, lineEnd)

								if len(lines) == 0
									return
								endif

								if a:visual == 'block' || a:visual == "\<c-v>"
									call PEchoError('Operator not defined for VISUAL-BLOCK mode')
									return
								elseif a:visual == 'line' || a:visual ==# 'V'
									execute 'OpenBrowserSmartSearch ' . join(lines, '\n')
								elseif a:visual == 'char' || a:visual ==# 'v'
									let lines[-1] = lines[-1][: columnEnd - (&selection == 'inclusive' ? 1 : 2)]
									let lines[0]	= lines[0][columnStart - 1:]
									execute 'OpenBrowserSmartSearch ' . join(lines, '\n')
								endif
							endfunction

							nnoremap <silent> gb :set opfunc=OperatorOpenBrowser<CR>g@
							vnoremap <silent> gb :<C-U>call OperatorOpenBrowser(visualmode(), 1)<CR>

							nnoremap <silent> gbb :call OpenUnderCursor()<CR>
					"MAPPINGS
						"CUSTOM
							nmap <Leader>og :execute ":OpenBrowserSearch -github " GetWordUnderCursor() <CR>
							vmap <Leader>og :<C-w>execute ":OpenBrowserSearch -github " GetSelectedText() <CR>

							nmap <Leader>od :execute ":OpenBrowserSearch -duckduckgo " GetWordUnderCursor() <CR>
							vmap <Leader>od :<C-w>execute ":OpenBrowserSearch -duckduckgo " GetSelectedText() <CR>

							nmap <Leader>ow :execute ":OpenBrowserSearch -wikipedia " GetWordUnderCursor() <CR>
							vmap <Leader>ow :<C-w>execute ":OpenBrowserSearch -wikipedia " GetSelectedText() <CR>
			"LIBRARIES
				Plug 'nvim-lua/plenary.nvim'
				Plug 'nvim-lua/popup.nvim'
			"DEPENDENCIES
			"LIBRARIES
				Plug 'kana/vim-textobj-user'
				Plug 'kana/vim-operator-user'
				"Plug 'mattn/webapi-vim'
			"MESS:EXTENDING-VIM
				"Plug 'svermeulen/vim-yoink'
					"runtime plugins/vim-yoink.vim
				if has('macunix')
					"Plug 'gastonsimone/vim-dokumentary'
				endif
				"Plug 'tpope/vim-speeddating'
			"MESS
				"Plug 'vim-scripts/DrawIt'
				"Plug 'alpertuna/vim-header'
					"runtime plugins/vim-header.vim
				"Plug 'itchyny/calendar.vim'
					"runtime plugins/calendar.vim
				"Plug 'shanzi/autoHEADER'
				"Plug 'itchyny/dictionary.vim'
					"runtime plugins/dictionary.vim
				"Plug 'leothelocust/vim-makecols'
				"Plug 'sbdchd/vim-shebang'
				"Plug 'vim-utils/vim-read'
				"Plug 'antoyo/vim-licenses'
				"Plug 'vim-scripts/WholeLineColor'
					"runtime plugins/WholeLineColor.vim
				"Plug 'natw/keyboard_cat.vim'
				if !IsWindows()
					"Plug 'MrPeterLee/VimWordpress'
						"runtime VimWordpress.vim
				endif
				"Plug 'vim-scripts/autoscroll.vim'
					"runtime plugins/autoscroll.vim
				"Plug 'fadein/vim-FIGlet'
					"nnoremap <Leader>zf :FIGlet<CR>
					"nnoremap <Leader>zF :FIGlet -f<space>
					"vnoremap <Leader>zf :FIGlet<CR>
					"vnoremap <Leader>zF :FIGlet -f<space>
				"Plug 'chrisbra/changesPlugin'
				"Plug 'guns/xterm-color-table.vim'
				"Plug 'vim-scripts/ScrollColors'
				"Plug 'gorodinskiy/vim-coloresque'
				"Plug 'tweekmonster/nvim-api-viewer'
				"Plug 'kyuhi/vim-emoji-complete'
			"TOTEST
				if has('nvim')
					"TODO:NOT-WORKING
					"Plug 'ripxorip/aerojump.nvim', { 'do': ':UpdateRemotePlugins' }
						"runtime plugins/aerojump.vim
				endif
				if has('nvim-0.5')
					Plug 'sunjon/Shade.nvim'
				endif
				Plug 'pirmd/gemini.vim'
				Plug 'thinca/vim-breadcrumbs'
				if has('nvim-0.4')
					Plug 'henriquehbr/nvim-startup.lua'
				endif
				Plug 'https://git.sr.ht/~k1nkreet/gemivim'
				"BETTER-WILDMENU
					Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }
						"runtime plugins/wilder.vim
			"TODECIDE
				Plug 'jbyuki/nabla.nvim'
					nnoremap <Leader>em :lua require("nabla").action()<CR>
				"Plug 'drzel/vim-repo-edit'
				Plug 'beauwilliams/focus.nvim'
				"Plug 'obcat/vim-hitspop'
				"Plug 'kopischke/vim-fetch'
				"Plug 'gyim/vim-boxdraw'
				"Plug 'tweekmonster/fzf-filemru'
				"Plug 'fmoralesc/vim-pad'
				"Plug 'tenfyzhong/axring.vim'
					"let g:axring_rings = [
					"\ ]

					"augroup AXRING
						"au!
						"au Filetype python execute "let g:axring_rings_" . &filetype . " = s:languages['" . &filetype . "'].axrings"
					"augroup END
				Plug 'svermeulen/vim-macrobatics'
					runtime plugins/vim-macrobatics.vim
				if v:version >= 800
					"TODO:FIX
					"Plug 'TaDaa/vimade'
				endif
				"Plug 'tyru/capture.vim'
				"Plug 'unblevable/quick-scope'
				"Plug 'haya14busa/vim-signjk-motion'
				"Plug 'haya14busa/vim-over'
					"runtime plugins/vim-over.vim
				"Plug 'vim-scripts/MultipleSearch'
				"Plug 'henrik/vim-indexed-search'
				"Plug 'zirrostig/vim-schlepp'
					"runtime plugins/vim-schelepp.vim
				"Plug 'dohsimpson/vim-macroeditor'
					" runtime plugins/vim-macroeditor.vim
				"Plug 'majutsushi/tagbar'
					"runtime plugins/tagbar.vim
				"Plug 'romainl/vim-qf'
				"Plug 'tpope/vim-obsession'
				"Plug 'syngan/vim-operator-keeppos'
				"Plug 'blackbeltscripting/vim-paste-operator'
				"Plug 'tommcdo/vim-centaur'
				"Plug 'osyo-manga/vim-operator-blockwise'
				"Plug 'osyo-manga/vim-operator-stay-cursor'
				"Plug 'syngan/vim-operator-furround'
				"Plug 'thinca/vim-operator-sequence'
				"Plug 'wellle/visual-split.vim'
				"Plug 'spiiph/vim-space'
				"Plug 'gcmt/wildfire.vim'
				"Plug 'lambacck/preserve-vim'
				"Plug 'godlygeek/tabular'
				"Plug 'tpope/vim-unimpaired'
				"Plug 'jeanCarloMachado/vim-toop'
				"Plug 't9md/vim-transform'
				"Plug 'lfv89/vim-foldfocus'
				"Plug 'anschnapp/move-less'
				"Plug 'fergdev/vim-cursor-hist'
				"Plug 'osyo-manga/vim-anzu'
					"runtime plugins/vim-anzu.vim
				"Plug 'sickill/vim-pasta'
					" runtime plugins/vim-pasta.vim
				"Plug 'liuchengxu/vim-clap'
				"Plug 'tommcdo/vim-ninja-feet'
				"Plug 'RRethy/vim-illuminate'
					"CONFIGURATION
						let g:Illuminate_delay = 0
						"TODO:FIX hi illuminatedWord ctermfg=grey ctermbg=darkblue
				"Plug 'lucerion/vim-executor'
				"Plug 'vim-scripts/Omap.vim'
				"Plug 'tyru/capture.vim'
				"Plug 'JarrodCTaylor/vim-shell-executor'
				"Plug 'tommcdo/vim-express'
				"Plug 'syngan/vim-operator-evalf'
				"Plug 'neitanod/vim-sade'
			if has('nvim-0.5')
				Plug 'kevinhwang91/nvim-hlslens'
				" Plug 'mfussenegger/nvim-dap'
				" Plug 'rcarriga/nvim-dap-ui'
				" Plug 'Pocco81/DAPInstall.nvim'
				" Plug 'theHamsta/nvim-dap-virtual-text'
			endif
			Plug 'sindrets/diffview.nvim'
			"TEMPORAL
				"NOT-WORKING
					Plug 'dstein64/vim-menu'
				if has('python3')
					Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}
				endif
				if executable('jq')
					Plug 'gennaro-tedesco/nvim-jqx'
				endif
				"Plug 'chimay/wheel'
				Plug 'bratpeki/truedark-vim'
				Plug 'brooth/far.vim'
				Plug 'christianchiarulli/nvcode-color-schemes.vim'
				Plug 'AckslD/nvim-revJ.lua'
				Plug 'Groctel/vim-keytree'
				"Plug 'lewis6991/spellsitter.nvim'
		call plug#end()
	"POST-LOADING
			runtime plugins/vim-which-key.vim
		"WHICH-KEY
		if has('nvim-0.5')
			lua require('plugins/nvim-treesitter')
			lua require('plugins/treesitter-unit')
			lua require('plugins/telescope')
			lua require('plugins/gitlinker')
			lua require('plugins/Catppuccino')
			lua require('plugins/neorg')
			lua require('plugins/headlines')
			lua require('plugins/venn')
			lua require('plugins/nvim-gps')
			" lua require('plugins/modes')
			lua require('plugins/nvim-bufferline')
			" lua require('plugins/tabline')
			" lua require('plugins/lualine')
			lua require('plugins/nvim-notify')
			" lua require('plugins/nvim-startup')
			" lua require('plugins/nvim-treesitter-context')
			"lua require('plugins/spellsitter')
			"lua require('plugins/smart-cursor')
			"lua require('plugins/nvim-ts-hint-textobject')
			lua require('plugins/goto-preview')
			lua require('plugins/nvim-comment-frame')
			lua require('plugins/neoscroll')
			lua require('plugins/nvim-lspconfig')
			lua require('plugins/nvim-lsp-installer')
			"lua require('plugins/lsputils')
			lua require('plugins/trouble')
			lua require('plugins/nvim-compe')
			lua require('plugins/lspkind')
			lua require('plugins/lspsaga')
			lua require('plugins/lsp-ts-utils')
			lua require('plugins/lua-dev')
			"lua require('plugins/lightbulb')
			"lua require('plugins/diagnosticls-nvim')
			lua require('plugins/nvim-blamer')
			lua require('plugins/gitsigns')
			lua require('plugins/diffview')
			lua require('plugins/nvim-colorizer')
			lua require('plugins/nvim-tree')
			lua require('plugins/nvim-spectre')
			"lua require('plugins/editing/nvim-eevj')
			lua require('plugins/nvim-hlslens')
			lua require('plugins/galaxyline')
			lua require('plugins/zen-mode')
			"lua require('plugins/twilight')
			"lua require('spellsitter').setup()
			lua require('numb').setup()
			lua require('plugins/lsp_signature')
			lua require('plugins/vsnip')
			lua require('plugins/LuaSnip')
			lua require('plugins/libs/nui')
			lua require('plugins/close-buffers')
			" lua require('plugins/shade')
			lua require("bufjump").setup({ forward = "<C-S-i>", backward = "<C-S-o>" })

			"syntax
			lua require('plugins/todo-comments')
		endif
	"CUSTOM
		"EDITING
			"source ~/.config/nvim/plugins/editing/custom/buffer-jumplist.vim
		"AESTHETICS
			runtime custom/minimalistic-folds.vim
	"IDEAPAD
	"SCRATCHPAD
	"CLIENTS
		Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
			"let g:deoplete#enable_at_startup = 1
		Plug 'beeender/Comrade'
"CONFIGURATION
	"PYTHON-BINARIES
		"let g:loaded_python_provider	= 1
		"let g:loaded_python3_provider = 1

		"if IsNix()
			"let g:python_host_prog	= '~/neovim/bin/python3'
			"let g:python3_host_prog = '/Users/sahilsehwag/neovim/bin/python3'
		"elseif IsWindows()
		"  "TODO:FIX
		"  let g:python_host_prog	= "C:/Users/138100/scoop/apps/anaconda3/current/envs/pynvim2/python.exe"
		"  let g:python3_host_prog = "C:/Users/138100/scoop/apps/anaconda3/current/envs/pynvim/python.exe"
		"endif
	"MSWIN
		if IsWindows()
			nnoremap <Leader>mm :source $VIMRUNTIME/mswin.vim<CR>
		endif
"SETTINGS
	"FOLDING
		if has('folding')
			set foldlevel=0
			set foldignore=
			"set foldlevelstart=99
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
		set nobackup
		set nowritebackup
		set directory=~/.config/nvim/tmp/swapfiles
		set undodir=~/.config/nvim/tmp/undofiles
		set undofile
	"SEARCH
		set hls
		set nohls
		set incsearch
		set ignorecase
		set smartcase
		set gdefault
	"FILE-SEARCH
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
	"SYMBOL-SERACH
		"set include=
		"set define=
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
				set signcolumn=yes
		"LIST
			set nolist
			set shortmess=filmnrwxoOTWAIcFS
			set listchars=tab:\ \ ,
			"set listchars=tab:\│\ ,
			"set listchars+=eol:¬
			set listchars+=trail:•
			set listchars+=extends:…
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
				"colorscheme gruvbox
				" colorscheme vscode
				colorscheme nightfox
				"colorscheme tokyonight
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
				""some plugin is overriding the "showmode" when entering new buffer
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
	"PLUGINS
		let g:loaded_matchit = 0
		let g:loaded_matchparen = 0
		let loaded_netrwPlugin = 0
	"DIFF
		set diffopt=internal,filler,closeoff,iwhite
	"RANDOM
		set scrolloff=5
		set nocompatible
			"disabling vi compatibility features|mappings…
		set mouse=a
		set clipboard=unnamed
		set nf="alpha,octal,hex,bin"
"CLIENTS
	"VSCODE
		if exists('g:vscode')
			"DEFAULTS
			"MANAGER
			"PATCHES
				"zz is causing jittering and buggy cursor behaviour
				"∴ falling back to default behaviour
				nnoremap j j
				nnoremap k k
			"RANDOM
		endif
	"ONI
		if exists('g:gui_oni')
			"DEFAULTS
			"PATCHES
				let g:vim_search_pulse_disable_auto_mappings = 1
			"RANDOM
				let g:airline_powerline_fonts							= 0
				let g:airline_theme										= 'wombat'
				let g:airline#extensions#bufferline#enabled				= 1
				let g:airline#extensions#bufferline#overwrite_variables = 1
		endif
	"FIRENVIM
		if exists('g:started_by_firenvim')
			"CONFIGURATION
				let g:firenvim_config = {
					\'globalSettings': {
						\'alt': 'all',
					\},
					\'localSettings': {
						\'.*': {
							\'cmdline': 'firenvim',
							\'priority': 0,
							\'selector': 'textarea',
							\'takeover': 'never',
						\},
					\}
				\}
			"SETTINGS
				"set laststatus=0
				set guifont=Jetbrains\ Mono:h20
			"PLUGINS
				let g:startify_disable_at_vimenter = 0
		endif
	"IDEA
"HIGHLIGHTS
	"INTERFACE
		highlight VertSplit ctermbg=None guibg=None
	"SEARCH
		highlight Search ctermfg=49 cterm=NONE gui=NONE
		highlight IncSearchMatch ctermfg=black ctermbg=186
	"COMPLETION
		"highlight Pmenu ctermbg=232 ctermfg=7
		"highlight PmenuSel ctermfg=15
		highlight Pmenu ctermbg=238 gui=bold
	"DIFFING
		highlight JatAddFG          ctermfg=114 guifg=#98C379
		highlight JatDeleteFG       ctermfg=204 guifg=#E06C75
		highlight JatChangeFG       ctermfg=180 guifg=#E5C07B
		highlight JatChangeDeleteFG ctermfg=180 guifg=#61AFEF

		highlight JatAddBG          ctermbg=114 guibg=#98C379
		highlight JatDeleteBG       ctermbg=204 guibg=#E06C75
		highlight JatChangeBG       ctermbg=180 guibg=#E5C07B
		highlight JatChangeDeleteBG ctermbg=180 guibg=#61AFEF
	"STATUS
		highlight JatSuccessFG ctermfg=114 guifg=#98C379
		highlight JatErrorFG   ctermfg=204 guifg=#E06C75
		highlight JatWarningFG ctermfg=180 guifg=#E5C07B
		highlight JatInfoFG    ctermfg=180 guifg=#61AFEF
		highlight JatHintFG    ctermfg=180 guifg=#61AFEF

		highlight JatSuccessBG ctermbg=114 guibg=#98C379
		highlight JatErrorBG   ctermbg=204 guibg=#E06C75
		highlight JatWarningBG ctermbg=180 guibg=#E5C07B
		highlight JatInfoBG    ctermbg=180 guibg=#61AFEF
		highlight JatHintBG    ctermbg=180 guibg=#61AFEF
	"COLORS
		highlight JatCyanFG  ctermfg=235 ctermbg=39 guifg=#61AFEF guibg=#282C34
		highlight JatCyanBG ctermfg=235 ctermbg=39 guifg=#282C34 guibg=#61AFEF
	"RANDOM
		highlight! link SignColumn LineNr
	"PLUGINS
		highlight IndentBlankLineContext ctermfg=135 guifg=#af5fff
"REFERENCE
	"UNICODE
		"LAYOUT
			"EDGES
				"◜◝
				"◟◞
				"─ ━ │ ┃
				"┄ ┅ ┆ ┇
				"┈ ┉ ┊ ┋
				"┌	┍	┎	┏ ┐	┑	┒	┓
				"└	┕	┖	┗	┘	┙	┚	┛
				"├	┝	┞	┟ ┠	┡	┢	┣
				"┤	┥	┦	┧	┨	┩	┪	┫
				"┬	┭	┮	┯ ┰	┱	┲	┳
				"┴	┵	┶	┷	┸	┹	┺	┻
				"┼	┽	┾	┿ ╀	╁	╂	╃
				"╄	╅	╆	╇	╈	╉	╊	╋
				"╌	╍	╎	╏
				"═	║
				"╒	╓	╔	╕	╖	╗
				"╘	╙	╚	╛	╜	╝
				"╞	╟ ╠	╡	╢	╣
				"╤	╥	╦	╧	╨	╩
				"╪	╫	╬
				"╭ ╮
				"╰ ╯
				"╱ ╲ ╳
				"╴╵╶ ╷ ╸ ╹ ╺ ╻ ╼ ╽ ╾ ╿
			"BLOCKS
				"▀ ▁ ▂ ▃ ▄ ▅ ▆ ▇ █ ▉ ▊ ▋ ▌ ▍ ▎ ▏ ▐	░	▒	▓	▔	▕	▖	▗	▘	▙	▚	▛	▜	▝	▞	▟
		"SHAPES
			"⸻		⸺		― —	–
			"■□ ▢ ⬚	▣	 ▪▫ ◻◼	 ▤ ▥ ▦ ▧ ▨ ▩	◲◱◳◰ ◫ ◧◨◪◩ ▬ ▭ ▮▯ ☐☑☒ ⬗⬖⬘⬙ ﱢ
			"▲▼ ◀▶	► △▽ ▷ ▵ ◃◁ ▴▾◂ ▸ ▿▹ ▻◅ ◄ ◸◹ ◺◿		◣ ◢	◤ ◥		◬◭◮ ⮀⮁ ⯅⯆⯇⯈
			"·∙○●◦ ◉ ◯ ◌ ⭘ ⬤	◶◵◷◴ ◐ ◑ ◒ ◓	 ◔◕	◖◗⯊⯋ ◚◛  ◠◡ ⦾⦿◎ ◘ ◙ ◍ ☉
			"◇◆	⬥⬦ ◈	◊♦♢
			"⬟ ⬠ ⬡ ⬢ ⬣
			"★ ☆
			"▰▱ ⁃⁌⁍
			"☰ ☱ ☲ ☳ ☴ ☵ ☶ ☷
		"BULLETS
			"∙•・◦ ● ○ ◎ ◉ ⦿ ❍
			"⁌ ⁍ ⁃ -
			"☐ ☑︎ ☒
			"■ □ ▪︎ ▫︎ ◻︎ ◼︎ ◘ ❏ ❐ ❑ ❒
			"◆ ◇
			"▶︎ ▷ ‣ ▸ ▹ ► ▻ ◀︎ ◁ ▼ ▽ ▾ ▿ ▴ ▵ ▲ △
			"☞ ☛ ➢ ➣ ➤
			"❖ ✢ ✣ ✤ ✥ ✦ ✧
			"★ ☆ ✯ ✡︎ ✩ ✪ ✫ ✬ ✭ ✮ ✰
			"✶ ✷ ✵ ✸ ✹ ✺
			"❊ ✻ ✽ ✼ ❉ ✱ ✾ ❃ ✳︎ ❋ ✴︎ ❇︎ ❈ ※ ❅ ❆ ❄︎ ⚙︎ ✿ ❀ ❁ ❂
			"✓ ✔︎ ✕ ✖︎ ✗ ✘
			"﹅﹆ ❤︎ ❥ ☙ ❧ ❦ ❡
		"GLYPHS
			"⏻ ⏼ ⭘ ⏾ ⏽ ☠ ⚡
			"♯ ☢ ☣ ⚠
			"☁ ☂ ☼ ☀ ☽ ☾ ❄
			"
		"ARROWS
			"←	↑	→	↓	↔	↕	↖	↗	↘	↙	↚	↛	↜	↝	↞	↟
			"↠	↡	↢	↣	↤	↥	↦	↧	↨	↩	↪	↫	↬	↭	↮	↯
			"↰	↱	↲	↳	↴	↵	↶	↷	↸	↹	↺	↻	↼	↽	↾	↿
			"⇀	⇁	⇂	⇃	⇄	⇅	⇆	⇇	⇈	⇉	⇊	⇋	⇌	⇍	⇎	⇏
			"⇐	⇑	⇒	⇓	⇔	⇕	⇖	⇗	⇘	⇙	⇚	⇛	⇜	⇝	⇞	⇟
			"⇠	⇡	⇢	⇣	⇤	⇥	⇦	⇧	⇨	⇩	⇪	⇫	⇬	⇭	⇮	⇯
			"⇰	⇱	⇲	⇳	⇴	⇵	⇶	⇷	⇸	⇹	⇺	⇻	⇼	⇽	⇾	⇿
			"⟰	⟱	⟲	⟳	⟴	⟵	⟶	⟷	⟸	⟹	⟺	⟻	⟼	⟽	⟾	⟿
			"⤀	⤁	⤂	⤃	⤄	⤅	⤆	⤇	⤈	⤉	⤊	⤋	⤌	⤍	⤎	⤏
			"⤐	⤑	⤒	⤓	⤔	⤕	⤖	⤗	⤘	⤙	⤚	⤛	⤜	⤝	⤞	⤟
			"⤠	⤡	⤢	⤣	⤤	⤥	⤦	⤧	⤨	⤩	⤪	⤫	⤬	⤭	⤮	⤯
			"⤰	⤱	⤲	⤳	⤴	⤵	⤶	⤷	⤸	⤹	⤺	⤻	⤼	⤽	⤾	⤿
			"⥀	⥁	⥂	⥃	⥄	⥅	⥆	⥇	⥈	⥉	⥊	⥋	⥌	⥍	⥎	⥏
			"⥐	⥑	⥒	⥓	⥔	⥕	⥖	⥗	⥘	⥙	⥚	⥛	⥜	⥝	⥞	⥟
			"⥠	⥡	⥢	⥣	⥤	⥥	⥦	⥧	⥨	⥩	⥪	⥫	⥬	⥭	⥮	⥯
			"⥰	⥱	⥲	⥳	⥴	⥵	⥶	⥷	⥸	⥹	⥺	⥻	⥼	⥽	⥾	⥿
			"⬀	⬁	⬂	⬃	⬄	⬅	⬆	⬇	⬈	⬉	⬊	⬋	⬌	⬍	⬎	⬏
			"⬐	⬑ ⮕ ⮐	⮑
			"⭠	⭡	⭢	⭣	⭤	⭥
			"⬰	⬱	⬲	⬳	⬴	⬵	⬶	⬷	⬸	⬹	⬺	⬻	⬼	⬽	⬾	⬿
			"⭀	⭁	⭂	⭃	⭄	⭅	⭆	⭇	⭈	⭉	⭊	⭋	⭌
		"MATHS
			"∀	∁	∂	∃	∄	∅	∆	∇	∈	∉	∊	∋	∌	∍	∎	∏
			"∐	∑	−	∓	∔	∕	∖	∗	∘	∙	√	∛	∜	∝	∞	∟
			"∠	∡	∢	∣	∤	∥	∦	∧	∨	∩	∪	∫	∬	∭	∮	∯
			"∰	∱	∲	∳	∴	∵	∶	∷	∸	∹	∺	∻	∼	∽	∾	∿
			"≀	≁	≂	≃	≄	≅	≆	≇	≈	≉	≊	≋	≌	≍	≎	≏
			"≐	≑	≒	≓	≔	≕	≖	≗	≘	≙	≚	≛	≜	≝	≞	≟
			"≠	≡	≢	≣	≤	≥	≦	≧	≨	≩	≪	≫	≬	≭	≮	≯
			"≰	≱	≲	≳	≴	≵	≶	≷	≸	≹	≺	≻	≼	≽	≾	≿
			"⊀	⊁	⊂	⊃	⊄	⊅	⊆	⊇	⊈	⊉	⊊	⊋	⊌	⊍	⊎	⊏
			"⊐	⊑	⊒	⊓	⊔	⊕	⊖	⊗	⊘	⊙	⊚	⊛	⊜	⊝	⊞	⊟
			"⊠	⊡	⊢	⊣	⊤	⊥	⊦	⊧	⊨	⊩	⊪	⊫	⊬	⊭	⊮	⊯
			"⊰	⊱	⊲	⊳	⊴	⊵	⊶	⊷	⊸	⊹	⊺	⊻	⊼	⊽	⊾	⊿
			"⋀	⋁	⋂	⋃	⋄	⋅	⋆	⋇	⋈	⋉	⋊	⋋	⋌	⋍	⋎	⋏
			"⋐	⋑	⋒	⋓	⋔	⋕	⋖	⋗	⋘	⋙	⋚	⋛	⋜	⋝	⋞	⋟
			"⋠	⋡	⋢	⋣	⋤	⋥	⋦	⋧	⋨	⋩	⋪	⋫	⋬	⋭	⋮	⋯
			"⋰	⋱	⋲	⋳	⋴	⋵	⋶	⋷	⋸	⋹	⋺	⋻	⋼	⋽	⋾	⋿
		"NUMBERS
			"⅐	⅑	⅒	⅓	⅔	⅕	⅖	⅗	⅘	⅙	⅚	⅛	⅜	⅝	⅞	⅟
			"Ⅰ	Ⅱ	Ⅲ	Ⅳ	Ⅴ	Ⅵ	Ⅶ	Ⅷ	Ⅸ	Ⅹ	Ⅺ	Ⅻ	Ⅼ	Ⅽ	Ⅾ	Ⅿ
			"ⅰ	ⅱ	ⅲ	ⅳ	ⅴ	ⅵ	ⅶ	ⅷ	ⅸ	ⅹ	ⅺ	ⅻ	ⅼ	ⅽ	ⅾ	ⅿ
			"ↀ	ↁ	ↂ	Ↄ	ↄ	ↅ	ↆ	ↇ	ↈ	↉	↊	↋
		"LETTERS
			"𝐀	𝐁	𝐂	𝐃	𝐄	𝐅	𝐆	𝐇	𝐈	𝐉	𝐊	𝐋	𝐌	𝐍	𝐎	𝐏
			"𝐐	𝐑	𝐒	𝐓	𝐔	𝐕	𝐖	𝐗	𝐘	𝐙	𝐚	𝐛	𝐜	𝐝	𝐞	𝐟
			"𝐠	𝐡	𝐢	𝐣	𝐤	𝐥	𝐦	𝐧	𝐨	𝐩	𝐪	𝐫	𝐬	𝐭	𝐮	𝐯
			"𝐰	𝐱	𝐲	𝐳	𝐴	𝐵	𝐶	𝐷	𝐸	𝐹	𝐺	𝐻	𝐼	𝐽	𝐾	𝐿
			"𝑀	𝑁	𝑂	𝑃	𝑄	𝑅	𝑆	𝑇	𝑈	𝑉	𝑊	𝑋	𝑌	𝑍	𝑎	𝑏
			"𝑐	𝑑	𝑒	𝑓	𝑔		𝑖	𝑗	𝑘	𝑙	𝑚	𝑛	𝑜	𝑝	𝑞	𝑟
			"𝑠	𝑡	𝑢	𝑣	𝑤	𝑥	𝑦	𝑧	𝑨	𝑩	𝑪	𝑫	𝑬	𝑭	𝑮	𝑯
			"𝑰	𝑱	𝑲	𝑳	𝑴	𝑵	𝑶	𝑷	𝑸	𝑹	𝑺	𝑻	𝑼	𝑽	𝑾	𝑿
			"𝒀	𝒁	𝒂	𝒃	𝒄	𝒅	𝒆	𝒇	𝒈	𝒉	𝒊	𝒋	𝒌	𝒍	𝒎	𝒏
			"𝒐	𝒑	𝒒	𝒓	𝒔	𝒕	𝒖	𝒗	𝒘	𝒙	𝒚	𝒛	𝒜		𝒞	𝒟
					"𝒢			𝒥	𝒦			𝒩	𝒪	𝒫	𝒬		𝒮	𝒯
			"𝒰	𝒱	𝒲	𝒳	𝒴	𝒵	𝒶	𝒷	𝒸	𝒹		𝒻		𝒽	𝒾	𝒿
			"𝓀	𝓁	𝓂	𝓃		𝓅	𝓆	𝓇	𝓈	𝓉	𝓊	𝓋	𝓌	𝓍	𝓎	𝓏
			"𝓐	𝓑	𝓒	𝓓	𝓔	𝓕	𝓖	𝓗	𝓘	𝓙	𝓚	𝓛	𝓜	𝓝	𝓞	𝓟
			"𝓠	𝓡	𝓢	𝓣	𝓤	𝓥	𝓦	𝓧	𝓨	𝓩	𝓪	𝓫	𝓬	𝓭	𝓮	𝓯
			"𝓰	𝓱	𝓲	𝓳	𝓴	𝓵	𝓶	𝓷	𝓸	𝓹	𝓺	𝓻	𝓼	𝓽	𝓾	𝓿
			"𝔀	𝔁	𝔂	𝔃	𝔄	𝔅		𝔇	𝔈	𝔉	𝔊			𝔍	𝔎	𝔏
			"𝔐	𝔑	𝔒	𝔓	𝔔		𝔖	𝔗	𝔘	𝔙	𝔚	𝔛	𝔜		𝔞	𝔟
			"𝔠	𝔡	𝔢	𝔣	𝔤	𝔥	𝔦	𝔧	𝔨	𝔩	𝔪	𝔫	𝔬	𝔭	𝔮	𝔯
			"𝔰	𝔱	𝔲	𝔳	𝔴	𝔵	𝔶	𝔷	𝔸	𝔹		𝔻	𝔼	𝔽	𝔾
			"𝕀	𝕁	𝕂	𝕃	𝕄		𝕆				𝕊	𝕋	𝕌	𝕍	𝕎	𝕏
			"𝕐		𝕒	𝕓	𝕔	𝕕	𝕖	𝕗	𝕘	𝕙	𝕚	𝕛	𝕜	𝕝	𝕞	𝕟
			"𝕠	𝕡	𝕢	𝕣	𝕤	𝕥	𝕦	𝕧	𝕨	𝕩	𝕪	𝕫	𝕬	𝕭	𝕮	𝕯
			"𝕰	𝕱	𝕲	𝕳	𝕴	𝕵	𝕶	𝕷	𝕸	𝕹	𝕺	𝕻	𝕼	𝕽	𝕾	𝕿
			"𝖀	𝖁	𝖂	𝖃	𝖄	𝖅	𝖆	𝖇	𝖈	𝖉	𝖊	𝖋	𝖌	𝖍	𝖎	𝖏
			"𝖐	𝖑	𝖒	𝖓	𝖔	𝖕	𝖖	𝖗	𝖘	𝖙	𝖚	𝖛	𝖜	𝖝	𝖞	𝖟
			"𝖠	𝖡	𝖢	𝖣	𝖤	𝖥	𝖦	𝖧	𝖨	𝖩	𝖪	𝖫	𝖬	𝖭	𝖮	𝖯
			"𝖰	𝖱	𝖲	𝖳	𝖴	𝖵	𝖶	𝖷	𝖸	𝖹	𝖺	𝖻	𝖼	𝖽	𝖾	𝖿
			"𝗀	𝗁	𝗂	𝗃	𝗄	𝗅	𝗆	𝗇	𝗈	𝗉	𝗊	𝗋	𝗌	𝗍	𝗎	𝗏
			"𝗐	𝗑	𝗒	𝗓	𝗔	𝗕	𝗖	𝗗	𝗘	𝗙	𝗚	𝗛	𝗜	𝗝	𝗞	𝗟
			"𝗠	𝗡	𝗢	𝗣	𝗤	𝗥	𝗦	𝗧	𝗨	𝗩	𝗪	𝗫	𝗬	𝗭	𝗮	𝗯
			"𝗰	𝗱	𝗲	𝗳	𝗴	𝗵	𝗶	𝗷	𝗸	𝗹	𝗺	𝗻	𝗼	𝗽	𝗾	𝗿
			"𝘀	𝘁	𝘂	𝘃	𝘄	𝘅	𝘆	𝘇	𝘈	𝘉	𝘊	𝘋	𝘌	𝘍	𝘎	𝘏
			"𝘐	𝘑	𝘒	𝘓	𝘔	𝘕	𝘖	𝘗	𝘘	𝘙	𝘚	𝘛	𝘜	𝘝	𝘞	𝘟
			"𝘠	𝘡	𝘢	𝘣	𝘤	𝘥	𝘦	𝘧	𝘨	𝘩	𝘪	𝘫	𝘬	𝘭	𝘮	𝘯
			"𝘰	𝘱	𝘲	𝘳	𝘴	𝘵	𝘶	𝘷	𝘸	𝘹	𝘺	𝘻	𝘼	𝘽	𝘾	𝘿
			"𝙀	𝙁	𝙂	𝙃	𝙄	𝙅	𝙆	𝙇	𝙈	𝙉	𝙊	𝙋	𝙌	𝙍	𝙎	𝙏
			"𝙐	𝙑	𝙒	𝙓	𝙔	𝙕	𝙖	𝙗	𝙘	𝙙	𝙚	𝙛	𝙜	𝙝	𝙞	𝙟
			"𝙠	𝙡	𝙢	𝙣	𝙤	𝙥	𝙦	𝙧	𝙨	𝙩	𝙪	𝙫	𝙬	𝙭	𝙮	𝙯
			"𝙰	𝙱	𝙲	𝙳	𝙴	𝙵	𝙶	𝙷	𝙸	𝙹	𝙺	𝙻	𝙼	𝙽	𝙾	𝙿
			"𝚀	𝚁	𝚂	𝚃	𝚄	𝚅	𝚆	𝚇	𝚈	𝚉	𝚊	𝚋	𝚌	𝚍	𝚎	𝚏
			"𝚐	𝚑	𝚒	𝚓	𝚔	𝚕	𝚖	𝚗	𝚘	𝚙	𝚚	𝚛	𝚜	𝚝	𝚞	𝚟
			"𝚠	𝚡	𝚢	𝚣	𝚤	𝚥			𝚨	𝚩	𝚪	𝚫	𝚬	𝚭	𝚮	𝚯
			"𝚰	𝚱	𝚲	𝚳	𝚴	𝚵	𝚶	𝚷	𝚸	𝚹	𝚺	𝚻	𝚼	𝚽	𝚾	𝚿
			"𝛀	𝛁	𝛂	𝛃	𝛄	𝛅	𝛆	𝛇	𝛈	𝛉	𝛊	𝛋	𝛌	𝛍	𝛎	𝛏
			"𝛐	𝛑	𝛒	𝛓	𝛔	𝛕	𝛖	𝛗	𝛘	𝛙	𝛚	𝛛	𝛜	𝛝	𝛞	𝛟
			"𝛠	𝛡	𝛢	𝛣	𝛤	𝛥	𝛦	𝛧	𝛨	𝛩	𝛪	𝛫	𝛬	𝛭	𝛮	𝛯
			"𝛰	𝛱	𝛲	𝛳	𝛴	𝛵	𝛶	𝛷	𝛸	𝛹	𝛺	𝛻	𝛼	𝛽	𝛾	𝛿
			"𝜀	𝜁	𝜂	𝜃	𝜄	𝜅	𝜆	𝜇	𝜈	𝜉	𝜊	𝜋	𝜌	𝜍	𝜎	𝜏
			"𝜐	𝜑	𝜒	𝜓	𝜔	𝜕	𝜖	𝜗	𝜘	𝜙	𝜚	𝜛	𝜜	𝜝	𝜞	𝜟
			"𝜠	𝜡	𝜢	𝜣	𝜤	𝜥	𝜦	𝜧	𝜨	𝜩	𝜪	𝜫	𝜬	𝜭	𝜮	𝜯
			"𝜰	𝜱	𝜲	𝜳	𝜴	𝜵	𝜶	𝜷	𝜸	𝜹	𝜺	𝜻	𝜼	𝜽	𝜾	𝜿
			"𝝀	𝝁	𝝂	𝝃	𝝄	𝝅	𝝆	𝝇	𝝈	𝝉	𝝊	𝝋	𝝌	𝝍	𝝎	𝝏
			"𝝐	𝝑	𝝒	𝝓	𝝔	𝝕	𝝖	𝝗	𝝘	𝝙	𝝚	𝝛	𝝜	𝝝	𝝞	𝝟
			"𝝠	𝝡	𝝢	𝝣	𝝤	𝝥	𝝦	𝝧	𝝨	𝝩	𝝪	𝝫	𝝬	𝝭	𝝮	𝝯
			"𝝰	𝝱	𝝲	𝝳	𝝴	𝝵	𝝶	𝝷	𝝸	𝝹	𝝺	𝝻	𝝼	𝝽	𝝾	𝝿
			"𝞀	𝞁	𝞂	𝞃	𝞄	𝞅	𝞆	𝞇	𝞈	𝞉	𝞊	𝞋	𝞌	𝞍	𝞎	𝞏
			"𝞐	𝞑	𝞒	𝞓	𝞔	𝞕	𝞖	𝞗	𝞘	𝞙	𝞚	𝞛	𝞜	𝞝	𝞞	𝞟
			"𝞠	𝞡	𝞢	𝞣	𝞤	𝞥	𝞦	𝞧	𝞨	𝞩	𝞪	𝞫	𝞬	𝞭	𝞮	𝞯
			"𝞰	𝞱	𝞲	𝞳	𝞴	𝞵	𝞶	𝞷	𝞸	𝞹	𝞺	𝞻	𝞼	𝞽	𝞾	𝞿
			"𝟀	𝟁	𝟂	𝟃	𝟄	𝟅	𝟆	𝟇	𝟈	𝟉	𝟊	𝟋			𝟎	𝟏
			"𝟐	𝟑	𝟒	𝟓	𝟔	𝟕	𝟖	𝟗	𝟘	𝟙	𝟚	𝟛	𝟜	𝟝	𝟞	𝟟
			"𝟠	𝟡	𝟢	𝟣	𝟤	𝟥	𝟦	𝟧	𝟨	𝟩	𝟪	𝟫	𝟬	𝟭	𝟮	𝟯
			"𝟰	𝟱	𝟲	𝟳	𝟴	𝟵	𝟶	𝟷	𝟸	𝟹	𝟺	𝟻	𝟼	𝟽	𝟾	𝟿

			"①	②	③	④	⑤	⑥	⑦	⑧	⑨	⑩	⑪	⑫	⑬	⑭	⑮	⑯
			"⑰	⑱	⑲	⑳	⑴	⑵	⑶	⑷	⑸	⑹	⑺	⑻	⑼	⑽	⑾	⑿
			"⒀	⒁	⒂	⒃	⒄	⒅	⒆	⒇	⒈	⒉	⒊	⒋	⒌	⒍	⒎	⒏
			"⒐	⒑	⒒	⒓	⒔	⒕	⒖	⒗	⒘	⒙	⒚	⒛	⒜	⒝	⒞	⒟
			"⒠	⒡	⒢	⒣	⒤	⒥	⒦	⒧	⒨	⒩	⒪	⒫	⒬	⒭	⒮	⒯
			"⒰	⒱	⒲	⒳	⒴	⒵	Ⓐ	Ⓑ	Ⓒ	Ⓓ	Ⓔ	Ⓕ	Ⓖ	Ⓗ	Ⓘ	Ⓙ
			"Ⓚ	Ⓛ	Ⓜ	Ⓝ	Ⓞ	Ⓟ	Ⓠ	Ⓡ	Ⓢ	Ⓣ	Ⓤ	Ⓥ	Ⓦ	Ⓧ	Ⓨ	Ⓩ
			"ⓐ	ⓑ	ⓒ	ⓓ	ⓔ	ⓕ	ⓖ	ⓗ	ⓘ	ⓙ	ⓚ	ⓛ	ⓜ	ⓝ	ⓞ	ⓟ
			"ⓠ	ⓡ	ⓢ	ⓣ	ⓤ	ⓥ	ⓦ	ⓧ	ⓨ	ⓩ	⓪	⓫	⓬	⓭	⓮	⓯
			"⓰	⓱	⓲	⓳	⓴	⓵	⓶	⓷	⓸	⓹	⓺	⓻	⓼	⓽	⓾	⓿

			"℀	℁	ℂ	℃	℄	℅	℆	ℇ	℈	℉	ℊ	ℋ	ℌ	ℍ	ℎ	ℏ
			"ℐ	ℑ	ℒ	ℓ	℔	ℕ	№	℗	℘	ℙ	ℚ	ℛ	ℜ	ℝ	℞	℟
			"℠	℡	™	℣	ℤ	℥	Ω	℧	ℨ	℩	K	Å	ℬ	ℭ	℮	ℯ
			"ℰ	ℱ	Ⅎ	ℳ	ℴ	ℵ	ℶ	ℷ	ℸ	ℹ	℺	℻	ℼ	ℽ	ℾ	ℿ
			"⅀	⅁	⅂	⅃	⅄	ⅅ	ⅆ	ⅇ	ⅈ	ⅉ	⅊	⅋	⅌	⅍	ⅎ	⅏
		"SCRIPTS
			"⁰	ⁱ			⁴	⁵	⁶	⁷	⁸	⁹	⁺	⁻	⁼	⁽	⁾	ⁿ
			"₀	₁	₂	₃	₄	₅	₆	₇	₈	₉	₊	₋	₌	₍	₎
			"ₐ	ₑ	ₒ	ₓ	ₔ	ₕ	ₖ	ₗ	ₘ	ₙ	ₚ	ₛ	ₜ
		"PUNCTUATION
			"‐	‑	‒	–	—	―	‖	‗	‘	’	‚	‛	“	”	„	‟
			"†	‡	•	‣	․	‥	…	‧	L
			"‰	‱	′	″	‴	‵	‶	‷	‸	‹	›	※	‼	‽	‾	‿
			"⁀	⁁	⁂	⁃	⁄	⁅	⁆	⁇	⁈	⁉	⁊	⁋	⁌	⁍	⁎	⁏
			"⁐	⁑	⁒	⁓	⁔	⁕	⁖	⁗	⁘	⁙	⁚	⁛	⁜	⁝	⁞
		"HINDI
		"GREEK
			"Ͱ	ͱ	Ͳ	ͳ	ʹ	͵	Ͷ	ͷ			ͺ	ͻ	ͼ	ͽ	;	Ϳ
							"΄	΅	Ά	·	Έ	Ή	Ί		Ό		Ύ	Ώ
			"ΐ	Α	Β	Γ	Δ	Ε	Ζ	Η	Θ	Ι	Κ	Λ	Μ	Ν	Ξ	Ο
			"Π	Ρ		Σ	Τ	Υ	Φ	Χ	Ψ	Ω	Ϊ	Ϋ	ά	έ	ή	ί
			"ΰ	α	β	γ	δ	ε	ζ	η	θ	ι	κ	λ	μ	ν	ξ	ο
			"π	ρ	ς	σ	τ	υ	φ	χ	ψ	ω	ϊ	ϋ	ό	ύ	ώ	Ϗ
			"ϐ	ϑ	ϒ	ϓ	ϔ	ϕ	ϖ	ϗ	Ϙ	ϙ	Ϛ	ϛ	Ϝ	ϝ	Ϟ	ϟ
			"Ϡ	ϡ	Ϣ	ϣ	Ϥ	ϥ	Ϧ	ϧ	Ϩ	ϩ	Ϫ	ϫ	Ϭ	ϭ	Ϯ	ϯ
			"ϰ	ϱ	ϲ	ϳ	ϴ	ϵ	϶	Ϸ	ϸ	Ϲ	Ϻ	ϻ	ϼ	Ͻ	Ͼ	Ͽ

			"ἀ	ἁ	ἂ	ἃ	ἄ	ἅ	ἆ	ἇ	Ἀ	Ἁ	Ἂ	Ἃ	Ἄ	Ἅ	Ἆ	Ἇ
			"ἐ	ἑ	ἒ	ἓ	ἔ	ἕ			Ἐ	Ἑ	Ἒ	Ἓ	Ἔ	Ἕ
			"ἠ	ἡ	ἢ	ἣ	ἤ	ἥ	ἦ	ἧ	Ἠ	Ἡ	Ἢ	Ἣ	Ἤ	Ἥ	Ἦ	Ἧ
			"ἰ	ἱ	ἲ	ἳ	ἴ	ἵ	ἶ	ἷ	Ἰ	Ἱ	Ἲ	Ἳ	Ἴ	Ἵ	Ἶ	Ἷ
			"ὀ	ὁ	ὂ	ὃ	ὄ	ὅ			Ὀ	Ὁ	Ὂ	Ὃ	Ὄ	Ὅ
			"ὐ	ὑ	ὒ	ὓ	ὔ	ὕ	ὖ	ὗ		Ὑ		Ὓ		Ὕ		Ὗ
			"ὠ	ὡ	ὢ	ὣ	ὤ	ὥ	ὦ	ὧ	Ὠ	Ὡ	Ὢ	Ὣ	Ὤ	Ὥ	Ὦ	Ὧ
			"ὰ	ά	ὲ	έ	ὴ	ή	ὶ	ί	ὸ	ό	ὺ	ύ	ὼ	ώ
			"ᾀ	ᾁ	ᾂ	ᾃ	ᾄ	ᾅ	ᾆ	ᾇ	ᾈ	ᾉ	ᾊ	ᾋ	ᾌ	ᾍ	ᾎ	ᾏ
			"ᾐ	ᾑ	ᾒ	ᾓ	ᾔ	ᾕ	ᾖ	ᾗ	ᾘ	ᾙ	ᾚ	ᾛ	ᾜ	ᾝ	ᾞ	ᾟ
			"ᾠ	ᾡ	ᾢ	ᾣ	ᾤ	ᾥ	ᾦ	ᾧ	ᾨ	ᾩ	ᾪ	ᾫ	ᾬ	ᾭ	ᾮ	ᾯ
			"ᾰ	ᾱ	ᾲ	ᾳ	ᾴ		ᾶ	ᾷ	Ᾰ	Ᾱ	Ὰ	Ά	ᾼ	᾽	ι	᾿
			"῀	῁	ῂ	ῃ	ῄ		ῆ	ῇ	Ὲ	Έ	Ὴ	Ή	ῌ	῍	῎	῏
			"ῐ	ῑ	ῒ	ΐ			ῖ	ῗ	Ῐ	Ῑ	Ὶ	Ί		῝	῞	῟
			"ῠ	ῡ	ῢ	ΰ	ῤ	ῥ	ῦ	ῧ	Ῠ	Ῡ	Ὺ	Ύ	Ῥ	῭	΅	`
			"		ῲ	ῳ	ῴ		ῶ	ῷ	Ὸ	Ό	Ὼ	Ώ	ῼ	´	῾
		"CURRENCY
			"₠	₡	₢	₣	₤	₥	₦	₧	₨	₩	₪	₫	€	₭	₮	₯
			"₰	₱	₲	₳	₴	₵	₶	₷	₸	₹	₺	₻	₼	₽	₾	₿
	"EMOJIs
		"SQUARES
			"◼️ ◽️◾️◻️ ▪️ ▫️ ◽◾⬛⬜
		"CIRLCE
			"⚫🌑
	"MISCELLANEOUS
		"DINGBATS
				"✀	✁	✂	✃	✄	✆	✇	✈	✉	✌	✍	✎	✏
				"✐	✑	✒	✓	✔	✕	✖	✗	✘	✙	✚	✛	✜	✝	✞	✟
				"✠	✡	✢	✣	✤	✥	✦	✧	✩	✪	✫	✬	✭	✮	✯
				"✰	✱	✲	✳	✴	✵	✶	✷	✸	✹	✺	✻	✼	✽	✾	✿
				"❀	❁	❂	❃	❄	❅	❆	❇	❈	❉	❊	❋	❍	❏
				"❐	❑	❒	❖	❘	❙	❚	❛	❜	❝	❞	❟
				"❠	❡	❢	❣	❤	❥	❦	❧	❨	❩	❪	❫	❬	❭	❮	❯
				"❰	❱	❲	❳	❴	❵	❶	❷	❸	❹	❺	❻	❼	❽	❾	❿
				"➀	➁	➂	➃	➄	➅	➆	➇	➈	➉	➊	➋	➌	➍	➎	➏
				"➐	➑	➒	➓	➔	➕	➖	➗	➘	➙	➚	➛	➜	➝	➞	➟
				"➠	➡	➢	➣	➤	➥	➦	➧	➨	➩	➪	➫	➬	➭	➮	➯
				"➰	➱	➲	➳	➴	➵	➶	➷	➸	➹	➺	➻	➼	➽	➾	➿
"TEMPORARY
	"let g:promptline_preset = {
	"  \'a':		[ promptline#slices#cwd() ],
	"  \'b':		[ promptline#slices#vcs_branch() ],
	"  \'c':		[ promptline#slices#git_status() ],
	"  \'z':		[ promptline#slices#jobs() ],
	"  \'warn': [ promptline#slices#last_exit_code() ]
	"\}
	nnoremap <Leader>p.f :split<bar>terminal yarn run prettier-fix<CR>
	nnoremap <Leader>vf :AnyFoldActivate<CR>
"EXPERIMENT
	"FEATURES
		"+VIMDIFF
		"+CONCEAL
		"+PREVIEW=pedit|ptag…
"PLUGINS[WIP]
	"HIGHLIGHTER
		highlight LineHighlight ctermbg=darkgray guibg=darkgray
		nnoremap <silent> <Leader>hl :call matchadd('LineHighlight', '\%'.line('.').'l')<CR>
		nnoremap <silent> <Leader>hc :call clearmatches()<CR>"DEFAULTS.vim
runtime clients/neovide.vim
nnoremap <silent> <Leader>laf <CMD>lua require('libs/runner').format()<CR>
