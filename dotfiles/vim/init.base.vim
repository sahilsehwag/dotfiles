"GENERAL
	runtime libs/init.vim
	runtime general/variables.vim
	runtime general/settings.vim
	runtime general/mappings/init.vim
	runtime general/highlights.vim
	runtime general/specification.vim
	runtime general/plugins.vim

	if has('nvim-0.5')
		runtime general/lsp.lua
	endif
"CUSTOM
	execute 'set rtp+=' . globpath(&rtp, 'custom')
	
	runtime better-make.vim
	runtime better-paste.vim
	runtime better-motions.vim
	runtime better-cursor.vim
	runtime better-folds.vim
	runtime better-terminal.vim
	runtime better-help.vim
	runtime minimalistic-folds.vim

	runtime terminator.vim
	runtime projectinator.vim
	runtime nixification.vim
	runtime space-warrior.vim
	"symbolic.vim
	"vifm.vim

	runtime object-at.vim
	runtime object-before.vim
	runtime object-between.vim
	runtime object-after.vim
	runtime object-line.vim
	runtime object-entire.vim
	runtime object-last-selected.vim
	
	if has('nvim-0.5')
		runtime configs/pacman.lua
		runtime configs/plugman.lua
		runtime configs/executioner.lua
	else
		"call g:loaders['plug'](s:plugins, s:configs)
		runtime executioner.vim
	end
"CLIENTS
	runtime clients/firenvim.vim
	runtime clients/vscode.vim
	runtime clients/neovide.vim
	runtime clients/goneovim.vim
"OVERRIDES
	runtime general/overrides.vim
