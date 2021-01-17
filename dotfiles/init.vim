"LEADER
	nnoremap ; :
	let mapleader      = ' '
	let maplocalleader = ','

	"let g:modifier_ctrl = 'C'
	"let g:modifier_alt  = 'A'
	"let g:modifier_cmd  = 'D'

	"let g:modifier_ctrl_alt   = 'C-A'
	"let g:modifier_ctrl_shift = 'C-S'
	"let g:modifier_alt_shift  = 'A-S'

	let g:motion_leader   = 'C-A'
	let g:insert_leader   = ';'
	let g:terminal_leader = ';'

	"TODO:REFACTOR
	let g:modifier_leader = 'A'
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
							nnoremap <silent> j gj:nohl<CR>
							nnoremap <silent> k gk:nohl<CR>

							nnoremap <silent> h h:nohl<CR>
							nnoremap <silent> l l:nohl<CR>
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
						nnoremap <C-j> :move .+1<CR>==
						nnoremap <C-k> :move .-2<CR>==
						inoremap <C-j> <Esc>:move .+1<CR>==gi
						inoremap <C-k> <Esc>:move .-2<CR>==gi
						vnoremap <C-j> :move '>+1<CR>gv=gv
						vnoremap <C-k> :move '<-2<CR>gv=gv
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
										\'extension' : 'py',
										\'repl'      : 'ipython',
										\'execute'   : 'python3 %:p:S',
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
										\'extension' : 'r',
										\'repl'      : 'r',
									\}
									let g:languages.javascript = {
										\'extension' : 'js',
										\'repl'      : 'node',
										\'execute'   : 'node %:p:S',
									\}
									let g:languages.ruby = {
										\'extension' : 'rb',
										\'repl'      : 'irb',
										\'execute'   : 'ruby %:p:S',
									\}
									let g:languages.perl = {
										\'extension' : 'pl',
										\'repl'      : 'perl',
										\'execute'   : 'perl %:p:S',
									\}
									let g:languages.php = {
										\'extension' : 'php',
										\'repl'      : 'php',
										\'execute'   : 'php %:p:S',
									\}
									let g:languages.lisp = {
										\'extension' : 'lsp',
										\'repl'      : 'sbcl',
									\}
									let g:languages.lua = {
										\'extension' : 'lua',
										\'repl'      : 'lua',
										\'execute'   : 'lua %:p:S',
									\}
								"COMPILED
									let g:languages.c = {
										\'extension'       : 'c',
										\'repl'            : 'cling',
										\'compile'         : 'gcc %:p:S -o %:p:r:S.out',
										\'execute'         : '%:p:r:S.out',
										\'compile-execute' : 'gcc %:p:S -o %:p:r:S.out && %:p:r:S.out',
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

					command! ProjectinatorSearchProject :call fzf#run(fzf#wrap({
						\ 'source'  : g:jaat_find_lines_command,
						\ 'sink'    : 'edit',
						\ 'options' : '--prompt "search-project> "'
					\}))<CR>
				"DEFAULTS
					if ExistsAndTrue('g:projectinator_enable_default_mappings')
						nnoremap <silent> <Leader>po :ProjectinatorOpenProject<CR>
						nnoremap <silent> <Leader>pf :ProjectinatorOpenFile<CR>
						nnoremap <silent> <Leader>pt :ProjectinatorSearchProject<CR>
						nnoremap <silent> <Leader>pe :CocCommand explorer<CR>
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
				nnoremap <silent> <Leader>ae :execute 'FloatermNew ' . g:jaat_explorer_command<CR>
				nnoremap <silent> <Leader>pE :execute 'FloatermNew ' . g:jaat_explorer_command . ' ' . shellescape(getcwd())<CR>
			endif

			if executable('glow')
				command! -nargs=1 Glow :execute 'FloatermNew --autoclose=0 glow ' . shellescape(<q-args>)

				nnoremap <silent> <Leader>am :FloatermNew glow<CR>
				nnoremap <silent> <Leader>aM :execute 'FloatermNew --autoclose=0 glow ' . shellescape(expand('%:p'))<CR>
			endif

			if executable('lazygit')
				nnoremap <silent> <Leader>ag :FloatermNew lazygit<CR>
			endif

			if executable('bat')
				command! -nargs=1 Bat :FloatermNew bat <q-args>

				nnoremap <silent> <Leader>ab :execute 'FloatermNew bat    --file-name=' . expand('%:p:t') . ' ' .expand('%:p')<CR>
				nnoremap <silent> <Leader>aB :execute 'FloatermNew bat -d --file-name=' . expand('%:p:t') . ' ' .expand('%:p')<CR>
			endif

			if executable('open')
				command! -nargs=1 Open :FloatermNew open <q-args>
			endif

			if executable('slack-term')
				nnoremap <silent> <Leader>as :FloatermNew slack-term<CR>
			endif

			if executable('lazynpm')
				nnoremap <silent> <Leader>an :FloatermNew lazynpm<CR>
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
		let g:jaat_vimfiles_path = glob('~/vimfiles/')
		let g:jaat_home_path = expand('~')
		let g:jaat_root_path =
			\ IsNix()
			\ ? shellescape(expand('/'))
			\ : shellescape(expand('D:'))
		let g:jaat_drive_path =
			\ IsNix()
			\ ? shellescape(expand('~/Google Drive'))
			\ : shellescape(expand('D:/OneDrive - Hitachi Consulting'))
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
		"GREPISH
			let g:jaat_grep_command = 'grep -rHnas --color --exclude-dir=".git" --exclude-dir="node_modules" -i . *'
				"TODO:FIX
			let g:jaat_ag_command	= 'ag --nogroup -s .+'
		"FINDISH
			let g:jaat_fd_command_files		  = "fd -tf '.*'"
			let g:jaat_fd_command_directories = "fd -td '.*'"

			let g:jaat_find_command_files		= 'find -type f -iname'
			let g:jaat_find_command_directories = 'find -type d -iname'
		"EXPLORER
			let g:jaat_vifm_command = 'vifm'
			let g:jaat_ranger_command = 'ranger'
		let g:jaat_explorer_command =
			\ executable('vifm')
			\ ? g:jaat_vifm_command
			\ : executable('ranger')
			\ ? g:jaat_ranger_command
			\ : ''
		let g:jaat_find_lines_command =
			\ executable('ag')
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
			"TODO:FIX
				"execute 'nnoremap <silent> <' . g:leader_2 . '-space> <ESC>'
		"EDITING
			"OPERATORS
			"OBJECTS
			"MOTIONS
			"JUMPS
				execute 'nnoremap <' . g:modifier_leader . '-o> <C-o>'
				execute 'nnoremap <' . g:modifier_leader . '-i> <C-i>'

				execute 'nnoremap <' . g:modifier_leader . '-[> <C-t>'
				execute 'nnoremap <' . g:modifier_leader . '-]> <C-]>'
		"INTERFACE
			"TABS
				nnoremap <silent> <Leader>Ta :tabnew	  <CR>
				nnoremap <silent> <Leader>Td :tabclose	  <CR>
				nnoremap <silent> <Leader>Tn :tabnext	  <CR>
				nnoremap <silent> <Leader>Tp :tabprevious <CR>
				nnoremap <silent> <Leader>TN :tabmove -   <CR>
				nnoremap <silent> <Leader>TP :tabmove +   <CR>
			"BUFFERS
				nnoremap <silent> <Leader>ba :enew<CR>
				nnoremap <silent> <Leader>bc :bp<bar>sp<bar>bn<bar>bd<CR>
				nnoremap <silent> <Leader>bd :bdelete<CR>
				nnoremap <silent> <Leader>bD :bdelete!<CR>
				nnoremap <silent> <Leader>bs :call ScratchBuffer('e')<CR>
				nnoremap <silent> <Leader>bS :call ScratchBuffer('e', 1)<CR>
				nnoremap <silent> <Leader>bw :write!<CR>


				nnoremap <Leader>` <C-^>

				nnoremap <silent> ]b :bnext<CR>
				nnoremap <silent> [b :bprevious<CR>
				execute 'map <silent> <' . g:modifier_leader . '-p> :bprevious<CR>'
				execute 'map <silent> <' . g:modifier_leader . '-n> :bnext<CR>'
			"WINDOWS
				nnoremap <silent> <Leader>wh :sp<CR>
				nnoremap <silent> <Leader>wv :vsp<CR>
				nnoremap <silent> <Leader>wH :new<CR>
				nnoremap <silent> <Leader>wV :vnew<CR>
				nnoremap <silent> <Leader>wo :only<CR>
				nnoremap <silent> <Leader>wc :close<CR>

				if has('nvim')
					execute 'nnoremap <silent> <' . g:modifier_leader . '-h> <C-w><C-h>'
					execute 'nnoremap <silent> <' . g:modifier_leader . '-j> <C-w><C-j>'
					execute 'nnoremap <silent> <' . g:modifier_leader . '-k> <C-w><C-k>'
					execute 'nnoremap <silent> <' . g:modifier_leader . '-l> <C-w><C-l>'

					execute 'inoremap <silent> <' . g:modifier_leader . '-h> <ESC><C-w><C-h>'
					execute 'inoremap <silent> <' . g:modifier_leader . '-j> <ESC><C-w><C-j>'
					execute 'inoremap <silent> <' . g:modifier_leader . '-k> <ESC><C-w><C-k>'
					execute 'inoremap <silent> <' . g:modifier_leader . '-l> <ESC><C-w><C-l>'

					"window navigation for non-floating terminals
					execute 'tnoremap <silent> <' . g:modifier_leader . '-h> <C-\><C-n><C-w>h'
					execute 'tnoremap <silent> <' . g:modifier_leader . '-j> <C-\><C-n><C-w>j'
					execute 'tnoremap <silent> <' . g:modifier_leader . '-k> <C-\><C-n><C-w>k'
					execute 'tnoremap <silent> <' . g:modifier_leader . '-l> <C-\><C-n><C-w>l'
				endif
			"TERMINAL
				if has('nvim')
					"MAPPINGS
						"<esc>
						execute 'tnoremap <silent> <' . g:modifier_leader . '-[> <C-\><C-n>'

						"vim-registers
						tnoremap <silent> <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
					"ALIASES
						"GIT
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gi git init<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gC git clone '

							execute 'tnoremap <silent> ' . g:terminal_leader . 'ga git add **<LEFT>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gd git diff ** \| delta<C-LEFT><LEFT><LEFT><LEFT><LEFT>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gs git status<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gD git checkout -- '

							execute 'tnoremap <silent> ' . g:terminal_leader . 'grp git pull '
							execute 'tnoremap <silent> ' . g:terminal_leader . 'grP git push '

							execute 'tnoremap <silent> ' . g:terminal_leader . 'gSs git stash<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gSl git stash list<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gSa git stash apply<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gSp git stash pop<CR>'

							execute 'tnoremap <silent> ' . g:terminal_leader . 'gcm git commit -m ""<LEFT>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gca git commit --amend'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gcl git log<CR>'

							execute 'tnoremap <silent> ' . g:terminal_leader . 'gbl git branch<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gbn git branch '
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gbc git checkout '
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gbC git checkout -b '
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gbN git checkout -b '
						"SHELL
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
								execute 'tnoremap <silent> <' . g:modifier_leader . '-w> <C-RIGHT>'
								execute 'tnoremap <silent> <' . g:modifier_leader . '-b> <C-LEFT>'
								execute 'tnoremap <silent> <' . g:modifier_leader . '-0> <HOME>'
								execute 'tnoremap <silent> <' . g:modifier_leader . '-9> <END>'
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
	"RANDOM
"PLUGINS
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
				Plug 'tommcdo/vim-exchange'
					let g:exchange_no_mappings = 1
					nmap gx  <Plug>(Exchange)
					nmap gxx <Plug>(ExchangeLine)
					xmap X	 <Plug>(Exchange)
					nmap gxc <Plug>(ExchangeClear)
				Plug 'svermeulen/vim-subversive'
					nmap gs <plug>(SubversiveSubstituteRange)
					xmap gs <plug>(SubversiveSubstituteRange)
				Plug 'deris/vim-operator-insert'
					"TODO:FIX|DECIDE
					nmap gi <Plug>(operator-insert-i)
					nmap ga <Plug>(operator-insert-a)
				Plug 'gustavo-hms/vim-duplicate'
					"TODO:NOT-USED-MUCH
					map gy <Plug>(operator-duplicate)
				Plug 'rjayatilleka/vim-operator-goto'
					map g[ <Plug>(operator-gotostart)
					map g] <Plug>(operator-gotoend)
				Plug 'christoomey/vim-titlecase'
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
			"RANDOM
				Plug 'machakann/vim-swap'
					let g:swap_no_default_key_mappings = 1
					nmap g<			<Plug>(swap-prev)
					nmap g>			<Plug>(swap-next)
					nmap <Leader>zs <Plug>(swap-interactive)

					onoremap id <Plug>(swap-textobject-i)
					onoremap ad <Plug>(swap-textobject-a)
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
					let g:multi_cursor_quit_key			   = '<Esc>'
					let g:multi_cursor_start_word_key	   = '<C-n>'
					let g:multi_cursor_start_key		   = 'g<C-n>'
					let g:multi_cursor_next_key			   = '<C-n>'
					let g:multi_cursor_prev_key			   = '<C-p>'
					let g:multi_cursor_skip_key			   = '<C-x>'
					let g:multi_cursor_select_all_word_key = '<A-a>'
					let g:multi_cursor_select_all_key	   = 'g<A-a>'
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
					Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release/rpc' }
					Plug 'dominickng/fzf-session.vim'
						"CONFIGURATION
							let g:fzf_session_path = g:jaat_vimfiles_path . 'vim-sessions'
						"MAPPINGS
							nnoremap <silent> <Leader>Sl :Sessions<CR>
							nnoremap <silent> <Leader>Sn :Session<space>
							nnoremap <silent> <Leader>Sd :SDelete<space>
							nnoremap <silent> <Leader>So :SLoad<space>
							nnoremap <silent> <Leader>Sc :SQuit<CR>
					Plug 'pbogut/fzf-mru.vim'
						"nnoremap <silent> <Leader>fr :<C-u>FZFMru<CR>
						nnoremap <silent> <A-m> :<C-u>FZFMru<CR>
			Plug 'voldikss/vim-floaterm'
				nnoremap <silent> <Leader>tt :FloatermToggle<CR>
				nnoremap <silent> <Leader>tf :FloatermNew<CR>
				nnoremap <silent> <Leader>td :FloatermKill<CR>
				nnoremap <silent> <Leader>tn :FloatermNext<CR>
				nnoremap <silent> <Leader>tp :FloatermPrev<CR>

				execute 'nnoremap <silent> <' . g:modifier_leader . '-`> :FloatermToggle<CR>'
				execute 'tnoremap <silent> <' . g:modifier_leader . '-`> <C-\><C-n>:FloatermToggle<CR>'
				execute 'tnoremap <silent> <' . g:modifier_leader . '-f> <C-\><C-n>:FloatermNew<CR>'
				execute 'tnoremap <silent> <' . g:modifier_leader . '-d> <C-\><C-n>:FloatermKill<CR>'
				execute 'tnoremap <silent> <' . g:modifier_leader . '-p> <C-\><C-n>:FloatermNext<CR>'
				execute 'tnoremap <silent> <' . g:modifier_leader . '-n> <C-\><C-n>:FloatermPrev<CR>'
		"LOOK&FEEL
			"STATUSLINE
				if IsNix()
					Plug 'vim-airline/vim-airline'
						"CONFIGURATION
							let g:airline_powerline_fonts = 0
							let g:airline_theme			  = 'bubblegum'
						"TABLINE
							let g:airline#extensions#tabline#enabled		   = 1
							"let g:airline#extensions#tabline#left_sep			= ' '
							"let g:airline#extensions#tabline#left_alt_sep		= '|'
							"let g:airline#extensions#tabline#right_sep			= ' '
							"let g:airline#extensions#tabline#right_alt_sep		= '|'
							"let g:airline#extensions#tabline#show_splits		= 1
							"let g:airline#extensions#tabline#show_close_button = 1
							"let g:airline#extensions#tabline#close_symbol		= '✖ '
						"TMUXLINE
							"let airline#extensions#tmuxline#color_template = 'normal'
							"let airline#extensions#tmuxline#color_template = 'insert'
							"let airline#extensions#tmuxline#color_template = 'visual'
							"let airline#extensions#tmuxline#color_template = 'replace'
						"BUFFERLINE
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
						"EXTENSIONS
							let g:airline#extensions#wordcount#enabled					 = 0
							"let g:airline#extensions#wordcount#filetypes				  = []
							"let g:airline#extensions#whitespace#enabled				  = 1
							"let g:airline#extensions#whitespace#mixed_indent_algo		  = 0
							"let g:airline#extensions#whitespace#symbol					  = '!'
							"let g:airline#extensions#whitespace#checks					  = [ 'indent', 'trailing', 'long', 'mixed-indent-file' ]
							"let g:airline#extensions#whitespace#trailing_format		  = 'trailing[%s]'
							"let g:airline#extensions#whitespace#mixed_indent_format	  = 'mixed-indent[%s]'
							"let g:airline#extensions#whitespace#long_format			  = 'long[%s]'
							"let g:airline#extensions#whitespace#mixed_indent_file_format = 'mix-indent-file[%s]'
							"let g:airline#extensions#whitespace#trailing_regexp		  = '\s$'
					Plug 'vim-airline/vim-airline-themes'
					Plug 'augustold/vim-airline-colornum'
					Plug 'gcavallanti/vim-noscrollbar'
						function! Noscrollbar(...)
							let w:airline_section_z = '%{noscrollbar#statusline(20," ", "█")}'
							"let w:airline_section_z = '%{noscrollbar#statusline(20," ", "▌")}'
							"let w:airline_section_z = '%{noscrollbar#statusline(20," ", "▐")}'
						endfunction
						"call airline#add_statusline_func('Noscrollbar')
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
								\'directory'	: 'GetCurrentDirectoryName',
								\'vim-capslock' : 'CapsLock',
								\'gitbranch'	: 'FugitiveHead'
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
			"TABLINE
				"Plug 'romgrk/barbar.nvim'
				"Plug 'akinsho/nvim-bufferline.lua'
				"Plug 'bling/vim-bufferline'
					let g:bufferline_echo				 = 1
					let g:bufferline_active_buffer_left  = '['
					let g:bufferline_active_buffer_right = ']'
					let g:bufferline_modified			 = '+'
					let g:bufferline_rotate				 = 0
					let g:bufferline_show_bufnr			 = 0
					let g:bufferline_fname_mod			 = ':t'
					let g:bufferline_active_highlight	 = 'StatusLineNC'
					let g:bufferline_inactive_highlight  = 'StatusLineNC'
					let g:bufferline_solo_highlight		 = 0
					let g:bufferline_pathshorten		 = 0
				"Plug 'edkolev/tmuxline.vim'
				"Plug 'edkolev/promptline.vim'
			"COLORSCHEMES
				Plug 'flazz/vim-colorschemes'
				Plug 'rafi/awesome-vim-colorschemes'
				Plug 'chriskempson/base16-vim'
				Plug 'KeitaNakamura/neodark.vim'
					let g:neodark#use_256color		   = 1
					let g:neodark#solid_vertsplit	   = 1
					let g:neodark#background		   = '#202020'
					"let g:lightline					= {}
					"let g:lightline.colorscheme		= 'neodark'
					"let g:neodark#terminal_transparent = 1
				Plug 'sindresorhus/focus'
				Plug 'KabbAmine/yowish.vim'
				Plug 'ayu-theme/ayu-vim'
				Plug 'tyrannicaltoucan/vim-quantum'
				Plug 'raphamorim/lucario'
				Plug 'paranoida/vim-airlineish'
				Plug 'arzg/vim-corvine'
				"REFERENCE
					"TYPE:LIGHT
						"*SOLARIZED8-LIGHT*|CORVINE-LIGHT=1
						"XCODE=1
					"TYPE:DARK:HIGH
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
			"RANDOM
				Plug 'kyazdani42/nvim-web-devicons'
				Plug 'ryanoasis/vim-devicons'
				Plug 'mhinz/vim-startify'
					"CONFIGURATION
						let g:startify_change_to_vcs_root  = 1
							"let g:startify_change_to_dir = 0
						let g:startify_session_dir		   = g:jaat_vimfiles_path . 'vim-sessions'
						let g:startify_fortune_use_unicode = 1
						let g:startify_session_sort		   = 1
						let g:startify_custom_indices	   = []
							"let g:startify_custom_indices = map(range(1,100), 'string(v:val)')
						"let g:startify_custom_header		= ''
							"let g:startify_custom_header = 'startify#pad([string])'
							"let g:startify_custom_header = 'startify#center([string])'
							"let g:startify_custom_header = 'startify#fortune#quote()'
							"let g:startify_custom_header = 'startify#fortune#boxed()'
							"let g:startify_custom_header = 'startify#fortune#cowsay()'
					"AUTOCOMMANDS
						autocmd User StartifyReady setl foldlevel=99
				Plug 'itchyny/vim-highlighturl'
					"let g:highlighturl_ctermfg   = ''
					"let g:highlighturl_guifg	  = ''
					"let g:highlighturl_underline = 0
			"DISABLED
				"Plug 'haya14busa/vim-keeppad'
				"Plug 'zefei/vim-colortuner'
				"Plug 'Yggdroot/indentLine'
					"let g:indentLine_enabled = 1
					"let g:indentLine_setColors = 0
					"let g:indentLine_char_list = ['│', '|', '¦', '┆', '┊']
		"MANAGEMENT
		"PROGRAMMING
			"SYNTAX
				Plug 'sheerun/vim-polyglot'
				Plug 'chrisbra/csv.vim'
				Plug 'plasticboy/vim-markdown'
					let g:vim_markdown_no_default_key_mappings = 1
				"Plug 'vim-syntastic/syntastic'
				"Plug 'coachshea/jade-vim'
			"VCS
				Plug 'rhysd/git-messenger.vim'
					"CONFIGURATION
						let g:git_messenger_no_default_mappings = v:true
						let g:git_messenger_include_diff		= "none"
						let g:git_messenger_max_popup_width		= 200
						let g:git_messenger_max_popup_height	= 40
					"HIGHLIGHTS
					"MAPPINGS
						nmap <silent> <Leader>gm <Plug>(git-messenger)
			"LSP
				if has('node') && version >= 800
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
									\ 'coc-tslint',
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
									\ 'coc-pairs',
									\ 'coc-emmet',
									\ 'coc-tabnine',
									\ 'coc-syntax',
									\ 'coc-highlight',
									\ 'coc-restclient',
									\ 'coc-db',
									\ 'coc-zi',
								\]
							"RANDOM
								let g:coc_global_extensions += [
									\ 'coc-lists',
									\ 'coc-markmap',
									\ 'coc-leetcode',
									\ 'coc-template',
									\ 'coc-word',
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
							"COC-LIST
								nnoremap <silent><nowait> <Leader>lL  :<C-u>CocList<CR>
								nnoremap <silent><nowait> <Leader>ll  :<C-u>CocListResume<CR>
								nnoremap <silent><nowait> <Leader>le  :<C-u>CocList diagnostics<CR>
								nnoremap <silent><nowait> <Leader>lc  :<C-u>CocList commands<CR>
								nnoremap <silent><nowait> <Leader>lo  :<C-u>CocList outline<CR>
								nnoremap <silent><nowait> <Leader>ls  :<C-u>CocList -I symbols<CR>

								nnoremap <silent><nowait> <Leader>ln  :<C-u>CocNext<CR>
								nnoremap <silent><nowait> <Leader>lp  :<C-u>CocPrev<CR>
							"COC-GOTO
								nmap <silent> <Leader>lgd <Plug>(coc-definition)
								nmap <silent> <Leader>lgD <Plug>(coc-type-definition)
								nmap <silent> <Leader>lgi <Plug>(coc-implementation)
								nmap <silent> <Leader>lgr <Plug>(coc-references)
							"COC-DIAGNOSTICS
								nmap <silent> [e <Plug>(coc-diagnostic-prev)
								nmap <silent> ]e <Plug>(coc-diagnostic-next)
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
							"COC-ACTIONS
								"COC-FORMAT
									xmap <leader>lf  <Plug>(coc-format-selected)
									nmap <leader>lf  <Plug>(coc-format-selected)
									nmap <leader>lF  :COCFormat<CR>
								"MESS
									" Applying codeAction to the selected region.
									" Example: `<leader>aap` for current paragraph
									xmap <Leader>za  <Plug>(coc-codeaction-selected)
									nmap <Leader>za  <Plug>(coc-codeaction-selected)

									" Remap keys for applying codeAction to the current buffer.
									nmap <leader>lac  <Plug>(coc-codeaction)
									" Apply AutoFix to problem on the current line.
									nmap <leader>lq  <Plug>(coc-fix-current)
							"COC-COMPLETION
								if exists('*complete_info')
									inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
								else
									inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
								endif

								inoremap <silent><expr> <TAB>
									\ pumvisible() ? "\<C-n>" :
									\ <SID>checkBackspace() ? "\<TAB>" :
									\ coc#refresh()
								inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
									"Use tab for trigger completion with characters ahead and navigate.
									"NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
									"other plugin before putting this into your config.
								inoremap <silent><expr> <c-space> coc#refresh()
							"RANDOM
								nmap          <Leader>lr <Plug>(coc-rename)
								nmap <silent> <C-s>      <Plug>(coc-range-select)
								xmap <silent> <C-s>      <Plug>(coc-range-select)
				endif
				Plug 'liuchengxu/vista.vim'
					"CONFIGURATION
						let g:vista_default_executive = 'coc'
						let g:vista#renderer#enable_icon = 1
						let g:vista_sidebar_width = 45
						let g:vista_fzf_preview = ['right:50%']
						let g:vista_echo_cursor_strategy = 'echo'
					"MAPPINGS
						nnoremap <silent> <Leader>lt :Vista!!<CR>
						nnoremap <silent> <Leader>lT :Vista finder fzf<CR>
					"STATUSLINE
						function! NearestMethodOrFunction() abort
							return get(b:, 'vista_nearest_method_or_function', '')
						endfunction

						set statusline+=%{NearestMethodOrFunction()}
						autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
			"TREESITTER
			"DATABASE
				Plug 'tpope/vim-dadbod'
				Plug 'kristijanhusak/vim-dadbod-ui'
			"DEBUGGING
			"PLAYGROUND
				Plug 'metakirby5/codi.vim'
					let g:codi#width	  = 80
					let g:codi#rightalign = 0
					nmap <LocalLeader>ci :Codi!!<CR>
				Plug 'arkwright/vim-whiteboard'
					"CONFIGURATION
						let g:whiteboard_temp_directory = g:jaat_vimfiles_path . 'whiteboard'
						let g:whiteboard_interpreters = {
							\'python'	  : { 'extension': 'py'		,'command': 'python3'	},
							\'r'		  : { 'extension': 'r'		,'command': 'r'			},
							\'javascript' : { 'extension': 'js'		,'command': 'node'		},
							\'java'		  : { 'extension': 'java'	,'command': 'jshell'	},
							\'lua'		  : { 'extension': 'lua'	,'command': 'lua'		},
							\'php'		  : { 'extension': 'php'	,'command': 'php'		},
							\'ruby'		  : { 'extension': 'rb'		,'command': 'ruby'		},
							\'haskell'	  : { 'extension': 'hs'		,'command': 'ghci'		},
							\'scala'	  : { 'extension': 'scala'	,'command': 'scala'		},
							\'perl'		  : { 'extension': 'pl'		,'command': 'perl'		},
							\'go'		  : { 'extension': 'go'		,'command': 'gore'		},
							\'typescript' : { 'extension': 'ts'		,'command': 'ts-node'	},
							\'sh'		  : { 'extension': 'sh'		,'command': 'bash'		},
							\'bash'		  : { 'extension': 'bash'	,'command': 'bash'		},
							\'zsh'		  : { 'extension': 'zsh'	,'command': 'zsh'		},
							\'fish'		  : { 'extension': 'fsh'	,'command': 'fsh'		},
							\'pandoc'	  : { 'extension': 'pandoc' ,'command': 'pandoc'	},
							\'redis'	  : { 'extension': 'redis'	,'command': 'redis-cli' },
							\'mongo'	  : { 'extension': 'mongo'	,'command': 'mongo'		},
							\'mysql'	  : { 'extension': 'mysql'	,'command': 'mysql'		},
							\'sqlite'	  : { 'extension': 'sqlite'  ,'command': 'sqlite'	},
							\'dosbatch'   : { 'extension': 'cmd'	,'command': 'cmd'		},
							\'git'		  : { 'extension': 'git'	,'command': 'gitsome'	},
							\'lisp'		  : { 'extension': 'lisp'	,'command': 'sbcl'	   }}
					"MAPPINGS
						nnoremap <LocalLeader>cs :execute "Whiteboard "  . &filetype<CR>
						nnoremap <LocalLeader>cS :execute "Whiteboard! " . &filetype<CR>
			"RANDOM
				Plug 'mattn/emmet-vim'
					let g:user_emmet_install_global = 0
					let g:user_emmet_leader_key='<TAB>'
					autocmd FileType html,css,jsx,js,ts,tsx EmmetInstall
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
								\ }
						let g:mkdp_markdown_css = ''
						let g:mkdp_highlight_css = ''
						let g:mkdp_port = ''
						let g:mkdp_page_title = '?${name}?'
						let g:mkdp_filetypes = ['markdown']
				else
					"install instant-markdown-d usig NPM
					Plug 'suan/vim-instant-markdown'
				endif
			"DOCUMENTATION
		"EXTENSIONS
			Plug 'tpope/vim-repeat'
			Plug 'tpope/vim-capslock'
				nmap <silent> <LocalLeader><LocalLeader> <Plug>CapsLockToggle
				imap ;; <Plug>CapsLockToggle
			Plug 'liuchengxu/vim-which-key'
				"CONFIGURATION
					let g:which_key_sep				   = '→'
					let g:which_key_hspace			   = 5
					let g:which_key_flatten			   = 1
					let g:which_key_max_size		   = 0
					let g:which_key_sort_horizontal    = 0
					let g:which_key_vertical		   = 0
					let g:which_key_use_floating_win   = 0
					let g:which_key_align_by_seperator = 1
					let g:which_key_display_names	   = {
						\' '	 : 'SPC',
						\'<C-H>' : 'BS'
					\}
					let g:which_key_map				   = {}

					"hiding statusline
					autocmd! FileType which_key
					autocmd  FileType which_key set laststatus=0 noshowmode noruler
						\| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

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
						\'name' : 'which_key_ignore',
					\}
					let g:which_key_map['b'] = {
						\'name' : '+buffers',
						\'l'	: 'list-buffers',
						\'a'	: 'add-buffer',
						\'c'	: 'close-buffer',
						\'d'	: 'delete-buffer',
						\'D'	: 'DELETE-buffer',
						\'w'	: 'WRITE-buffer',
						\'s'	: 'scratch-buffer',
						\'S'	: 'scratch-buffer-filetype',
						\'/'	: 'buffer-lines',
						\'?'	: 'all-buffer-lines',
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
						\'name' : 'which_key_ignore',
					\}
					let g:which_key_map['g'] = {
						\'name' : '+git',
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
						\'g': {
							\'name': '+goto',
							\'d': 'goto-definition',
							\'D': 'goto-type-definition',
							\'i': 'goto-implementation',
							\'r': 'goto-references',
						\},
						\'c': 'show-commands',
						\'e': 'show-errors',
						\'s': 'show-symbols',
						\'o': 'show-outline',
						\'r': 'rename-symbol',
						\'f': 'format-selected',
						\'F': 'format-buffer',
						\'q': 'quickfix',
						\'l': 'coc-list',
						\'L': 'coc-list-resume',
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
						\'l'	: '-list-projects',
						\'n'	: '-new-project',
						\'o'	: 'open-project',
						\'O'	: '-open-last-project',
						\'c'	: '-close-project',
						\'f'	: 'open-project-file',
						\'t'	: 'search-project',
						\'e'	: 'open-project-directory',
						\'E'	: 'open-file-directory',
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
						\'l'	: 'list-terminals',
						\'b'	: 'buffer-terminal',
						\'f'	: 'float-terminal',
						\'v'	: 'vertical-terminal',
						\'h'	: 'horizontal-terminal',
						\'t'	: 'toggle-terminal',
						\'d'	: 'delete-terminal',
						\'n'	: 'next-terminal',
						\'p'	: 'previous-terminal',
						\'B'	: 'buffer-terminal-lcd',
						\'F'	: '-float-terminal-lcd',
						\'V'	: 'vertical-terminal-lcd',
						\'H'	: 'horizontal-terminal-lcd',
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
						\'c' : 'open-config-file',
						\'s' : 'source-config-file',
						\'C' : 'set-colorscheme',
						\'/' : 'search-history',
						\':' : 'command-history',
						\'h' : {
							\'name' : '+help',
							\'c'	: 'commands',
							\'h'	: 'help',
							\'m'	: 'maps',
						\},
						\'p' : {
							\'name' : '+plugin-manager',
							\'l'	: 'list-plugins',
							\'a'	: 'install-plugins',
							\'d'	: 'uninstall-plugins',
							\'u'	: 'update-plugins',
							\'U'	: 'update-plugin',
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
				"MAPPINGS
					nnoremap <silent> <Leader>		:<C-U>WhichKey		 '<SPACE>' <CR>
					vnoremap <silent> <Leader>		:<C-U>WhichKeyVisual '<SPACE>' <CR>
					nnoremap <silent> <LocalLeader> :<C-U>WhichKey		 ','	   <CR>
			Plug 'szw/vim-maximizer'
				nnoremap <silent> <Leader>wm :MaximizerToggle<CR>
			Plug 'junegunn/vim-peekaboo'
				let g:peekaboo_window  = 'vert bo 80new'
				let g:peekaboo_prefix  = '<Leader>'
			if has('folding')
				Plug 'pseewald/vim-anyfold'
					let g:anyfold_motion			= 0
					let g:anyfold_fold_comments		= 0
					let g:anyfold_identify_comments = 0
					let g:anyfold_comments			= []
					autocmd FileType * AnyFoldActivate

					"WONT WORK BY DEFAULT
						"to make these work, use lines below in anyfold.vim
						"let foldSizeStr = " " . foldSize . g:anyfold_fold_size_str
						"let foldLevelStr = repeat(g:anyfold_fold_level_str, v:foldlevel)
					let g:anyfold_fold_size_str  = ' Lines '
					let g:anyfold_fold_level_str = ''
				Plug 'arecarn/vim-fold-cycle'
					let g:fold_cycle_default_mapping = 0
					nmap <TAB>	 <Plug>(fold-cycle-open)
					nmap <S-TAB> <Plug>(fold-cycle-close)
			endif
			if has('signs')
				Plug 'kshenoy/vim-signature'
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
			Plug 'mtth/scratch.vim'
				let g:scratch_no_mappings	   = 1
				let g:scratch_height		   = 0.3
				let g:scratch_top			   = 0
				let g:scratch_persistence_file = g:jaat_vimfiles_path . 'temp.scratch'

				nnoremap <silent> <Leader>so :Scratch<CR>
				nnoremap <silent> <Leader>sp :ScratchPreview<CR>
				vnoremap <silent> <Leader>ss :ScratchSelection<CR>

				augroup SCRATCH_ENTER
					autocmd!
					autocmd FileType scratch nnoremap <buffer> <esc> :q<CR>
					autocmd FileType scratch set syntax=jproperties
				augroup END
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
		"DEPENDENCIES
			Plug 'Shougo/vimproc.vim'
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
		"TODO:DEVELOPMENT
			"VCS
				"Plug 'tpope/vim-fugutive'
					nnoremap <Leader>gc :Commits<CR>
					nnoremap <Leader>gC :BCommits<CR>
					nnoremap <Leader>gf :GFiles<CR>
					nnoremap <Leader>gF :GFiles?<CR>

					nnoremap <Leader>gb :Gbrowser<CR>
				"Plug 'airblade/vim-gitgutter'
				"Plug 'mhinz/vim-signify'
			"SNIPPETS
				Plug 'honza/vim-snippets'
				if has('python3')
					"Plug 'SirVer/ultisnips'
						"let g:UltiSnipsExpandTrigger="<CR>"
						let g:UltiSnipsJumpForwardTrigger="<C-b>"
						let g:UltiSnipsJumpBackwardTrigger="<C-z>"
				endif
			"AUTO-COMPLETION
				if has('macunix') && has('python3')
					"Plug 'Valloric/YouCompleteMe'
						"CONFIGURATION
							let g:ycm_python_binary_path = 'python3'
							let g:ycm_add_preview_to_completeopt = 0

							"let g:ycm_key_list_select_completion = ['<SPACE>', '<Down>']
							"let g:ycm_key_list_previous_completion = ['<S-SPACE>', '<Up>']
							"let g:ycm_key_list_stop_completion = ['<CR>']

							"let g:ycm_autoclose_preview_window_after_completion = 1
							"let g:ycm_autoclose_preview_window_after_insertion = 1
						"MAPPINGS
							nnoremap <Leader>jd :YcmCompleter GoToDeclaration<CR>
							nnoremap <Leader>jD :YcmCompleter GoToDefinition<CR>
							nnoremap <Leader>jj :YcmCompleter GoTo<CR>
							nnoremap <Leader>ji :YcmCompleter GoToImplementation<CR>
				endif
			"COMMENTS
				Plug 'scrooloose/nerdcommenter'
				"Plug 'tpope/vim-commentary'
				Plug 'manasthakur/vim-commentor'
					nmap gk  <Plug>Commentor
					xmap gk  <Plug>Commentor
					nmap gkk <Plug>CommentorLine
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
			"Plug 'joeytwiddle/sexy_scroller.vim'
				let g:SexyScoller_ScrollTime = 10
				let g:SexyScroller_CursorTime = 5
				let g:SexyScroller_MaxTime = 200
				let g:SexyScroller_EasingStyle = 1
			"Plug 'terryma/vim-smooth-scroll'
			"Plug 'jiangmiao/auto-pairs'
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
			Plug 'tweekmonster/startuptime.vim'
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
			Plug 'rhysd/conflict-marker.vim'
			"Plug 'camspiers/animate.vim'
				""CONFIGURATION
					"let g:fzf_layout = {'window': 'new | wincmd J | resize 1 | call animate#window_percent_height(0.5)'}
				""MAPPINGS
					"nnoremap <silent> <up>    :call animate#window_delta_height(10)<CR>
					"nnoremap <silent> <down>  :call animate#window_delta_height(-10)<CR>
					"nnoremap <silent> <left>  :call animate#window_delta_width(10)<CR>
					"nnoremap <silent> <right> :call animate#window_delta_width(-10)<CR>
			"Plug 'camspiers/lens.vim'
				let g:lens#animate = 1
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
			"Plug 'majutsushi/tagbar'
				nnoremap <Leader>nT :TagbarToggle<CR>
			"Plug 'andymass/vim-matchup'
			"Plug 'romainl/vim-qf'
			"Plug 'tpope/vim-obsession'
			"Plug 'syngan/vim-operator-keeppos'
			"Plug 'blackbeltscripting/vim-paste-operator'
			"Plug 'tommcdo/vim-centaur'
			"Plug 'osyo-manga/vim-operator-blockwise'
			"Plug 'osyo-manga/vim-operator-stay-cursor'
			"Plug 'syngan/vim-operator-furround'
			"Plug 'luochen1990/rainbow'
			"Plug 'thinca/vim-operator-sequence'
			"Plug 'wellle/visual-split.vim'
			"Plug 'spiiph/vim-space'
			"Plug 'gcmt/wildfire.vim'
			"Plug 'lambacck/preserve-vim'
			"Plug 'mbbill/undotree'
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
			Plug 'liuchengxu/vim-clap'
			"Plug 'liuchengxu/vista.vim'
			Plug 'ap/vim-css-color'
			Plug 'tommcdo/vim-ninja-feet'
			"Plug 'RRethy/vim-illuminate'
				"CONFIGURATION
					let g:Illuminate_delay = 0
					"TODO:FIX hi illuminatedWord ctermfg=grey ctermbg=darkblue
			"Plug 'itchyny/vim-cursorword'
			"Plug 'lucerion/vim-executor'
			"Plug 'vim-scripts/Omap.vim'
			"Plug 'tyru/capture.vim'
			"Plug 'JarrodCTaylor/vim-shell-executor'
			"Plug 'tommcdo/vim-express'
			"Plug 'syngan/vim-operator-evalf'
			"Plug 'neitanod/vim-sade'
	call plug#end()

	"post-loading…
	call which_key#register('<SPACE>', "g:which_key_map")
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
		"Inconsolata
		"OperatorMono?
	"FOLDING
		if has('folding')
			set foldlevel=0
			set foldignore=
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
		set nobackup
		set nowritebackup
		set directory=~/.config/nvim/temp
		"if has('persistent_undo')
			"TODO:FIX
			"let myUndoDir = expand(vimDir . '/undodir')
			"call system('mkdir ' . vimDir)
			"call system('mkdir ' . myUndoDir)
			"let &undodir = myUndoDir
			"set undofile
		"endif
	"SEARCH
		set hls
		set incsearch
		set ignorecase
		set smartcase
		set gdefault
	"FILE-SEARCH
		set path+=**
			"using ":find" to find files recursively in current "cd", by using patterns
		if has('wildmenu')
			set wildmenu
			set wildmode=longest:full,full
			set wildignore+=*.a,*.o
			set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
			set wildignore+=.DS_Store,.git,.hg,.svn
			set wildignore+=*~,*.swp,*.tmp
			set wildignorecase
		endif
	"COMMANDS
		set ttimeout
		set ttimeoutlen=100
		set timeoutlen=500
	"COMMANDLINE
		set cmdheight=1
		set cmdwinheight=10
	"INTERFACE
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
				colorscheme molokai
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
		set updatetime=300
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
				colorscheme xcode
				set laststatus=0
				"not-working because of autocmd
				set showmode
			"PLUGINS
				let g:startify_disable_at_vimenter = 0
		endif
"TEMPORARY
	if IsWindows()
		execute 'tnoremap <silent> ' . g:terminal_leader . 'ns npm start<CR>'
	endif
"EXPERIMENT
	"FEATURES
		"+VIMDIFF
		"+CONCEAL
		"+PREVIEW=pedit|ptag…
	"DEFAULTS.vim
