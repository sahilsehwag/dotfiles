let mapleader = ' '
let maplocalleader = ','

runtime libs/init.vim
runtime general/settings.vim
runtime general/variables.vim
runtime general/mappings.vim
runtime general/highlights.vim
runtime general/specification.vim
if has('nvim-0.5')
	lua require('general/lsp')
endif
