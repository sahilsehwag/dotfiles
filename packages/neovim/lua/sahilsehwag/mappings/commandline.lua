vim.cmd [[
	"GIT
		execute 'cnoremap ' . g:command_leader . 'gi !git init<CR>'
		execute 'cnoremap ' . g:command_leader . 'gC !git clone '

		execute 'cnoremap ' . g:command_leader . 'ga !git add **<LEFT>'
		execute 'cnoremap ' . g:command_leader . 'gd !git diff ** \| delta<C-LEFT><LEFT><LEFT><LEFT><LEFT>'
		execute 'cnoremap ' . g:command_leader . 'gs !git status<CR>'
		execute 'cnoremap ' . g:command_leader . 'gD !git checkout -- '

		execute 'cnoremap ' . g:command_leader . 'grp !git pull '
		execute 'cnoremap ' . g:command_leader . 'grP !git push '

		execute 'cnoremap ' . g:command_leader . 'gSs !git stash<CR>'
		execute 'cnoremap ' . g:command_leader . 'gSl !git stash list<CR>'
		execute 'cnoremap ' . g:command_leader . 'gSa !git stash apply<CR>'
		execute 'cnoremap ' . g:command_leader . 'gSp !git stash pop<CR>'

		execute 'cnoremap ' . g:command_leader . 'gcm !git commit -m ""<LEFT>'
		execute 'cnoremap ' . g:command_leader . 'gca !git commit --amend'
		execute 'cnoremap ' . g:command_leader . 'gcl !git log<CR>'

		execute 'cnoremap ' . g:command_leader . 'gbl !git branch<CR>'
		execute 'cnoremap ' . g:command_leader . 'gbn !git branch '
		execute 'cnoremap ' . g:command_leader . 'gbc !git checkout '
		execute 'cnoremap ' . g:command_leader . 'gbC !git checkout -b '
		execute 'cnoremap ' . g:command_leader . 'gbN !git checkout -b '
	"VIM
]]
