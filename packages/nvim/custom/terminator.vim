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
		command! -bang			  -nargs=1 Term		call Terminal(0       , ''           , 'enew' , <bang>0 , <q-args>)
		command! -bang -count -nargs=1 HBTerm call Terminal(<count> , 'botright'   , 'new'  , <bang>0 , <q-args>)
		command! -bang -count -nargs=1 HTTerm call Terminal(<count> , 'topleft'    , 'new'  , <bang>0 , <q-args>)
		command! -bang -count -nargs=1 VLTerm call Terminal(<count> , 'leftabove'  , 'vnew' , <bang>0 , <q-args>)
		command! -bang -count -nargs=1 VRTerm call Terminal(<count> , 'rightbelow' , 'vnew' , <bang>0 , <q-args>)

		command! TermSendSelected call TerminalSend(GetSelectedText(), '\n')
		command! TermSendFile     call TerminalSend(getline(0, '$'))
		command! TermSendLine     call TerminalSend([getline('.')])
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

			call DefineMap('nnoremap <silent> ', '<Leader>Tb', ':Term '		. g:terminal_program . '<CR>')
			call DefineMap('nnoremap <silent> ', '<Leader>Tv', ':VRTerm '	. g:terminal_program . '<CR>')
			call DefineMap('nnoremap <silent> ', '<Leader>Th', ':15HBTerm ' . g:terminal_program . '<CR>')

			call DefineMap('nnoremap <silent> ', '<Leader>TB', ':lcd %:p:h \| Term '	 . g:terminal_program . '<CR>')
			call DefineMap('nnoremap <silent> ', '<Leader>TV', ':lcd %:p:h \| VRTerm '	 . g:terminal_program . '<CR>')
			call DefineMap('nnoremap <silent> ', '<Leader>TH', ':lcd %:p:h \| 15HBTerm ' . g:terminal_program . '<CR>')
		endif
endif
