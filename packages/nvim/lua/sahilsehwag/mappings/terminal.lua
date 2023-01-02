vim.cmd [[
	if has('nvim') || has('terminal')
		"BASICS
			nnoremap <Leader>Tb :terminal<CR>
			nnoremap <Leader>Th :split<bar>terminal<CR>
			nnoremap <Leader>Tv :vsplit<bar>terminal<CR>

			nnoremap <Leader>TB :terminal<SPACE>
			nnoremap <Leader>TH :split<bar>terminal<SPACE>
			nnoremap <Leader>TV :vsplit<bar>terminal<SPACE>
		"MAPPINGS
			"<ESC>
				execute 'tnoremap <silent> <' . g:action_leader . '-[> <C-\><C-n>'
			"VIM-REGISTERS
				tnoremap <silent> <expr> <A-'> '<C-\><C-N>"'.nr2char(getchar()).'pi'
		"ABBREVIATIONS
			"GIT
				execute 'tnoremap <silent> ' . g:terminal_leader . 'g; git '
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gi git init<CR>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gC git clone '

				"working-directory|staging-area
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gas git status<CR>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gad git diff **/** \| delta \| bat<C-LEFT><C-LEFT><LEFT><LEFT><LEFT><LEFT>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gaD git rerere diff **/** \| delta \| bat<C-LEFT><C-LEFT><LEFT><LEFT><LEFT><LEFT>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gaa git add **/**<LEFT>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gau git restore --staged **/**<LEFT>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gaD git restore **/**<LEFT>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gac git clean -d -f<CR>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gar git reset --hard HEAD<CR>'

				"remote
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gr; git remote '
				execute 'tnoremap <silent> ' . g:terminal_leader . 'grp git pull<CR>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'grP git push<CR>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'grl git remote show<CR>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gra git remote add '
				execute 'tnoremap <silent> ' . g:terminal_leader . 'grd git remote remove '
				execute 'tnoremap <silent> ' . g:terminal_leader . 'grr git remote rename '
				execute 'tnoremap <silent> ' . g:terminal_leader . 'grg git remote get-url '
				execute 'tnoremap <silent> ' . g:terminal_leader . 'grs git remote set-url '

				"stash
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gs; git stash '
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gss git stash<CR>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gsl git stash list<CR>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gsa git stash apply<CR>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gsp git stash pop<CR>'

				"commits
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gcl git log --oneline<CR>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gcL git log --graph<CR>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gcm git commit -m ""<LEFT>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gca git commit --amend'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gcu git reset --mixed HEAD^<CR>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gcd git reset --hard HEAD^<CR>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gcr git reset --'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gcs git show	\| delta \| bat<CR>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gcS git show	\| delta \| bat<C-LEFT><C-LEFT><LEFT><LEFT><LEFT>'

				"branch
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gbl git branch<CR>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gbn git branch '
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gbN git checkout -b '
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gbc git checkout '
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gbC git checkout -<CR>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gbm git merge '
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gbM git merge --no-ff '
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gbr git rebase '
				execute 'tnoremap <silent> ' . g:terminal_leader . 'gbR git rebase -i '
			"SHELL
				execute 'tnoremap <silent> ' . g:terminal_leader . 'sc clear<CR>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'sq exit<CR>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'sp <space>\|<space>'
			"NPM
				execute 'tnoremap <silent> ' . g:terminal_leader . 'ni npm install --save '
				execute 'tnoremap <silent> ' . g:terminal_leader . 'nd npm install --save-dev '
				execute 'tnoremap <silent> ' . g:terminal_leader . 'ns npm run start<CR>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'nt npm run test<CR>'
				execute 'tnoremap <silent> ' . g:terminal_leader . 'nb npm run build<CR>'
		"VISH
			"CONFIGURATION
				"let g:modes	 = ['N','I']
				"let g:vi_mode = 'I'
			"FUNCTIONS
			"MAPPINGS
				if IsWindows()
					execute 'tnoremap <silent> <' . g:action_leader . '-w> <C-RIGHT>'
					execute 'tnoremap <silent> <' . g:action_leader . '-b> <C-LEFT>'
					execute 'tnoremap <silent> <' . g:action_leader . '-0> <HOME>'
					execute 'tnoremap <silent> <' . g:action_leader . '-9> <END>'
				endif
	endif
]]
