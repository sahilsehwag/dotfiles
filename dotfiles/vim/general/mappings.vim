"LEADER
	"nnoremap ; :
	let mapleader      = ' '
	let maplocalleader = ','

	let g:insert_leader   = ';'
	let g:terminal_leader = ';'

	let g:action_leader = 'A'
	let g:mode_leader   = 'C-A'
	let g:motion_leader = 'C-S'
"MAPPINGS
	"NOPS
		map Q <nop>
		map <C-r> <nop>
	"REMAPS
		nnoremap U <C-r>
		nnoremap ' "
		nnoremap " '
	"LEADER
		"BASICS
			nnoremap <Leader>vq :qall<CR>
			nnoremap <Leader>vQ :qall!<CR>
			"TODO:FIX
				"execute 'nnoremap <silent> <' . g:leader_2 . '-space> <ESC>'
		"EDITING
			"OPERATORS
			"OBJECTS
			"MOTIONS
			"JUMPS
				execute 'nnoremap <' . g:action_leader . '-o> <C-o>'
				execute 'nnoremap <' . g:action_leader . '-i> <C-i>'

				execute 'nnoremap <' . g:action_leader . '-[> <C-t>'
				execute 'nnoremap <' . g:action_leader . '-]> <C-]>'
		"INTERFACE
			"TABS
				nnoremap <silent> <Leader>Ta :tabnew	  <CR>
				nnoremap <silent> <Leader>Td :tabclose	  <CR>
				nnoremap <silent> <Leader>Tn :tabnext	  <CR>
				nnoremap <silent> <Leader>Tp :tabprevious <CR>
				nnoremap <silent> <Leader>TN :tabmove -   <CR>
				nnoremap <silent> <Leader>TP :tabmove +   <CR>
			"BUFFERS
				nnoremap <silent> <Leader>ban :enew<CR>
				nnoremap <silent> <Leader>bas :call ScratchBuffer('e')<CR>
				nnoremap <silent> <Leader>baS :call ScratchBuffer('e', 1)<CR>

				nnoremap <silent> <Leader>bcc :bprevious<bar>split<bar>bnext<bar>bdelete<CR>
				nnoremap <silent> <Leader>bcC :bprevious<bar>split<bar>bnext<bar>bdelete!<CR>
				"nnoremap <silent> <Leader>bca :bufdo bp<bar>sp<bar>bn<bar>bd<CR>
				"nnoremap <silent> <Leader>bcA :bufdo bp<bar>sp<bar>bn<bar>bd!<CR>
				"nnoremap <silent> <Leader>bco :%bp<bar>sp<bar>bn<bar>bd<bar>e#<CR>
				"nnoremap <silent> <Leader>bcO :%bp<bar>sp<bar>bn<bar>bd!<bar>e#<CR>

				nnoremap <silent> <Leader>bdc :bdelete<CR>
				nnoremap <silent> <Leader>bdC :bdelete!<CR>
				nnoremap <silent> <Leader>bda :%bdelete<CR>
				nnoremap <silent> <Leader>bdA :%bdelete!<CR>
				nnoremap <silent> <Leader>bdo :%bdelete<bar>edit#<bar>bnext<bar>bdelete<CR>
				nnoremap <silent> <Leader>bdO :%bdelete!<bar>edit#<bar>bnext<bar>bdelete!<CR>

				nnoremap <silent> <Leader>bs :call ScratchBuffer('e')<CR>
				nnoremap <silent> <Leader>bS :call ScratchBuffer('e', 1)<CR>

				nnoremap <silent> <Leader>bwc :write<CR>
				nnoremap <silent> <Leader>bwa :wall<CR>
				nnoremap <silent> <Leader>bwC :write!<CR>
				nnoremap <silent> <Leader>bwA :wall!<CR>
				nnoremap <silent> <C-s> :w<CR>
				nnoremap <silent> <C-S-s> :wall<CR>

				"shortcuts
				nnoremap <Leader>` <C-^>
				nnoremap <silent> <A-d> :bp<bar>sp<bar>bn<bar>bd<CR>
				nnoremap <silent> <A-n> :bprevious<CR>
				nnoremap <silent> <A-p> :bnext<CR>
			"WINDOWS
				nnoremap <silent> <Leader>wh :sp<CR>
				nnoremap <silent> <Leader>wv :vsp<CR>
				nnoremap <silent> <Leader>wH :new<CR>
				nnoremap <silent> <Leader>wV :vnew<CR>
				nnoremap <silent> <Leader>wo :only<CR>
				nnoremap <silent> <Leader>wc :close<CR>
				nnoremap <silent> <Leader>w= <C-w>=

				"layouts
				nnoremap <silent> <Leader>w3v :only<bar>vsplit<bar>split<bar>wincmd h<CR>
				nnoremap <silent> <Leader>w3h :only<bar>split<bar>vsplit<bar>wincmd k<CR>
				nnoremap <silent> <Leader>w4d :only<bar>vsplit<bar>split<bar>wincmd h<bar>split<bar>wincmd k<CR>
				nnoremap <silent> <Leader>w4v :only<bar>vsplit<bar>split<bar>split<bar>wincmd h<CR>
				nnoremap <silent> <Leader>w4h :only<bar>split<bar>vsplit<bar>vsplit<bar>wincmd k<CR>
				nnoremap <silent> <Leader>w5v :only<bar>vsplit<bar>split<bar>split<bar>split<bar>wincmd h<CR>
				nnoremap <silent> <Leader>w5h :only<bar>split<bar>vsplit<bar>vsplit<bar>vsplit<bar>wincmd k<CR>

				if has('nvim')
					execute 'nnoremap <silent> <' . g:action_leader . '-h> <C-w><C-h>'
					execute 'nnoremap <silent> <' . g:action_leader . '-j> <C-w><C-j>'
					execute 'nnoremap <silent> <' . g:action_leader . '-k> <C-w><C-k>'
					execute 'nnoremap <silent> <' . g:action_leader . '-l> <C-w><C-l>'

					execute 'inoremap <silent> <' . g:action_leader . '-h> <ESC><C-w><C-h>'
					execute 'inoremap <silent> <' . g:action_leader . '-j> <ESC><C-w><C-j>'
					execute 'inoremap <silent> <' . g:action_leader . '-k> <ESC><C-w><C-k>'
					execute 'inoremap <silent> <' . g:action_leader . '-l> <ESC><C-w><C-l>'

					"window navigation for non-floating terminals
					execute 'tnoremap <silent> <' . g:action_leader . '-h> <C-\><C-n><C-w>h'
					execute 'tnoremap <silent> <' . g:action_leader . '-j> <C-\><C-n><C-w>j'
					execute 'tnoremap <silent> <' . g:action_leader . '-k> <C-\><C-n><C-w>k'
					execute 'tnoremap <silent> <' . g:action_leader . '-l> <C-\><C-n><C-w>l'
				endif
			"TERMINAL
				if has('nvim')
					"MAPPINGS
						"<esc>
						execute 'tnoremap <silent> <' . g:action_leader . '-[> <C-\><C-n>'

						"vim-registers
						tnoremap <silent> <expr> <A-'> '<C-\><C-N>"'.nr2char(getchar()).'pi'
					"ALIASES
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
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gcs git show  \| delta \| bat<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'gcS git show  \| delta \| bat<C-LEFT><C-LEFT><LEFT><LEFT><LEFT>'

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
							execute 'tnoremap <silent> ' . g:terminal_leader . 'sq exit<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'sc clear<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'sp <space>\|<space>'
						"NPM
							execute 'tnoremap <silent> ' . g:terminal_leader . 'ns npm run start<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'nt npm run test<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'nb npm run build<CR>'
							execute 'tnoremap <silent> ' . g:terminal_leader . 'ni npm install --save '
							execute 'tnoremap <silent> ' . g:terminal_leader . 'nd npm install --save-dev '
					"VISH
						"CONFIGURATION
							"let g:modes   = ['N','I']
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
		"MODE:INSERT
		"MODE:COMMAND
		"SOURCE
			nnoremap <silent> <expr> <Leader>vc ':edit '   . g:jaat_config_path . '<CR>'
			nnoremap <silent> <expr> <Leader>vs ':source ' . g:jaat_config_path . '<CR>'
		"PLUGINS
			nnoremap <silent> <Leader>vpl :PlugStatus<CR>
			nnoremap <silent> <Leader>vpi :PlugInstall<CR>
			nnoremap <silent> <Leader>vpu :PlugUpdate<CR>
			nnoremap <silent> <Leader>vpU :PlugClean<CR>
	"LOCALLEADER
		"CODING
			nnoremap <silent> <LocalLeader>cm :make<CR>
		"MESS
			"TEXT
			"MARKUP
				"MARKDOWN
					"@TODO:FIX
					augroup MARKDOWN
						au!
						"au FileType markdown nmap <buffer> <LocalLeader>ch :call RunNpmCommand('', "%", 'gh-markdown-cli')<CR>
						"au FileType markdown vmap <buffer> <LocalLeader>ch :call RunNpmCommand('mdown', '', "'<,'>", 'gh-markdown-cli')<CR>
					augroup END
				"XML
					augroup XML
						au!
						au FileType xml nmap <buffer> <LocalLeader>cj :call RunNpmCommand('x2j', '', '%', 'x2j-cli')<CR>
						au FileType xml vmap <buffer> <LocalLeader>cj :call RunNpmCommand('x2j', '', "'<,'>", 'x2j-cli')<CR>
					augroup END
				"MATH
					augroup MATH
						au!
						"OPERATORS
							"ALGEBRIC
								au FileType math iabbrev <buffer> is =
									au FileType math iabbrev <buffer> equal =
									au FileType math iabbrev <buffer> equals =
									au FileType math iabbrev <buffer> equalsto =
								au FileType math iabbrev <buffer> add +
								au FileType math iabbrev <buffer> sub -
								au FileType math iabbrev <buffer> lt <
								au FileType math iabbrev <buffer> gt >
								au FileType math iabbrev <buffer> le ≤
									au FileType math iabbrev <buffer> <= ≤
								au FileType math iabbrev <buffer> ge ≥
									au FileType math iabbrev <buffer> >= ≥
								au FileType math iabbrev <buffer> ne ≠
									au FileType math iabbrev <buffer> != ≠
								au FileType math iabbrev <buffer> == ⇔
								au FileType math iabbrev <buffer> . ∙
								au FileType math iabbrev <buffer> \ ÷
									au FileType math iabbrev <buffer> div ÷
							"SET
								au FileType math iabbrev <buffer> su ∪
								au FileType math iabbrev <buffer> si ∩
						"FUNCTIONS
							"CALCULAS
								au FileType math iabbrev <buffer> int ∫
								au FileType math iabbrev <buffer> int2 ∬
								au FileType math iabbrev <buffer> int3 ∭
								au FileType math iabbrev <buffer> int4 ⨌
								au FileType math iabbrev <buffer> diff 𝛛
							"ALGEBRIC
								au FileType math iabbrev <buffer> sqrt √
								au FileType math iabbrev <buffer> cbrt ∛
								au FileType math iabbrev <buffer> qdrt ∜
						"SYMBOLS
							"MATH
								au FileType math iabbrev <buffer> inf ∞
								au FileType math iabbrev <buffer> ninf -∞
								au FileType math iabbrev <buffer> pm ±
								au FileType math iabbrev <buffer> mp ∓
							"NUMBERS
								au FileType math iabbrev <buffer> 0u ⁰<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 1u ¹<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 2u ²<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 3u ³<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 4u ⁴<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 5u ⁵<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 6u ⁶<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 7u ⁷<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 8u ⁸<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 9u ⁹<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 0d ₀<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 1d ₁<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 2d ₂<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 3d ₃<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 4d ₄<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 5d ₅<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 6d ₆<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 7d ₇<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 8d ₈<ESC>F<SPACE>xa
								au FileType math iabbrev <buffer> 9d ₉<ESC>F<SPACE>xa
							"LATIN
								au FileType math iabbrev <buffer> alpha 𝛂
								au FileType math iabbrev <buffer> beta 𝛃
								au FileType math iabbrev <buffer> gamma 𝛄
								au FileType math iabbrev <buffer> delta 𝛅
								au FileType math iabbrev <buffer> epsi 𝛆
								au FileType math iabbrev <buffer> eta 𝛈
								au FileType math iabbrev <buffer> theta 𝛉
								au FileType math iabbrev <buffer> lambda 𝛌
								au FileType math iabbrev <buffer> mu 𝛍
								au FileType math iabbrev <buffer> nu 𝛎
								au FileType math iabbrev <buffer> pi 𝛑
								au FileType math iabbrev <buffer> rho 𝛒
								au FileType math iabbrev <buffer> sigma 𝛔
								au FileType math iabbrev <buffer> tau 𝛕
								au FileType math iabbrev <buffer> upsi 𝛖
								au FileType math iabbrev <buffer> phi 𝛟
								au FileType math iabbrev <buffer> chi 𝛘
								au FileType math iabbrev <buffer> psi 𝛙
								au FileType math iabbrev <buffer> omega 𝛚
								au FileType math iabbrev <buffer> kpi 𝛞
						"RANDOM
							au FileType math iabbrev <buffer> tf ∴
								au FileType math iabbrev <buffer> therefore ∴
							au FileType math iabbrev <buffer> ie ∵
							au FileType math iabbrev <buffer> ... ⋯
					augroup END
			"FRONTEND
				"PUG|JADE
					"FUNCTIONS
						function! Pug(range)
							call RunNpmCommand('pug', '-P', a:range, 'pug-cli')
						endfunction
					"MAPPINGS
						augroup PUG
							au!
							au FileType jade,pug map  <buffer> <LocalLeader>cw :JadeWatch html vertical<CR>
							au FileType jade,pug nmap <buffer> <LocalLeader>cc :<C-u> call Pug('')<CR>
							au FileType jade,pug vmap <buffer> <LocalLeader>cc :<C-u> call Pug("'<,'>")<CR>
							au FileType jade,pug nmap <buffer> <LocalLeader>cb :<C-u> call Pug('%')<CR>
						augroup END
				"HTML
					"FUNCTIONS
						function! Html2Pug(range)
							call RunNpmCommand('html2pug', '-f', a:range, 'html2pug')
						endfunction
					"MAPPINGS
						augroup HTML
							au!
							au FileType html nmap <buffer> <LocalLeader>cj :call Html2Pug('%')<CR>
							au FileType html vmap <buffer> <LocalLeader>cj :call Html2Pug("'<,'>")<CR>
						augroup END
				"CSS
			"WORDPRESS
				augroup WORDPRESS
					au!
					au BufEnter wordpress set filetype=jade
					au BufEnter wordpress map <buffer> <LocalLeader>ch :<C-u>call Pug('12,$')<CR>
					au BufEnter wordpress map <buffer> <LocalLeader>cj :<C-u>call Html2Pug('12,$')<CR>
				augroup END
	"MODE-LEADER
	"MOTION-LEADER
	"ACTION-LEADER
	"INSERT-LEADER
	"COMMAND-LEADER
		"GIT
			"TODO:FIX
			execute 'cnoremap <silent> ' . g:command_leader . 'gi :!git init<CR>'
			execute 'cnoremap <silent> ' . g:command_leader . 'gC :!git clone '

			execute 'cnoremap <silent> ' . g:command_leader . 'ga :!git add **<LEFT>'
			execute 'cnoremap <silent> ' . g:command_leader . 'gd :!git diff ** \| delta<C-LEFT><LEFT><LEFT><LEFT><LEFT>'
			execute 'cnoremap <silent> ' . g:command_leader . 'gs :!git status<CR>'
			execute 'cnoremap <silent> ' . g:command_leader . 'gD :!git checkout -- '

			execute 'cnoremap <silent> ' . g:command_leader . 'grp :!git pull '
			execute 'cnoremap <silent> ' . g:command_leader . 'grP :!git push '

			execute 'cnoremap <silent> ' . g:command_leader . 'gSs :!git stash<CR>'
			execute 'cnoremap <silent> ' . g:command_leader . 'gSl :!git stash list<CR>'
			execute 'cnoremap <silent> ' . g:command_leader . 'gSa :!git stash apply<CR>'
			execute 'cnoremap <silent> ' . g:command_leader . 'gSp :!git stash pop<CR>'

			execute 'cnoremap <silent> ' . g:command_leader . 'gcm :!git commit -m ""<LEFT>'
			execute 'cnoremap <silent> ' . g:command_leader . 'gca :!git commit --amend'
			execute 'cnoremap <silent> ' . g:command_leader . 'gcl :!git log<CR>'

			execute 'cnoremap <silent> ' . g:command_leader . 'gbl :!git branch<CR>'
			execute 'cnoremap <silent> ' . g:command_leader . 'gbn :!git branch '
			execute 'cnoremap <silent> ' . g:command_leader . 'gbc :!git checkout '
			execute 'cnoremap <silent> ' . g:command_leader . 'gbC :!git checkout -b '
			execute 'cnoremap <silent> ' . g:command_leader . 'gbN :!git checkout -b '
		"VIM
	"TERMINAL-LEADER
	"RANDOM
