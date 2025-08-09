"RUNTIMEPATH
	execute 'set rtp+=' . globpath(&rtp, 'custom')
	execute 'set rtp+=' . globpath(&rtp, 'custom/vim')
"LIBS
	if has('nvim-0.5')
		lua require('lib.funk')
		lua require('lib.func')
	end

	runtime libs/init.vim
"GENERAL
	lua require('sahilsehwag.general.variables')
	lua require('sahilsehwag.general.settings')
	lua require('sahilsehwag.general.highlights')
	lua require('sahilsehwag.general.autocmds')
	lua require('sahilsehwag.general.specification')

	lua require('sahilsehwag.mappings.leaders')
	lua require('sahilsehwag.mappings.remaps')
	lua require('sahilsehwag.mappings.buffers')
	lua require('sahilsehwag.mappings.windows')
	lua require('sahilsehwag.mappings.tabs')
	lua require('sahilsehwag.mappings.terminal')
	lua require('sahilsehwag.mappings.commandline')
	lua require('sahilsehwag.mappings.quickfix')
	lua require('sahilsehwag.mappings.general')
	lua require('sahilsehwag.mappings.abbreviations')
	lua require('sahilsehwag.mappings.programming')
	lua require('sahilsehwag.mappings.plugin')
	lua require('sahilsehwag.mappings.hacks')
	lua require('sahilsehwag.mappings.toggles')
	lua require('sahilsehwag.mappings.random')
	lua require('sahilsehwag.mappings.mess')
	lua require('sahilsehwag.mappings.temporal')
	lua require('sahilsehwag.mappings.tmux')

	lua require('sahilsehwag.mappings.filetype.markdown')

	lua require('sahilsehwag.configs.plugins')

	if has('nvim-0.5')
		lua require('sahilsehwag.general.lsp')
	endif
"CUSTOM
	runtime better-defaults/init.vim

	if has('nvim-0.5')
		lua require('folder').setup({ folder = 'default' })
	end

	runtime preserve.vim

	runtime terminator.vim
	runtime projectinator.vim
	runtime space-warrior.vim
	"runtime ivim/init.vim
	"runtime movee.vim

	runtime worktree/init.vim

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
		"lua require('sahilsehwag.lazy')
		runtime configs/tmuxinator.lua
		runtime configs/executioner.lua
		runtime configs/projectinator.lua
		runtime configs/npm_scripts.lua
		runtime configs/worktree.lua
		runtime configs/git_workspace.lua
		runtime configs/mani.lua
		runtime configs/fasd.lua
		runtime configs/nix.lua
		runtime configs/macrograph.lua
	end
"CLIENTS
	runtime clients/firenvim.vim
	runtime clients/neovide.vim
	runtime clients/nvui.vim
	runtime clients/goneovim.vim
"OVERRIDES
	lua require('sahilsehwag.general.highlights')
	lua require('sahilsehwag.general.overrides')
"MESS
	function! ProcessFileChangedShell()
		if v:fcs_reason == 'mode' || v:fcs_reason == 'time'
			let v:fcs_choice = ''
		else
			let v:fcs_choice = 'ask'
		endif
	endfunction
	autocmd FileChangedShell <buffer> call ProcessFileChangedShell()
	autocmd FileChangedShellPost <buffer> call ProcessFileChangedShell()
