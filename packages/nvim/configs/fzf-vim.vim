"MAPPINGS
	nmap <silent> <Leader><TAB> <plug>(fzf-maps-n)
	xmap <silent> <Leader><TAB> <plug>(fzf-maps-x)
	omap <silent> <Leader><TAB> <plug>(fzf-maps-o)
	imap <silent> ;<TAB> <plug>(fzf-maps-i)
"INBUILT
	nnoremap <silent> <Leader>bl :Buffers<CR>
	nnoremap <silent> <Leader>b/ :BLines<CR>
	nnoremap <silent> <Leader>b? :Lines<CR>
	nnoremap <silent> <Leader>bf :Filetypes<CR>

	"nnoremap <silent> <Leader>vfc :Colors<CR>
	"nnoremap <silent> <Leader>v<tab> :Maps<CR>

	nnoremap <silent> <Leader>v; :Commands<CR>
	nnoremap <silent> <Leader>v: :History:<CR>
	nnoremap <silent> <Leader>v/ :History/<CR>
	nnoremap <silent> <Leader>v? :Helptags<CR>

	nnoremap <silent> <Leader>lTp :Tags<CR>
	nnoremap <silent> <Leader>lTb :BTags<CR>
"COMPLETION
	imap		;w <plug>(fzf-complete-word)
	imap		;p <plug>(fzf-complete-path)
	imap		;f <plug>(fzf-complete-file-ag)
	imap		;l <plug>(fzf-complete-buffer-line)
	imap		;L <plug>(fzf-complete-line)
	imap <expr> ;cp fzf#complete('find ~/Google\ Drive')
	imap <expr> ;cf fzf#complete('find ~/Google\ Drive -type f')
	imap <expr> ;cd fzf#complete('find ~/Google\ Drive -type d')
"GIT
	nnoremap <Leader>gCp :Commits<CR>
	nnoremap <Leader>gCb :BCommits<CR>

	nnoremap <Leader>pg  :GFiles?<CR>
	"nnoremap <Leader>pG  :GFiles<CR>
"SEARCH
	nnoremap          <Leader>p/ :Rg<SPACE>
	nnoremap <silent> <Leader>p? :Rg<CR>
	nnoremap <C-/>   :Rg<space>
	nnoremap <C-S-/> :Rg<CR>
