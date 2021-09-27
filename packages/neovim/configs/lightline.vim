"CONFIGURATION
	let g:lightline = {
		\'enable': {
			\'statusline': 1,
			\'tabline': 1,
		\},
		\'active': {
			\'left': [
				\['mode', 'paste'],
				\['gitbranch', 'readonly', 'filename', 'modified', 'directory', 'vim-capslock'],
			\],
			\'right': [
				\['lineinfo'],
				\['percent'],
				\['fileformat', 'fileencoding', 'filetype'],
			\],
		\},
	\}
	let g:lightline.colorscheme = 'neodark'
		"powerline
		"powerlineish
		"wombat
		"solarized
		"jellybeans
		"molokai
		"seoul256
		"dracula
		"selenized_dark|black|light|white
		"Tomorrow[_Night][_Blue|Bright|Eigthies]
		"PaperColor
		"landscape
		"one
		"materia
		"material
		"OldHope
		"nord
		"deus
		"simpleblack
		"srcery_drk
		"ayu_mirage|light|dark
		"16color
	let g:lightline.mode_map = {
		\'n'	  : 'NORMAL',
		\'i'	  : 'INSERT',
		\'R'	  : 'REPLACE',
		\'v'	  : 'VISUAL',
		\'V'	  : 'V-LINE',
		\"\<C-v>" : 'V-BLOCK',
		\'t'	  : 'TERMINAL',
		\'c'	  : 'COMMAND',
		\'s'	  : 'SELECT',
		\'S'	  : 'S-LINE',
		\"\<C-s>" : 'S-BLOCK',
	\}
	let g:lightline.component = {}
	let g:lightline.component_function = {
		\'directory'    : 'GetCurrentDirectoryName',
		\'vim-capslock' : 'CapsLock',
		\'gitbranch'    : 'FugitiveHead'
	\}
"FUNCTIONS
	function! CapsLock()
		return exists('*CapsLockStatusline') ? CapsLockStatusline('CAPS') : ''
	endfunction
