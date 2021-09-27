"CONFIGURATION
	"let g:floaterm_autoinsert = 1
	"let g:floaterm_autohide = 1
	let g:floaterm_autoclose = 1

	"let g:floaterm_wintype = 'float'
	"let g:floaterm_width = 0.9
	"let g:floaterm_height = 0.9

	let g:floaterm_wintype = 'split'
	let g:floaterm_height = 0.4
	let g:floaterm_borderchars = '        '
	let g:floaterm_title = ''
"MAPPINGS
	nnoremap <silent> <Leader>Tf :FloatermNew --wintype=float<CR>
	nnoremap <silent> <Leader>Th :FloatermNew --wintype=split --height=0.4<CR>
	nnoremap <silent> <Leader>Tv :FloatermNew --wintype=vsplit --width=0.5<CR>
	nnoremap <silent> <Leader>Tt :FloatermToggle<CR>

	nnoremap <silent> <Leader>Td :FloatermKill<CR>
	nnoremap <silent> <Leader>Tn :FloatermNext<CR>
	nnoremap <silent> <Leader>Tp :FloatermPrev<CR>

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
		command! -nargs=1 Vifm :execute 'FloatermNew --wintype=float --height=0.999 --width=0.999 ' g:jaat_explorer_command . ' ' . shellescape(<q-args>)

		nnoremap <silent> <Leader>aE :execute 'FloatermNew --wintype=float --height=0.999 --width=0.999 ' . g:jaat_explorer_command . ' ' . shellescape(getcwd())<CR>
		nnoremap <silent> <Leader>ae :execute 'FloatermNew --wintype=float --height=0.999 --width=0.999 ' . g:jaat_explorer_command<CR>
	endif

	if executable('glow')
		command! -nargs=1 Glow :execute 'FloatermNew --wintype=float --height=0.999 --width=0.999 --autoclose=0 glow ' . shellescape(<q-args>)

		nnoremap <silent> <Leader>am :FloatermNew --wintype=float --height=0.999 --width=0.999 glow<CR>
		nnoremap <silent> <Leader>aM :execute 'FloatermNew --wintype=float --height=0.999 --width=0.999 --autoclose=0 glow ' . expand('%:p:S')<CR>
	endif

	if executable('ytfzf')
		command! -nargs=? YtFzf FloatermNew --wintype=float --height=0.999 --width=0.999 ytfzf <q-args>
		command! -nargs=? YtFzfMusic FloatermNew --wintype=float --height=0.999 --width=0.999 ytfzf -m <q-args>

		nnoremap <silent> <Leader>ay :YtFzf<CR>
		nnoremap <silent> <Leader>aY :YtFzfMusic<CR>
	endif

	if has('mac')
		command! -nargs=1 Typora :execute 'FloatermNew --wintype=float --height=0.999 --width=0.999 open -a Typora ' . shellescape(<q-args>)
	endif

	if executable('lazygit')
		nnoremap <silent> <Leader>ag :FloatermNew --wintype=float --height=0.999 --width=0.999 lazygit<CR>
		"nnoremap <silent> <Leader>aG :FloatermNew --wintype=float --height=0.999 --width=0.999 --cwd=/ lazygit<CR>
	endif

	if executable('gh')
		nnoremap <silent> <Leader>ahd :FloatermNew --wintype=float --height=0.999 --width=0.999 gh dash<CR>
	endif

	if executable('broot')
		nnoremap <silent> <Leader>. :FloatermNew --opener=edit --wintype=split --width=1.0 --height=0.5 broot<CR>
	endif

	if executable('k9s')
		nnoremap <Leader>ak :execute 'FloatermNew --wintype=float --height=0.999 --width=0.999 k9s -n ' . input('Enter namespace: ')<CR>
	endif

	if executable('mitype')
		command! MiType :FloatermNew --wintype=float --height=0.999 --width=0.999 mitype
		nnoremap <silent> <Leader>at :MiType<CR>
	endif

	if executable('bat')
		command! -nargs=1 Bat :FloatermNew --wintype=float --height=0.999 --width=0.999 bat <q-args>
	endif

	" if executable('delta')
	"  command! -nargs=2 Delta :FloatermNew --wintype=float --height=0.999 --width=0.999 delta <q-args>
	" endif

	if executable('open')
		command! -nargs=1 Open :FloatermNew --wintype=float --height=0.999 --width=0.999 open <q-args>
	endif

	if executable('slack-term')
		command! Slack :FloatermNew --wintype=float --height=0.999 --width=0.999 slack-term
	endif

	if executable('lazynpm')
		command! Slack :FloatermNew --wintype=float --height=0.999 --width=0.999 lazynpm
	endif

	if executable('man') && executable('bat')
		command! -nargs=1 Man :FloatermNew --wintype=float --height=0.999 --width=0.999 man <q-args> | bat
	elseif executable('man') && executable('less')
		command! -nargs=1 Man :FloatermNew --wintype=float --height=0.999 --width=0.999 man <q-args> | less
	endif
