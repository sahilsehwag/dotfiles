"CONFIGURATION
	let g:which_key_sep										 = '→'
	let g:which_key_hspace								 = 5
	let g:which_key_flatten								 = 0
	let g:which_key_max_size							 = 0
	let g:which_key_sort_horizontal				 = 0
	let g:which_key_vertical							 = 0
	let g:which_key_align_by_seperator		 = 1
	let g:which_key_run_map_on_popup			 = 1
	let g:which_key_fallback_to_native_key = 1
	let g:which_key_centered							 = 1
	let g:which_key_default_group_name		 = ''

	let g:which_key_use_floating_win			= 0
	let g:which_key_floating_relative_win = 0
	" let g:which_key_floating_opts = { 'row': '-1' }
	let g:which_key_disable_default_offset = 1

	let g:which_key_display_names = {' ': 'SPC', '<C-H>': 'BS'}
	let g:which_key_map = {}

	"hiding statusline
	autocmd! FileType which_key
	autocmd  FileType which_key set laststatus=0 noshowmode noruler
		\| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

	let g:which_key_map['*']	 = "which_key_ignore"
	let g:which_key_map['"']	 = "which_key_ignore"
	let g:which_key_map['/']	 = "which_key_ignore"
	let g:which_key_map['?']	 = "which_key_ignore"
	let g:which_key_map['@']	 = "which_key_ignore"

	let g:which_key_map['1-9'] = "open-buffer"
	let g:which_key_map['1']	 = "which_key_ignore"
	let g:which_key_map['2']	 = "which_key_ignore"
	let g:which_key_map['3']	 = "which_key_ignore"
	let g:which_key_map['4']	 = "which_key_ignore"
	let g:which_key_map['5']	 = "which_key_ignore"
	let g:which_key_map['6']	 = "which_key_ignore"
	let g:which_key_map['7']	 = "which_key_ignore"
	let g:which_key_map['8']	 = "which_key_ignore"
	let g:which_key_map['9']	 = "which_key_ignore"
	let g:which_key_map['`']	 = "open-last-buffer"

	let g:which_key_map['<Tab>'] = "show-mappings"
	let g:which_key_map[' '] = {'name':'+miscellanous'}

	let g:which_key_map['a'] = {
		\'name' : 'applications(tui)',
		\'e' : 'explorer',
		\'m' : 'markdown',
		\'M' : 'markdown-current-file',
		\'g' : 'git',
		\'t' : 'typing',
		\'y' : 'youtube',
		\'Y' : 'youtube-music',
	\}
	let g:which_key_map['b'] = {
		\'name' : '+buffers',
		\'.'	: 'buffer-mode',
		\'a': {
			\'name': '+add',
			\'n': 'new-buffer',
			\'s': 'scratch-buffer',
			\'S': 'scratch-buffer-filetype',
		\},
		\'c': {
			\'name': '+close',
			\'c': 'close-current',
			\'C': 'CLOSE-current',
			\'a': 'close-all',
			\'A': 'CLOSE-all',
			\'o': 'close-others',
			\'O': 'CLOSE-others',
			\'h': 'close-left',
			\'l': 'close-right',
			\'g': 'close-glob',
			\'G': 'CLOSE-glob',
			\'r': 'close-regex',
			\'R': 'CLOSE-regex',
			\'f': 'close-all-filetype',
			\'F': 'CLOSE-all-filetype',
			\'v': 'close-hidden',
			\'V': 'CLOSE-hidden',
			\'n': 'close-nameless',
			\'N': 'CLOSE-nameless',
		\},
		\'d': {
			\'name': '+delete',
			\'c': 'delete-current',
			\'C': 'DELETE-current',
			\'a': 'delete-all',
			\'A': 'DELETE-all',
			\'o': '--delete-others',
			\'O': '--DELETE-others',
			\'h': '--delete-left',
			\'l': '--delete-right',
			\'g': '--delete-glob',
			\'G': '--DELETE-glob',
			\'r': '--delete-regex',
			\'R': '--DELETE-regex',
			\'f': '--delete-all-filetype',
			\'F': '--DELETE-all-filetype',
			\'v': '--delete-hidden',
			\'V': '--DELETE-hidden',
			\'n': '--delete-nameless',
			\'N': '--DELETE-nameless',
		\},
		\'w' : {
			\'name': '+write',
			\'c': 'write-current-buffer',
			\'C': 'WRITE-current-buffer',
			\'a': 'write-all-buffers',
			\'A': 'WRITE-all-buffers',
		\},
		\'l'	: 'list-buffers',
		\'t'	: 'buffer-tree',
		\'g'	: 'goto-buffer',
		\'f'	: 'change-buffer-filetype',
		\'/'	: 'search-current-buffer',
		\'?'	: 'search-all-buffers',
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
		\'name' : '+fuzzy',
		\'.': 'sources',
		\'f' : {
			\'name': '+files',
			\'/': 'search-/',
			\'h': 'search-home',
			\'d': 'search-drive',
			\'p': 'search-project',
			\'c': 'search-curent',
		\},
		\'d' : {
			\'name': '+directories',
			\'/': 'search-/',
			\'h': 'search-home',
			\'d': 'search-drive',
			\'p': 'search-project',
			\'c': 'search-curent',
		\},
		\'s' : {
			\'name': '+search',
			\'w': 'search-replace-word',
			\'f': 'search-replace-file',
			\'p': 'search-replace-project',
		\},
		\'r': 'mru',
	\}
	let g:which_key_map['g'] = {
		\'name' : '+git',
		\'i' : 'git-init',
		\'d' : {
			\'name': '+diff',
			\'.': 'diff-view',
			\'o': 'conflict-ours',
			\'t': 'conflict-theirs',
			\'n': 'conflict-none',
			\'b': 'conflict-both',
			\'B': 'conflict-both-reverse',
		\},
		\'h' : {
			\'name': '+hunks',
			\'s': 'stage-hunk',
			\'u': 'unstage-hunk',
			\'p': 'preview-hunk',
			\'r': 'reset-hunk',
			\'R': 'reset-buffer',
		\},
		\'b' : 'toggle-blame-line',
		\'l' : 'line-history',
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
		\'f': {
			\'name': '+file',
			\'c': 'compile',
			\'e': 'run',
			\'q': 'compile-run',
			\'r': 'repl',
			\'t': 'test',
			\'l': 'lint',
			\'f': 'format',
		\},
		\'a': {
			\'name': '+actions',
			\'.': 'show-code-actions',
			\'d': 'generate-documentation',
			\'f': 'format-buffer',
			\'o': '--organize-imports',
			\'q': '--quickfix',
		\},
		\'g': {
			\'name': '+goto',
			\'d': 'goto-definition',
			\'D': 'goto-declaration',
			\'t': 'goto-type-definition',
			\'i': 'goto-implementation',
			\'r': 'goto-references',
			\'S': 'goto-source-file',
			\'T': 'goto-test-file',
			\'F': 'goto-fixture-file',
		\},
		\'p': {
			\'name': '+preview',
			\'d': 'preview-definition',
			\'D': 'preview-declaration',
			\'t': 'preview-type-definition',
			\'i': 'preview-implementation',
			\'S': 'preview-source-file',
			\'T': 'preview-test-file',
			\'F': 'preview-fixture-file',
		\},
		\'s': {
			\'name': '+symbols',
			\'d': 'document-symbols',
			\'w': 'workspace-symbols',
			\'r': 'rename-symbol',
			\'R': 'rename-symbol-treesitter',
			\'t': 'symbols-tree',
		\},
		\'e': {
			\'name': '+diagnostics',
			\'l': 'line-diagnostics',
			\'d': 'document-diagnostics',
			\'w': 'workspace-diagnostics',
			\'q': 'open-in-quickfix',
		\},
		\'h': {
			\'name': '+help',
			\'h': 'hover-documentation',
			\'s': 'signature-help',
		\},
	\}
	let g:which_key_map['m'] = {
		\'name' : 'which_key_ignore',
	\}
	let g:which_key_map['n'] = {
		\'name' : '+nix',
		\'u': 'unique',
		\'s': 'sort',
		\'c': 'calculate',
	\}
	let g:which_key_map['o'] = {
		\'name' : '+browse',
		\'g'	: 'search-github',
		\'d'	: 'search-duckduckgo',
		\'w'	: 'search-wikipedia',
	\}
	let g:which_key_map['p'] = {
		\'name': '+projects',
		\'o':		 'open-project',
		\'f':		 'open-project-file',
		\'r':		 'open-project-mru',
		\'R':		 'open-project-mrw',
		\'/':		 'search-project',
		\'e':		 'open-project-directory',
		\'E':		 'open-file-directory',
		\'g':		 'open-modified-git-file',
		\'G':		 'open-git-file',
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
		\'l'	: '--list-terminals',
		\'b'	: 'new-buffer-terminal',
		\'f'	: 'new-floating-terminal',
		\'v'	: 'new-vertical-terminal',
		\'h'	: 'new-horizontal-terminal',
		\'t'	: 'toggle-terminal',
		\'k'	: 'kill-terminal',
		\'n'	: 'next-terminal',
		\'p'	: 'previous-terminal',
		\'B'	: 'new-buffer-terminal-lcd',
		\'F'	: '--new-floating-terminal-lcd',
		\'V'	: 'new-vertical-terminal-lcd',
		\'H'	: 'new-horizontal-terminal-lcd',
	\}
	let g:which_key_map['T'] = {
		\'name' : '+tabs',
		\'.'	: 'tab-mode',
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
		\'c' : 'open-config',
		\'s' : 'source-config',
		\';' : 'commands',
		\':' : 'command-history',
		\'/' : 'search-history',
		\'?' : 'helptags',
		\'q' : 'quit',
		\'p' : {
			\'name' : '+plugin-manager',
			\'l'	: 'list-plugins',
			\'i'	: 'install-plugins',
			\'d'	: 'uninstall-plugins',
			\'u'	: 'update-plugins',
			\'U'	: '--update-plugin',
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
		\'.'	: 'window-mode',
		\'h'	: 'horizontal-split',
		\'v'	: 'vertical-split',
		\'c'	: 'close-split',
		\'o'	: 'only-split',
		\'m'	: 'maximize-split',
		\'H'	: 'empty-horizontal-split',
		\'V'	: 'empty-vertical-split',
		\'g'	: 'toggle-golden-ratio',
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
	nnoremap <silent> <Leader>			:<C-U>WhichKey			 '<SPACE>'<CR>
	vnoremap <silent> <Leader>			:<C-U>WhichKeyVisual '<SPACE>'<CR>
	nnoremap <silent> <LocalLeader> :<C-U>WhichKey			 ','<CR>
"REGISTRATION
	call which_key#register('<SPACE>', "g:which_key_map")
