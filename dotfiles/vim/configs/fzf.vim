"DEPENDENCIES
"CONFIGURATION
	let g:fzf_action = {
		\'ALT-t': 'tab split',
		\'ALT-h': 'split',
		\'ALT-v': 'vsplit',
		\'ALT-m': 'Glow',
		\'ALT-c': 'cd',
		\'ALT-e': 'Vifm',
		\'ALT-o': 'Open'
	\}
		"'SaveAs'
		"'SaveAs!'
		"'NewFile'
		"'NewDirectory'
		"'DeleteFile'
		"'DeleteDirectory'
		"'DeleteDirectory!'
	let g:fzf_layout = { 'down': '40%' }
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
	nnoremap <silent> <Leader>ff/ :call FZFFiles(g:jaat_root_path)<CR>
	nnoremap <silent> <Leader>ffh :call FZFFiles(g:jaat_home_path)<CR>
	nnoremap <silent> <Leader>ffd :call FZFFiles(g:jaat_drive_path)<CR>
	nnoremap <silent> <Leader>ffp :call FZFFiles('')<CR>
	nnoremap <silent> <Leader>ffc :call FZFFiles(expand('%:h'))<CR>

	nnoremap <silent> <Leader>fd/ :call FZFDirectories(g:jaat_root_path)<CR>
	nnoremap <silent> <Leader>fdh :call FZFDirectories(g:jaat_home_path)<CR>
	nnoremap <silent> <Leader>fdd :call FZFDirectories(g:jaat_drive_path)<CR>
	nnoremap <silent> <Leader>fdp :call FZFDirectories('')<CR>
	nnoremap <silent> <Leader>fdc :call FZFDirectories(expand('%:h'))<CR>
