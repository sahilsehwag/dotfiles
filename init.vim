"LEADER
	let mapleader		= " "
	let maplocalleader	= ","
	let mapinsertleader = ";"
"VIMSCRIPT
	"HELPERS
		"VIM
			"FILESYSTEM
				"FUNCTIONS
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
					command! -nargs=1 -bang SaveAs	: call SaveAs  (<q-args>, <bang>0)
					command! -nargs=1 -bang Read	: call Read    (<q-args>, <bang>0)
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

				function! IsLinuxy()
					return has('unix') || has('macunix') || has('linux') || has('win32unix')
				endfunction

				function! IsWindows()
					return has('win32') || has('windows')
				endfunction
			"DYNAMIC
				function! DefineMap(type, map, action)
					execute a:type . ' ' . a:map . ' ' . a:action
				endfunction

				function! DefineAbbreviation(source, target)
					execute 'iabbrev' . ' ' . a:source . ' ' . a:target
				endfunction
			"MISCELLANOUS
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
				"TODO:BETTER-OVERRIDES
					"LEVEL=1
					"LEVEL=2
					"LEVEL=3
				"BETTER-DELETE
					let g:better_delete_enable_default_mappings = 1
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
				"TODO:BETTER-YANK
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
				"TODO:BETTER-o|O
					"nnoremap <CR> :normal! o<ESC>k^0<CR> @TODO
					"nnoremap <SHIFT><CR> :normal! O<ESC>j^0<CR> @TODO
				"TODO:BETTER-VISUAL
					"OBJECTS:PRESERVE-POSITION
				"TODO:BETTER-NAVIGATION
					let g:better_navigation_enable_default_mappings = 1
					if ExistsAndTrue('g:better_vim_enable_default_mappings') && ExistsAndTrue('g:better_navigation_enable_default_mappings')
						nnoremap 0 ^
						nnoremap ^ 0
					endif
				"TODO:BETTER-BUILD
					"BETTER-MAKE
						"VARIABLES
							let g:better_make_enable_default_mappings = 1
						"GROUP
							augroup MAKE
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
						"DEFAULTS
							if ExistsAndTrue('g:better_vim_enable_default_mappings') && ExistsAndTrue('g:better_make_enable_default_mappings')
								nnoremap <LocalLeader>cm :make<CR>
							endif
					"TODO:BETTER-QUICKFIX
				"TODO:BETTER-FOLDS
					"VARIABLES
						let g:better_folds_enable_default_mappings = 1
					"HIGHLIGHTS
						"highlight Folded cterm=NONE
				"TODO:BETTER-BTW
					"VARIABLES
						let g:better_btw_enable_default_mappings = 1
					"BUFFER
					"TAB
					"WINDOW
						"TODO:FEATURE:TOGGLE-MAXIMIZE
				"TODO:BETTER-TAGS
					"TODO:EXECTUABLE
						"TODO:CREATION
						"TODO:UPDATION
					"TODO:NAVIGATION
						"TODO:JUMP
						"TODO:NEXT|PREVIOUS|ROOT
				"TODO:BETTER-JUMPS
					"TODO:BETTER-MARKS
					"TODO:BETTER-JUMPLIST
					"TODO:BETTER-CHANGELIST
				"TODO:BETTER-COMPLETE
				"TODO:BETTER-UNDO
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
				"BETTER-SEARCH
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
				"TODO:BETTER-HELP
					if has('nvim')
						function! FloatingWindowHelp(query) abort
							let s:float_buffer = CreateCenteredFloatingWindow()
							call nvim_set_current_buf(l:buf)
							setlocal filetype=help
							setlocal buftype=help
							execute 'help ' . a:query
						endfunction

						command! -complete=help -nargs=? Help call FloatingWindowHelp(<q-args>)
					endif
				"BETTER-INDENT
				"TODO:BETTER-CURSOR
					"FEATURE:PRESERVE-POSITION
			"TODO:MODALING
				"TODO:MODE
					"USE:RESET…|RESTRICTION+REPURPOSE
					"TODO:MODE-VIMLINE
					"TODO:MODE-JUMPER
				"TODO:STATE
					"USE:INTERACTIVE
					"=<Leader><namespace>.
				"TODO:MODIFIER
					"USE:REPETITIVE
					"=ALT
				"TODO:PERSISTENT…?
			"TODO:KEYPR
			"TODO:INTERCEPT+HIGHLIGHT
			"MANAGEMENT
				"TODO:BTW
				"TODO:SESSION
				"TODO:REGISTRATION
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
			"MISCELLANOUS
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
								nnoremap <Leader>vw :call AutoSaveToggle()<CR>
							endif
				"TODO:SOURCERER
					"augroup SOURCERER
						"au!
						"au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,init.vim so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
					"augroup END
				"TODO:BLOCK|FILE-ZOOM
					"TODO:ZOOM-MODE
		"SYSTEM
			"TERMINAL
				if has('nvim')
					"VARIABLES
						let g:terminal_enable_default_mappings = 1
						let g:terminal_program =
							\ IsWindows()
							\ ? "cmd"
							\ : "bash"
					"FUNCTIONS
						function! Terminal(count, dir, pos, bang, cmd)
							if a:count == 0
								execute a:dir a:pos
							else
								execute a:dir . ' ' . a:count a:pos
							endif

							setl modifiable

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

							call DefineMap('nnoremap', '<Leader>te', ':Term '		. g:terminal_program . '<CR>')
							call DefineMap('nnoremap', '<Leader>tv', ':VRTerm '	. g:terminal_program . '<CR>')
							call DefineMap('nnoremap', '<Leader>th', ':15HBTerm ' . g:terminal_program . '<CR>')

							call DefineMap('nnoremap', '<Leader>tE', ':lcd %:p:h \| Term '	 . g:terminal_program . '<CR>')
							call DefineMap('nnoremap', '<Leader>tV', ':lcd %:p:h \| VRTerm '	 . g:terminal_program . '<CR>')
							call DefineMap('nnoremap', '<Leader>tH', ':lcd %:p:h \| 15HBTerm ' . g:terminal_program . '<CR>')
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
							nnoremap <Leader>nv :Vifm %:p:h<CR>
						endif
				endif
			"FZF
				"FZF-EXTENSIONS
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
								let s:float_buffer = nvim_create_buf(v:false, v:true)
								call nvim_buf_set_lines(s:float_buffer, 0, -1, v:true, lines)
								call nvim_open_win(s:float_buffer, v:true, opts)
								set winhl=Normal:Floating
								let opts.row += 1
								let opts.height -= 2
								let opts.col += 2
								let opts.width -= 4
								call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
								au BufWipeout <buffer> exe 'bw ' . s:float_buffer
							endfunction

							let g:fzf_layout = {'window': 'call CreateCenteredFloatingWindow()'}
						endif
					"TODO:FZF-FILESYSTEM
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
			"TODO:LINUX
				"VARIABLES
					let g:linuxing_enable_default_mappings = 1
				"DEFAULTS
					if ExistsAndTrue('g:linuxing_enable_default_mappings')
						vnoremap <Leader>lus :sort						   <CR>
						vnoremap <Leader>luu :<C-u>'<,'>sort \| '<,'>!uniq <CR>
						vnoremap <Leader>luc :<C-u>'<,'>!bc				   <CR>
					endif
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

					nnoremap <silent> gbb :execute 'OpenBrowserSmartSearch ' . getline('.')<CR>
					vnoremap <silent> gbb :<C-U>execute 'OpenBrowserSmartSearch ' . getline('.')<CR>
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

					nnoremap <silent> g; :set opfunc=OperatorExRange<CR>g@
					vnoremap <silent> g; :<C-U>call OperatorExRange(visualmode())<CR>

					nnoremap <silent> g;; :execute getline('.')<CR>
					vnoremap <silent> g;; :<C-U>execute getline('.')<CR>
			"OBJECT
				"CHAR-OBJECTS
					"TODO:OBJECT-SUBWORD
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
					"OBJECT-ENTIRE
						vnoremap ie :<C-u>normal! ggVG<CR>
						onoremap ie :<C-u>normal! ggVG<CR>
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
			"MISCELLEANOUS
				"TODO:MOVEE
					"TODO:SUBMODE
					"TODO:COUNT
					nnoremap <A-j> :move .+1<CR>==
					nnoremap <A-k> :move .-2<CR>==
					inoremap <A-j> <Esc>:move .+1<CR>==gi
					inoremap <A-k> <Esc>:move .-2<CR>==gi
					vnoremap <A-j> :move '>+1<CR>gv=gv
					vnoremap <A-k> :move '<-2<CR>gv=gv
		"PROGRAMMING
			"EXECUTIONER
				let g:executioner_enabled = 1
				if ExistsAndTrue(g:executioner_enabled)
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
									let g:languages.typescript = {
										\'extension' : 'ts',
										\'repl'		 : 'ts-node',
										\'execute'	 : 'tsc %:p:S',
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
										\'extension'	   : 'c',
										\'repl'			   : 'cling',
										\'compile'		   : 'gcc %:p:S -o %:p:r:S.out',
										\'execute'		   : '%:p:r:S.out',
										\'compile-execute' : 'gcc %:p:S -o %:p:r:S.out && %:p:r:S.out',
										\'init'		 : [
												\'#include <stdio.h>',
												\'#include <math.h>',
										\],
									\}
									let g:languages.cpp = {
										\'extension'	   : 'cpp',
										\'repl'			   : 'cling',
										\'compile'		   : 'g++ -std=c++14 %:p:S -o %:p:r:S.out',
										\'execute'		   : '%:p:r:S.out',
										\'compile-execute' : 'g++ -std=c++14 %:p:S -o %:p:r:S.out && %:p:r:S.out',
										\'init'			   : [
											\'#include <iostream>',
											\'#include <string>',
											\'using namespace std;',
										\],
									\}
									let g:languages.cs = {
										\'extension'	   : 'cs',
										\'repl'			   : 'csharp',
										\'compile'		   : 'csc %:p:s',
										\'execute'		   : 'mono %:p:r:s.exe',
										\'compile-execute' : 'csc %:p:s && mono %:p:r:s.exe',
									\}
									let g:languages.csx = {
										\'extension' : 'csx',
										\'repl'		 : 'scriptcs',
										\'execute'	 : 'scriptcs %:p:r:S.csx',
									\}
									let g:languages.java = {
										\'extension'	   : 'java',
										\'repl'			   : 'jshell',
										\'compile'		   : 'javac %:p:S',
										\'execute'		   : 'java %:p:r:S',
										\'compile-execute' : 'javac %:p:S && java %:p:r:S',
									\}
									let g:languages.scala = {
										\'extension'	   : 'scala',
										\'repl'			   : 'scala',
										\'compile'		   : 'scalac %:p:S',
										\'execute'		   : 'scala %:p:r:S',
										\'compile-execute' : 'scalac %:p:S && scala %:p:r:S',
									\}
									let g:languages.haskell = {
										\'extension'	   : 'hs',
										\'repl'			   : 'ghci',
										\'compile'		   : 'ghc -Wno-tabs %:p:S',
										\'execute'		   : '%:p:r:S',
										\'compile-execute' : 'ghc -Wno-tabs %:p:S && %:p:r:S',
									\}
									let g:languages.processing = {
										\'extension'	   : 'pde',
										\'compile'		   : 'processing-java --output=/tmp/processing/ --force --sketch=%:p:h:S --build',
										\'execute'		   : 'processing-java --output=/tmp/processing/ --force --sketch=%:p:h:S --run',
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
								function! ExecutionerCommand(type, ...)
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
						command! -narg=? ExecutionerREPL   :execute 'VRTerm '	 . ExecutionerCommand('repl', <q-args>) | :call ExecutionerInitREPL()
						command! ExecutionerCompile		   :execute '10HBTerm '  . ExecutionerCommand('compile')
						command! ExecutionerExecute		   :execute '20HBTerm! ' . ExecutionerCommand('execute')
						command! ExecutionerCompileExecute :execute '20HBTerm! ' . ExecutionerCommand('compile-execute')
					"MAPPINGS
						nmap <silent> <Plug>(executioner-repl)			  :ExecutionerREPL<CR>
						nmap <silent> <Plug>(executioner-compile)		  :ExecutionerCompile<CR>
						nmap <silent> <Plug>(executioner-execute)		  :ExecutionerExecute<CR>
						nmap <silent> <Plug>(executioner-compile-execute) :ExecutionerCompileExecute<CR>
						nmap <silent> <Plug>(executioner-fzf-repl)		  :call fzf#run(fzf#wrap({'source': getcompletion('', 'filetype'), 'sink': 'ExecutionerREPL'}))<CR>
					"DEFAULTS
						if ExistsAndTrue('g:executioner_enable_default_mappings')
							nmap <LocalLeader>cr <Plug>(ee-repl)
							nmap <LocalLeader>cb <Plug>(ee-compile)
							nmap <LocalLeader>ce <Plug>(ee-execute)

							nmap <LocalLeader>cR <Plug>(ee-fzf-repl)
							nmap <LocalLeader>cq <Plug>(ee-compile-execute)
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
				"FEATURE:ROOT
				"FEATURE:AUTO-COMPLETION
				"FEATURE:TAGS
				"FEATURE:JUMPS
				"FEATURE:REFACTOR
				"FEATURE:PERSISTENCE
			"TODO:PACKMAN
			"TODO:FRAMEWORKS
		"LIBRARIES
			"TODO:LOGGER
			"TODO:ECHOES
				function! PEchoError(msg)
					echohl ErrorMsg
					echomsg a:msg
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
			"TODO:ANSWER-ME-GODDAMN-IT
				function! Prompt(msg)
				endfunction
			"TODO:OUTPUT
			"TODO:TUNER
		"MISCELLANOUS
			"SYMBOLIC
				"VARIABLES
					let g:symbolic_leader =
						\ exists('g:mapinsertleader')
						\ ? g:mapinsertleader
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
				"TODO:SCRATCH
			"TODO:COLORTUNER
				"FEATURE:INTERFACE
				"FEATURE:SYNTAX
				"FEATURE:HIGHLIGHT
				"FEATURE:COLORWHEEL
			"TODO:WRAPIT.vim
	"MISCELLANOUS
		"TODO:I-KNOW-VIM
			"MODES
"PYTHON
	"PLUGINS
"COMMANDS
	command! -nargs=* Wrap set wrap linebreak nolist
"CONFIGURATION
	"VARIABLES
		"PERFORMANCE
			let loaded_netrwPlugin = 0
		"INTERFACE
			let g:jaat_highlight_search = 1
	"PYTHON-BINARIES
		let g:loaded_python_provider  = 0
		let g:loaded_python3_provider = 1

		if IsLinuxy()
			let g:python_host_prog	= 'python'
			let g:python3_host_prog = 'python3'
		elseif IsWindows()
			"TODO:FIX
			let g:python_host_prog	= "C:/Users/138100/scoop/apps/anaconda3/current/envs/pynvim2/python.exe"
			"let g:python3_host_prog = "C:/Users/138100/scoop/apps/anaconda3/current/envs/pynvim/python.exe"
			let g:python3_host_prog = "C:/Users/138100/scoop/apps/anaconda3/current/python.EXE"
		endif
	"MSWIN
		if has("win32")
			nnoremap <Leader>mm :source $VIMRUNTIME/mswin.vim<CR>
		endif
	"HIGHLIGHTS
		"SEARCH-HIGHLIGHTS
			if ExistsAndTrue('g:jaat_highlight_search')
				highlight Search ctermfg=49 cterm=NONE gui=NONE
				highlight IncSearchMatch ctermfg=black ctermbg=186
			endif
		"AUTO-COMPLETION-MENU
			"highlight Pmenu ctermbg=232 ctermfg=7
			"highlight PmenuSel ctermfg=15
			highlight Pmenu ctermbg=238 gui=bold
		"INTERFACE-HIGHLIGHTS
			highlight VertSplit ctermbg=None guibg=None
"MAPPINGS
	"MAIN-LAYOUT
		nnoremap ; :
		nnoremap U <C-R>
	"SOURCE
		if IsLinuxy() && has('nvim')
			nnoremap <Leader>vc :edit ~/.config/nvim/init.vim<CR>
			nnoremap <Leader>vs :source ~/.config/nvim/init.vim<CR>
		elseif IsWindows() && has('nvim')
			nnoremap <Leader>vc :edit ~/AppData/Local/nvim/init.vim<CR>
			nnoremap <Leader>vs :source ~/AppData/Local/nvim/init.vim<CR>
		endif
	"INTERFACE
		"TABS
			nnoremap <LEADER>ta :tabnew<CR>
			nnoremap <LEADER>tc :tabclose<CR>
			nnoremap <LEADER>tn :tabnext<CR>
			nnoremap <LEADER>tp :tabprevious<CR>
			nnoremap <LEADER>tj :tabmove -<CR>
			nnoremap <LEADER>tk :tabmove +<CR>
		"BUFFERS
			nnoremap H			 :bprevious<CR>
			nnoremap L			 :bnext<CR>
			nnoremap <Leader>bn  :enew<CR>
			nnoremap <Leader>ba  :badd<space>
			nnoremap <Leader>bd  :bdelete<CR>
			nnoremap <Leader>bfd :bdelete!<CR>
			nnoremap <Leader>bl  :bnext<CR>
			nnoremap <Leader>bh  :bprevious<CR>
			nnoremap <Leader>br  :e<CR>
			nnoremap <Leader>bfr :e!<CR>
			nnoremap <Leader>bv  :view<CR>
			nnoremap <Leader>bfv :view!<CR>
			nnoremap <Leader>bw  :write<CR>
			nnoremap <Leader>bfw :write!<CR>
			nnoremap <Leader>bc  :bp<bar>sp<bar>bn<bar>bd<CR>
			nnoremap <Leader>bt  :call ScratchBuffer('e')<CR>
			nnoremap <Leader>bT  :call ScratchBuffer('e', 1)<CR>
		"WINDOWS
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
		"TERMINAL
			if has('nvim')
				tnoremap <C-SPACE> <C-\><C-n>
			endif
		"COMMANDLINE
	"PLUGINS
		nnoremap <Leader>vi :PlugInstall<CR>
		nnoremap <Leader>vu :PlugClean<CR>
	"MISCELLANOUS
		nnoremap <Leader>vv :nohl<CR>
		"REGISTERS TODO:MOVE
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
		"LINUX-MAPPINGS TODO:MOVE
			"FILESYSTEM
				nnoremap <silent> <Leader>ld :execute "DeleteFile " . fnamescape(expand('%'))<CR>
	"MESS
		"QUICK EXIT MAPPINGS
		"REPEAT LAST OPERATION ON A MATCH ON NEXT n MATCH
			"nnoremap Q :normal n.<CR>
			"nnoremap Q @='n.'<CR>
"FILETYPE
	"TEXT
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
				"MISCELLANOUS
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
	"PROGRAMMING
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
		Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
			"CONFIGURATION
				let g:fzf_action = {
					\ 'ctrl-t': 'tab split',
					\ 'ctrl-h': 'split',
					\ 'ctrl-v': 'vsplit',
					\ 'ctrl-a': 'badd',
					\ 'ctrl-r': 'Read',
					\ 'ctrl-p': 'view',
					\ }
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

				autocmd! FileType fzf
				autocmd  FileType fzf set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler
			"TODO:FUNCTIONS
			"TODO:COMMANDS
			"MAPPINGS
				"SINK:BUFFER
				"SINK:INTERNAL
					if IsLinuxy()
						nnoremap <Leader>nf  :call fzf#run(fzf#wrap({'source': 'find ~/Google\ Drive -type d', 'sink': 'Vifm' }))<CR>
						nnoremap <Leader>nF  :call fzf#run(fzf#wrap({'source': 'find ~				 -type d', 'sink': 'Vifm' }))<CR>
					endif
				"SINK:EXTERNAL
					"FILESYSTEM
						if IsLinuxy()
							nnoremap <Leader>nw  :call fzf#run(fzf#wrap({'source': 'find ~ -type d' , 'sink': 'SaveAs'			 }))<CR>
							nnoremap <Leader>nW  :call fzf#run(fzf#wrap({'source': 'find ~ -type d' , 'sink': 'SaveAs!'			 }))<CR>
							nnoremap <Leader>lnf :call fzf#run(fzf#wrap({'source': 'find ~ -type d' , 'sink': 'NewFile'			 }))<CR>
							nnoremap <Leader>lnd :call fzf#run(fzf#wrap({'source': 'find ~ -type d' , 'sink': 'NewDirectory'	 }))<CR>
							nnoremap <Leader>ldf :call fzf#run(fzf#wrap({'source': 'find ~ -type f' , 'sink': 'DeleteFile'		 }))<CR>
							nnoremap <Leader>ldd :call fzf#run(fzf#wrap({'source': 'find ~ -type d' , 'sink': 'DeleteDirectory'  }))<CR>
							nnoremap <Leader>ldD :call fzf#run(fzf#wrap({'source': 'find ~ -type d' , 'sink': 'DeleteDirectory!' }))<CR>

							nnoremap <Leader>nr  :call fzf#run(fzf#wrap({'source': 'ag --hidden --ignore .git -g "" ~' , 'sink': 'Read!' }))<CR>
						endif
			"EXTENSIONS
				Plug 'junegunn/fzf.vim'
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
							nnoremap <Leader>nd :Files ~/Google Drive<CR>
							nnoremap <Leader>nu :Files ~<CR>
						"MAPPINGS
							nmap <Leader><tab>	 <plug>(fzf-maps-n)
							xmap <Leader><tab>	 <plug>(fzf-maps-x)
							omap <Leader><tab>	 <plug>(fzf-maps-o)
							imap ;<tab>			 <plug>(fzf-maps-i)
						"COMPLETION
							imap		;w <plug>(fzf-complete-word)
							imap		;p <plug>(fzf-complete-path)
							imap		;f <plug>(fzf-complete-file-ag)
							imap		;l <plug>(fzf-complete-line)
							imap		;L <plug>(fzf-complete-buffer-line)
							imap <expr> ;cp fzf#complete('find ~/Google\ Drive')
							imap <expr> ;cf fzf#complete('find ~/Google\ Drive -type f')
							imap <expr> ;cd fzf#complete('find ~/Google\ Drive -type d')
				Plug 'pbogut/fzf-mru.vim'
					map M :<C-u>FZFMru<CR>
				Plug 'dominickng/fzf-session.vim'
					let g:fzf_session_path = '~/.vim-sessions'
					nnoremap <Leader>sl :Sessions<CR>
					nnoremap <Leader>sn :Session<space>
					nnoremap <Leader>sd :SDelete<space>
					nnoremap <Leader>so :SLoad<space>
					nnoremap <Leader>sc :SQuit<CR>
				if has('nvim')
					Plug 'yuki-ycino/fzf-preview.vim'
				endif
		Plug 'easymotion/vim-easymotion'
			"CONFIGURATION
				nmap <Leader>j <Plug>(easymotion-prefix)
				let g:EasyMotion_smartcase		  = 1
				let g:EasyMotion_use_upper		  = 0
				let g:EasyMotion_enter_jump_first = 1
				let g:EasyMotion_space_jump_first = 1
				"let g:EasyMotion_keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;'
				"hi link EasyMotionTarget Search
			"MAPPINGS
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
					omap <Leader>w <Plug>(easymotion-bd-w)
					omap <Leader>W <Plug>(easymotion-bd-W)
					omap <Leader>e <Plug>(easymotion-bd-e)
					omap <Leader>E <Plug>(easymotion-bd-E)
					omap <Leader>l <Plug>(easymotion-bd-jk)
					omap <Leader>j <Plug>(easymotion-j)
					omap <Leader>k <Plug>(easymotion-k)
					omap <Leader>J <Plug>(easymotion-eol-j)
					omap <Leader>K <Plug>(easymotion-eol-K)
					omap <Leader>f <Plug>(easymotion-bd-f)
					omap <Leader>s <Plug>(easymotion-bd-f2)
					omap <Leader>t <Plug>(easymotion-bd-t)
					omap <Leader>S <Plug>(easymotion-bd-t2)
					omap <Leader>/ <Plug>(easymotion-sn)
					omap <Leader>? <Plug>(easymotion-tn)
					omap <Leader>n <Plug>(easymotion-bd-n)
					omap <Leader>. <Plug>(easymotion-repeat)
					omap <Leader>v <Plug>(easymotion-segments-LF)
					omap <Leader>V <Plug>(easymotion-segments-LB)
					omap <Leader>gv <Plug>(easymotion-segments-RF)
					omap <Leader>gV <Plug>(easymotion-segments-RB)
					omap <Leader>a <Plug>(easymotion-jumptoanywhere)
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
			"LEVELS
				"LEVEL=1
				"LEVEL=2
				"LEVEL=3
		Plug 'cocopon/vaffle.vim'
		Plug 'voldikss/vim-floaterm'
		"Plug 'vifm/neovim-vifm'
			"nnoremap <LEADER>nf :VifmToggle %:p:h<CR>
			"nnoremap <LEADER>nF :VifmToggle .<CR>
	"PROGRAMMING
		"LANGUAGES
			"CODE-EXECUTION
				Plug 'coachshea/jade-vim'
			"AUTO-COMPLETION
				"Plug 'dNitro/vim-pug-complete'
			"SYNTAXES
				Plug 'sheerun/vim-polyglot'
				Plug 'chrisbra/csv.vim'
				"Plug 'lervag/vimtex'
					"Plug 'vim-latex/vim-latex'
			"MISCELLANOUS
				Plug 'mattn/emmet-vim'
					let g:user_emmet_install_global = 0
					autocmd FileType html,css EmmetInstall
					let g:user_emmet_leader_key='<tab>'
	"DEVELOPMENT
		"VCS
			"Plug 'tpope/vim-fugutive'
				nnoremap <Leader>gc :Commits<CR>
				nnoremap <Leader>gC :BCommits<CR>
				nnoremap <Leader>gf :GFiles<CR>
				nnoremap <Leader>gF :GFiles?<CR>

				nnoremap <Leader>gb :Gbrowser<CR>
			"Plug 'airblade/vim-gitgutter'
			"Plug 'mhinz/vim-signify'
		"AUTOFORMAT
			Plug 'chiel92/vim-autoformat'
				"CONFIGURATION
					let g:formatterpath = ['/usr/local/bin/autopep8']
				"AUTOFORMAT-TOGGLE
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
				"MAPPINGS
					nnoremap <Leader>vF :call AutoFormatToggle()<CR>
					vnoremap <Leader>vf :Autoformat<CR>
		"SNIPPETS
			Plug 'honza/vim-snippets'
			if has('python3')
				Plug 'SirVer/ultisnips'
					"let g:UltiSnipsExpandTrigger="<CR>"
					let g:UltiSnipsJumpForwardTrigger="<C-b>"
					let g:UltiSnipsJumpBackwardTrigger="<C-z>"
			endif
		"AUTO-COMPLETION
			"Plug 'ervandew/supertab'
			Plug 'vim-scripts/AutoComplPop'
				let g:acp_enableAtStartup = 0

				augroup AutoComplPop
					autocmd!
					autocmd BufEnter *.txt :AcpEnable
					autocmd BufLeave *.txt :AcpDisable
				augroup END
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
						"set splitbelow
					"MAPPINGS
						nnoremap <Leader>jd :YcmCompleter GoToDeclaration<CR>
						nnoremap <Leader>jD :YcmCompleter GoToDefinition<CR>
						nnoremap <Leader>jj :YcmCompleter GoTo<CR>
						nnoremap <Leader>ji :YcmCompleter GoToImplementation<CR>
			endif
		"CODE-EXECUTION
			Plug 'metakirby5/codi.vim'
				let g:codi#width	  = 80
				let g:codi#rightalign = 0
				nmap <LocalLeader>ci :Codi!!<CR>
			Plug 'arkwright/vim-whiteboard'
				"CONFIGURATIONS
					let g:whiteboard_temp_directory = '~/.config/nvim/temp'
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
		"SYNTAX
			"Plug 'vim-syntastic/syntastic'
			Plug 'neovimhaskell/haskell-vim'
		"COMMENTING
			Plug 'scrooloose/nerdcommenter'
			"Plug 'tpope/vim-commentary'
			Plug 'manasthakur/vim-commentor'
				nmap gk  <Plug>Commentor
				xmap gk  <Plug>Commentor
				nmap gkk <Plug>CommentorLine
		"DOCUMENTATION
			if has('macunix')
				Plug 'rizzatti/dash.vim'
				nnoremap <Leader>fd :Dash<CR>
				nnoremap <Leader>fD :Dash<space>
			endif
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
				xmap X	 <Plug>(Exchange)
				nmap gxc <Plug>(ExchangeClear)
			Plug 'tpope/vim-surround'
			Plug 'junegunn/vim-easy-align'
				xmap ga <Plug>(EasyAlign)
				nmap ga <Plug>(EasyAlign)
			Plug 'christoomey/vim-titlecase'
			Plug 'svermeulen/vim-subversive'
				nmap r <plug>(SubversiveSubstituteRange)
				xmap r <plug>(SubversiveSubstituteRange)
			Plug 'milsen/vim-operator-substitute'
				let g:operator#substitute#default_flags		= ""
				let g:operator#substitute#default_delimiter = ";"

				map gr <Plug>(operator-substitute)
				map &  <Plug>(operator-substitute-repeat)
			Plug 'tyru/operator-camelize.vim'
				map cp <Plug>(operator-camelize)
				map cu <Plug>(operator-decamelize)
				map cP <Plug>(operator-camelize-toggle)
			Plug 'deris/vim-operator-insert'
				nmap gI <Plug>(operator-insert-i)
				nmap gA <Plug>(operator-insert-a)
			Plug 'emonkak/vim-operator-sort'
				map gS <Plug>(operator-sort)
			Plug 'gustavo-hms/vim-duplicate'
				"map gd <Plug>(operator-duplicate)
			Plug 'rjayatilleka/vim-operator-goto'
				map go <Plug>(operator-gotostart)
				map gO <Plug>(operator-gotoend)
		"OBJECTS
			Plug 'wellle/targets.vim'
			Plug 'michaeljsmith/vim-indent-object'
			Plug 'coderifous/textobj-word-column.vim'
			Plug 'rhysd/vim-textobj-anyblock'
			Plug 'thinca/vim-textobj-between'
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
				let g:pastedtext_select_key = 'gp'
			Plug 'haya14busa/vim-easyoperator-line'
				omap gl  <Plug>(easyoperator-line-select)
				xmap gl  <Plug>(easyoperator-line-select)
			Plug 'haya14busa/vim-easyoperator-phrase'
				omap gs  <Plug>(easyoperator-phrase-select)
				xmap gs  <Plug>(easyoperator-phrase-select)
		"MISCELLANOUS
			Plug 'chaoren/vim-wordmotion'
			Plug 'machakann/vim-swap'
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
					\	'converters': [incsearch#config#fuzzy#converter()],
					\	'modules': [incsearch#config#easymotion#module()],
					\	'keymap': {"\<CR>": '<Over>(easymotion)'},
					\	'is_expr': 0,
					\	'is_stay': 1
					\ }), get(a:, 1, {}))
			endfunction

			noremap <silent><expr> <Leader>fg/ incsearch#go(<SID>config_easyfuzzymotion())
		Plug 'aykamko/vim-easymotion-segments'
		Plug 'bronson/vim-visual-star-search'
		if IsLinuxy() && has('nvim')
			Plug 'lambdalisue/lista.nvim'
				nmap <Leader>ff :Lista<CR>
				nmap <Leader>fF :ListaCursorWord<CR>
		endif
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
			"STATUSLINE
				if IsLinuxy()
					Plug 'vim-airline/vim-airline'
						"CONFIGURATION
							if !exists('g:gui_oni')
								let g:airline_powerline_fonts = 0
								let g:airline_theme			  = 'bubblegum'
							else
								let g:airline_powerline_fonts = 0
								let g:airline_theme			  = 'wombat'
							endif
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
							if exists('g:gui_oni')
								let g:airline#extensions#bufferline#enabled				= 1
								let g:airline#extensions#bufferline#overwrite_variables = 1
							endif
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
						"FUNCTIONS
							function! CapsLock()
								return exists('*CapsLockStatusline') ? CapsLockStatusline('CAPS') : ''
							endfunction
						"CONFIGURATION
							let g:lightline = {
								\'colorscheme': 'wombat',
								\'active': {
									\'left': [
										\['mode', 'paste'],
										\['readonly', 'filename', 'modified', 'directory', 'vim-capslock'],
									\],
									\'right': [
										\['lineinfo'],
										\['percent'],
										\['fileformat', 'fileencoding', 'filetype'],
									\],
								\},
								\'component': {
								\},
								\'component_function': {
									\'directory': 'GetCurrentDirectoryName',
									\'vim-capslock': 'CapsLock',
								\},
								\'mode_map': {
									\'n'	  : 'NORMAL',
									\'i'	  : 'INSERT',
									\'R'	  : 'REPLACE',
									\'v'	  : 'VISUAL',
									\'V'	  : 'V-LINE',
									\"\<C-v>" : 'V-BLOCK',
									\'t'	  : 'TERMINAL',
									\'c'	  : 'COMMANDLINE',
									\'s'	  : 'S',
									\'S'	  : 'SL',
									\"\<C-s>" : 'SB',
								\}
							\}
				endif
			Plug 'bling/vim-bufferline'
				let g:bufferline_echo				 = 1
				let g:bufferline_active_buffer_left  = '['
				let g:bufferline_active_buffer_right = ']'
				let g:bufferline_modified			 = '[+]'
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
		"MISCELLEANOUS
			Plug 'ryanoasis/vim-devicons'
			"TODO:IMPLEMENT
			Plug 'itchyny/vim-highlighturl'
				"let g:highlighturl_ctermfg   = ''
				"let g:highlighturl_guifg	  = ''
				"let g:highlighturl_underline = 0
			"Plug 'zefei/vim-colortuner'
			"Plug 'Yggdroot/indentLine'
	"EXTENDING-VIM
		"FOLDING
			if has('folding')
				Plug 'pseewald/vim-anyfold'
					let g:anyfold_activate			= 1
					let g:anyfold_fold_display		= 1
					let g:anyfold_motion			= 0
					let g:anyfold_fold_comments		= 0
					let g:anyfold_identify_comments = 0
					let g:anyfold_comments			= []
					"autocmd Filetype * AnyFoldActivate

					"WONT WORK BY DEFAULT
						"to make these work, use lines below in anyfold.vim
						"let foldSizeStr = " " . foldSize . g:anyfold_fold_size_str
						"let foldLevelStr = repeat(g:anyfold_fold_level_str, v:foldlevel)
					let g:anyfold_fold_size_str  = ' Lines	'
					let g:anyfold_fold_level_str = ''
				Plug 'arecarn/vim-fold-cycle'
					let g:fold_cycle_default_mapping = 0
					nmap <Tab> <Plug>(fold-cycle-open)
					nmap <S-Tab> <Plug>(fold-cycle-close)
			endif
		Plug 'svermeulen/vim-yoink'
			let g:yoinkMaxItems				   = 10
			let g:yoinkSyncNumberedRegisters   = 1
			let g:yoinkIncludeDeleteOperations = 1
			let g:yoinkAutoFormatPaste		   = 0
			let g:yoinkIncludeNamedRegisters   = 0

			"nmap <expr> p yoink#canSwap() ? '<plug>(YoinkPostPasteSwapBack)' : '<plug>(YoinkPaste_p)'
			"nmap <expr> P yoink#canSwap() ? '<plug>(YoinkPostPasteSwapForward)' : '<plug>(YoinkPaste_P)'
		"Plug 'vim-scripts/repmo.vim'
			let repmo_key = ";"
			let repmo_revkey = ","
		Plug 'unblevable/quick-scope'
		Plug 'gastonsimone/vim-dokumentary'
		Plug 'tpope/vim-eunuch'
		Plug 'kopischke/vim-fetch'
		Plug 'dohsimpson/vim-macroeditor'
			nnoremap <Leader>zm :execute "MacroEdit " nr2char(getchar()) <CR>
		Plug 'kassio/neoterm'
		Plug 'zirrostig/vim-schlepp'
			vmap <up>	 <Plug>SchleppUp
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
		Plug 'rhysd/clever-f.vim'
			let g:clever_f_ignore_case	   = 1
			let g:clever_f_smart_case	   = 1
			"let g:clever_f_mark_char_color = 'cssColor66ffcc'
		"Plug 'jiangmiao/auto-pairs'
		Plug 'haya14busa/vim-operator-flashy'
			let g:operator#flashy#group = 'Visual'
			map y <Plug>(operator-flashy)
			map Y <Plug>(operator-flashy)$
		"Plug 'reedes/vim-wheel'
			let g:wheel#map#up	 = '<D-k>'
			let g:wheel#map#down = '<D-j>'
			let g:wheel#map#mouse = 1
		"Plug 'tpope/vim-speeddating'
		"Plug 'severin-lemaignan/vim-minimap'
		Plug 'junegunn/vim-peekaboo'
			let g:peekaboo_window  = 'vert bo 80new'
			let g:peekaboo_prefix  = '<Leader>'
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
			highlight WLCRedBackground	  ctermbg=52  guibg=#882323
			highlight WLCBlueBackground   ctermbg=17  guibg=#003366
			highlight WLCPurpleBackground ctermbg=53  guibg=#732c7b
			highlight WLCGreyBackground   ctermbg=238 guibg=#464646
			highlight WLCGreenBackground  ctermbg=22  guibg=#005500
		Plug 'tyru/open-browser.vim'
			"CONFIGURATION
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

			nnoremap <Leader>vd  :Goyo<CR>
		Plug 'junegunn/limelight.vim'
			nnoremap <Leader>vl  :Limelight!!<CR>
		Plug 'mtth/scratch.vim'
			let g:scratch_no_mappings	   = 1
			let g:scratch_height		   = 0.3
			let g:scratch_top			   = 0
			let g:scratch_persistence_file = glob('~/') . 'temp.scratch'

			nnoremap <Leader>ss :Scratch<CR>
			nnoremap <Leader>sS :Scratch!<CR>
			nnoremap <Leader>sp :ScratchPreview<CR>
			nnoremap <Leader>si :ScratchInsert<CR>
			nnoremap <Leader>sI :ScratchInsert!<CR>

			vnoremap <Leader>ss :ScratchSelection<CR>
			vnoremap <Leader>sS :ScratchSelection!<CR>

			augroup ScratchEnter
				autocmd!
				autocmd FileType scratch nnoremap <buffer> <esc> :q<CR>
				autocmd FileType scratch set syntax=jproperties
			augroup END
		Plug 'mhinz/vim-startify'
			let g:startify_session_dir='~/.vim-sessions'
			nnoremap <LEADER>vS  :Startify<CR>
		Plug 'suan/vim-instant-markdown'
		Plug 'tpope/vim-capslock'
			nmap <LocalLeader><LocalLeader> <Plug>CapsLockToggle
			imap ;; <Plug>CapsLockToggle
		"Plug 'natw/keyboard_cat.vim'
		if !IsWindows()
			Plug 'MrPeterLee/VimWordpress'
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
		"Plug 'vim-scripts/DrawIt'
		"Plug 'gorodinskiy/vim-coloresque'
		Plug 'hecal3/vim-leader-guide'
			"nnoremap <space> :LeaderGuide		 '<Leader>'		 <CR>
			"nnoremap ,		  :LeaderGuide		 '<LocalLeader>' <CR>
			"vnoremap <space> :LeaderGuideVisual '<Leader>'		 <CR>
			"vnoremap ,		  :LeaderGuideVisual '<LocalLeader>' <CR>

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
		Plug 'kana/vim-arpeggio'
		Plug 'vim-scripts/tinymode.vim'
		Plug 'tyru/stickykey.vim'
		Plug 'luzhlon/popup.vim'
		Plug 'skywind3000/quickmenu.vim'
	"TOTEST
		if has('nvim')
			"not-working
			Plug 'ripxorip/aerojump.nvim', { 'do': ':UpdateRemotePlugins' }
				nmap <Leader>as <Plug>(AerojumpSpace)
				nmap <Leader>ab <Plug>(AerojumpBolt)
				nmap <Leader>aa <Plug>(AerojumpFromCursorBolt)
				nmap <Leader>ad <Plug>(AerojumpDefault)
		endif
	"TODECIDE
		"Plug 'sickill/vim-pasta'
			let g:pasta_paste_before_mapping = 'P'
			let g:pasta_paste_after_mapping = 'p'
		Plug 'liuchengxu/vim-clap'
		Plug 'ap/vim-css-color'
		"Plug 'justinmk/vim-sneak'
		Plug 'tommcdo/vim-ninja-feet'
		Plug 'terryma/vim-multiple-cursors'
		Plug 'RRethy/vim-illuminate'
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
"SETTINGS
	"FOLDS
		if has('folding')
			set foldlevel=0
			set foldignore=
		endif
	"INDENTATION
		set autoindent
		set smartindent
		set shiftwidth=4
		set tabstop=4
		set noexpandtab
	"LINES
		set number
		set relativenumber
	"SWAP|BACKUP
		set nobackup
		set directory=~/.config/nvim/temp
	"SEARCH
		set hls
		set incsearch
		set ignorecase
		set smartcase
	"COMMANDLINE
	"INTERFACE
		"BTW
			"BUFFER
				set nowrap
				set hidden
				set fileformats=unix,mac,dos
				set noruler

				"set colorcolumn=120
				"TODO:FIX
					"DAMIAN-CONVAY
					highlight ColorColumn ctermbg=magenta
					call matchadd('ColorColumn', '\%81v', 100)
			"WINDOW
				set splitbelow
			"TABS
		"LIST
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
		"CURSOR
			set cursorcolumn
			set cursorline
			"TODO set guicursor=a:block
		"COLORSCHEME
			colorscheme molokai
		"STATUSLINE
			set noshowcmd
			augroup NOSHOWMODE
				"some plugin is overriding the "showmode" when entering new buffer
				au!
				au BufEnter * set noshowmode
			augroup END
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
	"MISCELLANOUS
		set nocompatible
			"disabling vi compatibility features|mappings…
		set mouse=a
		set clipboard=unnamed
		set nf="alpha,octal,hex,bin"
