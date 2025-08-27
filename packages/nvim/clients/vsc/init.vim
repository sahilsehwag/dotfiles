"RUNTIMEPATH
execute 'set rtp+=' . globpath(&rtp, 'custom')
execute 'set rtp+=' . globpath(&rtp, 'custom/vim')
execute 'set rtp+=' . globpath(&rtp, 'clients')
execute 'set rtp+=' . globpath(&rtp, 'clients/vsc')

runtime better-defaults/init.vim

"LIBS
if has('nvim-0.5')
  lua require('lib.funk')
  lua require('lib.func')
end
runtime libs/init.vim

"LEADERS
let mapleader = " "
let maplocalleader = ","

"GENERAL
lua require('sahilsehwag.general.variables')
lua require('sahilsehwag.general.settings')
lua require('sahilsehwag.general.highlights')
lua require('sahilsehwag.general.autocmds')
lua require('sahilsehwag.general.specification')

lua require('sahilsehwag.mappings.filetype.markdown')

"PLUGINS
runtime object-at.vim
runtime object-before.vim
runtime object-between.vim
runtime object-after.vim
runtime object-line.vim
runtime object-entire.vim
runtime object-last-selected.vim

runtime space-warrior.vim
runtime ivim/init.vim

runtime configs/npm_scripts.lua
runtime configs/worktree.lua
runtime configs/git_workspace.lua
runtime configs/mani.lua
runtime configs/nix.lua
