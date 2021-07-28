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
	nnoremap <C-/> :Rg<space>
