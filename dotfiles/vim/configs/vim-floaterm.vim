"CONFIGURATION
	"let g:floaterm_autoinsert = 1
	"let g:floaterm_autohide = 1
	let g:floaterm_autoclose = 1
	let g:floaterm_width = 0.9
	let g:floaterm_height = 0.9
"MAPPINGS
	nnoremap <silent> <Leader>tf :FloatermNew --wintype=float<CR>
	nnoremap <silent> <Leader>th :FloatermNew --wintype=split --height=0.4<CR>
	nnoremap <silent> <Leader>tv :FloatermNew --wintype=vsplit --width=0.5<CR>
	nnoremap <silent> <Leader>tt :FloatermToggle<CR>

	nnoremap <silent> <Leader>td :FloatermKill<CR>
	nnoremap <silent> <Leader>tn :FloatermNext<CR>
	nnoremap <silent> <Leader>tp :FloatermPrev<CR>

	nnoremap <silent> <C-`> :FloatermToggle<CR>
	tnoremap <silent> <C-`> <C-\><C-n>:FloatermToggle<CR>
	tnoremap <silent> <C-S-f> <C-\><C-n>:FloatermNew<CR>
	tnoremap <silent> <C-S-s> <C-\><C-n>:FloatermNew --wintype=split --height=0.4<CR>
	tnoremap <silent> <C-S-v> <C-\><C-n>:FloatermNew --wintype=vsplit --width=0.5<CR>
	tnoremap <silent> <C-S-d> <C-\><C-n>:FloatermKill<CR>
	tnoremap <silent> <C-0> <C-\><C-n>:FloatermNext<CR>
	tnoremap <silent> <C-9> <C-\><C-n>:FloatermPrev<CR>
"INTEGRATION
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

	" if executable('delta')
	"  command! -nargs=2 Delta :FloatermNew delta <q-args>
	" endif

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
