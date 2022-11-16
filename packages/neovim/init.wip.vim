"LEADER
	"nnoremap ; :
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
		nnoremap " '
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

				nnoremap <silent> <Leader>bcc :bprevious<bar>split<bar>bnext<bar>bdelete<CR>
				nnoremap <silent> <Leader>bcC :bprevious<bar>split<bar>bnext<bar>bdelete!<CR>
				"nnoremap <silent> <Leader>bca :bufdo bp<bar>sp<bar>bn<bar>bd<CR>
				"nnoremap <silent> <Leader>bcA :bufdo bp<bar>sp<bar>bn<bar>bd!<CR>
				"nnoremap <silent> <Leader>bco :%bp<bar>sp<bar>bn<bar>bd<bar>e#<CR>
				"nnoremap <silent> <Leader>bcO :%bp<bar>sp<bar>bn<bar>bd!<bar>e#<CR>

				nnoremap <silent> <Leader>bdc :bdelete<CR>
				nnoremap <silent> <Leader>bdC :bdelete!<CR>
				nnoremap <silent> <Leader>bda :%bdelete<CR>
				nnoremap <silent> <Leader>bdA :%bdelete!<CR>
				nnoremap <silent> <Leader>bdo :%bdelete<bar>edit#<bar>bnext<bar>bdelete<CR>
				nnoremap <silent> <Leader>bdO :%bdelete!<bar>edit#<bar>bnext<bar>bdelete!<CR>

				nnoremap <silent> <Leader>bs :call ScratchBuffer('e')<CR>
				nnoremap <silent> <Leader>bS :call ScratchBuffer('e', 1)<CR>

				nnoremap <silent> <Leader>bwc :write<CR>
				nnoremap <silent> <Leader>bwa :wall<CR>
				nnoremap <silent> <Leader>bwC :write!<CR>
				nnoremap <silent> <Leader>bwA :wall!<CR>
				nnoremap <silent> <C-s> :w<CR>
				nnoremap <silent> <C-S-s> :wall<CR>

				"shortcuts
				nnoremap <Leader>` <C-^>
				nnoremap <silent> <C-S-d> :bp<bar>sp<bar>bn<bar>bd<CR>
				nnoremap <silent> <C-n> :bprevious<CR>
				nnoremap <silent> <C-p> :bnext<CR>
			"WINDOWS
				nnoremap <silent> <Leader>wh :sp<CR>
				nnoremap <silent> <Leader>wv :vsp<CR>
				nnoremap <silent> <Leader>wH :new<CR>
				nnoremap <silent> <Leader>wV :vnew<CR>
				nnoremap <silent> <Leader>wo :only<CR>
				nnoremap <silent> <Leader>wc :close<CR>
				nnoremap <silent> <Leader>w= <C-w>=

				"layouts
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
				"GENERAL
					"BETTER-CAPSLOCK
						Plug 'tpope/vim-capslock'
							runtime plugins/vim-capslock.vim
					"BETTER-REPEAT
						"BETTER-DOT
							Plug 'tpope/vim-repeat'
						"BETTER-;,
							if v:false
								Plug 'Houl/repmo-vim'
							else
								Plug 'vim-scripts/repmo.vim'
									runtime plugins/repmo.vim
							endif
				"OPERATORS
					Plug 'JRasmusBm/vim-peculiar'
						runtime plugins/vim-peculiar.vim
					Plug 'haya14busa/vim-operator-flashy'
						runtime plugins/vim-operator-flashy.vim
					Plug 'tpope/vim-surround'
					Plug 'junegunn/vim-easy-align'
						runtime plugins/vim-easy-align.vim
					Plug 'svermeulen/vim-subversive'
						runtime plugins/vim-subversive.vim
					Plug 'tommcdo/vim-exchange'
						runtime plugins/vim-exchange.vim
					Plug 'arthurxavierx/vim-caser'
						runtime plugins/vim-caser.vim
					Plug 'gustavo-hms/vim-duplicate'
						runtime plugins/vim-duplicate.vim
					Plug 'rjayatilleka/vim-operator-goto'
						runtime plugins/vim-operator-goto.vim
					Plug 'deris/vim-operator-insert'
						runtime plugins/operator-insert.vim
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
					Plug 'inside/vim-search-pulse'
						runtime plugins/vim-search-pulse.vim
					Plug 'haya14busa/vim-asterisk'
						runtime plugins/vim-asterisk.vim
					Plug 'bronson/vim-visual-star-search'
					Plug 'rhysd/clever-f.vim'
						runtime plugins/clever-f.vim
					Plug 'justinmk/vim-sneak'
						runtime plugins/vim-sneak.vim
					Plug 'haya14busa/incsearch.vim'
						runtime plugins/incserach.vim
					Plug 'haya14busa/incsearch-fuzzy.vim'
						runtime plugins/incserach-fuzzy.vim
					Plug 'lambdalisue/reword.vim'
					Plug 'easymotion/vim-easymotion'
						runtime plugins/vim-easymotion.vim
					Plug 'haya14busa/incsearch-easymotion.vim'
						runtime plugins/incsearch-easymotion.vim
					if has('nvim') && IsNix()
						Plug 'lambdalisue/lista.nvim'
							runtime plugins/lista.vim
						Plug 'osyo-manga/vim-hopping'
							runtime plugins/vim-hopping.vim
					endif
					if v:version >= 740
						Plug 'andymass/vim-matchup'
					endif
				"JUMPS
				"COMMANDS
				"RANDOM
					Plug 'machakann/vim-swap'
						runtime plugins/vim-swap.vim
					Plug 'AndrewRadev/splitjoin.vim'
					Plug 'jiangmiao/auto-pairs'
						runtime plugins/auto-pairs.vim
					"Plug 'terryma/vim-expand-region'
						"runtime plugins/vim-expand-region.vim
					Plug 'terryma/vim-multiple-cursors'
						runtime plugins/vim-multiple-cursors.vim
					Plug 'dkarter/bullets.vim'
						runtime plugins/bullets.vim
			"EDITOR
				"GENERAL
					"STARTSCREEN
						Plug 'mhinz/vim-startify'
							runtime plugins/vim-startify.vim
					"UNDOTREE
						Plug 'mbbill/undotree'
							runtime plugins/undotree.vim
					"SESSIONS
						Plug 'abdalrahman-ali/vim-remembers'
							runtime plugins/vim-remembers.vim
					"MINIMAP
						if has('nvim-0.5') || v:version >= 820
							Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}
								runtime plugins/minimap.vim
						endif
					"SEARCH-REPLACE
						if has('nvim-0.5')
							Plug 'windwp/nvim-spectre'
						endif
					"SCRATCH-BUFFER
						Plug 'mtth/scratch.vim'
							runtime plugins/scratch.vim
					"BUFFER-TREE
						Plug 'el-iot/buffer-tree-explorer'
							runtime plugins/buffer-tree-explorer.vim
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
						"Plug 'kana/vim-arpeggio'
						"Plug 'vim-scripts/tinymode.vim'
						"Plug 'tyru/stickykey.vim'
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
						if has('nvim-0.3') || v:version >= 800
							Plug 'psliwka/vim-smoothie'
								runtime plugins/vim-smoothie.vim
						else
							Plug 'joeytwiddle/sexy_scroller.vim'
								runtime plugins/sexy_scroller.vim
						endif
					"INDENTLINE"
						if has('nvim-0.5')
							"remove lua branch when neovim-0.5 is released, since this will be
							"moved to the the main branch
							Plug 'lukas-reineke/indent-blankline.nvim'
								runtime plugins/indent-blankline.vim
						elseif has('conceal')
							"Plug 'Yggdroot/indentLine'
								"runtime plugins/indentLine.vim
						endif
					"COLOR-HIGHLIGHTER
						if has('nvim-0.5')
							Plug 'norcalli/nvim-colorizer.lua'
						endif
					"WORD-HIGHLIGHER
						Plug 'itchyny/vim-cursorword'
					"PASTE-HIGHLIGHTER
						if has('nvim-0.5') || v:version >= 810
							Plug 'ayosec/hltermpaste.vim'
						endif
					"BETTER-BUFFER-CLOSING
						if has('nvim-0.5')
							Plug 'kazhala/close-buffers.nvim'
						endif
					"CHANGE-HIGHLIGHER
						Plug 'axlebedev/footprints'
					"MODE-HIGHLIGHT
						Plug 'mvllow/modes.nvim'
					"SEARCH-HIGHLIGHT
						if has('nvim-0.5')
							Plug 'kevinhwang91/nvim-hlslens'
						endif
						if has('nvim')
							Plug 'ironhouzi/starlite-nvim'
								runtime plugins/starlite-nvim.vim
						else
							Plug 'ironhouzi/vim-stim'
						endif
					if has('nvim-0.5')
						Plug 'nacro90/numb.nvim'
					endif
				"WINDOW
					"ANIMATION
						Plug 'camspiers/animate.vim'
							runtime plugins/animate.vim
						"Plug 'camspiers/lens.vim'
							"runtime plugins/lens.vim
					Plug 'szw/vim-maximizer'
						runtime plugins/vim-maximizer.vim
					Plug 'blueyed/vim-diminactive'
						runtime plugins/vim-diminactive.vim
				"MAPPINGS
					if has('nvim-0.6')
						Plug 'folke/which-key.nvim'
					elseif has('vim')
						Plug 'liuchengxu/vim-which-key'
							runtime plugins/vim-which-key.vim
					else
						"Plug 'luzhlon/guider.nvim'
						"Plug 'skywind3000/quickmenu.vim'
					endif
				"BETTER
					"BETTER-FOLDING
						if has('folding')
							Plug 'pseewald/vim-anyfold'
								runtime plugins/vim-anyfold.vim
							Plug 'arecarn/vim-fold-cycle'
								runtime plugins/vim-fold-cycle.vim
						endif
					"BETTER-SIGNS
						if has('signs')
							Plug 'kshenoy/vim-signature'
						endif
					"BETTER-QUICKFIX
						if has('nvim')
							Plug 'kevinhwang91/nvim-bqf'
						endif
				"RANDOM
					"COLOR-CONVERTER
						if has('nvim-0.4')
							Plug 'NTBBloodbath/color-converter.nvim'
								runtime plugins/color-converter.vim
						else
							Plug 'amadeus/vim-convert-color-to'
						endif
					if has('nvim-0.2.3') || v:version >= 810
						Plug 'markonm/traces.vim'
					endif
				Plug 'junegunn/vim-peekaboo'
					runtime plugins/vim-peekaboo.vim
			"AESTHETICS
				"STATUSLINE
					if has('nvim-0.5')
						Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
					elseif IsNix()
						Plug 'vim-airline/vim-airline'
							runtime plugins/vim-airline.vim
						Plug 'vim-airline/vim-airline-themes'
						Plug 'augustold/vim-airline-colornum'
					elseif IsWindows()
						Plug 'itchyny/lightline.vim'
							runtime plugins/lightline.vim
						Plug 'mengelbrecht/lightline-bufferline'
							runtime plugins/lightline-bufferline.vim
					endif
				"BUFFERLINE
					"Plug 'bling/vim-bufferline'
						"runtime plugins/vim-bufferline.vim
				"TABLINE
					if has('nvim-0.5')
						if v:true
							Plug 'akinsho/nvim-bufferline.lua'
						else
							Plug 'romgrk/barbar.nvim'
								runtime plugins/barbar.vim
						endif
					endif
				"EXTERNAL
					Plug 'edkolev/tmuxline.vim'
						runtime plugins/tmuxline.vim
					Plug 'edkolev/promptline.vim'
						runtime plugins/promptline.vim
				"COLORSCHEMES
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
								runtime plugins/tokyonight.vim
						else
							Plug 'ghifarit53/tokyonight-vim'
								runtime plugins/tokyonight-vim.vim
						endif
					"SPACEDUCK
						"Plug 'pineapplegiant/spaceduck'
					"CHALLENGER-DEEP
						"Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
					"COLLECTIONS
						Plug 'flazz/vim-colorschemes'
						Plug 'rafi/awesome-vim-colorschemes'
						Plug 'chriskempson/base16-vim'
					"RANDOM
						Plug 'KeitaNakamura/neodark.vim'
							runtime plugins/neodark.vim
						"Plug 'sindresorhus/focus'
						"Plug 'KabbAmine/yowish.vim'
						"Plug 'ayu-theme/ayu-vim'
						"Plug 'tyrannicaltoucan/vim-quantum'
						"Plug 'raphamorim/lucario'
						"Plug 'paranoida/vim-airlineish'
						"Plug 'arzg/vim-corvine'
						"Plug 'i3d/vim-jimbothemes'
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
			"SYSTEM
				"SEARCH
					Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': { -> fzf#install() }}
						runtime plugins/fzf.vim
					Plug 'junegunn/fzf.vim'
						runtime plugins/fzf-vim.vim
					Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release/rpc' }
						runtime plugins/fzf-preview.vim
					Plug 'dominickng/fzf-session.vim'
						runtime plugins/fzf-session.vim
					Plug 'pbogut/fzf-mru.vim'
						runtime plugins/fzf-mru.vim
				"TERMINAL
					Plug 'voldikss/vim-floaterm'
						runtime plugins/vim-floaterm.vim
				"FILESYSTEM
					if has('nvim-0.5')
						Plug 'kyazdani42/nvim-tree.lua'
					endif
			"PROGRAMMING
				"SYNTAX
					"RAINBOW
						Plug 'luochen1990/rainbow'
							runtime plugins/rainbow.vim
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
						runtime plugins/vim-markdown.vim
					"Plug 'vim-syntastic/syntastic'
					"Plug 'coachshea/jade-vim'
				"VCS[GIT]
					Plug 'tpope/vim-fugitive'
						runtime plugins/vim-fugitive.vim
					Plug 'rhysd/git-messenger.vim'
						runtime plugins/git-messenger.vim
					Plug 'rhysd/conflict-marker.vim'
					if has('nvim')
						Plug 'ttys3/nvim-blamer.lua'
					endif
					if has('nvim-0.5')
						Plug 'lewis6991/gitsigns.nvim'
							Plug 'nvim-lua/plenary.nvim'
						Plug 'sindrets/diffview.nvim'
					else
						Plug 'airblade/vim-gitgutter'
					endif
				"LSP
					if has('nvim-0.5')
						luafile ~/.config/nvim/lsp.lua
						Plug 'neovim/nvim-lspconfig'
						Plug 'alexaandru/nvim-lspupdate'
						Plug 'folke/trouble.nvim'
						Plug 'RishabhRD/nvim-lsputils'
							Plug 'RishabhRD/popfix'
						Plug 'glepnir/lspsaga.nvim'
						Plug 'kosayoda/nvim-lightbulb'
						Plug 'ray-x/lsp_signature.nvim'
						Plug 'onsails/lspkind-nvim'
						Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
						Plug 'folke/lua-dev.nvim'
					elseif has('node') && (v:version >= 800 || has('nvim-0.4'))
						Plug 'neoclide/coc.nvim', {'branch': 'release'}
							runtime plugins/coc.vim
						Plug 'Shougo/neco-vim'
						Plug 'neoclide/coc-neco'
					endif
					"PREVIEW
						if has('nvim-0.5')
							Plug 'rmagatti/goto-preview'
						endif
					"TAGBAR
						Plug 'liuchengxu/vista.vim'
							runtime plugins/vista.vim
				"TREESITTER
					if has('nvim-0.5')
						Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
						Plug 'nvim-treesitter/playground'
						Plug 'nvim-treesitter/nvim-treesitter-textobjects'
						Plug 'singlexyz/treesitter-frontend-textobjects'
						Plug 'mfussenegger/nvim-ts-hint-textobject'
							omap <silent> gt <cmd>lua require('tsht').nodes()<CR>
							vnoremap <silent> gt <cmd>lua require('tsht').nodes()<CR>
						Plug 'romgrk/nvim-treesitter-context'
						Plug 'haringsrob/nvim_context_vt'
						Plug 'nvim-treesitter/nvim-treesitter-refactor'
						Plug 'p00f/nvim-ts-rainbow'
						Plug 'windwp/nvim-ts-autotag'
						Plug 'JoosepAlviste/nvim-ts-context-commentstring'
					endif
				"COMMENTS
					if has('nvim-0.5')
						Plug 's1n7ax/nvim-comment-frame'
					endif
					"Plug 'tpope/vim-commentary'
					Plug 'scrooloose/nerdcommenter'
						runtime plugins/nerdcommenter.vim
				"DATABASE
					Plug 'tpope/vim-dadbod'
					Plug 'kristijanhusak/vim-dadbod-ui'
				"SNIPPETS
					if has('nvim-0.5')
						Plug 'L3MON4D3/LuaSnip'
					elseif (has('nvim-0.4.4') || v:version >= 800) && v:false
						Plug 'hrsh7th/vim-vsnip'
						Plug 'hrsh7th/vim-vsnip-integ'
						Plug 'rafamadriz/friendly-snippets'
					elseif has('nvim-0.5') && v:false
						"Plug 'norcalli/snippets.nvim'
					else
						Plug 'SirVer/ultisnips'
							runtime plugins/ultisnips.vim
						Plug 'honza/vim-snippets'
						"Plug 'epilande/vim-react-snippets'
					endif
				"COMPLETION
					if has('nvim-0.5')
						Plug 'hrsh7th/nvim-compe'
							Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }
					endif
					Plug 'mattn/emmet-vim'
						runtime plugins/emmet-vim.vim
				"DEBUGGING
				"TAGS
					"Plug 'ludovicchabant/vim-gutentags'
				"DOCUMENTATION
					if has('nvim-0.5')
						Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
							runtime plugins/vim-doge.vim
						"Plug 'nvim-treesitter/nvim-tree-docs'
					endif
				"PLAYGROUND
					Plug 'metakirby5/codi.vim'
						runtime plugins/codi.vim
					Plug 'arkwright/vim-whiteboard'
						runtime plugins/vim-whiteboard.vim
				"RANDOM
					"Plug 'tpope/vim-abolish'
					"MARKDOWN-PREVIEW"
						if has('nvim') || (has('vim') && v:version >= 800)
							Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
								runtime plugins/markdown-preview.vim
						else
							"install instant-markdown-d usig NPM
							Plug 'suan/vim-instant-markdown'
						endif
			"CLIENTS
				if has('nvim')
					Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
				endif
			"AUTHORING
				Plug 'reedes/vim-pencil'
					runtime plugins/vim-pencil.vim
				Plug 'panozzaj/vim-autocorrect'
					runtime plugins/vim-autocorrect.vim
				Plug 'davidbeckingsale/writegood.vim'
				Plug 'dbmrq/vim-ditto'
				Plug 'reedes/vim-lexical'
					runtime plugins/vim-lexical.vim
			"RANDOM
				if has('nvim-0.2.2') || v:version >= 800
					"Plug 'dstein64/vim-startuptime'
				endif
				Plug 'tyru/open-browser.vim'
					runtime plugins/open-browser.vim
			"LIBRARIES
				"EDITING
					Plug 'kana/vim-operator-user'
					Plug 'kana/vim-textobj-user'
				"UI
					Plug 'MunifTanjim/nui.nvim'
				"NETWORK
					"Plug 'mattn/webapi-vim'
			"DEPENDENCIES
				Plug 'Shougo/vimproc.vim'
			"MESS:EXTENDING-VIM
				"Plug 'svermeulen/vim-yoink'
					"runtime plugins/vim-yoink.vim
				if has('macunix')
					Plug 'gastonsimone/vim-dokumentary'
				endif
				"Plug 'tpope/vim-speeddating'
			"MESS
				Plug 'vim-scripts/DrawIt'
				Plug 'alpertuna/vim-header'
					runtime plugins/vim-header.vim
				Plug 'itchyny/calendar.vim'
					runtime plugins/calendar.vim
				Plug 'shanzi/autoHEADER'
				Plug 'itchyny/dictionary.vim'
					runtime plugins/dictionary.vim
				Plug 'leothelocust/vim-makecols'
				Plug 'sbdchd/vim-shebang'
				Plug 'vim-utils/vim-read'
				Plug 'antoyo/vim-licenses'
				Plug 'vim-scripts/WholeLineColor'
					runtime plugins/WholeLineColor.vim
				"Plug 'natw/keyboard_cat.vim'
				if !IsWindows()
					"Plug 'MrPeterLee/VimWordpress'
						"runtime VimWordpress.vim
				endif
				"Plug 'vim-scripts/autoscroll.vim'
					"runtime plugins/autoscroll.vim
				"Plug 'fadein/vim-FIGlet'
					"runtime plugins/vim-FIGlet.vim
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
						"runtime plugins/aerojump
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
					runtime plugins/vim-macrobatics.vim
				if v:version >= 800
					"TODO:FIX
					"Plug 'TaDaa/vimade'
				endif
				"Plug 'tyru/capture.vim'
				Plug 'unblevable/quick-scope'
				Plug 'haya14busa/vim-signjk-motion'
				Plug 'haya14busa/vim-over'
					runtime plugins/vim-over.vim
				"Plug 'vim-scripts/MultipleSearch'
				"Plug 'henrik/vim-indexed-search'
				Plug 'zirrostig/vim-schlepp'
					runtime plugins/vim-schelepp.vim
				Plug 'dohsimpson/vim-macroeditor'
					runtime plugins/vim-macroeditor.vim
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
				"Plug 'majutsushi/tagbar'
					"runtime plugins/tagbar.vim
				Plug 'osyo-manga/vim-anzu'
					"runtime plugins/vim-anzu.vim
				"Plug 'sickill/vim-pasta'
					runtime plugins/vim-pasta.vim
				"Plug 'liuchengxu/vim-clap'
				Plug 'tommcdo/vim-ninja-feet'
				"Plug 'RRethy/vim-illuminate'
					"CONFIGURATION
						let g:Illuminate_delay = 0
						"TODO:FIX hi illuminatedWord ctermfg=grey ctermbg=darkblue
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
				"editing
				lua require('plugins/nvim-comment-frame')

				"treesitter
				lua require('plugins/treesitter/treesitter')
				"lua require('plugins/treesitter/hint-textobject')

				"lsp
				lua require('plugins/lsp/lspconfig')
				lua require('plugins/trouble')
				lua require('plugins/lsputils')
				lua require('plugins/lspsaga')
				lua require('plugins/lightbulb')
				lua require('plugins/nvim-compe')
				lua require('plugins/lsp_signature')
				lua require('plugins/lspkind')
				lua require('plugins/lsp-ts-utils')
				lua require('plugins/lua-dev')
				lua require('plugins/lsp/luasnip')
				lua require('plugins/vsnip')

				"vcs
				lua require('plugins/gitsigns')
				lua require('plugins/nvim-blamer')
				lua require('plugins/diffview')

				"syntax
				lua require('plugins/nvim-colorizer')
				lua require('plugins/todo-comments')

				"system
				lua require('plugins/nvim-tree')
				lua require('plugins/nvim-spectre')

				"editor
				lua require('numb').setup()
				lua require('plugins/goto-preview')
				lua require('plugins/close-buffers')
				lua require('plugins/nvim-hlslens')

				"aesthetics
				lua require('plugins/galaxyline/evilline')
				lua require('plugins/nvim-bufferline')
				lua require('plugins/zen-mode')
				lua require('plugins/twilight')

				"ui
				lua require('plugins/libs/ui/nui')
			endif
	"CUSTOM
		runtime custom/minimalistic-folds.vim
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
"EXPERIMENT
	"FEATURES
		"+VIMDIFF
		"+CONCEAL
		"+PREVIEW=pedit|ptag…
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
