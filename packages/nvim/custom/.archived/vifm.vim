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
