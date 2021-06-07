"LEADER
	nnoremap ; :
	let mapleader      = ' '
	let maplocalleader = ','

	let g:insert_leader   = ';'
	let g:terminal_leader = ';'

	let g:action_leader = 'A'
	let g:mode_leader   = 'C-A'
	let g:motion_leader = 'C-S'

	"let g:modifier_1 = 'A-S'
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
					command! -nargs=1 -bang SaveAs	:call SaveAs  (<q-args>, <bang>0)
					command! -nargs=1 -bang Read	:call Read	  (<q-args>, <bang>0)
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
					command! -nargs=1		NewFile			:call NewFile		  (<q-args>)
					command! -nargs=1		NewDirectory	:call NewDiretory	  (<q-args>)
					command! -nargs=1 -bang DeleteDirectory :call DeleteDirectory (<q-args>,<bang>0)
					command! -nargs=1		DeleteFile		:call DeleteFile	  (<q-args>)
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
							" nnoremap <silent> j gj:nohl<CR>
							" nnoremap <silent> k gk:nohl<CR>

							" nnoremap <silent> h h:nohl<CR>
							" nnoremap <silent> l l:nohl<CR>
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
					"TODO:BETTER-JUMPS
						"TODO:BETTER-MARKS
						"TODO:BETTER-JUMPLIST
						"TODO:BETTER-YANKLIST
						"TODO:BETTER-CHANGELIST
						"TODO:BETTER-gf
							"FEATURE:FILENAME+LOCATION(COLUMN+ROW)
							"EXAMPLE:VIM-FETCH
					"TODO:BETTER-PASTE
						"TODO:FIX
						let g:better_paste_enable_default_mappings = 1
						if ExistsAndTrue('g:better_vim_enable_default_mappings') && ExistsAndTrue('g:better_paste_enable_default_mappings')
							"PASTE+SWAP
								"nnoremap p :normal! ]p <CR>
								"nnoremap P :normal! [p <CR>
								"nnoremap ]p :normal! p <CR>
								"nnoremap [p :normal! P <CR>
								"vnoremap p :<C-u>normal! ]pgvd <CR>
								"vnoremap P :<C-u>normal! [pgvd <CR>
								"vnoremap ]p :<C-u>normal! pgvd <CR>
								"vnoremap [p :<C-u>normal! Pgvd <CR>
							"PASTE+INDENT
								nnoremap >p :normal! ]p>> <CR>
								nnoremap <p :normal! ]p<< <CR>
								nnoremap >P :normal! [p>> <CR>
								nnoremap <P :normal! [p<< <CR>
							"PASTE+NEWLINE
								nnoremap ]p :normal! o<esc>p==
								nnoremap [p :normal! O<Esc>P==
							"PASTE+CYCLE
							"PASTE+FORMAT
						endif
					"TODO:BETTER-UNDO
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
									let g:better_cursor_default_preserve	  = 1
									let g:better_cursor_operators_preserve	  = []
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
							function GetFoldText() abort
								let l:lines  = v:foldend - v:foldstart + 1
								let l:first  = substitute(getline(v:foldstart), '\v *', '', '')
								let l:dashes = substitute(v:folddashes, '-', '', 'g')

								return ' ▵' . ' [' . l:lines . '] ' . l:first
							endfunction
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
			"TODO:HOOKER
				"ALIAS:HOOKS
				"TODO:OPERATOR
				"TODO:OBJECT
				"TODO:MOTION
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
							let lines[0]  = lines[0][columnStart - 1:]

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
				"TODO:MOVEE
					"FEATURE:STATE
					"FEATURE:COUNT
					"VERTICAL
						nnoremap <silent> <C-j> :move .+1<CR>==
						nnoremap <silent> <C-k> :move .-2<CR>==
						inoremap <silent> <C-j> <Esc>:move .+1<CR>==gi
						inoremap <silent> <C-k> <Esc>:move .-2<CR>==gi
						vnoremap <silent> <C-j> :move '>+1<CR>gv=gv
						vnoremap <silent> <C-k> :move '<-2<CR>gv=gv
					"HORIZONTAL
					"TODO:VISUAL-BLOCK
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
						command! -bang		  -nargs=1 Term   call Terminal(0	   , ''			 , 'enew', <bang>0, <q-args>)
						command! -bang -count -nargs=1 HBTerm call Terminal(<count>, 'botright'  , 'new' , <bang>0, <q-args>)
						command! -bang -count -nargs=1 HTTerm call Terminal(<count>, 'topleft'	 , 'new' , <bang>0, <q-args>)
						command! -bang -count -nargs=1 VLTerm call Terminal(<count>, 'leftabove' , 'vnew', <bang>0, <q-args>)
						command! -bang -count -nargs=1 VRTerm call Terminal(<count>, 'rightbelow', 'vnew', <bang>0, <q-args>)

						command! TermSendSelected	  call TerminalSend(GetSelectedText(), '\n')
						command! TermSendFile		  call TerminalSend(getline(0, '$'))
						command! TermSendLine		  call TerminalSend([getline('.')])
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
									let lines[0]  = lines[0][columnStart - 1:]
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
						vnoremap <Leader>lus :sort						   <CR>
						vnoremap <Leader>luu :<C-u>'<,'>sort \| '<,'>!uniq <CR>
						vnoremap <Leader>luc :<C-u>'<,'>!bc				   <CR>
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
										\'extension' :'py',
										\'repl'      :'ipython',
										\'execute'   :'python3 %:p:S',
										\'init'      : [
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
										\'extension' :'r',
										\'repl'      :'r',
									\}
									let g:languages.javascript = {
										\'extension' :'js',
										\'repl'      :'node',
										\'execute'   :'node %:p:S',
									\}
									let g:languages.ruby = {
										\'extension' :'rb',
										\'repl'      :'irb',
										\'execute'   :'ruby %:p:S',
									\}
									let g:languages.perl = {
										\'extension' :'pl',
										\'repl'      :'perl',
										\'execute'   :'perl %:p:S',
									\}
									let g:languages.php = {
										\'extension' :'php',
										\'repl'      :'php',
										\'execute'   :'php %:p:S',
									\}
									let g:languages.lisp = {
										\'extension' :'lsp',
										\'repl'      :'sbcl',
									\}
									let g:languages.lua = {
										\'extension' :'lua',
										\'repl'      :'lua',
										\'execute'   :'lua %:p:S',
									\}
								"COMPILED
									let g:languages.c = {
										\'extension'       :'c',
										\'repl'            :'cling',
										\'compile'         :'gcc %:p:S -o %:p:r:S.out',
										\'execute'         :'%:p:r:S.out',
										\'compile-execute' :'gcc %:p:S -o %:p:r:S.out && %:p:r:S.out',
										\'init'            : [
												\'#include <stdio.h>',
												\'#include <math.h>',
										\],
									\}
									let g:languages.cpp = {
										\'extension'       : 'cpp',
										\'repl'            : 'cling',
										\'compile'         : 'g++ -std=c++14 %:p:S -o %:p:r:S.out',
										\'execute'         : '%:p:r:S.out',
										\'compile-execute' : 'g++ -std=c++14 %:p:S -o %:p:r:S.out && %:p:r:S.out',
										\'init'            : [
											\'#include <iostream>',
											\'#include <string>',
											\'using namespace std;',
										\],
									\}
									let g:languages.cs = {
										\'extension'       : 'cs',
										\'repl'            : 'csharp',
										\'compile'         : 'csc %:p:s',
										\'execute'         : 'mono %:p:r:s.exe',
										\'compile-execute' : 'csc %:p:s && mono %:p:r:s.exe',
									\}
									let g:languages.csx = {
										\'extension' : 'csx',
										\'repl'      : 'scriptcs',
										\'execute'   : 'scriptcs %:p:r:S.csx',
									\}
									let g:languages.java = {
										\'extension'       : 'java',
										\'repl'            : 'jshell',
										\'compile'         : 'javac %:p:S',
										\'execute'         : 'java %:p:r:S',
										\'compile-execute' : 'javac %:p:S && java %:p:r:S',
									\}
									let g:languages.scala = {
										\'extension'       : 'scala',
										\'repl'            : 'scala',
										\'compile'         : 'scalac %:p:S',
										\'execute'         : 'scala %:p:r:S',
										\'compile-execute' : 'scalac %:p:S && scala %:p:r:S',
									\}
									let g:languages.haskell = {
										\'extension'       : 'hs',
										\'repl'            : 'ghci',
										\'compile'         : 'ghc -Wno-tabs %:p:S',
										\'execute'         : '%:p:r:S',
										\'compile-execute' : 'ghc -Wno-tabs %:p:S && %:p:r:S',
									\}
									let g:languages.typescript = {
										\'extension'       : 'ts',
										\'repl'            : 'ts-node',
										\'compile'         : 'tsc %:p:S',
										\'execute'         : 'node %:p:r:S.js',
										\'compile-execute' : 'tsc %:p:S && node %:p:r:S.js',
									\}
									let g:languages.processing = {
										\'extension'       : 'pde',
										\'compile'         : 'processing-java --output=/tmp/processing/ --force --sketch=%:p:h:S --build',
										\'execute'         : 'processing-java --output=/tmp/processing/ --force --sketch=%:p:h:S --run',
										\'compile-execute' : 'processing-java --output=/tmp/processing/ --force --sketch=%:p:h:S --run',
									\}
							"REPL
								"SHELL
									let g:languages.sh = {
										\'extension' : 'sh',
										\'repl'      : 'sh',
										\'execute'   : 'sh %:p:S',
									\}
									let g:languages.bash = {
										\'extension' : 'bash',
										\'repl'      : 'bash',
										\'execute'   : 'bash %:p:S',
									\}
									let g:languages.zsh = {
										\'extension' : 'zsh',
										\'repl'      : 'zsh',
										\'execute'   : 'zsh %:p:S',
									\}
									let g:languages.fish = {
										\'extension' : 'fsh',
										\'repl'      : 'fsh',
										\'execute'   : 'fsh',
									\}
									let g:languages.batch = {
										\'extension' : 'cmd',
										\'repl'      : 'cmd',
									\}
								"DATABASE
									let g:languages.sqlite = {
										\'extension' : 'sql',
										\'repl'      : 'sqlite',
									\}
									let g:languages.mysql = {
										\'extension' : 'mysql',
										\'repl'      : 'mysql',
									\}
									let g:languages.redis = {
										\'extension' : 'redis',
										\'repl'      : 'redis-cli',
									\}
									let g:languages.mongo = {
										\'extension' : 'mongo',
										\'repl'      : 'mongo',
									\}
							"FRAMEWORKS
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
					"COMMANDS
						command! -narg=? ExecutionerREPL           :execute 'VRTerm '	   . ExecutionerCommand('repl', <q-args>) | :call ExecutionerInitREPL()
						command!         ExecutionerCompile        :execute '10HBTerm '  . ExecutionerCommand('compile')
						command!         ExecutionerExecute        :execute '20HBTerm! ' . ExecutionerCommand('execute')
						command!         ExecutionerCompileExecute :execute '20HBTerm! ' . ExecutionerCommand('compile-execute')
					"MAPPINGS
						nmap <silent> <Plug>(executioner-repl)            :ExecutionerREPL<CR>
						nmap <silent> <Plug>(executioner-compile)         :ExecutionerCompile<CR>
						nmap <silent> <Plug>(executioner-execute)         :ExecutionerExecute<CR>
						nmap <silent> <Plug>(executioner-compile-execute) :ExecutionerCompileExecute<CR>
						nmap <silent> <Plug>(executioner-fzf-repl)        :call fzf#run(fzf#wrap({'source': getcompletion('', 'filetype'), 'sink': 'ExecutionerREPL'}))<CR>
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
					let g:space_warrior_enable_default_mappings			 = 1
					let g:space_warrior_highlight_trailing_whitespaces	 = 1
					let g:space_warrior_highlight_leading_spaces		 = 1
					let g:space_warrior_highlight_leading_tabs			 = 0
					let g:space_warrior_highlight_listchars				 = 1
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
					command! SWSpaces2Tabs			   :execute ConvertSpaces2Tabs()
					command! SWTabs2Spaces			   :execute ConvertSpaces2Tabs()
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
					nmap <silent> <Plug>(sw-spaces-2-tabs)			   :SWSpaces2Tabs<CR>
					nmap <silent> <Plug>(sw-tabs-2-spaces)			   :SWTabs2Spaces<CR>
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
							highlight NonText	  ctermfg=135 guifg=#af5fff
							highlight Whitespace  ctermfg=135 guifg=#af5fff
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
						\ 'source'  : g:jaat_find_directories_command . ' ' . g:jaat_root_path,
						\ 'sink'    : 'cd',
						\ 'options' : '--prompt "open-project> "'
					\}))<CR>

					command! ProjectinatorOpenFile :call fzf#run(fzf#wrap({
						\ 'source'	: g:jaat_find_files_command,
						\ 'options' : '--prompt "open-project-file> "'
					\}))<CR>

					"TODO:FIX
					command! ProjectinatorSearchText :call fzf#run(fzf#wrap({
						\ 'source'  : g:jaat_find_lines_command,
						\ 'sink'    : 'edit',
						\ 'options' : '--prompt "search-project> "'
					\}))<CR>
				"DEFAULTS
					if ExistsAndTrue('g:projectinator_enable_default_mappings')
						nnoremap <silent> <Leader>po :ProjectinatorOpenProject<CR>
						nnoremap <silent> <Leader>pf :ProjectinatorOpenFile<CR>

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
							\["->u"   , "↑"],
							\["->d"   , "↓"],
							\["<-"	  , "←"],
							\["->"	  , "→"],
							\["<->"   , "↔"],
							\["<.."   , "⇠"],
							\["..>"   , "⇢"],
							\["..>u"  , "⇡"],
							\["..>d"  , "⇣"],
							\["<--"   , "⟵"],
							\["-->"   , "⟶"],
							\["<-->"  , "⟷"],
							\["<="	  , "⇐"],
							\["=>"	  , "⇒"],
							\["<=>"   , "⇔"],
							\["<=="   , "⟸"],
							\["==>"   , "⟹"],
							\["<==>"  , "⟺"],
							\["\\|>"  , "↦"],
							\["<\\|"  , "↤"],
							\["\\|->" , "⟼" ],
							\["<-\\|" , "⟻"],
							\["<=\\|" , "⟽"],
							\["\\|=>" , "⟾" ],
						\]
						let g:symbolic_pairs.operators = [
							\["<-"	  , "≤"],
							\["<<"	  , "≪"],
							\["<<<"   , "⋘"],
							\[">-"	  , "≥"],
							\[">>"	  , "≫"],
							\[">>>"   , "⋙"],
							\["!="	  , "≠"],
							\["*"	  , "×"],
							\["/"	  , "÷"],
							\["sum"   , "∑"],
							\["prod"  , "∏"],
							\["cprod" , "∐"],
							\["srt"   , "√"],
							\["crt"   , "∛"],
							\["qrt"   , "∜"],
							\["~"	  , "≈"],
							\["="	  , "≡"],
							\["prop"  , "∝"],
							\["floor" , "⌊⌋"],
							\["ceil"  , "⌈⌉"],
							\["+-"	  , "±"],
							\["-+"	  , "∓"],
							\["."	  , "∙"],
							\["<="	  , "≦"],
							\[">="	  , "≧"],
							\["ox"	  , "⨂"],
							\["o+"	  , "⨁"],
							\["o-"	  , "⊖"],
							\["o."	  , "⨀"],
							\["o*"	  , "⊛"],
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
							\["beta"   , "𝛃"],
							\["gamma"  , "𝛄"],
							\["Gamma"  , "Γ"],
							\["delta"  , "𝛅"],
							\["Delta"  , "∆"],
							\["nabla"  , "∇"],
							\["epsi"   , "𝛆"],
							\["zeta"   , "ζ"],
							\["eta"    , "𝛈"],
							\["theta"  , "𝛉"],
							\["Theta"  , "Θ"],
							\["iota"   , "ι"],
							\["kappa"  , "𝛞"],
							\["lambda" , "𝛌"],
							\["Lambda" , "Λ"],
							\["mu"	   , "𝛍"],
							\["nu"	   , "𝛎"],
							\["xi"	   , "ξ"],
							\["Xi"	   , "Ξ"],
							\["pi"	   , "𝛑"],
							\["Pi"	   , "Π"],
							\["rho"    , "𝛒"],
							\["sigma"  , "𝛔"],
							\["Sigma"  , "Σ"],
							\["tau"    , "𝛕"],
							\["upsi"   , "𝛖"],
							\["Upsi"   , "ϒ"],
							\["phi"    , "φ"],
							\["Phi"    , "𝛟"],
							\["chi"    , "𝛘"],
							\["psi"    , "Ψ"],
							\["Psi"    , "𝛙"],
							\["omega"  , "𝛚"],
							\["Omega"  , "Ω"],
							\["a"	   , "𝛂"],
							\["b"	   , "𝛃"],
							\["e"	   , "𝛆"],
							\["E"	   , "Σ"],
							\["n"	   , "𝛈"],
							\["o"	   , "𝛉"],
							\["i"	   , "ι"],
							\["u"	   , "𝛍"],
							\["v"	   , "𝛎"],
							\["p"	   , "𝛒"],
							\["T"	   , "𝛕"],
							\["w"	   , "𝛚"],
							\["x"	   , "𝛞"],
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
							\["0u"	   , "⁰"],
							\["1u"	   , "¹"],
							\["2u"	   , "²"],
							\["3u"	   , "³"],
							\["4u"	   , "⁴"],
							\["5u"	   , "⁵"],
							\["6u"	   , "⁶"],
							\["7u"	   , "⁷"],
							\["8u"	   , "⁸"],
							\["9u"	   , "⁹"],
							\["0d"	   , "₀"],
							\["1d"	   , "₁"],
							\["2d"	   , "₂"],
							\["3d"	   , "₃"],
							\["4d"	   , "₄"],
							\["5d"	   , "₅"],
							\["6d"	   , "₆"],
							\["7d"	   , "₇"],
							\["8d"	   , "₈"],
							\["9d"	   , "₉"],
							\["+u"	   , "⁺"],
							\["-u"	   , "⁻"],
							\["(u"	   , "⁽"],
							\[")u"	   , "⁾"],
							\["=u"	   , "⁼"],
							\["+d"	   , "₊"],
							\["-d"	   , "₋"],
							\["(d"	   , "₍"],
							\[")d"	   , "₎"],
							\["=d"	   , "₌"],
							\["au"	   , "ᵃ"],
							\["bu"	   , "ᵇ"],
							\["cu"	   , "ᶜ"],
							\["du"	   , "ᵈ"],
							\["eu"	   , "ᵉ"],
							\["fu"	   , "ᶠ"],
							\["gu"	   , "ᵍ"],
							\["hu"	   , "ʰ"],
							\["iu"	   , "ⁱ"],
							\["ju"	   , "ʲ"],
							\["ku"	   , "ᵏ"],
							\["lu"	   , "ˡ"],
							\["mu"	   , "ᵐ"],
							\["nu"	   , "ⁿ"],
							\["ou"	   , "ᵒ"],
							\["pu"	   , "ᵖ"],
							\["qu"	   , "⁺"],
							\["ru"	   , "ʳ"],
							\["su"	   , "ˢ"],
							\["tu"	   , "ᵗ"],
							\["uu"	   , "ᵘ"],
							\["vu"	   , "ᵛ"],
							\["wu"	   , "ʷ"],
							\["xu"	   , "ˣ"],
							\["yu"	   , "ʸ"],
							\["zu"	   , "ᶻ"],
							\["Au"	   , "ᴬ"],
							\["Bu"	   , "ᴮ"],
							\["Cu"	   , "⁺"],
							\["Du"	   , "ᴰ"],
							\["Eu"	   , "ᴱ"],
							\["Fu"	   , "⁺"],
							\["Gu"	   , "ᴳ"],
							\["Hu"	   , "ᴴ"],
							\["Iu"	   , "ᴵ"],
							\["Ju"	   , "ᴶ"],
							\["Ku"	   , "ᴷ"],
							\["Lu"	   , "ᴸ"],
							\["Mu"	   , "ᴹ"],
							\["Nu"	   , "ᴺ"],
							\["Ou"	   , "ᴼ"],
							\["Pu"	   , "ᴾ"],
							\["Qu"	   , "⁺"],
							\["Ru"	   , "ᴿ"],
							\["Su"	   , "⁺"],
							\["Tu"	   , "ᵀ"],
							\["Uu"	   , "ᵁ"],
							\["Vu"	   , "ⱽ"],
							\["Wu"	   , "ᵂ"],
							\["Xu"	   , "⁺"],
							\["Yu"	   , "⁺"],
							\["Zu"	   , "⁺"],
							\["ad"	   , "ₐ"],
							\["bd"	   , "⁺"],
							\["cd"	   , "⁺"],
							\["dd"	   , "⁺"],
							\["ed"	   , "ₑ"],
							\["fd"	   , "⁺"],
							\["gd"	   , "⁺"],
							\["hd"	   , "⁺"],
							\["id"	   , "ᵢ"],
							\["jd"	   , "ⱼ"],
							\["kd"	   , "⁺"],
							\["ld"	   , "⁺"],
							\["md"	   , "⁺"],
							\["nd"	   , "⁺"],
							\["od"	   , "ₒ"],
							\["pd"	   , "⁺"],
							\["qd"	   , "⁺"],
							\["rd"	   , "ᵣ"],
							\["sd"	   , "⁺"],
							\["td"	   , "⁺"],
							\["ud"	   , "ᵤ"],
							\["vd"	   , "ᵥ"],
							\["wd"	   , "⁺"],
							\["xd"	   , "ₓ"],
							\["yd"	   , "⁺"],
							\["zd"	   , "⁺"],
							\["Ad"	   , "⁺"],
							\["Bd"	   , "⁺"],
							\["Cd"	   , "⁺"],
							\["Dd"	   , "⁺"],
							\["Ed"	   , "⁺"],
							\["Fd"	   , "⁺"],
							\["Gd"	   , "⁺"],
							\["Hd"	   , "⁺"],
							\["Id"	   , "⁺"],
							\["Jd"	   , "⁺"],
							\["Kd"	   , "⁺"],
							\["Ld"	   , "⁺"],
							\["Md"	   , "⁺"],
							\["Nd"	   , "⁺"],
							\["Od"	   , "⁺"],
							\["Pd"	   , "⁺"],
							\["Qd"	   , "⁺"],
							\["Rd"	   , "⁺"],
							\["Sd"	   , "⁺"],
							\["Td"	   , "⁺"],
							\["Ud"	   , "⁺"],
							\["Vd"	   , "⁺"],
							\["Wd"	   , "⁺"],
							\["Xd"	   , "⁺"],
							\["Yd"	   , "⁺"],
							\["Zd"	   , "⁺"],
							\["alphau" , "ᵅ"],
							\["betau"  , "ᵝ"],
							\["epsiu"  , "ᵋ"],
							\["deltau" , "ᵟ"],
							\["thetau" , "ᶿ"],
							\["phiu"   , "ᶲ"],
							\["Phiu"   , "ᵠ"],
							\["betad"  , "ᵦ"],
							\["phid"   , "ᵩ"],
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

						let top    = ((&lines - height) / 2) - 1
						let left   = (&columns - width) / 2
						let opts   = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

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
							let l:sno	 = string(emoji['sno']) . '.  '
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
					imap :ej <ESC>:FZFEmojis<CR>
		"FLOATERM
			if executable('vifm')
				command! -nargs=1 Vifm :execute 'FloatermNew ' g:jaat_explorer_command . ' ' . shellescape(<q-args>)
				nnoremap <silent> <Leader>aE :execute 'FloatermNew ' . g:jaat_explorer_command . ' ' . shellescape(getcwd())<CR>
				nnoremap <silent> <Leader>ae :execute 'FloatermNew ' . g:jaat_explorer_command<CR>
			endif

			if executable('glow')
				command! -nargs=1 Glow :execute 'FloatermNew --autoclose=0 glow ' . shellescape(<q-args>)

				nnoremap <silent> <Leader>am :FloatermNew glow<CR>
				nnoremap <silent> <Leader>aM :execute 'FloatermNew --autoclose=0 glow ' . shellescape(expand('%:p'))<CR>
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
		let g:jaat_lists_path = g:jaat_tmp_path . 'lists/'

		let g:jaat_home_path = expand('~')
		let g:jaat_root_path =
			\ IsNix()
			\ ? shellescape(expand('/'))
			\ : shellescape(expand('D:'))
		let g:jaat_drive_path =
			\ IsNix()
			\ ? shellescape(expand('~/Google Drive'))
			\ : shellescape(expand('~/Google Drive'))
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
"MAPPINGS
	"NOPS
		map Q <nop>
		map <C-r> <nop>
	"REMAPS
		nnoremap U <C-r>
		nnoremap ' "
	"LEADER
		"BASICS
			nnoremap <Leader>vq :qall<CR>
			nnoremap <Leader>vQ :qall!<CR>
			"TODO:FIX
				"execute 'nnoremap <silent> <' . g:leader_2 . '-space> <ESC>'
		"EDITING
			"OPERATORS
			"OBJECTS
			"MOTIONS
			"JUMPS
				execute 'nnoremap <' . g:action_leader . '-o> <C-o>'
				execute 'nnoremap <' . g:action_leader . '-i> <C-i>'

				execute 'nnoremap <' . g:action_leader . '-[> <C-t>'
				execute 'nnoremap <' . g:action_leader . '-]> <C-]>'
		"INTERFACE
			"TABS
				nnoremap <silent> <Leader>Ta :tabnew	  <CR>
				nnoremap <silent> <Leader>Td :tabclose	  <CR>
				nnoremap <silent> <Leader>Tn :tabnext	  <CR>
				nnoremap <silent> <Leader>Tp :tabprevious <CR>
				nnoremap <silent> <Leader>TN :tabmove -   <CR>
				nnoremap <silent> <Leader>TP :tabmove +   <CR>
			"BUFFERS
				nnoremap <silent> <Leader>ban :enew<CR>
				nnoremap <silent> <Leader>bas :call ScratchBuffer('e')<CR>
				nnoremap <silent> <Leader>baS :call ScratchBuffer('e', 1)<CR>

				nnoremap <silent> <Leader>bcc :bp<bar>sp<bar>bn<bar>bd<CR>
				nnoremap <silent> <Leader>bcC :bp<bar>sp<bar>bn<bar>bd!<CR>
				nnoremap <silent> <Leader>bcA :bufdo bp<bar>sp<bar>bn<bar>bd<CR>
				nnoremap <silent> <Leader>bcA :bufdo bp<bar>sp<bar>bn<bar>bd!<CR>

				nnoremap <silent> <Leader>bdc :bdelete<CR>
				nnoremap <silent> <Leader>bdC :bdelete!<CR>
				nnoremap <silent> <Leader>bda :bufdo bdelete<CR>
				nnoremap <silent> <Leader>bdA :bufdo bdelete!<CR>
				nnoremap <silent> <A-d> :bp<bar>sp<bar>bn<bar>bd<CR>

				nnoremap <silent> <Leader>bs :call ScratchBuffer('e')<CR>
				nnoremap <silent> <Leader>bS :call ScratchBuffer('e', 1)<CR>

				nnoremap <silent> <Leader>bwc :write<CR>
				nnoremap <silent> <Leader>bwa :wall<CR>
				nnoremap <silent> <Leader>bwC :write!<CR>
				nnoremap <silent> <Leader>bwA :wall!<CR>
				nnoremap <silent> <A-s> :wall<CR>

				nnoremap <Leader>` <C-^>

				nnoremap <silent> <A-n> :bprevious<CR>
				nnoremap <silent> <A-p> :bnext<CR>
			"WINDOWS
				nnoremap <silent> <Leader>wh :sp<CR>
				nnoremap <silent> <Leader>wv :vsp<CR>
				nnoremap <silent> <Leader>wH :new<CR>
				nnoremap <silent> <Leader>wV :vnew<CR>
				nnoremap <silent> <Leader>wo :only<CR>
				nnoremap <silent> <Leader>wc :close<CR>
				nnoremap <silent> <Leader>w= <C-w>=

				if has('nvim')
					execute 'nnoremap <silent> <' . g:action_leader . '-h> <C-w><C-h>'
					execute 'nnoremap <silent> <' . g:action_leader . '-j> <C-w><C-j>'
					execute 'nnoremap <silent> <' . g:action_leader . '-k> <C-w><C-k>'
					execute 'nnoremap <silent> <' . g:action_leader . '-l> <C-w><C-l>'

					execute 'inoremap <silent> <' . g:action_leader . '-h> <ESC><C-w><C-h>'
					execute 'inoremap <silent> <' . g:action_leader . '-j> <ESC><C-w><C-j>'
					execute 'inoremap <silent> <' . g:action_leader . '-k> <ESC><C-w><C-k>'
					execute 'inoremap <silent> <' . g:action_leader . '-l> <ESC><C-w><C-l>'

					"window navigation for non-floating terminals
					execute 'tnoremap <silent> <' . g:action_leader . '-h> <C-\><C-n><C-w>h'
					execute 'tnoremap <silent> <' . g:action_leader . '-j> <C-\><C-n><C-w>j'
					execute 'tnoremap <silent> <' . g:action_leader . '-k> <C-\><C-n><C-w>k'
					execute 'tnoremap <silent> <' . g:action_leader . '-l> <C-\><C-n><C-w>l'
				endif
			"TERMINAL
				if has('nvim')
					"MAPPINGS
						"<esc>
						execute 'tnoremap <silent> <' . g:action_leader . '-[> <C-\><C-n>'

						"vim-registers
						tnoremap <silent> <expr> <A-'> '<C-\><C-N>"'.nr2char(getchar()).'pi'
					"ALIASES
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
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gcs git show  \| delta \| bat<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gcS git show  \| delta \| bat<C-LEFT><C-LEFT><LEFT><LEFT><LEFT>'

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
							execute 'tnoremap <silent> ' . g:terminal_leader . 'sq exit<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'sc clear<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'sp <space>\|<space>'
						"NPM
							execute 'tnoremap <silent> ' . g:terminal_leader . 'ns npm run start<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'nt npm run test<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'nb npm run build<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'ni npm install --save '
							execute 'tnoremap <silent> ' . g:terminal_leader . 'nd npm install --save-dev '
					"VISH
						"CONFIGURATION
							"let g:modes   = ['N','I']
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
		"MODE:INSERT
		"MODE:COMMAND
		"SOURCE
			nnoremap <silent> <expr> <Leader>vc ':edit '   . g:jaat_config_path . '<CR>'
			nnoremap <silent> <expr> <Leader>vs ':source ' . g:jaat_config_path . '<CR>'
		"PLUGINS
			nnoremap <silent> <Leader>vpl :PlugStatus<CR>
			nnoremap <silent> <Leader>vpi :PlugInstall<CR>
			nnoremap <silent> <Leader>vpu :PlugClean<CR>
			nnoremap <silent> <Leader>vpU :PlugUpdate<CR>
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
						"au FileType markdown nmap <buffer> <LocalLeader>ch :call RunNpmCommand('', "%", 'gh-markdown-cli')<CR>
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
			"WORDPRESS
				augroup WORDPRESS
					au!
					au BufEnter wordpress set filetype=jade
					au BufEnter wordpress map <buffer> <LocalLeader>ch :<C-u>call Pug('12,$')<CR>
					au BufEnter wordpress map <buffer> <LocalLeader>cj :<C-u>call Html2Pug('12,$')<CR>
				augroup END
	"MODE-LEADER
	"MOTION-LEADER
	"ACTION-LEADER
	"INSERT-LEADER
	"COMMAND-LEADER
		"GIT
			"TODO:FIX
			execute 'cnoremap <silent> ' . g:command_leader . 'gi :!git init<CR>'
			execute 'cnoremap <silent> ' . g:command_leader . 'gC :!git clone '

			execute 'cnoremap <silent> ' . g:command_leader . 'ga :!git add **<LEFT>'
			execute 'cnoremap <silent> ' . g:command_leader . 'gd :!git diff ** \| delta<C-LEFT><LEFT><LEFT><LEFT><LEFT>'
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
	"TERMINAL-LEADER
	"RANDOM
"PLUGINS
	"INSTALLED
		call plug#begin()
			"DEFAULTS
			"EDITING
				"OPERATORS
					Plug 'haya14busa/vim-operator-flashy'
						"CONFIGURATION
							let g:operator#flashy#group = 'Visual'
						"MAPPINGS
							map y <Plug>(operator-flashy)
							map Y <Plug>(operator-flashy)$
					Plug 'tpope/vim-surround'
					Plug 'junegunn/vim-easy-align'
						xmap gl <Plug>(EasyAlign)
						nmap gl <Plug>(EasyAlign)
					Plug 'svermeulen/vim-subversive'
						nmap gs <plug>(SubversiveSubstituteRange)
						xmap gs <plug>(SubversiveSubstituteRange)
					Plug 'tommcdo/vim-exchange'
						let g:exchange_no_mappings = 1
						nmap gx  <Plug>(Exchange)
						nmap gxx <Plug>(ExchangeLine)
						xmap X	 <Plug>(Exchange)
						nmap gxc <Plug>(ExchangeClear)
					Plug 'arthurxavierx/vim-caser'
						"CONFIGURATIONS
							let g:caser_no_mappings = 1
							let g:caser_prefix = 'gc'
						"MAPPINGS
							nmap <silent> gcc <Plug>CaserCamelCase
							vmap <silent> gcc <Plug>CaserVCamelCase

							nmap <silent> gcp <Plug>CaserMixedCase
							vmap <silent> gcp <Plug>CaserVMixedCase

							nmap <silent> gc. <Plug>CaserDotCase
							vmap <silent> gc. <Plug>CaserVDotCase

							nmap <silent> gc- <Plug>CaserKebabCase
							vmap <silent> gc- <Plug>CaserVKebabCase

							nmap <silent> gc_ <Plug>CaserSnakeCase
							vmap <silent> gc_ <Plug>CaserVSnakeCase

							nmap <silent> gc<space> <Plug>CaserSpaceCase
							vmap <silent> gc<space> <Plug>CaserVMixSpaceCase

							nmap <silent> gcT <Plug>CaserTitleKebabCase
							vmap <silent> gcT <Plug>CaserVTitleKebabCase

							nmap <silent> gct <Plug>CaserTitleCase
							vmap <silent> gct <Plug>CaserVTitleCase

							nmap <silent> gcs <Plug>CaserSentenceCase
							vmap <silent> gcs <Plug>CaserVSentenceCase

							nnoremap <silent> gcl gu
							vnoremap <silent> gcl gu

							nmap <silent> gcu <Plug>CaserUpperCase
							vmap <silent> gcu <Plug>CaserVUpperCase
					Plug 'gustavo-hms/vim-duplicate'
						map gy <Plug>(operator-duplicate)
					"TODO:DECIDE
						Plug 'rjayatilleka/vim-operator-goto'
							map g[ <Plug>(operator-gotostart)
							map g] <Plug>(operator-gotoend)
						Plug 'deris/vim-operator-insert'
							"TODO:FIX|DECIDE
							nmap gi <Plug>(operator-insert-i)
							nmap ga <Plug>(operator-insert-a)
				"OBJECTS
					Plug 'wellle/targets.vim'
					Plug 'michaeljsmith/vim-indent-object'
					Plug 'Julian/vim-textobj-variable-segment'
					Plug 'saaguero/vim-textobj-pastedtext'
						let g:pastedtext_select_key = 'gp'
					Plug 'rhysd/vim-textobj-lastinserted'
					Plug 'coderifous/textobj-word-column.vim'
					Plug 'rhysd/vim-textobj-anyblock'
					Plug 'thinca/vim-textobj-between'
					Plug 'sgur/vim-textobj-parameter'
						let g:vim_textobj_parameter_mapping = 'a'
					Plug 'haya14busa/vim-easyoperator-line'
						omap gr <Plug>(easyoperator-line-select)
						xmap gr <Plug>(easyoperator-line-select)
					Plug 'haya14busa/vim-easyoperator-phrase'
						omap gR <Plug>(easyoperator-phrase-select)
						xmap gR <Plug>(easyoperator-phrase-select)
					Plug 'glts/vim-textobj-comment'
						let g:textobj_comment_no_default_mappings = 1
						xmap ak <Plug>(textobj-comment-a)
						xmap ik <Plug>(textobj-comment-i)
						omap ak <Plug>(textobj-comment-a)
						omap ik <Plug>(textobj-comment-i)
				"MOTIONS
					Plug 'chaoren/vim-wordmotion'
					Plug 'haya14busa/vim-edgemotion'
						"map <C-j> <Plug>(edgemotion-j)
						"map <C-k> <Plug>(edgemotion-k)
				"SEARCH
					"Plug 'romainl/vim-cool'
						"TODO:DECIDE|CHECK-IF-NEEDED
					Plug 'inside/vim-search-pulse'
						"CONFIGURATION
							let g:vim_search_pulse_mode = 'cursor_line'
						"MAPPINGS
							map n  <Plug>(incsearch-nohl-n)<Plug>Pulse
							map N  <Plug>(incsearch-nohl-N)<Plug>Pulse
							map *  <Plug>(incsearch-nohl-*)<Plug>Pulse
							map #  <Plug>(incsearch-nohl-#)<Plug>Pulse
							map g* <Plug>(incsearch-nohl-g*)<Plug>Pulse
							map g# <Plug>(incsearch-nohl-g#)<Plug>Pulse
					Plug 'haya14busa/vim-asterisk'
						"CONFIGURATION
							"TODO:NOT-WORKING
							let g:asterisk#keeppos = 1
						"MAPPINGS
							map *  <Plug>(asterisk-z*)
							map #  <Plug>(asterisk-z#)
							map g* <Plug>(asterisk-gz*)
							map g# <Plug>(asterisk-gz#)
					Plug 'bronson/vim-visual-star-search'
					Plug 'rhysd/clever-f.vim'
						let g:clever_f_ignore_case           = 1
						let g:clever_f_smart_case            = 1
						let g:clever_f_across_no_line        = 0
						let g:clever_f_chars_match_any_signs = '['
					Plug 'justinmk/vim-sneak'
						"CONFIGURATION
							let g:sneak#label	   = 0
							let g:sneak#s_next	   = 1
							let g:sneak#use_ic_scs = 1
						"MAPPINGS
							"map f <Plug>Sneak_s
							"map F <Plug>Sneak_S
							"map t <Plug>Sneak_t
								"not-working"
							"map T <Plug>Sneak_T
								"not-working"
					Plug 'haya14busa/incsearch.vim'
						"CONFIGURATION
						"MAPPINGS
							"SEARCH
								map / <Plug>(incsearch-forward)
									"map / <Plug>(incsearch-stay)
								map ? <Plug>(incsearch-backward)
							"NOHL
								""using "vim-cool"
								"set hlsearch
								"let g:incsearch#auto_nohlsearch = 1
								"map n	<Plug>(incsearch-nohl-n)
								"map N	<Plug>(incsearch-nohl-N)
								"map *	<Plug>(incsearch-nohl-*)
								"map #	<Plug>(incsearch-nohl-#)
								"map g* <Plug>(incsearch-nohl-g*)
								"map g# <Plug>(incsearch-nohl-g#)
						"EXTENSIONS
							Plug 'haya14busa/incsearch-fuzzy.vim'
								map <Leader>/ <Plug>(incsearch-fuzzy-/)
									"map <Leader>/ <Plug>(incsearch-fuzzy-stay)
								map <Leader>? <Plug>(incsearch-fuzzy-?)
					Plug 'lambdalisue/reword.vim'
					Plug 'easymotion/vim-easymotion'
						"CONFIGURATION
							let g:EasyMotion_do_mapping		  = 0
							let g:EasyMotion_smartcase		  = 1
							let g:EasyMotion_use_upper		  = 0
							let g:EasyMotion_enter_jump_first = 1
							let g:EasyMotion_space_jump_first = 1
							"nmap <Leader>j <Plug>(easymotion-prefix)
							"let g:EasyMotion_keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;'
							"hi link EasyMotionTarget Search
						"MAPPINGS
							"LEVEL=1
								"MODE:NORMAL
									nmap <Leader>jw <Plug>(easymotion-overwin-w)
									nmap <Leader>jl <Plug>(easymotion-overwin-line)
									nmap <Leader>je <Plug>(easymotion-bd-e)
									nmap <Leader>jf <Plug>(easymotion-overwin-f)
									nmap <Leader>js <Plug>(easymotion-overwin-f2)
									nmap <Leader>jj <Plug>(easymotion-j)
									nmap <Leader>jk <Plug>(easymotion-k)
									nmap <Leader>jJ <Plug>(easymotion-eol-j)
									nmap <Leader>jK <Plug>(easymotion-eol-k)
									nmap <Leader>j. <Plug>(easymotion-repeat)
									nmap <Leader>ja <Plug>(easymotion-jumptoanywhere)
									nmap <Leader>j/ <Plug>(easymotion-sn)
									nmap <Leader>j? <Plug>(easymotion-tn)
								"MODE:OPERATOR
									"omap <Leader>w <Plug>(easymotion-bd-w)
									"omap <Leader>W <Plug>(easymotion-bd-W)
									"omap <Leader>e <Plug>(easymotion-bd-e)
									"omap <Leader>E <Plug>(easymotion-bd-E)
									"omap <Leader>l <Plug>(easymotion-bd-jk)
									"omap <Leader>j <Plug>(easymotion-j)
									"omap <Leader>k <Plug>(easymotion-k)
									"omap <Leader>J <Plug>(easymotion-eol-j)
									"omap <Leader>K <Plug>(easymotion-eol-K)
									"omap <Leader>f <Plug>(easymotion-bd-f)
									"omap <Leader>s <Plug>(easymotion-bd-f2)
									"omap <Leader>t <Plug>(easymotion-bd-t)
									"omap <Leader>S <Plug>(easymotion-bd-t2)
									"omap <Leader>/ <Plug>(easymotion-sn)
									"omap <Leader>? <Plug>(easymotion-tn)
									"omap <Leader>n <Plug>(easymotion-bd-n)
									"omap <Leader>. <Plug>(easymotion-repeat)
									"omap <Leader>v <Plug>(easymotion-segments-LF)
									"omap <Leader>V <Plug>(easymotion-segments-LB)
									"omap <Leader>gv <Plug>(easymotion-segments-RF)
									"omap <Leader>gV <Plug>(easymotion-segments-RB)
									"omap <Leader>a <Plug>(easymotion-jumptoanywhere)
								"MODE:VISUAL
									xmap <Leader>w <Plug>(easymotion-bd-w)
									xmap <Leader>W <Plug>(easymotion-bd-W)
									xmap <Leader>e <Plug>(easymotion-bd-e)
									xmap <Leader>E <Plug>(easymotion-bd-E)
									xmap <Leader>l <Plug>(easymotion-bd-jk)
									xmap <Leader>j <Plug>(easymotion-j)
									xmap <Leader>k <Plug>(easymotion-k)
									xmap <Leader>J <Plug>(easymotion-eol-j)
									xmap <Leader>K <Plug>(easymotion-eol-K)
									xmap <Leader>f <Plug>(easymotion-bd-f)
									xmap <Leader>t <Plug>(easymotion-bd-t)
									xmap <Leader>s <Plug>(easymotion-bd-f2)
									xmap <Leader>S <Plug>(easymotion-bd-t2)
									xmap <Leader>/ <Plug>(easymotion-sn)
									xmap <Leader>? <Plug>(easymotion-tn)
									xmap <Leader>n <Plug>(easymotion-bd-n)
									xmap <Leader>. <Plug>(easymotion-repeat)
									xmap <Leader>v <Plug>(easymotion-segments-LF)
									xmap <Leader>V <Plug>(easymotion-segments-LB)
									xmap <Leader>gv <Plug>(easymotion-segments-RF)
									xmap <Leader>gV <Plug>(easymotion-segments-RB)
									xmap <Leader>a <Plug>(easymotion-jumptoanywhere)
							"LEVEL=2
							"LEVEL=3
						"EXTENSIONS
							Plug 'haya14busa/incsearch-easymotion.vim'
								map <Leader><Leader>/ <Plug>(incsearch-easymotion-/)
									"map <Leader><Leader>/ <Plug>(incsearch-easymotion-stay)
								map <Leader><Leader>? <Plug>(incsearch-easymotion-?)
							"incsearch-easymotion-fuzzy
								"FUNCTIONS
									function! s:config_easyfuzzymotion(...) abort
										return extend(copy({
											\	'converters': [incsearch#config#fuzzy#converter()],
											\	'modules': [incsearch#config#easymotion#module()],
											\	'keymap': {"\<CR>": '<Over>(easymotion)'},
											\	'is_expr': 0,
											\	'is_stay': 0
											\ }), get(a:, 1, {}))
									endfunction
								"MAPPINGS
									noremap <silent><expr> <Leader><Leader>g/ incsearch#go(<SID>config_easyfuzzymotion())
					if has('nvim') && IsNix()
						Plug 'lambdalisue/lista.nvim'
							nmap <Leader>b/ :Lista<CR>
							nmap <Leader>b? :ListaCursorWord<CR>
						"Plug 'osyo-manga/vim-hopping'
							"nmap <Leader>b/ :HoppingStart<CR>
					endif
					if v:version >= 740
						Plug 'andymass/vim-matchup'
					endif
				"RANDOM
					Plug 'machakann/vim-swap'
						let g:swap_no_default_key_mappings = 1
						nmap g<			<Plug>(swap-prev)
						nmap g>			<Plug>(swap-next)
						nmap <Leader>zs <Plug>(swap-interactive)

						onoremap id <Plug>(swap-textobject-i)
						onoremap ad <Plug>(swap-textobject-a)
					Plug 'AndrewRadev/splitjoin.vim'
					Plug 'jiangmiao/auto-pairs'
						let g:AutoPairsShortcutToggle = ''
						let g:AutoPairsShortcutJump = ''
						let g:AutoPairsFastWrap = ''
						let g:AutoPairsShortcutBackInsert = ''
					"Plug 'terryma/vim-expand-region'
						""CONFIGURATION
							""let g:expand_region_text_objects = {
								""\'iw'  :0,
								""\'iW'  :0,
								""\'i"'  :0,
								""\'i''' :0,
								""\'i]'  :1,
								""\'ib'  :1,
								""\'iB'  :1,
								""\'il'  :0,
								""\'ip'  :0,
								""\'ie'  :0,
							""\}
							""call expand_region#custom_text_objects({
								""\ "\/\\n\\n\<CR>": 1, " Motions are supported as well. Here's a search motion that finds a blank line
								""\ 'a]' :1, " Support nesting of 'around' brackets
								""\ 'ab' :1, " Support nesting of 'around' parentheses
								""\ 'aB' :1, " Support nesting of 'around' braces
								""\ 'ii' :0, " 'inside indent'. Available through https://github.com/kana/vim-textobj-indent
								""\ 'ai' :0, " 'around indent'. Available through https://github.com/kana/vim-textobj-indent
								""\ })
						""MAPPINGS
							""map <C-=> <Plug>(expand_region_expand)
							""map <C-+> <Plug>(expand_region_shrink)
					Plug 'terryma/vim-multiple-cursors'
						let g:multi_cursor_use_default_mapping = 0
						let g:multi_cursor_quit_key            = '<Esc>'
						let g:multi_cursor_start_word_key      = '<C-n>'
						let g:multi_cursor_start_key           = 'g<C-n>'
						let g:multi_cursor_next_key            = '<C-n>'
						let g:multi_cursor_prev_key            = '<C-p>'
						let g:multi_cursor_skip_key            = '<C-x>'
						let g:multi_cursor_select_all_word_key = '<A-a>'
						let g:multi_cursor_select_all_key      = 'g<A-a>'
					Plug 'dkarter/bullets.vim'
						let g:bullets_set_mappings = 0
						let g:bullets_enabled_file_types = [
							\ 'markdown',
							\ 'text',
							\ 'gitcommit',
							\ 'scratch',
						\]
						let g:bullets_delete_last_bullet_if_empty = 1
						let g:bullets_pad_right = 1
						let g:bullets_max_alpha_characters = 2
			"EDITOR
				"MODES
					if has('nvim-0.5')
						Plug 'Iron-E/nvim-libmodal', { 'branch': 'feature' }
					elseif has('nvim-0.4')
						Plug 'Iron-E/nvim-libmodal', { 'branch': 'master' }
					else
						Plug 'Iron-E/vim-libmodal'
					endif
				"BUFFER
					"SCROLLBAR"
						if has('nvim-0.5')
							Plug 'dstein64/nvim-scrollview'
						elseif has('nvim')
							Plug 'Xuyuanp/scrollbar.nvim'
								"CONFIGURATION
									augroup ScrollbarInit
										autocmd!
										autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
										autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
										autocmd WinLeave,FocusLost             * silent! lua require('scrollbar').clear()
									augroup end
						endif
					"SMOOTHSCROLL
						if has('nvim-0.3') || v:version >= 800
							Plug 'psliwka/vim-smoothie'
								let g:smoothie_enabled = v:true
								let g:smoothie_no_default_mappings = v:true

								nmap <silent> <C-f> <Plug>(SmoothieForwards)
								nmap <silent> <C-b> <Plug>(SmoothieBackwards)
								nmap <silent> <C-d> <Plug>(SmoothieDownwards)
								nmap <silent> <C-u> <Plug>(SmoothieUpwards)
								nmap <silent> G <Plug>(Smoothie_G)
								nmap <silent> gg <Plug>(Smoothie_gg)
						else
							"Plug 'joeytwiddle/sexy_scroller.vim'
								let g:SexyScoller_ScrollTime = 10
								let g:SexyScroller_CursorTime = 5
								let g:SexyScroller_MaxTime = 200
								let g:SexyScroller_EasingStyle = 1
						endif
					"INDENTLINE"
						if has('nvim-0.5')
							"remove lua branch when neovim-0.5 is released, since this will be
							"moved to the the main branch
							Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }
								let g:indent_blankline_enabled = v:true

								let g:indent_blankline_char = '│'
								let g:indent_blankline_char_list = []
								"let g:indent_blankline_char_highlight = 'SpecialKey'
								let g:indent_blankline_char_highlight = 'NonText'
								let g:indent_blankline_char_highlight_list = []

								let g:indent_blankline_show_first_indent_level = v:false
								let g:indent_blankline_indent_level = 10

								let g:indent_blankline_filetype = ['html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'python', 'lua']
								let g:indent_blankline_filetype_exclude = ['help', 'startify', 'floaterm']
								let g:indent_blankline_buftype_exclude = ['terminal']
								let g:indent_blankline_bufname_exclude = ['README.md', '.*\.py']

								let g:indent_blankline_use_treesitter = v:true
								let g:indent_blankline_show_current_context = v:true
								let g:indent_blankline_context_highlight = ['class', 'function', 'method']
								"let g:indent_blankline_context_highlight = 'ModeMsg'
								let g:indent_blankline_context_highlight = 'SpecialKey'
						elseif has('conceal')
							"Plug 'Yggdroot/indentLine'
								"let g:indentLine_enabled = 1
								"let g:indentLine_char = '│'
								"let g:indentLine_setColors = 1
								"let g:indentLine_defaultGroup = 'VertSplit'
								"let g:indentLine_concealcursor = 'inc'
								"let g:indentLine_conceallevel = 1
								"let g:indentLine_char_list = ['│', '|', '¦', '┆', '┊']
						endif
					"COLOR-HIGHLIGHTER
						if has('nvim-0.5')
							Plug 'norcalli/nvim-colorizer.lua'
						endif
					"BETTER-FOLDING
						if has('folding')
							Plug 'pseewald/vim-anyfold'
								"CONFIGURATION
									let g:anyfold_motion            = 0
									let g:anyfold_fold_comments     = 0
									let g:anyfold_identify_comments = 0
									let g:anyfold_fold_toplevel     = 0
									let g:anyfold_comments          = []
									let g:anyfold_fold_level_str    = ''
									let g:anyfold_fold_size_str     = '%s Lines   '
								"HIGHLIGHT
									"hi Folded ctermfg= ctermbg= guifg= guibg
								"AUTOCOMMANDS
									autocmd FileType text AnyFoldActivate
									autocmd FileType jproperties AnyFoldActivate
								"MAPPINGS
							Plug 'arecarn/vim-fold-cycle'
								let g:fold_cycle_default_mapping = 0
								nmap <TAB>	 <Plug>(fold-cycle-open)
								nmap <S-TAB> <Plug>(fold-cycle-close)
						endif
					"BETTER-SIGNS
						if has('signs')
							Plug 'kshenoy/vim-signature'
						endif
					Plug 'itchyny/vim-cursorword'
					if has('nvim-0.5')
						Plug 'nacro90/numb.nvim'
					endif
				"WINDOW
					"ANIMATION
						Plug 'camspiers/animate.vim'
							"CONFIGURATION
								"let g:fzf_layout = {'window': 'new | wincmd J | resize 1 | call animate#window_percent_height(0.5)'}
							"MAPPINGS
								nnoremap <silent> <up>    :call animate#window_delta_height(10)<CR>
								nnoremap <silent> <down>  :call animate#window_delta_height(-10)<CR>
								nnoremap <silent> <left>  :call animate#window_delta_width(10)<CR>
								nnoremap <silent> <right> :call animate#window_delta_width(-10)<CR>
						"Plug 'camspiers/lens.vim'
							let g:lens#animate = 1
					Plug 'szw/vim-maximizer'
						nnoremap <silent> <Leader>wm :MaximizerToggle<CR>
					Plug 'blueyed/vim-diminactive'
						let g:diminactive_use_syntax = 1
						let g:diminactive_use_colorcolumn = 0
						"highlight ColorColumn ctermbg=0 guibg=#081C23
				"MAPPINGS
					if has('nvim-.0.6')
						Plug 'folke/which-key.nvim'
					else
						Plug 'liuchengxu/vim-which-key'
							"CONFIGURATION
								let g:which_key_sep					 = '→'
								let g:which_key_hspace				 = 5
								let g:which_key_flatten				 = 1
								let g:which_key_max_size			 = 0
								let g:which_key_sort_horizontal		 = 0
								let g:which_key_vertical			 = 0
								let g:which_key_use_floating_win	 = 0
								let g:which_key_align_by_seperator = 1
								let g:which_key_display_names		 = {
									\' '	 : 'SPC',
									\'<C-H>' : 'BS'
								\}
								let g:which_key_map					 = {}

								"hiding statusline
								autocmd! FileType which_key
								autocmd  FileType which_key set laststatus=0 noshowmode noruler
									\| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

								let g:which_key_map['*']	 = "which_key_ignore"
								let g:which_key_map['"']	 = "which_key_ignore"
								let g:which_key_map['/']	 = "which_key_ignore"
								let g:which_key_map['?']	 = "which_key_ignore"
								let g:which_key_map['@']	 = "which_key_ignore"

								let g:which_key_map['1-9'] = "open-buffer"
									let g:which_key_map['1']	 = "which_key_ignore"
									let g:which_key_map['2']	 = "which_key_ignore"
									let g:which_key_map['3']	 = "which_key_ignore"
									let g:which_key_map['4']	 = "which_key_ignore"
									let g:which_key_map['5']	 = "which_key_ignore"
									let g:which_key_map['6']	 = "which_key_ignore"
									let g:which_key_map['7']	 = "which_key_ignore"
									let g:which_key_map['8']	 = "which_key_ignore"
									let g:which_key_map['9']	 = "which_key_ignore"
								let g:which_key_map['`']	 = "open-last-buffer"

								let g:which_key_map['<Tab>'] = "show-mappings"
								let g:which_key_map[' '] = {'name':'+miscellanous'}

								let g:which_key_map['a'] = {
									\'name' : 'applications(tui)',
									\'e' : 'explorer',
									\'m' : 'markdown',
									\'M' : 'markdown-current-file',
									\'g' : 'git',
									\'t' : 'typing',
									\'y' : 'youtube',
									\'Y' : 'youtube-music',
								\}
								let g:which_key_map['b'] = {
									\'name' : '+buffers',
									\'a': {
										\'name': '+add',
										\'n': 'new-buffer',
										\'s': 'scratch-buffer',
										\'S': 'scratch-buffer-filetype',
									\},
									\'c': {
										\'name': '+close',
										\'c': 'close-current',
										\'C': 'CLOSE-current',
										\'a': 'close-all',
										\'A': 'CLOSE-all',
										\'o': 'close-others',
										\'h': 'close-left-ones',
										\'l': 'close-right-ones',
									\},
									\'d': {
										\'name': '+close',
										\'c': 'delete-current',
										\'C': 'DELETE-current',
										\'a': 'delete-all',
										\'A': 'DELETE-all',
										\'o': '--delete-others',
										\'h': '--delete-left-ones',
										\'l': '--delete-right-ones',
									\},
									\'w' : {
										\'name': '+write',
										\'c': 'write-current-buffer',
										\'C': 'WRITE-current-buffer',
										\'a': 'write-all-buffers',
										\'A': 'WRITE-all-buffers',
									\},
									\'l'	: 'list-buffers',
									\'g'	: 'goto-buffer',
									\'t'	: 'open-buffer-tree',
									\'f'	: 'change-buffer-filetype',
									\'/'	: 'search-current-buffer',
									\'?'	: 'search-all-buffers',
								\}
								let g:which_key_map['c'] = {
									\'name' : 'which_key_ignore',
								\}
								let g:which_key_map['d'] = {
									\'name' : 'which_key_ignore',
								\}
								let g:which_key_map['e'] = {
									\'name' : 'which_key_ignore',
								\}
								let g:which_key_map['f'] = {
									\'name' : '+fuzzy',
									\'f' : {
										\'name': '+files',
										\'/': 'search-/',
										\'h': 'search-home',
										\'d': 'search-drive',
										\'p': 'search-current-directory',
										\'c': 'search-curent-buffer-directory',
									\},
									\'d' : {
										\'name': '+directories',
										\'/': 'search-/',
										\'h': 'search-home',
										\'d': 'search-drive',
										\'p': 'search-current-directory',
										\'c': 'search-curent-buffer-directory',
									\},
								\}
								let g:which_key_map['g'] = {
									\'name' : '+git',
									\'i' : 'git-init',
									\'B' : 'git-blame-toggle',
									\'a' : {
										\'name': '+staging-area',
										\'s': 'git-status',
										\'d': '--git-diff',
										\'a': '--git-add',
										\'r': '--reset-working-area',
									\},
									\'b' : {
										\'name': '+branch',
										\'l': '--list-branches',
										\'n': '--new-branch',
										\'N': '--new-branch+checkout',
										\'c': '--git-checkout',
										\'C': '--git-checkout-last-branch',
										\'m': '--git-merge',
										\'M': '--git-merge-no-ff',
										\'r': '--git-rebase',
										\'R': '--git-rebase-interactive',
									\},
									\'c' : {
										\'name': '+commits',
										\'l': 'git-log',
										\'L': 'git-log-buffer',
										\'m': '--git-commit',
										\'a': '--git-commit-amend',
										\'u': '--undo-commit',
										\'d': '--delete-commit',
										\'h': 'show-line-commit-history',
									\},
									\'h' : {
										\'name': '+hunks',
										\'s': 'stage-hunk',
										\'u': 'undo-stage-hunk',
										\'p': 'preview-hunk',
										\'r': 'reset-hunk',
										\'R': 'reset-buffer',
									\},
									\'r' : {
										\'name': '+remote',
										\'p': '--git-pull',
										\'P': '--git-push',
										\'l': '--git-remote-show',
										\'a': '--git-remote-add',
										\'d': '--git-remote-remove',
										\'r': '--git-remote-rename',
									\},
									\'s' : {
										\'name': '+stash',
										\'s': '--git-stash',
										\'l': '--git-stash-list',
										\'a': '--git-stash-apply',
										\'p': '--git-stash-pop',
										\'d': '--git-stash-drop',
										\'c': '--git-stash-clear',
									\},
								\}
								let g:which_key_map['h'] = {
									\'name' : 'which_key_ignore',
								\}
								let g:which_key_map['i'] = {
									\'name' : 'which_key_ignore',
								\}
								let g:which_key_map['j'] = {
									\'name' : '+jump',
								\}
								let g:which_key_map['k'] = {
									\'name' : 'which_key_ignore',
								\}
								let g:which_key_map['l'] = {
									\'name' : '+lsp',
									\'a': {
										\'name': '+actions',
										\'a': 'show-code-actions',
										\'d': 'generate-documentation',
										\'f': 'format-buffer',
										\'o': '--organize-imports',
										\'q': '--quickfix',
									\},
									\'g': {
										\'name': '+goto',
										\'d': 'goto-definition',
										\'D': 'goto-declaration',
										\'t': 'goto-type-definition',
										\'i': 'goto-implementation',
										\'r': 'goto-references',
										\'p': 'preview-definition',
									\},
									\'s': {
										\'name': '+symbols',
										\'d': 'show-document-symbols',
										\'w': 'show-workspace-symbols',
										\'r': 'rename-symbol',
										\'R': 'rename-symbol-treesitter',
										\'t': 'tagbar',
									\},
									\'d': {
										\'name': '+diagnostics',
										\'w': 'show-workspace-diagnostics',
										\'d': 'show-document-diagnostics',
										\'l': 'show-line-diagnostics',
										\'n': 'goto-next-diagnostic',
										\'p': 'goto-prev-diagnostic',
									\},
									\'h': {
										\'name': '+help',
										\'h': 'hover-documentation',
										\'s': 'signature-help',
									\},
								\}
								let g:which_key_map['m'] = {
									\'name' : 'which_key_ignore',
								\}
								let g:which_key_map['n'] = {
									\'name' : 'which_key_ignore',
								\}
								let g:which_key_map['o'] = {
									\'name' : '+browse',
									\'g'	: 'search-github',
									\'d'	: 'search-duckduckgo',
									\'w'	: 'search-wikipedia',
								\}
								let g:which_key_map['p'] = {
									\'name' : '+projects',
									\'o'    : 'open-project',
									\'f'    : 'open-project-file',
									\'r'    : 'open-project-mru',
									\'R'    : 'open-project-mrw',
									\'/'    : 'search-project',
									\'e'    : 'open-project-directory',
									\'E'    : 'open-file-directory',
									\'g'    : 'open-modified-git-file',
									\'G'    : 'open-git-file',
								\}
								let g:which_key_map['q'] = {
									\'name' : 'which_key_ignore',
								\}
								let g:which_key_map['r'] = {
									\'name' : 'which_key_ignore',
								\}
								let g:which_key_map['S'] = {
									\'name' : '+sessions',
									\'l'	: 'list-sessions',
									\'n'	: 'new-session',
									\'d'	: 'delete-session',
									\'s'	: '-save-session',
									\'o'	: 'open-session',
									\'c'	: 'close-session',
								\}
								let g:which_key_map['s'] = {
									\'name' : '+scratch-window',
									\'p'	: 'preview-scratch',
									\'o'	: 'open-scratch',
									\'s'	: 'send-selection',
								\}
								let g:which_key_map['t'] = {
									\'name' : '+terminals',
									\'l'	: '--list-terminals',
									\'b'	: 'new-buffer-terminal',
									\'f'	: 'new-flaating-terminal',
									\'v'	: 'new-vertical-terminal',
									\'h'	: 'new-horizontal-terminal',
									\'t'	: 'toggle-terminal',
									\'k'	: 'kill-terminal',
									\'n'	: 'next-terminal',
									\'p'	: 'previous-terminal',
									\'B'	: 'new-buffer-terminal-lcd',
									\'F'	: '--new-floating-terminal-lcd',
									\'V'	: 'new-vertical-terminal-lcd',
									\'H'	: 'new-horizontal-terminal-lcd',
								\}
								let g:which_key_map['T'] = {
									\'name' : '+tabs',
									\'l'	: 'list-tabs',
									\'a'	: 'add-tab',
									\'d'	: 'delete-tab',
									\'n'	: 'next-tab',
									\'p'	: 'previous-tab',
									\'N'	: 'move-tab-right',
									\'P'	: 'move-tab-left',
								\}
								let g:which_key_map['u'] = {
									\'name' : 'which_key_ignore',
								\}
								let g:which_key_map['v'] = {
									\'name' : '+vim',
									\'c' : 'open-config',
									\'s' : 'source-config',
									\'C' : 'select-colorscheme',
									\'/' : 'search-history',
									\':' : 'command-history',
									\'q' : 'quit-vim',
									\'h' : {
										\'name' : '+help',
										\'c'	: 'commands',
										\'h'	: 'help',
										\'m'	: 'maps',
									\},
									\'p' : {
										\'name' : '+plugin-manager',
										\'l'	: 'list-plugins',
										\'i'	: 'install-plugins',
										\'d'	: 'uninstall-plugins',
										\'u'	: 'update-plugins',
										\'U'	: '--update-plugin',
										\'p'	: 'update-plugin-manager',
									\},
									\'t' : {
										\'name' : '+toggles',
										\'w'	: 'autosave-toggle',
										\'c'	: 'autocorrect-toggle',
										\'f'	: 'autoformat-toggle',
										\'p'	: 'pencil-toggle',
										\'d'	: 'distraction-mode',
										\'l'	: 'limelight',
									\},
								\}
								let g:which_key_map['w'] = {
									\'name' : '+windows',
									\'h'	: 'horizontal-split',
									\'v'	: 'vertical-split',
									\'c'	: 'close-split',
									\'o'	: 'only-split',
									\'m'	: 'maximize-split',
									\'H'	: 'empty-horizontal-split',
									\'V'	: 'empty-vertical-split',
								\}
								let g:which_key_map['x'] = {
									\'name' : 'which_key_ignore',
								\}
								let g:which_key_map['y'] = {
									\'name' : 'which_key_ignore',
								\}
								let g:which_key_map['z'] = {
									\'name' : '+miscelleanous',
								\}

								let g:which_key_map[','] = {
									\'name' : '+localleader',
									\'c': {
										\'name': '+code',
										\'b': 'compile',
										\'e': 'execute',
										\'q': 'compile-and-execute',
										\'m': 'make',
										\'r': 'open-repl',
										\'R': 'open-repl-fzf',
										\'s': 'open-scratch-output',
										\'S': 'open-scratch-input-output',
										\'i': 'interactive',
									\}
								\}
							"MAPPINGS
								nnoremap <silent> <Leader>		:<C-U>WhichKey		 '<SPACE>' <CR>
								vnoremap <silent> <Leader>		:<C-U>WhichKeyVisual '<SPACE>' <CR>
								nnoremap <silent> <LocalLeader> :<C-U>WhichKey		 ','		 <CR>
					endif
				"MINIMAP
					if has('nvim-0.5') || v:version >= 820
						Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}
							let g:minimap_left = v:false
							let g:minimap_width = 15
							let g:minimap_auto_start = v:true
							let g:minimap_auto_start_win_enter = v:true
							let g:minimap_block_filetypes = ['fugitive', 'help', 'startify', 'floaterm']
							let g:minimap_block_buftypes = ['terminal']
							let g:indent_blankline_bufname_exclude = ['README.md', '.*\.py']
					endif
				"UNDOTREE
					Plug 'mbbill/undotree'
						"CONFIGURATIONS
							let g:undotree_WindowLayout = 2
							let g:undotree_ShortIndicators = 1
							let g:undotree_SplitWidth = 30
							let g:undotree_DiffpanelHeight = 10
							let g:undotree_SetFocusWhenToggle = 1
							let g:undotree_TreeNodeShape = '◉'
							" let g:undotree_DiffCommand = "Delta"
							let g:undotree_HighlightChangedText = 1
							let g:undotree_HighlightChangedWithSign = 1
							let g:undotree_HighlightSyntaxAdd = "DiffAdd"
							let g:undotree_HighlightSyntaxChange = "DiffChange"
							let g:undotree_HighlightSyntaxDel = "DiffDelete"
							let g:undotree_HelpLine = 0
							let g:undotree_CursorLine = 1
						"MAPPINGS
							nnoremap <Leader>vu :UndotreeToggle<CR>
				"SESSIONS
					Plug 'abdalrahman-ali/vim-remembers'
						let g:remembers_ignore_empty_buffers = 1
						let g:remembers_tmp_dir     = g:jaat_tmp_path . 'remembers/unnamed'
						let g:remembers_session_dir = g:jaat_tmp_path . 'remembers/sessions'
				"SEARCH
					if has('nvim-0.5')
						Plug 'windwp/nvim-spectre'
					endif
				"BETTER-QUICKFIX
					if has('nvim')
						Plug 'kevinhwang91/nvim-bqf'
					endif
				Plug 'mtth/scratch.vim'
					let g:scratch_no_mappings      = 1
					let g:scratch_height           = 0.3
					let g:scratch_top              = 0
					let g:scratch_persistence_file = g:jaat_tmp_path . 'scratch'

					nnoremap <silent> <Leader>so :Scratch<CR>
					nnoremap <silent> <Leader>sp :ScratchPreview<CR>
					vnoremap <silent> <Leader>ss :ScratchSelection<CR>

					augroup SCRATCH_ENTER
						autocmd!
						autocmd FileType scratch nnoremap <buffer> <esc> :q<CR>
						autocmd FileType scratch set syntax=jproperties
					augroup END
				Plug 'tpope/vim-repeat'
				Plug 'tpope/vim-capslock'
					nmap <silent> <LocalLeader><LocalLeader> <Plug>CapsLockToggle
					imap ;; <Plug>CapsLockToggle
				Plug 'liuchengxu/vim-which-key'
					"CONFIGURATION
						let g:which_key_sep = '→'
						let g:which_key_hspace = 5
						let g:which_key_flatten = 1
						let g:which_key_max_size = 0
						let g:which_key_sort_horizontal = 0
						let g:which_key_vertical = 0
						let g:which_key_use_floating_win = 0
						let g:which_key_align_by_seperator = 1
						let g:which_key_display_names	   = {
							\' '	 : 'SPC',
							\'<C-H>' : 'BS'
						\}

						"hiding statusline
						autocmd! FileType which_key
						autocmd  FileType which_key set laststatus=0 noshowmode noruler
							\| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

						let g:which_key_map = {}

						let g:which_key_map['*']   = "which_key_ignore"
						let g:which_key_map['"']   = "which_key_ignore"
						let g:which_key_map['/']   = "which_key_ignore"
						let g:which_key_map['?']   = "which_key_ignore"
						let g:which_key_map['@']   = "which_key_ignore"

						let g:which_key_map['1-9'] = "open-buffer"
							let g:which_key_map['1']   = "which_key_ignore"
							let g:which_key_map['2']   = "which_key_ignore"
							let g:which_key_map['3']   = "which_key_ignore"
							let g:which_key_map['4']   = "which_key_ignore"
							let g:which_key_map['5']   = "which_key_ignore"
							let g:which_key_map['6']   = "which_key_ignore"
							let g:which_key_map['7']   = "which_key_ignore"
							let g:which_key_map['8']   = "which_key_ignore"
							let g:which_key_map['9']   = "which_key_ignore"
						let g:which_key_map['`']   = "open-last-buffer"

						let g:which_key_map['<Tab>'] = "show-mappings"
						let g:which_key_map[' '] = {'name':'+miscellanous'}

						let g:which_key_map['a'] = {
							\'name' : 'applications(tui)',
							\'e' : 'explorer',
							\'m' : 'markdown',
							\'M' : 'markdown-current-file',
							\'g' : 'git',
							\'t' : 'typing-practise',
							\'y' : 'youtube',
							\'Y' : 'youtube-music',
						\}
						let g:which_key_map['b'] = {
							\'name' : '+buffers',
							\'a': {
								\'name': '+new',
								\'n': 'new-buffer',
								\'s': 'new-scratch-buffer',
								\'S': 'new-scratch-buffer-filetype',
							\},
							\'c': {
								\'name': '+close',
								\'c': 'close-current',
								\'C': 'CLOSE-current',
								\'a': 'close-all',
								\'A': 'CLOSE-all',
								\'o': 'close-others',
								\'h': 'close-left-ones',
								\'l': 'close-right-ones',
							\},
							\'d': {
								\'name': '+delete',
								\'c': 'delete-current',
								\'C': 'DELETE-current',
								\'a': 'delete-all',
								\'A': 'DELETE-all',
								\'o': '--delete-others',
								\'h': '--delete-left-ones',
								\'l': '--delete-right-ones',
							\},
							\'w' : {
								\'name': '+write',
								\'c': 'write-current-buffer',
								\'C': 'WRITE-current-buffer',
								\'a': 'write-all-buffers',
								\'A': 'WRITE-all-buffers',
							\},
							\'l': 'list-buffers',
							\'g': 'goto-buffer',
							\'t': 'open-buffer-tree',
							\'f': 'change-buffer-filetype',
							\'/': 'search-current-buffer',
							\'?': 'search-all-buffers',
						\}
						let g:which_key_map['c'] = {
							\'name' : 'which_key_ignore',
						\}
						let g:which_key_map['d'] = {
							\'name' : 'which_key_ignore',
						\}
						let g:which_key_map['e'] = {
							\'name' : 'which_key_ignore',
						\}
						let g:which_key_map['f'] = {
							\'name' : '+fuzzy',
							\'f' : {
								\'name': '+files',
								\'/': 'search-/',
								\'h': 'search-home',
								\'d': 'search-drive',
								\'p': 'search-current-directory',
								\'c': 'search-curent-buffer-directory',
							\},
							\'d' : {
								\'name': '+directories',
								\'/': 'search-/',
								\'h': 'search-home',
								\'d': 'search-drive',
								\'p': 'search-current-directory',
								\'c': 'search-curent-buffer-directory',
							\},
							\'r': 'open-recent-file'
						\}
						let g:which_key_map['g'] = {
							\'name' : '+git',
							\'i' : 'git-init',
							\'a' : {
								\'name': '+staging-area',
								\'s': 'git-status',
								\'d': '--git-diff',
								\'a': '--git-add',
								\'r': '--reset-working-area',
							\},
							\'b' : {
								\'name': '+branch',
								\'l': '--list-branches',
								\'n': '--new-branch',
								\'N': '--new-branch->checkout',
								\'c': '--git-checkout',
								\'C': '--git-checkout-last-branch',
								\'m': '--git-merge',
								\'M': '--git-merge-no-ff',
								\'r': '--git-rebase',
								\'R': '--git-rebase-interactive',
							\},
							\'c' : {
								\'name': '+commits',
								\'l': 'git-log',
								\'L': 'git-log-buffer',
								\'m': '--git-commit',
								\'a': '--git-commit-amend',
								\'u': '--undo-commit',
								\'d': '--delete-commit',
								\'h' : 'show-line-commit-history',
								\'b' : 'git-blame',
							\},
							\'h' : {
								\'name': '+hunks',
								\'s': 'stage-hunk',
								\'u': 'undo-stage-hunk',
								\'p': 'preview-hunk',
								\'r': 'reset-hunk',
								\'R': 'reset-buffer',
							\},
							\'r' : {
								\'name': '+remote',
								\'p': '--git-pull',
								\'P': '--git-push',
								\'l': '--git-remote-show',
								\'a': '--git-remote-add',
								\'d': '--git-remote-remove',
								\'r': '--git-remote-rename',
							\},
							\'s' : {
								\'name': '+stash',
								\'s': '--git-stash',
								\'l': '--git-stash-list',
								\'a': '--git-stash-apply',
								\'p': '--git-stash-pop',
								\'d': '--git-stash-drop',
								\'c': '--git-stash-clear',
							\},
						\}
						let g:which_key_map['h'] = {
							\'name' : 'which_key_ignore',
						\}
						let g:which_key_map['i'] = {
							\'name' : 'which_key_ignore',
						\}
						let g:which_key_map['j'] = {
							\'name' : '+jump',
						\}
						let g:which_key_map['k'] = {
							\'name' : 'which_key_ignore',
						\}
						let g:which_key_map['l'] = {
							\'name' : '+lsp',
							\'a': {
								\'name': '+actions',
								\'a': 'show-code-actions',
								\'f': 'format-buffer',
								\'o': '--organize-imports',
								\'q': '--quickfix',
							\},
							\'g': {
								\'name': '+goto',
								\'d': 'goto-definition',
								\'D': 'goto-declaration',
								\'t': 'goto-type-definition',
								\'i': 'goto-implementation',
								\'r': 'goto-references',
								\'p': 'preview-definition',
							\},
							\'s': {
								\'name': '+symbols',
								\'d': 'show-document-symbols',
								\'w': 'show-workspace-symbols',
								\'r': 'rename-symbol',
								\'R': 'rename-symbol-treesitter',
								\'t': 'tagbar',
							\},
							\'d': {
								\'name': '+diagnostics',
								\'w': 'show-workspace-diagnostics',
								\'d': 'show-document-diagnostics',
								\'l': 'show-line-diagnostics',
								\'n': 'goto-next-diagnostic',
								\'p': 'goto-prev-diagnostic',
							\},
							\'h': {
								\'name': '+help',
								\'h': 'hover-documentation',
								\'s': 'signature-help',
							\},
						\}
						let g:which_key_map['m'] = {
							\'name' : 'which_key_ignore',
						\}
						let g:which_key_map['n'] = {
							\'name' : 'which_key_ignore',
						\}
						let g:which_key_map['o'] = {
							\'name' : '+browse',
							\'g'	: 'search-github',
							\'d'	: 'search-duckduckgo',
							\'w'	: 'search-wikipedia',
						\}
						let g:which_key_map['p'] = {
							\'name' : '+projects',
							\'o'    : 'open-project',
							\'f'    : 'open-project-file',
							\'r'    : 'open-project-mru',
							\'/'    : 'search-project',
							\'e'    : 'open-file-directory',
							\'E'    : 'open-project-directory',
							\'g'    : 'open-modified-file',
						\}
						let g:which_key_map['q'] = {
							\'name' : 'which_key_ignore',
						\}
						let g:which_key_map['r'] = {
							\'name' : 'which_key_ignore',
						\}
						let g:which_key_map['S'] = {
							\'name' : '+sessions',
							\'l'	: 'list-sessions',
							\'n'	: 'new-session',
							\'d'	: 'delete-session',
							\'s'	: '--save-session',
							\'o'	: 'open-session',
							\'c'	: 'close-session',
						\}
						let g:which_key_map['s'] = {
							\'name' : '+scratch-window',
							\'p'	: 'preview-scratch',
							\'o'	: 'open-scratch',
							\'s'	: 'send-selection',
						\}
						let g:which_key_map['t'] = {
							\'name' : '+terminal',
							\'l'	: '--list-terminals',
							\'b'	: 'new-buffer-terminal',
							\'f'	: 'new-flaating-terminal',
							\'v'	: 'new-vertical-terminal',
							\'h'	: 'new-horizontal-terminal',
							\'t'	: 'toggle-terminal',
							\'k'	: 'kill-terminal',
							\'n'	: 'next-terminal',
							\'p'	: 'previous-terminal',
							\'B'	: '--new-buffer-terminal-lcd',
							\'F'	: '--new-floating-terminal-lcd',
							\'V'	: '--new-vertical-terminal-lcd',
							\'H'	: '--new-horizontal-terminal-lcd',
						\}
						let g:which_key_map['T'] = {
							\'name' : '+tabs',
							\'l'	: 'list-tabs',
							\'a'	: 'add-tab',
							\'d'	: 'delete-tab',
							\'n'	: 'next-tab',
							\'p'	: 'previous-tab',
							\'N'	: 'move-tab-right',
							\'P'	: 'move-tab-left',
						\}
						let g:which_key_map['u'] = {
							\'name' : 'which_key_ignore',
						\}
						let g:which_key_map['v'] = {
							\'name' : '+vim',
							\'c' : 'open-config',
							\'s' : 'source-config',
							\'C' : 'select-colorscheme',
							\'/' : 'search-history',
							\':' : 'command-history',
							\'q' : 'quit-vim',
							\'h' : {
								\'name' : '+help',
								\'c'	: 'commands',
								\'h'	: 'help',
								\'m'	: 'maps',
							\},
							\'p' : {
								\'name' : '+plugin-manager',
								\'l'	: 'list-plugins',
								\'i'	: 'install-plugins',
								\'d'	: 'uninstall-plugins',
								\'u'	: 'update-plugins',
								\'U'	: '--update-plugin',
								\'p'	: 'update-plugin-manager',
							\},
							\'t' : {
								\'name' : '+toggles',
								\'w'	: 'autosave-toggle',
								\'c'	: 'autocorrect-toggle',
								\'f'	: 'autoformat-toggle',
								\'p'	: 'pencil-toggle',
								\'d'	: 'distraction-mode',
								\'l'	: 'limelight',
							\},
						\}
						let g:which_key_map['w'] = {
							\'name' : '+windows',
							\'h'	: 'horizontal-split',
							\'v'	: 'vertical-split',
							\'c'	: 'close-split',
							\'o'	: 'only-split',
							\'m'	: 'maximize-split',
							\'H'	: 'empty-horizontal-split',
							\'V'	: 'empty-vertical-split',
							\'='	: 'make-windows-equal',
						\}
						let g:which_key_map['x'] = {
							\'name' : 'which_key_ignore',
						\}
						let g:which_key_map['y'] = {
							\'name' : 'which_key_ignore',
						\}
						let g:which_key_map['z'] = {
							\'name' : '+miscelleanous',
						\}
					"MAPPINGS
						nnoremap <silent> <Leader>      :<C-U>WhichKey       '<SPACE>' <CR>
						vnoremap <silent> <Leader>      :<C-U>WhichKeyVisual '<SPACE>' <CR>
						nnoremap <silent> <LocalLeader> :<C-U>WhichKey       ','       <CR>
				Plug 'el-iot/buffer-tree-explorer'
					let g:buffer_tree_explorer_compress = v:true
					nnoremap <Leader>bt :Tree<CR>
				Plug 'junegunn/vim-peekaboo'
					let g:peekaboo_window  = 'vert bo 80new'
					let g:peekaboo_compact = 0
			"SYSTEM
				Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': { -> fzf#install() }}
					"CONFIGURATION
						let g:fzf_action = {
							\'ALT-t': 'tab split',
							\'ALT-h': 'split',
							\'ALT-v': 'vsplit',
							\'ALT-m': 'Glow',
							\'ALT-c': 'cd',
							\'ALT-e': 'Vifm',
							\'ALT-o': 'Open',
						\}
							"'SaveAs'
							"'SaveAs!'
							"'NewFile'
							"'NewDirectory'
							"'DeleteFile'
							"'DeleteDirectory'
							"'DeleteDirectory!'
						"let g:fzf_layout = {}
						"let g:fzf_colors = {
							"\'fg':		 ['fg', 'Normal'],
							"\'bg':		 ['bg', 'Normal'],
							"\'hl':		 ['fg', 'Comment'],
							"\'fg+':	 ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
							"\'bg+':	 ['bg', 'CursorLine', 'CursorColumn'],
							"\'hl+':	 ['fg', 'Statement'],
							"\'info':	 ['fg', 'PreProc'],
							"\'border':  ['fg', 'Ignore'],
							"\'prompt':  ['fg', 'Conditional'],
							"\'pointer': ['fg', 'Exception'],
							"\'marker':  ['fg', 'Keyword'],
							"\'spinner': ['fg', 'Label'],
							"\'header':  ['fg', 'Comment'],
						"\}
						"let g:fzf_history_dir = {}
						"let g:fzf_launcher = {}
					"AUTOCOMMANDS
						autocmd! FileType fzf
						autocmd  FileType fzf set laststatus=0 | autocmd BufLeave <buffer> set laststatus=2
					"FUNCTIONS
						function! FZFFiles(path, ...)
							call fzf#run(fzf#wrap({
								\'source': g:jaat_find_files_command . ' ' . a:path,
							\}))
						endfunction

						function! FZFDirectories(path, ...)
							call fzf#run(fzf#wrap({
								\'source': g:jaat_find_directories_command . ' ' . a:path,
							\}))
						endfunction
					"MAPPINGS
						"nnoremap <silent> <Leader>ffr :call FZFFindFiles()<CR>
						nnoremap <silent> <Leader>ff/ :call FZFFiles(g:jaat_root_path)<CR>
						nnoremap <silent> <Leader>ffh :call FZFFiles(g:jaat_home_path)<CR>
						nnoremap <silent> <Leader>ffd :call FZFFiles(g:jaat_drive_path)<CR>
						nnoremap <silent> <Leader>ffp :call FZFFiles('')<CR>
						nnoremap <silent> <Leader>ffc :call FZFFiles(expand('%:h'))<CR>

						"nnoremap <silent> <Leader>fdr :call FZFFindDirectories()<CR>
						nnoremap <silent> <Leader>fd/ :call FZFDirectories(g:jaat_root_path)<CR>
						nnoremap <silent> <Leader>fdh :call FZFDirectories(g:jaat_home_path)<CR>
						nnoremap <silent> <Leader>fdd :call FZFDirectories(g:jaat_drive_path)<CR>
						nnoremap <silent> <Leader>fdp :call FZFDirectories('')<CR>
						nnoremap <silent> <Leader>fdc :call FZFDirectories(expand('%:h'))<CR>
					"EXTENSIONS
						Plug 'junegunn/fzf.vim'
							"MAPPINGS
								nmap <silent> <Leader><TAB> <plug>(fzf-maps-n)
								xmap <silent> <Leader><TAB> <plug>(fzf-maps-x)
								omap <silent> <Leader><TAB> <plug>(fzf-maps-o)
								imap <silent> ;<TAB> <plug>(fzf-maps-i)
							"INBUILT
								nnoremap <silent> <Leader>bl :Buffers<CR>
								"nnoremap <silent> <Leader>b/ :BLines<CR>
								nnoremap <silent> <Leader>b? :Lines<CR>

								nnoremap <silent> <Leader>bf :Filetypes<CR>

								nnoremap <silent> <Leader>vhc :Commands<CR>
								nnoremap <silent> <Leader>vhh :Helptags<CR>
								nnoremap <silent> <Leader>vhm :Maps<CR>

								nnoremap <silent> <Leader>v/ :History/<CR>
								nnoremap <silent> <Leader>v: :History:<CR>

								nnoremap <silent> <Leader>vC :Colors<CR>

								"nnoremap <silent> <Leader>nt :Tags<CR>
								"nnoremap <silent> <Leader>nT :BTags<CR>
							"COMPLETION
								imap		;w <plug>(fzf-complete-word)
								imap		;p <plug>(fzf-complete-path)
								imap		;f <plug>(fzf-complete-file-ag)
								imap		;l <plug>(fzf-complete-line)
								imap		;L <plug>(fzf-complete-buffer-line)
								imap <expr> ;cp fzf#complete('find ~/Google\ Drive')
								imap <expr> ;cf fzf#complete('find ~/Google\ Drive -type f')
								imap <expr> ;cd fzf#complete('find ~/Google\ Drive -type d')
							"GIT
								nnoremap <Leader>gcl :Commits<CR>
								nnoremap <Leader>gcL :BCommits<CR>
								nnoremap <Leader>pg  :GFiles?<CR>
								nnoremap <Leader>pG  :GFiles<CR>
							"SEARCH
								nnoremap <silent> <Leader>p/ :Rg<CR>

								nnoremap <A-/> :Rg<SPACE>
						Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release/rpc' }
							"MAPPINGS
								"PROJECT
									nnoremap <silent> <Leader>pr :FzfPreviewProjectMruFilesRpc<CR>
									nnoremap <silent> <Leader>pR :FzfPreviewProjectMrwFilesRpc<CR>

								nnoremap <silent> <A-r> :FzfPreviewProjectMruFilesRpc<CR>
						Plug 'dominickng/fzf-session.vim'
							"CONFIGURATION
								let g:fzf_session_path = g:jaat_tmp_path . 'sessions'
							"MAPPINGS
								nnoremap <silent> <Leader>Sl :Sessions<CR>
								nnoremap <silent> <Leader>Sn :Session<space>
								nnoremap <silent> <Leader>Sd :SDelete<space>
								nnoremap <silent> <Leader>So :SLoad<space>
								nnoremap <silent> <Leader>Sc :SQuit<CR>
						Plug 'pbogut/fzf-mru.vim'
							nnoremap <silent> <Leader>fr :<C-u>FZFMru<CR>
				Plug 'voldikss/vim-floaterm'
					"CONFIGURATION
						"let g:floaterm_autoinsert = 1
						"let g:floaterm_autohide = 1
						let g:floaterm_autoclose = 1
						let g:floaterm_width = 0.9
						let g:floaterm_height = 0.9
					"MAPPINGS
						nnoremap <silent> <Leader>tt :FloatermToggle<CR>

						nnoremap <silent> <Leader>tf :FloatermNew --wintype=float<CR>
						nnoremap <silent> <Leader>th :FloatermNew --wintype=split --height=0.4<CR>
						nnoremap <silent> <Leader>tv :FloatermNew --wintype=vsplit --width=0.5<CR>

						nnoremap <silent> <Leader>tk :FloatermKill<CR>
						nnoremap <silent> <Leader>tn :FloatermNext<CR>
						nnoremap <silent> <Leader>tp :FloatermPrev<CR>

						execute 'nnoremap <silent> <' . g:action_leader . '-`> :FloatermToggle<CR>'

						execute 'tnoremap <silent> <' . g:action_leader . '-`> <C-\><C-n>:FloatermToggle<CR>'
						execute 'tnoremap <silent> <' . g:action_leader . '-f> <C-\><C-n>:FloatermNew<CR>'
						execute 'tnoremap <silent> <' . g:action_leader . '-h> <C-\><C-n>:FloatermNew --wintype=split --height=0.4<CR>'
						execute 'tnoremap <silent> <' . g:action_leader . '-v> <C-\><C-n>:FloatermNew --wintype=vsplit --width=0.5<CR>'
						execute 'tnoremap <silent> <' . g:action_leader . '-k> <C-\><C-n>:FloatermKill<CR>'
						execute 'tnoremap <silent> <' . g:action_leader . '-p> <C-\><C-n>:FloatermNext<CR>'
						execute 'tnoremap <silent> <' . g:action_leader . '-n> <C-\><C-n>:FloatermPrev<CR>'
				if has('nvim-0.5')
					Plug 'kyazdani42/nvim-tree.lua'
				endif
			"AESTHETICS
				"STATUSLINE
					if has('nvim-0.5')
						Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
					elseif IsNix()
						Plug 'vim-airline/vim-airline'
							"CONFIGURATION
								let g:airline_powerline_fonts = 1
								function! AirlineInit()
									let g:airline_section_c = airline#section#create(['%{expand("%:.")}'])
								endfunction
								autocmd User AirlineAfterInit call AirlineInit()
							"BUFFERLINE
							"TABLINE
								let g:airline#extensions#tabline#enabled = 1
								let g:airline#extensions#tabline#fnamemod = ':t'
							"TMUXLINE
								let airline#extensions#tmuxline#color_template = 'normal'
							"CUSTOMIZATION
								let g:airline#extensions#default#layout = [
									\ [ 'a', 'b', 'c'],
									\ [ 'x', 'y', 'z', 'error', 'warning']
								\]
								let g:airline#extensions#default#section_truncate_width = {
									\ 'b': 79,
									\ 'x': 60,
									\ 'y': 88,
									\ 'z': 45,
									\ 'warning': 80,
									\ 'error': 80,
									\ }
								let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
							"EXTENSIONS
									let g:airline#extensions#fugitive#enabled= 1
									let g:airline#extensions#fzf#enabled= 1
									let g:airline#extensions#hunks#enabled = 1
									let g:airline#extensions#nvimlsp#enabled = 1
									let g:airline#extensions#vista#enabled = 1
										let g:airline#extensions#nvimlsp#error_symbol = '  '
										let g:airline#extensions#nvimlsp#warning_symbol = '  '
									let g:airline#extensions#whitespace#enabled = 1
										let g:airline#extensions#whitespace#mixed_indent_algo = 0
										let g:airline#extensions#whitespace#symbol = ''
										let g:airline#extensions#whitespace#checks = ['indent', 'trailing', 'mixed-indent-file, long']
										let g:airline#extensions#whitespace#trailing_format = 'T[%s]'
										let g:airline#extensions#whitespace#mixed_indent_format = 'MI[%s]'
										let g:airline#extensions#whitespace#long_format = 'L[%s]'
										let g:airline#extensions#whitespace#mixed_indent_file_format = 'MIF[%s]'
										let g:airline#extensions#whitespace#trailing_regexp = '\s$'
						Plug 'vim-airline/vim-airline-themes'
						Plug 'augustold/vim-airline-colornum'
					elseif IsWindows()
						Plug 'itchyny/lightline.vim'
							"CONFIGURATION
								let g:lightline = {
									\'enable': {
										\'statusline': 1,
										\'tabline': 1,
									\},
									\'active': {
										\'left': [
											\['mode', 'paste'],
											\['gitbranch', 'readonly', 'filename', 'modified', 'directory', 'vim-capslock'],
										\],
										\'right': [
											\['lineinfo'],
											\['percent'],
											\['fileformat', 'fileencoding', 'filetype'],
										\],
									\},
								\}
								let g:lightline.colorscheme = 'neodark'
									"powerline
									"powerlineish
									"wombat
									"solarized
									"jellybeans
									"molokai
									"seoul256
									"dracula
									"selenized_dark|black|light|white
									"Tomorrow[_Night][_Blue|Bright|Eigthies]
									"PaperColor
									"landscape
									"one
									"materia
									"material
									"OldHope
									"nord
									"deus
									"simpleblack
									"srcery_drk
									"ayu_mirage|light|dark
									"16color
								let g:lightline.mode_map = {
									\'n'	  : 'NORMAL',
									\'i'	  : 'INSERT',
									\'R'	  : 'REPLACE',
									\'v'	  : 'VISUAL',
									\'V'	  : 'V-LINE',
									\"\<C-v>" : 'V-BLOCK',
									\'t'	  : 'TERMINAL',
									\'c'	  : 'COMMAND',
									\'s'	  : 'SELECT',
									\'S'	  : 'S-LINE',
									\"\<C-s>" : 'S-BLOCK',
								\}
								let g:lightline.component = {}
								let g:lightline.component_function = {
									\'directory'    : 'GetCurrentDirectoryName',
									\'vim-capslock' : 'CapsLock',
									\'gitbranch'    : 'FugitiveHead'
								\}
							"FUNCTIONS
								function! CapsLock()
									return exists('*CapsLockStatusline') ? CapsLockStatusline('CAPS') : ''
								endfunction
						Plug 'mengelbrecht/lightline-bufferline'
							"CONFIGURATION
								set showtabline=2
								let g:lightline#bufferline#filename_modifier = ':t'
								let g:lightline#bufferline#show_number		 = 2
								let g:lightline#bufferline#shorten_path		 = 0
								let g:lightline#bufferline#unnamed			 = '[No Name]'
								let g:lightline#bufferline#unicode_symbols	 = 0
								let g:lightline#bufferline#enable_devicons	 = 0
								let g:lightline#bufferline#number_separator = ':'
								let g:lightline#bufferline#read_only		= '[ℝ]'
								let g:lightline#bufferline#more_buffers		= '…'
								let g:lightline#bufferline#modified			= '[+]'

								let g:lightline.tabline			 = {'left': [['buffers']], 'right': [['close']]}
								let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
								let g:lightline.component_type	 = {'buffers': 'tabsel'}
							"MAPPINGS
								nmap <Leader>1 <Plug>lightline#bufferline#go(1)
								nmap <Leader>2 <Plug>lightline#bufferline#go(2)
								nmap <Leader>3 <Plug>lightline#bufferline#go(3)
								nmap <Leader>4 <Plug>lightline#bufferline#go(4)
								nmap <Leader>5 <Plug>lightline#bufferline#go(5)
								nmap <Leader>6 <Plug>lightline#bufferline#go(6)
								nmap <Leader>7 <Plug>lightline#bufferline#go(7)
								nmap <Leader>8 <Plug>lightline#bufferline#go(8)
								nmap <Leader>9 <Plug>lightline#bufferline#go(9)
					endif
				"BUFFERLINE
					"Plug 'bling/vim-bufferline'
						let g:bufferline_echo                = 1
						let g:bufferline_active_buffer_left  = '['
						let g:bufferline_active_buffer_right = ']'
						let g:bufferline_modified            = '+'
						let g:bufferline_rotate              = 0
						let g:bufferline_show_bufnr          = 0
						let g:bufferline_fname_mod           = ':t'
						let g:bufferline_active_highlight    = 'StatusLineNC'
						let g:bufferline_inactive_highlight  = 'StatusLineNC'
						let g:bufferline_solo_highlight      = 0
						let g:bufferline_pathshorten         = 0
				"TABLINE
					if has('nvim-0.5')
						if v:true
							Plug 'akinsho/nvim-bufferline.lua'
								nnoremap <silent> <A-n> :BufferLineCycleNext<CR>
								nnoremap <silent> <A-p> :BufferLineCyclePrev<CR>
								nnoremap <silent> <A-b> :BufferLinePick<CR>

								nnoremap <silent> <A-=> :BufferLineMoveNext<CR>
								nnoremap <silent> <A--> :BufferLineMovePrev<CR>
						else
							Plug 'romgrk/barbar.nvim'
								"CONFIGURATION
									let bufferline = {}
									let bufferline.icon_close_tab_modified = '●'
									let bufferline.no_name_title = v:null
								"MAPPINGS
									nnoremap <silent> <Leader>` :BufferLast<CR>
									nnoremap <silent> <Leader>1 :BufferGoto 1<CR>
									nnoremap <silent> <Leader>2 :BufferGoto 2<CR>
									nnoremap <silent> <Leader>3 :BufferGoto 3<CR>
									nnoremap <silent> <Leader>4 :BufferGoto 4<CR>
									nnoremap <silent> <Leader>5 :BufferGoto 5<CR>
									nnoremap <silent> <Leader>6 :BufferGoto 6<CR>
									nnoremap <silent> <Leader>7 :BufferGoto 7<CR>
									nnoremap <silent> <Leader>8 :BufferGoto 8<CR>
									nnoremap <silent> <Leader>9 :BufferGoto 9<CR>
									nnoremap <silent> <Leader>bg :BufferPick<CR>

									nnoremap <silent> <Leader>bcc :BufferClose<CR>
									nnoremap <silent> <Leader>bcC :BufferClose!<CR>
									nnoremap <silent> <Leader>bcA :bufdo BufferClose<CR>
									nnoremap <silent> <Leader>bcA :bufdo BufferClose!<CR>
									nnoremap <silent> <Leader>bco :BufferCloseAllButCurrent<CR>
									nnoremap <silent> <Leader>bch :BufferCloseBuffersLeft<CR>
									nnoremap <silent> <Leader>bcl :BufferCloseBuffersRight<CR>

									"nnoremap <silent> <Leader>bd :BufferClose<CR>
									"nnoremap <silent> <Leader>bD :BufferDelete<CR>
									nnoremap <silent> <A-d> :BufferClose<CR>

									nnoremap <silent> <A-n> :BufferPrevious<CR>
									nnoremap <silent> <A-p> :BufferNext<CR>

									nnoremap <silent> <A--> :BufferMovePrevious<CR>
									nnoremap <silent> <A-=> :BufferMoveNext<CR>
						endif
					endif
				"EXTERNAL
					Plug 'edkolev/tmuxline.vim'
						"'#(whoami)'
						let g:tmuxline_powerline_separators = 1
						"let g:tmuxline_separators = {
							"\'left'      : '',
							"\'left_alt'  : '>',
							"\'right'     : '',
							"\'right_alt' : '<',
							"\'space'     : ' '
						"\}
						let g:tmuxline_preset = {
							\'a':    '#S',
							\'b':    '#W',
							\'c':    '',
							\'win':  '#W',
							\'cwin': '#W',
							\'x':    ['%R', '%A'],
							\'y':    '',
							\'z':    '#(whoami)'
						\}
						"let g:tmuxline_theme = 'powerline'
						"let g:tmuxline_theme = {
							"\'a':    [ 236, 103 ],
							"\'b':    [ 253, 239 ],
							"\'c':    [ 244, 236 ],
							"\'x':    [ 244, 236 ],
							"\'y':    [ 253, 239 ],
							"\'z':    [ 236, 103 ],
							"\'win':  [ 103, 236 ],
							"\'cwin': [ 236, 103 ],
							"\'bg':   [ 244, 236 ],
						"\}
					Plug 'edkolev/promptline.vim'
						"'$(whoami)'
						let g:promptline_powerline_symbols = 1
						let g:promptline_preset = {
							\'a':    [ promptline#slices#cwd() ],
							\'b':    [ promptline#slices#vcs_branch() ],
							\'c':    [ promptline#slices#git_status() ],
							\'z':    [ promptline#slices#jobs() ],
							\'warn': [ promptline#slices#last_exit_code() ]
						\}
						"let g:promptline_symbols = {
							"\'left'       : '',
							"\'left_alt'   : '>',
							"\'dir_sep'    : ' / ',
							"\'truncation' : '...',
							"\'vcs_branch' : '',
							"\'space'      : ' '
						"\}
				"COLORSCHEMES
					"Plug 'flazz/vim-colorschemes'
					Plug 'rafi/awesome-vim-colorschemes'
					"Plug 'chriskempson/base16-vim'
					"Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
					"Plug 'pineapplegiant/spaceduck'
					"Plug 'tomasiser/vim-code-dark'
					"Plug 'KeitaNakamura/neodark.vim'
						let g:neodark#use_256color			 = 1
						let g:neodark#solid_vertsplit		 = 1
						let g:neodark#background			 = '#202020'
						"let g:lightline					= {}
						"let g:lightline.colorscheme		= 'neodark'
						"let g:neodark#terminal_transparent = 1
					"Plug 'sindresorhus/focus'
					"Plug 'KabbAmine/yowish.vim'
					"Plug 'ayu-theme/ayu-vim'
					"Plug 'tyrannicaltoucan/vim-quantum'
					"Plug 'raphamorim/lucario'
					"Plug 'paranoida/vim-airlineish'
					"Plug 'arzg/vim-corvine'
					"Plug 'i3d/vim-jimbothemes'
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
					"REFERENCE
						"TYPE:LIGHT
							"*SOLARIZED8-LIGHT*|CORVINE-LIGHT=1
							"XCODE=1
						"TYPE:DARK:HIGH
							"SPACE-DUCK=1
							"VIM-MATERIAL=1
							"BASE16-MATERIAL-VIVID|DARKER=1
							"CHALLENGER-DEEP=1?:TUI
						"TYPE:DARK:MEDIUM
							"VIM-CODE-DARK=1 (VSCODE) (colorscheme + airline)
							"MONOKAI|MOLOKAI|MONOKAIN|BEEKAI=1
						"TYPE:DARK:LOW
							"GRUVBOX=1+:TUI
							"ONEDARK=1:TUI
							"SOLARIZED8-*
							"MATERIAL|MATERIAL-BOX|MATERIAL-THEME
						"TYPE:DULL
							"CORVINE=2:TUI
							"NEODARK
						"RANDOM
							"*MATERIAL*
				"ICONS
					Plug 'kyazdani42/nvim-web-devicons'
					Plug 'ryanoasis/vim-devicons'
				"RANDOM
					Plug 'itchyny/vim-highlighturl'
						"let g:highlighturl_ctermfg   = ''
						"let g:highlighturl_guifg	  = ''
						"let g:highlighturl_underline = 0
				"DISABLED
					"Plug 'haya14busa/vim-keeppad'
					"Plug 'zefei/vim-colortuner'
			"PROGRAMMING
				"SYNTAX
					"RAINBOW
						Plug 'luochen1990/rainbow'
							let g:rainbow_active = 1
						if has('nvim-0.5')
							Plug 'p00f/nvim-ts-rainbow'
						endif
					"TAGS
					Plug 'sheerun/vim-polyglot'
					Plug 'jparise/vim-graphql'
					Plug 'chrisbra/csv.vim'
					if has('nvim-0.5')
						Plug 'folke/lsp-colors.nvim'
							"TODO
					endif
					if has('nvim-0.5')
						Plug 'folke/todo-comments.nvim'
					endif
					Plug 'plasticboy/vim-markdown'
						let g:vim_markdown_no_default_key_mappings = 1
					"Plug 'vim-syntastic/syntastic'
					"Plug 'coachshea/jade-vim'
				"VCS:GIT
					Plug 'tpope/vim-fugitive'
						"TODO
						nnoremap <Leader>gas :Gstatus<CR>
					Plug 'rhysd/git-messenger.vim'
						"CONFIGURATION
							let g:git_messenger_include_diff        = "none"
							let g:git_messenger_max_popup_width     = 200
							let g:git_messenger_max_popup_height    = 40
							let g:git_messenger_no_default_mappings = v:true
						"HIGHLIGHTS
						"MAPPINGS
							nmap <silent> <Leader>gch <Plug>(git-messenger)
					Plug 'rhysd/conflict-marker.vim'
					if has('nvim')
						Plug 'ttys3/nvim-blamer.lua'
					endif
					if has('nvim-0.5')
						Plug 'lewis6991/gitsigns.nvim'
							Plug 'nvim-lua/plenary.nvim'
					else
						Plug 'airblade/vim-gitgutter'
					endif
				"LSP
					if has('nvim-0.5')
						source ~/.config/nvim/lsp.lua
						Plug 'neovim/nvim-lspconfig'
						Plug 'alexaandru/nvim-lspupdate'
						Plug 'folke/trouble.nvim'
						Plug 'RishabhRD/nvim-lsputils'
							Plug 'RishabhRD/popfix'
						Plug 'glepnir/lspsaga.nvim'
						Plug 'kosayoda/nvim-lightbulb'
						Plug 'hrsh7th/nvim-compe'
							Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }
						Plug 'onsails/lspkind-nvim'
						Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
					elseif has('node') && (v:version >= 800 || has('nvim-0.4'))
						Plug 'neoclide/coc.nvim', {'branch': 'release'}
							"CONFIGURATION
							"PLUGINS
								Plug 'Shougo/neco-vim'
								Plug 'neoclide/coc-neco'
							"EXTENSIONS
								"META
									let g:coc_global_extensions = [
										\ 'coc-marketplace',
										\ 'coc-explorer',
										\ 'coc-floatinput',
										\ 'coc-yank',
									\]
								"LSP
									let g:coc_global_extensions += [
										\ 'coc-vimlsp',
										\ 'coc-lua',
										\ 'coc-clangd',
										\ 'coc-html',
										\ 'coc-svg',
										\ 'coc-css',
										\ 'coc-cssmodules',
										\ 'coc-tsserver',
										\ 'coc-rome',
										\ 'coc-pyright',
										\ 'coc-java',
										\ 'coc-omnisharp',
										\ 'coc-sh',
										\ 'coc-sql',
										\ 'coc-graphql',
										\ 'coc-metals',
										\ 'coc-fsharp',
										\ 'coc-go',
										\ 'coc-r-lsp',
										\ 'coc-xml',
										\ 'coc-json',
										\ 'coc-yaml',
										\ 'coc-toml',
										\ 'coc-styled-components',
										\ 'coc-docker',
									\]
								"TOOLING
									let g:coc_global_extensions += [
										\ 'coc-git',
										\ 'coc-gitignore',
										\ 'coc-github',
										\ 'coc-gist',
										\ 'coc-flow',
										\ 'coc-eslint',
										\ 'coc-tslint-plugin',
										\ 'coc-stylelint',
										\ 'coc-stylelintplus',
										\ 'coc-diagnostic',
										\ 'coc-style-helper',
										\ 'coc-jest',
										\ 'coc-inline-jest',
										\ 'coc-markdownlint',
										\ 'coc-prettier',
										\ 'coc-react-refactor',
										\ 'coc-format-json',
										\ 'coc-import-cost',
										\ 'coc-docthis',
										\ 'coc-snippets',
										\ 'coc-zi',
										\ 'coc-pairs',
										\ 'coc-emmet',
										\ 'coc-tabnine',
										\ 'coc-syntax',
										\ 'coc-highlight',
										\ 'coc-restclient',
										\ 'coc-db',
									\]
								"RANDOM
									let g:coc_global_extensions += [
										\ 'coc-lists',
										\ 'coc-markmap',
										\ 'coc-template',
										\ 'coc-leetcode',
										\ 'coc-browser',
										\ 'coc-spell-checker',
										\ 'coc-emoji',
										\ 'coc-emoji-shortcodes',
										\ 'coc-calc',
									\]
							"FUNCTIONS
								function! s:checkBackspace() abort
									let col = col('.') - 1
									return !col || getline('.')[col - 1]	=~# '\s'
								endfunction

								function! s:showDocumentation()
									if (index(['vim','help'], &filetype) >= 0)
										execute 'h '.expand('<cword>')
									else
										call CocAction('doHover')
									endif
								endfunction
							"COMMANDS
								command! -nargs=0 COCFormat          :call CocAction('format')
								command! -nargs=? COCFold            :call CocAction('fold', <f-args>)
								command! -nargs=0 COCOrganizeImports :call CocAction('runCommand', 'editor.action.organizeImport')
							"AUTOCOMMANDS
								augroup COC
									autocmd!
									autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
									autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
								augroup end

								autocmd CursorHold * silent call CocActionAsync('highlight')
							"MAPPINGS
								"COC-GOTO
									nmap <silent> <Leader>lgd <Plug>(coc-definition)
									nmap <silent> <Leader>lgD <Plug>(coc-type-definition)
									nmap <silent> <Leader>lgi <Plug>(coc-implementation)
									nmap <silent> <Leader>lgr <Plug>(coc-references)
								"COC-COMPLETION
									inoremap <silent> <expr> <C-SPACE> coc#refresh()
									inoremap <silent> <expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
									inoremap <silent> <expr> <TAB>
										\ pumvisible() ? "\<C-n>" :
										\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
										\ <SID>checkBackspace() ? "\<TAB>" :
										\ coc#refresh()
									inoremap <silent> <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
								"COC-SNIPPETS
									"imap <C-l>     <Plug>(coc-snippets-expand)
									"imap <C-j>     <Plug>(coc-snippets-select)
									"imap <C-j>     <Plug>(coc-snippets-expand-jump)
									"xmap <leader>x <Plug>(coc-convert-snippet)
								"COC-DIAGNOSTICS
									nmap <silent> [e <Plug>(coc-diagnostic-prev)
									nmap <silent> ]e <Plug>(coc-diagnostic-next)
								"COC-ACTIONS
									nmap <leader>lac <Plug>(coc-codeaction)
									nmap <leader>laq <Plug>(coc-fix-current)
									xmap <leader>laf <Plug>(coc-format-selected)
									nmap <leader>laf <Plug>(coc-format-selected)
									nmap <leader>laF :COCFormat<CR>
									nmap <leader>lao :COCOrganizeImports<CR>

									nmap <C-A-a>  <Plug>(coc-codeaction-selected)
									xmap <C-A-a>  <Plug>(coc-codeaction-selected)
								"COC-DOCUMENTATION
									nnoremap <silent> K :call s:showDocumentation()<CR>
								"COC-OBJECTS
									"NOTE: Requires 'textDocument.documentSymbol' support from the language server.
									xmap <LocalLeader>if <Plug>(coc-funcobj-i)
									omap <LocalLeader>if <Plug>(coc-funcobj-i)
									xmap <LocalLeader>af <Plug>(coc-funcobj-a)
									omap <LocalLeader>af <Plug>(coc-funcobj-a)
									xmap <LocalLeader>ic <Plug>(coc-classobj-i)
									omap <LocalLeader>ic <Plug>(coc-classobj-i)
									xmap <LocalLeader>ac <Plug>(coc-classobj-a)
									omap <LocalLeader>ac <Plug>(coc-classobj-a)
								"COC-LIST
									nnoremap <silent><nowait> <Leader>lL  :<C-u>CocList<CR>
									nnoremap <silent><nowait> <Leader>ll  :<C-u>CocListResume<CR>
									nnoremap <silent><nowait> <Leader>le  :<C-u>CocList diagnostics<CR>
									nnoremap <silent><nowait> <Leader>lc  :<C-u>CocList commands<CR>
									nnoremap <silent><nowait> <Leader>lso  :<C-u>CocList outline<CR>
									nnoremap <silent><nowait> <Leader>lsl  :<C-u>CocList -I symbols<CR>

									nnoremap <silent><nowait> <Leader>ln  :<C-u>CocNext<CR>
									nnoremap <silent><nowait> <Leader>lp  :<C-u>CocPrev<CR>
								"RANDOM
									nmap          <Leader>lsr <Plug>(coc-rename)
									nmap <silent> <C-s>      <Plug>(coc-range-select)
									xmap <silent> <C-s>      <Plug>(coc-range-select)
					endif
					Plug 'liuchengxu/vista.vim'
						"CONFIGURATION
							let g:vista_default_executive =
								\ has('nvim-0.5')
								\ ? 'nvim_lsp'
								\ : 'coc'
							let g:vista#renderer#enable_icon = 1
							let g:vista_sidebar_width = 45
							let g:vista_fzf_preview = ['right:50%']
							let g:vista_echo_cursor_strategy = 'echo'
						"MAPPINGS
							nnoremap <silent> <Leader>lst :Vista!!<CR>
							nnoremap <silent> <Leader>lsD :Vista finder fzf<CR>
						"STATUSLINE
							function! NearestMethodOrFunction() abort
								return get(b:, 'vista_nearest_method_or_function', '')
							endfunction

							"set statusline+=%{NearestMethodOrFunction()}
							"autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
				"TREESITTER
					if has('nvim-0.5')
						Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
						Plug 'nvim-treesitter/playground'
						Plug 'nvim-treesitter/nvim-treesitter-textobjects'
						Plug 'nvim-treesitter/nvim-treesitter-refactor'
						Plug 'p00f/nvim-ts-rainbow'
						Plug 'windwp/nvim-ts-autotag'
						Plug 'JoosepAlviste/nvim-ts-context-commentstring'
					endif
				"COMMENTS
					"Plug 'tpope/vim-commentary'
					Plug 'scrooloose/nerdcommenter'
						"CONFIGURATION
							let g:NERDCreateDefaultMappings  = 0
							let g:NERDSpaceDelims            = 1
							let g:NERDCompactSexyComs        = 1
							let g:NERDDefaultAlign           = 'left'
							let g:NERDAltDelims_java         = 1
							let g:NERDCustomDelimiters       = { 'c': { 'left': '/**','right': '*/' } }
							let g:NERDCommentEmptyLines      = 0
							let g:NERDTrimTrailingWhitespace = 1
							let g:NERDToggleCheckAllLines    = 1
						"MAPPINGS
							nmap gkt <plug>NERDCommenterToggle
							xmap gkt <plug>NERDCommenterToggle

							nmap gkc <plug>NERDCommenterComment
							xmap gkc <plug>NERDCommenterComment

							nmap gku <plug>NERDCommenterUncomment
							xmap gku <plug>NERDCommenterUncomment

							xmap gkn <plug>NERDCommenterNested
							xmap gki <plug>NERDCommenterInvert
							xmap gky <plug>NERDCommenterYank

							"xmap gkm <plug>NERDCommenterAltDelims
							xmap gkm <plug>NERDCommenterMinimal
							xmap gks <plug>NERDCommenterSexy

							nmap gk9 <plug>NERDCommenterToEOL
							nmap gka <plug>NERDCommenterAppend

							nmap <silent> <A-c> <plug>NERDCommenterToggle
							xmap <silent> <A-c> <plug>NERDCommenterToggle
				"DATABASE
					Plug 'tpope/vim-dadbod'
					Plug 'kristijanhusak/vim-dadbod-ui'
				"SNIPPETS
					Plug 'honza/vim-snippets'
					Plug 'epilande/vim-react-snippets'
				"COMPLETION
					Plug 'mattn/emmet-vim'
						let g:user_emmet_install_global = 0
						let g:user_emmet_leader_key='<A-e>'
						autocmd! FileType html,css,javascript,javascriptreact,typescript,typescriptreact EmmetInstall
				"DEBUGGING
				"TAGS
					"Plug 'ludovicchabant/vim-gutentags'
				"DOCUMENTATION
					if has('nvim-0.5')
						Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
							let g:doge_enable_mappings = 0
							let g:doge_mapping = '<Leader>lad'
						"Plug 'nvim-treesitter/nvim-tree-docs'
					endif
				"PLAYGROUND
					Plug 'metakirby5/codi.vim'
						let g:codi#width	  = 80
						let g:codi#rightalign = 0
						nmap <LocalLeader>ci :Codi!!<CR>
					Plug 'arkwright/vim-whiteboard'
						"CONFIGURATION
							let g:whiteboard_temp_directory = g:jaat_tmp_path . 'whiteboard/'
							let g:whiteboard_interpreters = {
								\'python'     :{'extension': 'py'     ,'command': 'python3'  },
								\'r'          :{'extension': 'r'      ,'command': 'r'        },
								\'javascript' :{'extension': 'js'     ,'command': 'node'     },
								\'java'       :{'extension': 'java'   ,'command': 'jshell'   },
								\'lua'        :{'extension': 'lua'    ,'command': 'lua'      },
								\'php'        :{'extension': 'php'    ,'command': 'php'      },
								\'ruby'       :{'extension': 'rb'     ,'command': 'ruby'     },
								\'haskell'    :{'extension': 'hs'     ,'command': 'ghci'     },
								\'scala'      :{'extension': 'scala'  ,'command': 'scala'    },
								\'perl'       :{'extension': 'pl'     ,'command': 'perl'     },
								\'go'         :{'extension': 'go'     ,'command': 'gore'     },
								\'typescript' :{'extension': 'ts'     ,'command': 'ts-node'  },
								\'sh'         :{'extension': 'sh'     ,'command': 'bash'     },
								\'bash'       :{'extension': 'bash'   ,'command': 'bash'     },
								\'zsh'        :{'extension': 'zsh'    ,'command': 'zsh'      },
								\'fish'       :{'extension': 'fsh'    ,'command': 'fsh'      },
								\'pandoc'     :{'extension': 'pandoc' ,'command': 'pandoc'   },
								\'redis'      :{'extension': 'redis'  ,'command': 'redis-cli'},
								\'mongo'      :{'extension': 'mongo'  ,'command': 'mongo'    },
								\'mysql'      :{'extension': 'mysql'  ,'command': 'mysql'    },
								\'sqlite'     :{'extension': 'sqlite' ,'command': 'sqlite'   },
								\'dosbatch'   :{'extension': 'cmd'    ,'command': 'cmd'      },
								\'git'        :{'extension': 'git'    ,'command': 'gitsome'  },
								\'lisp'       :{'extension': 'lisp'   ,'command': 'sbcl'     }}
						"MAPPINGS
							nnoremap <LocalLeader>cs :execute "Whiteboard! " . &filetype<CR>
							nnoremap <LocalLeader>cS :execute "Whiteboard "  . &filetype<CR>
				"RANDOM
					"Plug 'tpope/vim-abolish'
					"MARKDOWN-PREVIEW"
						if has('nvim') || (has('vim') && v:version >= 800)
							Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
								let g:mkdp_auto_start = 0
								let g:mkdp_auto_close = 1
								let g:mkdp_refresh_slow = 0
								let g:mkdp_command_for_global = 0
								let g:mkdp_open_to_the_world = 0
								let g:mkdp_open_ip = ''
								let g:mkdp_browser = ''
								let g:mkdp_echo_preview_url = 0
								let g:mkdp_browserfunc = ''
								let g:mkdp_preview_options = {
									\ 'mkit': {},
									\ 'katex': {},
									\ 'uml': {},
									\ 'maid': {},
									\ 'disable_sync_scroll': 0,
									\ 'sync_scroll_type': 'middle',
									\ 'hide_yaml_meta': 1,
									\ 'sequence_diagrams': {},
									\ 'flowchart_diagrams': {},
									\ 'content_editable': v:false,
									\ 'disable_filename': 0
								\}
								let g:mkdp_markdown_css = ''
								let g:mkdp_highlight_css = ''
								let g:mkdp_port = ''
								let g:mkdp_page_title = '?${name}?'
								let g:mkdp_filetypes = ['markdown']
						else
							"install instant-markdown-d usig NPM
							Plug 'suan/vim-instant-markdown'
						endif
			"CLIENTS
				if has('nvim')
					Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
				endif
			"WRITTING
				Plug 'reedes/vim-pencil'
					nnoremap <silent> <Leader>vtp :PencilToggle<CR>
				Plug 'panozzaj/vim-autocorrect'
					nnoremap <silent> <Leader>vtc :call AutoCorrect()<CR>
				Plug 'davidbeckingsale/writegood.vim'
				Plug 'dbmrq/vim-ditto'
				Plug 'reedes/vim-lexical'
					nnoremap <silent> <Leader><Leader>s :set spell!<CR>
					let g:lexical#spell = 1
					let g:lexical#spell_key = '<leader>zs'
					let g:lexical#spelllang = ['en_us', 'en_ca',]
					"let g:lexical#dictionary = ['/usr/share/dict/words',]
					let g:lexical#thesaurus = ['~/.config/nvim/spell/mthesaurus.txt/',]
					let g:lexical#spellfile = ['~/.config/spell/en.utf-8.add',]
			"RANDOM
				Plug 'mhinz/vim-startify'
					"CONFIGURATION
						let g:startify_session_sort        = 1
						let g:startify_change_to_vcs_root  = 1
						let g:startify_fortune_use_unicode = 1
						let g:startify_session_dir         = g:jaat_tmp_path . 'sessions'
					"AUTOCOMMANDS
						autocmd User StartifyReady setl foldlevel=99
				if has('nvim-0.2.2') || v:version >= 800
					"Plug 'dstein64/vim-startuptime'
				endif
				Plug 'tyru/open-browser.vim'
					"CONFIGURATION
						"if something' not working run :VimProcInstall"
						let g:netrw_nogx = 1
						let g:openbrowser_search_engines = {
							\'askubuntu'   : 'http://askubuntu.com/search?q={query}',
							\'duckduckgo'  : 'http://duckduckgo.com/?q={query}',
							\'github'	   : 'http://github.com/search?q={query}',
							\'google'	   : 'http://google.com/search?q={query}',
							\'vim'		   : 'http://www.google.com/cse?cx=partner-pub-3005259998294962%3Abvyni59kjr1&ie=ISO-8859-1&q={query}&sa=Search&siteurl=www.vim.org%2F#gsc.tab=0&gsc.q={query}&gsc.page=1',
							\'flipkart'    : 'https://www.flipkart.com/search?q={query}&otracker=start&as-show=off&as=off',
							\'wikipedia'   : 'http://en.wikipedia.org/wiki/{query}',
							\'wikivoyage'  : 'https://en.wikivoyage.org/wiki/{query}',
							\'wiktionary'  : 'https://en.wiktionary.org/wiki/{query}',
							\'wikinews'    : 'https://en.wikinews.org/wiki/{query}',
							\'wikisource'  : 'https://en.wikisource.org/wiki/{query}',
							\'wikibooks'   : 'https://en.wikibooks.org/wiki/{query}',
							\'wikidata'    : 'https://en.wikidata.org/wiki/{query}',
							\'wikispecies' : 'https://species.wikimedia.org/wiki/{query}',
							\'wikiquote'   : 'https://en.wikiquote.org/wiki/{query}',
						\ }
					"FUNCTIONS
						function! OpenUnderCursor()
							let l:word = GetWORDUnderCursor()

							if l:word !~  '^http'
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
									let lines[0]  = lines[0][columnStart - 1:]
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
				Plug 'kana/vim-textobj-user'
				Plug 'kana/vim-operator-user'
				"Plug 'mattn/webapi-vim'
				"Plug 'lucerion/vim-buffr'
				"Plug 'kana/vim-submode'
					let g:submode_always_show_submode = 1
					"let g:submode_keep_leaving_key = 1
					"let g:submode_timeout = 0
					let g:submode_timeoutlen = 1000
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
				"Plug 'kana/vim-arpeggio'
				"Plug 'vim-scripts/tinymode.vim'
				"Plug 'tyru/stickykey.vim'
				"Plug 'luzhlon/popup.vim'
				"Plug 'skywind3000/quickmenu.vim'
			"DEPENDENCIES
				Plug 'Shougo/vimproc.vim'
			"MESS:EXTENDING-VIM
				Plug 'svermeulen/vim-yoink'
					let g:yoinkMaxItems				   = 10
					let g:yoinkSyncNumberedRegisters   = 1
					let g:yoinkIncludeDeleteOperations = 1
					let g:yoinkAutoFormatPaste		   = 0
					let g:yoinkIncludeNamedRegisters   = 0

					"nmap y <plug>(YoinkYankPreserveCursorPosition)
					"xmap y <plug>(YoinkYankPreserveCursorPosition)
					"nmap <expr> p yoink#canSwap() ? '<plug>(YoinkPostPasteSwapBack)' : '<plug>(YoinkPaste_p)'
					"nmap <expr> P yoink#canSwap() ? '<plug>(YoinkPostPasteSwapForward)' : '<plug>(YoinkPaste_P)'
				"Plug 'vim-scripts/repmo.vim'
					let repmo_key = ";"
					let repmo_revkey = ","
				if has('macunix')
					Plug 'gastonsimone/vim-dokumentary'
				endif
				"Plug 'tpope/vim-speeddating'
			"MESS
				Plug 'vim-scripts/DrawIt'
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
				Plug 'sbdchd/vim-shebang'
				Plug 'vim-utils/vim-read'
				Plug 'antoyo/vim-licenses'
				Plug 'vim-scripts/WholeLineColor'
					let g:wholelinecolor_leader = ','
					highlight WLCBlackBackground  ctermbg=233 guibg=#121212
					highlight WLCRedBackground	  ctermbg=52  guibg=#882323
					highlight WLCBlueBackground   ctermbg=17  guibg=#003366
					highlight WLCPurpleBackground ctermbg=53  guibg=#732c7b
					highlight WLCGreyBackground   ctermbg=238 guibg=#464646
					highlight WLCGreenBackground  ctermbg=22  guibg=#005500
				Plug 'junegunn/goyo.vim'
					let g:goyo_width = "75%"
					"let g:goyo_height = "90%"
					let g:goyo_linenr = 1

					nnoremap <Leader>vtd  :Goyo<CR>
				Plug 'junegunn/limelight.vim'
					nnoremap <Leader>vtl  :Limelight!!<CR>
				"Plug 'natw/keyboard_cat.vim'
				if !IsWindows()
					"Plug 'MrPeterLee/VimWordpress'
						nnoremap <LocalLeader>wl :call RunInNewBuffer('BlogList', 'wordpress')<CR>
						nnoremap <LocalLeader>wn :call RunInNewBuffer('BlogNew',  'wordpress')<CR>
						nnoremap <LocalLeader>wd :BlogSave draft<CR>
						nnoremap <LocalLeader>wP :BlogSave publish<CR>
						nnoremap <LocalLeader>wD :BlogPreview draft<CR>
						nnoremap <LocalLeader>wp :BlogPreview publish<CR>
						nnoremap <LocalLeader>wc :BlogCode python<CR>
						nnoremap <LocalLeader>wu :BlogUpload<space><CR>
				endif
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
				"Plug 'gorodinskiy/vim-coloresque'
				"Plug 'tweekmonster/nvim-api-viewer'
				"Plug 'kyuhi/vim-emoji-complete'
			"TOTEST
				if has('nvim')
					"TODO:NOT-WORKING
					"Plug 'ripxorip/aerojump.nvim', { 'do': ':UpdateRemotePlugins' }
						"nmap <Leader>as <Plug>(AerojumpSpace)
						"nmap <Leader>ab <Plug>(AerojumpBolt)
						"nmap <Leader>aa <Plug>(AerojumpFromCursorBolt)
						"nmap <Leader>ad <Plug>(AerojumpDefault)
				endif
			"TODECIDE
				Plug 'kopischke/vim-fetch'
				"Plug 'gyim/vim-boxdraw'
				"Plug 'fmoralesc/vim-pad'
				"Plug 'tenfyzhong/axring.vim'
					"let g:axring_rings = [
					"\ ]

					"augroup AXRING
						"au!
						"au Filetype python execute "let g:axring_rings_" . &filetype . " = s:languages['" . &filetype . "'].axrings"
					"augroup END
				Plug 'svermeulen/vim-macrobatics'
					nmap qp <plug>(Mac_Play)
					nmap qr <plug>(Mac_RecordNew)
				if v:version >= 800
					"TODO:FIX
					"Plug 'TaDaa/vimade'
				endif
				"Plug 'tyru/capture.vim'
				Plug 'unblevable/quick-scope'
				Plug 'haya14busa/vim-signjk-motion'
				Plug 'haya14busa/vim-over'
					"TODO:FIX|DECIDE
					"nmap <Leader>fR :OverCommandLine<CR>
				"Plug 'vim-scripts/MultipleSearch'
				"Plug 'henrik/vim-indexed-search'
				Plug 'zirrostig/vim-schlepp'
					vmap <up>	 <Plug>SchleppUp
					vmap <down>  <Plug>SchleppDown
					vmap <left>  <Plug>SchleppLeft
					vmap <right> <Plug>SchleppRight

					vmap Dk <Plug>SchleppDupUp
					vmap Dj <Plug>SchleppDupDown
					vmap Dh <Plug>SchleppDupLeft
					vmap Dl <Plug>SchleppDupRight
				Plug 'dohsimpson/vim-macroeditor'
					nnoremap <Leader>zm :execute "MacroEdit " nr2char(getchar()) <CR>
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
				Plug 'osyo-manga/vim-anzu'
					"nmap n <Plug>(incsearch-nohl-n)<Plug>(anzu-mode-n)
					"nmap N <Plug>(incsearch-nohl-N)<Plug>(anzu-mode-N)
					"nmap * <Plug>(anzu-star-with-echo)
					"nmap # <Plug>(anzu-sharp-with-echo)
				"Plug 'sickill/vim-pasta'
					let g:pasta_paste_before_mapping = 'P'
					let g:pasta_paste_after_mapping = 'p'
				"Plug 'liuchengxu/vim-clap'
				Plug 'tommcdo/vim-ninja-feet'
				"Plug 'RRethy/vim-illuminate'
					"CONFIGURATION
						let g:Illuminate_delay = 0
						"TODO:FIX hi illuminatedWord ctermfg=grey ctermbg=darkblue
				"Plug 'itchyny/vim-cursorword'
				"Plug 'lucerion/vim-executor'
				"Plug 'vim-scripts/Omap.vim'
				"Plug 'tyru/capture.vim'
				"Plug 'tommcdo/vim-express'
				"Plug 'syngan/vim-operator-evalf'
				"Plug 'neitanod/vim-sade'
		call plug#end()
	"POST-LOADING
		"WHICH-KEY
			call which_key#register('<SPACE>', "g:which_key_map")
		"LUA
			if has('nvim-0.5')
				"treesitter
				luafile ~/.config/nvim/plugins/treesitter/nvim-treesitter.lua

				"lsp
				luafile ~/.config/nvim/plugins/lsp/nvim-lspconfig.lua
				luafile ~/.config/nvim/plugins/lsp/trouble.lua
				luafile ~/.config/nvim/plugins/lsp/nvim-lsputils.lua
				luafile ~/.config/nvim/plugins/lsp/lspsaga.nvim.lua
				luafile ~/.config/nvim/plugins/lsp/nvim-lightbulb.lua
				luafile ~/.config/nvim/plugins/lsp/nvim-compe.lua
				luafile ~/.config/nvim/plugins/lsp/lspkind-nvim.lua
				luafile ~/.config/nvim/plugins/lsp/nvim-lsp-ts-utils.lua

				"vcs
				luafile ~/.config/nvim/plugins/vcs/gitsigns.nvim.lua
				luafile ~/.config/nvim/plugins/vcs/nvim-blamer.lua

				"syntax
				luafile ~/.config/nvim/plugins/aesthetics/nvim-colorizer.lua
				luafile ~/.config/nvim/plugins/syntax/todo-comments.lua

				"system
				luafile ~/.config/nvim/plugins/system/nvim-tree.lua
				luafile ~/.config/nvim/plugins/system/nvim-spectre.lua

				"editor
				lua require('numb').setup()

				"aesthetics
				luafile ~/.config/nvim/plugins/aesthetics/galaxyline/evilline.lua
				luafile ~/.config/nvim/plugins/aesthetics/nvim-bufferline.lua
			endif
	"CUSTOM
		source ~/.config/nvim/plugins/aesthetics/custom/minimalistic-folds.vim
	"IDEAPAD
	"SCRATCHPAD
"CONFIGURATION
	"PYTHON-BINARIES
		let g:loaded_python_provider  = 1
		let g:loaded_python3_provider = 1

		if IsNix()
			let g:python_host_prog	= '/usr/bin/python'
			let g:python3_host_prog = '/usr/local/bin/python3'
		elseif IsWindows()
			"TODO:FIX
			let g:python_host_prog	= "C:/Users/138100/scoop/apps/anaconda3/current/envs/pynvim2/python.exe"
			let g:python3_host_prog = "C:/Users/138100/scoop/apps/anaconda3/current/envs/pynvim/python.exe"
		endif
	"MSWIN
		if IsWindows()
			nnoremap <Leader>mm :source $VIMRUNTIME/mswin.vim<CR>
		endif
	"HIGHLIGHTS
		"SEARCH-HIGHLIGHTS
			highlight Search ctermfg=49 cterm=NONE gui=NONE
			highlight IncSearchMatch ctermfg=black ctermbg=186
		"AUTO-COMPLETION-MENU
			"highlight Pmenu ctermbg=232 ctermfg=7
			"highlight PmenuSel ctermfg=15
			highlight Pmenu ctermbg=238 gui=bold
		"INTERFACE-HIGHLIGHTS
			highlight VertSplit ctermbg=None guibg=None
"SETTINGS
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
				colorscheme gruvbox
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
				let g:airline_powerline_fonts = 0
				let g:airline_theme = 'wombat'
				let g:airline#extensions#bufferline#enabled = 1
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
				colorscheme xcode
				set laststatus=0
				"not-working because of autocmd
				set showmode
			"PLUGINS
				let g:startify_disable_at_vimenter = 0
		endif
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
			"⸻    ⸺   ― —	–
			"■□ ▢ ⬚	▣	 ▪▫ ◻◼	 ▤ ▥ ▦ ▧ ▨ ▩	◲◱◳◰ ◫ ◧◨◪◩ ▬ ▭ ▮▯ ☐☑☒ ⬗⬖⬘⬙ ﱢ
			"▲▼ ◀▶  ► △▽ ▷ ▵ ◃◁ ▴▾◂ ▸ ▿▹ ▻◅ ◄ ◸◹ ◺◿ 	◣ ◢	◤ ◥   ◬◭◮ ⮀⮁ ⯅⯆⯇⯈
			"·∙○●◦ ◉ ◯ ◌ ⭘ ⬤	◶◵◷◴ ◐ ◑ ◒ ◓	 ◔◕	◖◗⯊⯋ ◚◛  ◠◡ ⦾⦿◎ ◘ ◙ ◍ ☉
			"◇◆	⬥⬦ ◈  ◊♦♢
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
"TEMPORAL
"EXPERIMENT
	"FEATURES
		"+VIMDIFF
		"+CONCEAL
		"+PREVIEW=pedit|ptag…
	"DEFAULTS.vim
	"OPERATOR-WITHOUT-MOVING
		" gq wrapper that:
		" - tries its best at keeping the cursor in place
		" - tries to handle formatter errors
		function! Format(type, ...)
			normal! '[v']gq
			if v:shell_error > 0
				silent undo
				redraw
				echomsg 'formatprg "' . &formatprg . '" exited with status ' . v:shell_error
			endif
			call winrestview(w:gqview)
			unlet w:gqview
		endfunction
		nmap <silent> GQ :let w:gqview = winsaveview()<CR>:set opfunc=Format<CR>g@
