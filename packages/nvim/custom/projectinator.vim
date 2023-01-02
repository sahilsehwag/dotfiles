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
		\ 'source'  : g:jaat_find_directories_command . ' ' . g:jaat_home_path,
		\ 'sink'    : 'cd',
		\ 'options' : '--prompt "open-project> "'
	\}))<CR>

	command! ProjectinatorOpenFile :call fzf#run(fzf#wrap({
		\ 'source'  : g:jaat_find_files_command,
		\ 'sink'    : 'edit',
		\ 'options' : '--prompt "open-project-file> "'
	\}))<CR>

	command! ProjectinatorSearchText :call fzf#run(fzf#wrap({
		\ 'source'  : g:jaat_find_lines_command,
		\ 'sink'    : 'edit',
		\ 'options' : '--prompt "search-project> "'
	\}))<CR>
"DEFAULTS
	if ExistsAndTrue('g:projectinator_enable_default_mappings')
		nnoremap <silent> <Leader>pO :ProjectinatorOpenProject<CR>
		nnoremap <silent> <Leader>pf :ProjectinatorOpenFile<CR>
		nnoremap <silent> <Leader>p/ :ProjectinatorSearchText<CR>

		nnoremap <silent> <A-f> :ProjectinatorOpenFile<CR>
	endif
