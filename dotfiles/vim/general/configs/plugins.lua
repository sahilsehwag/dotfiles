local concat = require('libs.utils').table.list.concat

local core = {
	--general
	'tpope/vim-capslock',
	'tpope/vim-repeat',
	{'Iron-E/nvim-libmodal', 'Iron-E/vim-libmodal'},
	'kana/vim-submode',
	'vim-scripts/vim-easy-submode',
	'neovim/nvim-lspconfig',
	'nvim-treesitter/nvim-treesitter',

	--dependencies
	'kana/vim-textobj-user',
	'kana/vim-operator-user',
	'Shougo/vimproc.vim',

	--operator
	--'haya14busa/vim-operator-flashy',
	'tpope/vim-surround',
	'junegunn/vim-easy-align',
	'svermeulen/vim-subversive',
	'tommcdo/vim-exchange',
	'JRasmusBm/vim-peculiar',
	'arthurxavierx/vim-caser',
	'gustavo-hms/vim-duplicate',
	--'rjayatilleka/vim-operator-goto',
	--'deris/vim-operator-insert',

	--objects
	'wellle/targets.vim',
	'michaeljsmith/vim-indent-object',
	'Julian/vim-textobj-variable-segment',
	'saaguero/vim-textobj-pastedtext',
	'rhysd/vim-textobj-lastinserted',
	'coderifous/textobj-word-column.vim',
	'rhysd/vim-textobj-anyblock',
	'thinca/vim-textobj-between',
	'sgur/vim-textobj-parameter',
	'glts/vim-textobj-comment',
	'nvim-treesitter/nvim-treesitter-textobjects',
	--'Jason-M-Chan/ts-textobjects',
	'RRethy/nvim-treesitter-textsubjects',
	'singlexyz/treesitter-frontend-textobjects',
	'mfussenegger/nvim-ts-hint-textobject',
	'David-Kunz/treesitter-unit',
	'tommcdo/vim-ninja-feet',

	--motion
	--{'vim-scripts/repmo.vim', 'Houl/repmo-vim'},
	'chaoren/vim-wordmotion',
	'haya14busa/vim-edgemotion',

	--jumps
	'kwkarlwang/bufjump.nvim',
	{'andymass/vim-matchup', 'theHamsta/nvim-treesitter-pairs'},
	'kshenoy/vim-signature',

	--aesthetics
	'itchyny/vim-cursorword',
	'markonm/traces.vim',
	-- 'inside/vim-search-pulse',

	--search
	{'rhysd/clever-f.vim', 'justinmk/vim-sneak'},
	--'unblevable/quick-scope',
	--'haya14busa/incsearch.vim',
	--'haya14busa/incsearch-fuzzy.vim',
	'haya14busa/vim-asterisk',
	'bronson/vim-visual-star-search',
	--{'ironhouzi/starlite-nvim', 'ironhouzi/vim-stim'},

	--operations
	'machakann/vim-swap',
	'AndrewRadev/splitjoin.vim',
	'dkarter/bullets.vim',
	'lambdalisue/reword.vim',
	{'jiangmiao/auto-pairs', 'windwp/nvim-autopairs'},
	{'NTBBloodbath/color-converter.nvim', 'amadeus/vim-convert-color-to'},
	'terryma/vim-expand-region',

	--programming
	{'scrooloose/nerdcommenter', 'tpope/vim-commentary', 'b3nj5m1n/kommentary'},

	--treesitter
	'nvim-treesitter/playground',
	'p00f/nvim-ts-rainbow',
	'windwp/nvim-ts-autotag',
	's1n7ax/nvim-comment-frame',
	'JoosepAlviste/nvim-ts-context-commentstring',
	--{'wellle/context.vim', 'romgrk/nvim-treesitter-context'},
	'haringsrob/nvim_context_vt',
	'nvim-treesitter/nvim-treesitter-refactor',
	'winston0410/smart-cursor.nvim',
	--'nvim-treesitter/nvim-tree-docs',

	--random
	'tyru/open-browser.vim',
	'jbyuki/nabla.nvim',
}
local editor = {
	-- editing
	'terryma/vim-multiple-cursors',

	--jumps
	'nacro90/numb.nvim',

	--editor.general
	'gelguy/wilder.nvim',
	{'liuchengxu/vim-which-key', 'folke/which-key.nvim'},
	'abdalrahman-ali/vim-remembers',
	'rcarriga/nvim-notify',
	'kevinhwang91/nvim-bqf',
	'mbbill/undotree',
	{
		'svermeulen/vim-macrobatics',
		{'dohsimpson/vim-macroeditor', 'rbong/vim-buffest'},
	},
	'notomo/cmdbuf.nvim',
	'joechrisellis/vim-git-arglist',
	--'junegunn/vim-peekaboo',
	--not-working
	'boson-joe/vimwintab',

	--editor.aesthetics
	{'romgrk/barbar.nvim', 'akinsho/nvim-bufferline.lua', 'bling/vim-bufferline',},
	{'glepnir/galaxyline.nvim', 'hoob3rt/lualine.nvim', 'vim-airline/vim-airline', 'itchyny/lightline.vim'},

	--buffer
	{'kevinhwang91/nvim-hlslens', 'osyo-manga/vim-anzu'},
	'lukas-reineke/indent-blankline.nvim',
	'itchyny/vim-highlighturl',

	-- window
	'sindrets/winshift.nvim',
	{'beauwilliams/focus.nvim', 'szw/vim-maximizer'},

	--buffer
	'kazhala/close-buffers.nvim',
	'pseewald/vim-anyfold',
	-- 'arecarn/vim-fold-cycle',

	-- colorcshemes
	{
		--testing
		--'challenger-deep-theme/vim',
		--'Pocco81/Catppuccino.nvim',
		--'yashguptaz/calvera-dark.nvim',
		--'Shadorain/shadotheme',
		--'wuelnerdotexe/vim-enfocado',

		--stable
		'EdenEast/nightfox.nvim',
		'projekt0n/github-nvim-theme',
		'eddyekofo94/gruvbox-flat.nvim',
		{'folke/tokyonight.nvim', 'ghifarit53/tokyonight-vim'},
		{'Mofiqul/vscode.nvim', 'tomasiser/vim-code-dark'},
		{'kaicataldo/material.vim', 'marko-cerovac/material.nvim'},

		--good
		'christianchiarulli/nvcode-color-schemes.vim',
		'KeitaNakamura/neodark.vim',
		'Mangeshrex/uwu.vim',
		'ayu-theme/ayu-vim',
		'sindresorhus/focus',

		--okish
		'KabbAmine/yowish.vim',
		'tyrannicaltoucan/vim-quantum',
		'raphamorim/lucario',
		'arzg/vim-corvine',

		--collections
		'rockerBOO/boo-colorscheme-nvim',
		'flazz/vim-colorschemes',
		'rafi/awesome-vim-colorschemes',
		'chriskempson/base16-vim',
		'i3d/vim-jimbothemes',
	},

	-- clients
	'glacambre/firenvim',
}
local default = {
	--dependencies
	'MunifTanjim/nui.nvim',
	'RishabhRD/popfix',

	--operators
	--'haya14busa/vim-easyoperator-line',
	--'haya14busa/vim-easyoperator-phrase',

	--search
	--'easymotion/vim-easymotion',
	--'haya14busa/incsearch-easymotion.vim',
	'lambdalisue/lista.nvim',
	'osyo-manga/vim-hopping',
	{'windwp/nvim-spectre', 'brooth/far.vim'},

	--editor.general
	'dstein64/vim-startuptime',
	{'mhinz/vim-startify', 'glepnir/dashboard-nvim'},
	'mtth/scratch.vim',
	'jbyuki/venn.nvim',
	--'GustavoKatel/sidebar.nvim',

	--system
	'junegunn/fzf',
	'junegunn/fzf.vim',
	'pbogut/fzf-mru.vim',
	'dominickng/fzf-session.vim',
	'yuki-ycino/fzf-preview.vim',
	'nvim-telescope/telescope.nvim',
	{'voldikss/vim-floaterm', 'akinsho/toggleterm.nvim'},
	'kyazdani42/nvim-tree.lua',

	--buffer.general
	{'dstein64/nvim-scrollview', 'Xuyuanp/scrollbar.nvim'},
	{'karb94/neoscroll.nvim', 'psliwka/vim-smoothie', 'joeytwiddle/sexy_scroller.vim'},
	'el-iot/buffer-tree-explorer',

	--window
	--'camspiers/animate.vim',
	--'camspiers/lens.vim',
	--'blueyed/vim-diminactive',

	--random
	'edluffy/hologram.nvim',
}
local ide = {
	--editor.general
	--'wfxr/minimap.vim',
	'SmiteshP/nvim-gps',

	--buffer.aesthetics
	'folke/todo-comments.nvim',
	{'folke/zen-mode.nvim', 'junegunn/goyo.vim'},
	{'folke/twilight.nvim', 'junegunn/limelight.vim'},
	--'axlebedev/footprints',

	--programming.completion
	'L3MON4D3/LuaSnip',
	'SirVer/ultisnips',
	{ 'hrsh7th/vim-vsnip', 'norcalli/snippets.nvim' },
	{'hrsh7th/nvim-compe', 'ms-jpq/coq_nvim'},

	--programming.lsp
	'neoclide/coc.nvim',
	'folke/trouble.nvim',
	'folke/lsp-colors.nvim',
	'RishabhRD/nvim-lsputils',
	'rmagatti/goto-preview',
	'glepnir/lspsaga.nvim',
	'kosayoda/nvim-lightbulb',
	'ray-x/lsp_signature.nvim',
	'onsails/lspkind-nvim',
	'jose-elias-alvarez/nvim-lsp-ts-utils',
	'folke/lua-dev.nvim',
	--'nvim-lua/lsp-status.nvim',
	--'doums/lsp_spinner.nvim',
	--'onsails/vimway-lsp-diag.nvim',

	--progrmaming.general
	-- 'ludovicchabant/vim-gutentags',
	'mattn/emmet-vim',
	{ 'liuchengxu/vista.vim', 'majutsushi/tagbar' },
	'kkoomen/vim-doge',

	--programming.syntax
	'luochen1990/rainbow',
	'vim-syntastic/syntastic',
	'coachshea/jade-vim',
	'sheerun/vim-polyglot',
	'jparise/vim-graphql',
	'chrisbra/csv.vim',
	'norcalli/nvim-colorizer.lua',
	'plasticboy/vim-markdown',

	--programming.execution
	'metakirby5/codi.vim',
	'arkwright/vim-whiteboard',
	{'iamcco/markdown-preview.nvim', 'suan/vim-instant-markdown'},

	--programming.vcs
	{'tpope/vim-fugitive', 'tanvirtin/vgit.nvim', 'TimUntersberger/neogit'},
	{'airblade/vim-gitgutter', 'lewis6991/gitsigns.nvim'},
	'ttys3/nvim-blamer.lua',
	'sindrets/diffview.nvim',
	'rhysd/conflict-marker.vim',
	'rhysd/git-messenger.vim',
	'ruifm/gitlinker.nvim',
	--'pwntester/octo.nvim',

	--programming.testing
	'vim-test/vim-test',

	--programming.debugging
	'mfussenegger/nvim-dap',

	--programming.random
	'vuki656/package-info.nvim',
	'ayosec/hltermpaste.vim',
	--'alpertuna/vim-header',
	--'shanzi/autoHEADER',
}
local configuration = {
	--random
	'tpope/vim-scriptease',

	--api
	'tweekmonster/nvim-api-viewer',

	--colors
	'rktjmp/lush.nvim',
}
local markup = {
	--'kristijanhusak/orgmode.nvim',
	--'akinsho/org-bullets.nvim',
}
local featured = {
	--system
	'edkolev/tmuxline.vim',
	'edkolev/promptline.vim',
	'vim-scripts/WholeLineColor',

	--operations
	'tpope/vim-speeddating',

	--authoring
	'reedes/vim-pencil',
	'panozzaj/vim-autocorrect',

	--random
	--'MrPeterLee/VimWordpress',
}
local testing = {
	'dstein64/vim-menu',
	'r1ri/suffer',
	'lukas-reineke/headlines.nvim',
	'jameshiew/nvim-magic',
	'vigoux/architext.nvim',
	'noscript/taberian.vim',
	'tjdevries/colorbuddy.nvim',
	'dm1try/golden_size',
	'tpope/vim-dadbod',
	'vim-scripts/DrawIt',
	'itchyny/calendar.vim',
	'itchyny/dictionary.vim',
	'leothelocust/vim-makecols',
	'mattn/webapi-vim',
	'svermeulen/vim-yoink',
	'gastonsimone/vim-dokumentary',
	'sbdchd/vim-shebang',
	'vim-utils/vim-read',
	'antoyo/vim-licenses',
	'natw/keyboard_cat.vim',
	'vim-scripts/autoscroll.vim',
	'fadein/vim-FIGlet',
	'chrisbra/changesPlugin',
	'liuchengxu/vim-clap',
	'RRethy/vim-illuminate',
	'lucerion/vim-executor',
	'vim-scripts/Omap.vim',
	'tyru/capture.vim',
	'JarrodCTaylor/vim-shell-executor',
	'tommcdo/vim-express',
	'syngan/vim-operator-evalf',
	'neitanod/vim-sade',
	'chimay/wheel',
	'osyo-manga/vim-operator-blockwise',
	'osyo-manga/vim-operator-stay-cursor',
	'syngan/vim-operator-furround',
	'thinca/vim-operator-sequence',
	'syngan/vim-operator-keeppos',
	'blackbeltscripting/vim-paste-operator',
	'jeanCarloMachado/vim-toop',
	'lewis6991/spellsitter.nvim',
	'sickill/vim-pasta',
	'lfv89/vim-foldfocus',
	'anschnapp/move-less',
	'fergdev/vim-cursor-hist',
	'gcmt/wildfire.vim',
	'lambacck/preserve-vim',
	'godlygeek/tabular',
	'wellle/visual-split.vim',
	'spiiph/vim-space',
	'tpope/vim-unimpaired',
	't9md/vim-transform',
	'vim-scripts/MultipleSearch',
	'henrik/vim-indexed-search',
	'zirrostig/vim-schlepp',
	'fmoralesc/vim-pad',
	'tenfyzhong/axring.vim',
	-- 'TaDaa/vimade',
	-- 'obcat/vim-hitspop',
	'kopischke/vim-fetch',
	'gyim/vim-boxdraw',
	'vim-scripts/ScrollColors',
	'gorodinskiy/vim-coloresque',
	'kyuhi/vim-emoji-complete',
	'ripxorip/aerojump.nvim',
	'drzel/vim-repo-edit',
	'romainl/vim-cool',
	'haya14busa/vim-keeppad',
	'zefei/vim-colortuner',
	'creativenull/diagnosticls-nvim',
	-- 'davidbeckingsale/writegood.vim',
	'dbmrq/vim-ditto',
	'reedes/vim-lexical',
	'guns/xterm-color-table.vim',
	'haya14busa/vim-signjk-motion',
	'haya14busa/vim-over',
	--'romainl/vim-qf',
	--'tpope/vim-obsession',
	'tommcdo/vim-centaur',
	'tpope/vim-abolish',
	'lambdalisue/guise.vim',
	'rexagod/samwise.nvim',
}

return {
	setup = function()
	end,
	hooks = {
		--TODO
		vimEnter = function()
		end,
		vimExit = function()
		end,
	},
	plugins = {
		['author/name'] = {
			url = '',
			branch = '',
			tag = '',
			commit = '',
			alias = '',
			rtp = '',
			directory = '',
			dependencies = {
				pre = {},
				post = {},
			},
			is_enabled = function()
			end,
			is_locked = function()
			end,
			config = '',
			should_load_config = true,
			post_install = '',
			lazyload = {
				events = {},
				cmds = {},
				filetypes = {},
			},
			hooks = {
				before_plugin_install = function()
				end,
				after_plugin_install = function()
				end,
				before_plugin_load = function()
				end,
				after_plugin_load = function()
				end,
				before_config_load = function()
				end,
				after_config_load = function()
				end,
			},
		},

		--libraries
		['MunifTanjim/nui.nvim'] = {
			url = 'MunifTanjim/nui.nvim',
			should_load_config = false,
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},

		--EDITING
		--editing/operators
		--editing/motions
		--editing/objects
		--editing/search
		--editing/jump
		['kwkarlwang/bufjump.nvim'] = {
			url = 'kwkarlwang/bufjump.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			config = function()
				require("bufjump").setup({
					backward = "<C-S-o>",
					forward = "<C-S-i>",
				})
			end,
		},
		--editing/random
		['Rasukarusan/nvim-select-multi-line'] = {
			url = 'Rasukarusan/nvim-select-multi-line',
			is_enabled = function()
				return vim.fn.has('nvim-0.4') == 1
			end,
		},
		['jbyuki/nabla.nvim'] = {
			url = 'jbyuki/nabla.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			config = function()
				vim.cmd [[
					nnoremap <Leader>em :lua require("nabla").action()<CR>
				]]
			end,
		},
		['Iron-E/nvim-libmodal'] = {
			url = 'Iron-E/nvim-libmodal',
			branch = 'master',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['windwp/nvim-autopairs'] = {
			url = 'windwp/nvim-autopairs',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},

		--EDITOR
		--editor/feature
		['windwp/nvim-spectre'] = {
			url = 'windwp/nvim-spectre',
			is_enabled = function()
				return (
					vim.fn.has('nvim-0.5') == 1 and
					vim.fn.executable('rg') == 1 and
					vim.fn.executable('sed') == 1
				)
			end,
			dependencies = {
				pre = {
					'nvim-lua/plenary.nvim',
					'nvim-lua/popup.nvim',
					'kyazdani42/nvim-web-devicons',
					'ryanoasis/vim-devicons',
				},
			},
		},
		['rexagod/samwise.nvim'] = {
			url = 'rexagod/samwise.nvim',
			is_enabled = function()
				return vim.fn.has('nvim') == 1
			end,
		},
		['glepnir/dashboard-nvim'] = {
			url = 'glepnir/dashboard-nvim',
			is_enabled = function()
				return vim.fn.has('nvim') == 1
			end,
		},
		['gelguy/wilder.nvim'] = {
			url = 'gelguy/wilder.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.3') == 1 or vim.v.version >= 810
			end,
			post_install = ':UpdateRemotePlugins',
			dependencies = {
				pre = {
					'roxma/nvim-yarp',
					'roxma/vim-hug-neovim-rpc',
					'nixprime/cpsm',
				},
			},
		},
		['dstein64/vim-startuptime'] = {
			url = 'dstein64/vim-startuptime',
			is_enabled = function()
				return vim.fn.has('nvim-0.3.1') == 1 or vim.v.version >= 810
			end,
		},

		--editor/colorschemes
		['EdenEast/nightfox.nvim'] = {
			url = 'EdenEast/nightfox.nvim',
			config = function()
				vim.cmd('colorscheme nightfox')
			end,
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			hooks = {
				after_plugin_load = function()
					-- focus.nvim
					-- #1d2836 #1f2a38
					vim.cmd('hi UnfocusedWindow guibg=#1f2a38')
				end,
			},
		},
		['wuelnerdotexe/vim-enfocado'] = {
			url = 'wuelnerdotexe/vim-enfocado',
			config = function()
				vim.cmd('set termguicolors')
				vim.cmd('colorscheme enfocado')
				--vim.cmd('autocmd VimEnter * ++nested colorscheme enfocado')
			end
		},
		['projekt0n/github-nvim-theme'] = {
			url = 'projekt0n/github-nvim-theme',
			config = function()
				--vim.cmd('colorscheme github_dimmed')
				--vim.cmd('colorscheme github_dark')
				--vim.cmd('colorscheme github_light')
				vim.cmd('colorscheme github_dark_default')
				--vim.cmd('colorscheme github_light_default')
			end,
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['challenger-deep-theme/vim'] = {
			url = 'challenger-deep-theme/vim',
			config = function()
				vim.cmd [[ colorscheme challenger_deep ]]
			end,
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			alias = 'challenger-deep',
		},
		['Mofiqul/vscode.nvim'] = {
			url = 'Mofiqul/vscode.nvim',
			config = function()
				vim.cmd [[
					let g:vscode_style = "dark"
					colorscheme vscode
				]]
			end,
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['folke/tokyonight.nvim'] = {
			url = 'folke/tokyonight.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['Pocco81/Catppuccino.nvim'] = {
			url = 'Pocco81/Catppuccino.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['Mangeshrex/uwu.vim'] = {
			url = 'Mangeshrex/uwu.vim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['yashguptaz/calvera-dark.nvim'] = {
			url = 'yashguptaz/calvera-dark.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.4') == 1
			end,
			config = function()
				vim.cmd [[ colorscheme calvera ]]
			end,
		},
		['Shadorain/shadotheme'] = {
			url = 'Shadorain/shadotheme',
			config = function()
				vim.cmd [[ colorscheme xshado ]]
			end,
		},
		['christianchiarulli/nvcode-color-schemes.vim'] = {
			url = 'christianchiarulli/nvcode-color-schemes.vim',
			config = function()
				vim.cmd [[ colorscheme aurora ]]
			end,
		},
		['marko-cerovac/material.nvim'] = {
			url = 'marko-cerovac/material.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			config = function()
				vim.g.material_style = 'deep ocean'
				vim.cmd [[ colorscheme material ]]
			end,
		},
		['eddyekofo94/gruvbox-flat.nvim'] = {
			url = 'eddyekofo94/gruvbox-flat.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			config = function()
				vim.cmd [[ colorscheme gruvbox-flat ]]
			end,
		},
		['rockerBOO/boo-colorscheme-nvim'] = {
			url = 'rockerBOO/boo-colorscheme-nvim',
			config = function()
				vim.cmd [[
					if (has("termguicolors"))
						set termguicolors
					endif
					colorscheme boo
				]]
			end,
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['sindresorhus/focus'] = {
			url = 'sindresorhus/focus',
			config = function()
				vim.cmd('colorscheme focus')
			end,
			rtp = 'vim',
		},

		--editor/ui
		['liuchengxu/vim-which-key'] = {
			url = 'liuchengxu/vim-which-key',
		},
		['wfxr/minimap.vim'] = {
			url = 'wfxr/minimap.vim',
			post_install = ':!cargo install --locked code-minimap',
			is_enabled = function()
				return vim.fn.exists('neovide') == 0 and vim.fn.exists('goneovim') == 0
			end,
		},
		['tyru/open-browser.vim'] = {
			url = 'tyru/open-browser.vim',
		},
		['glepnir/galaxyline.nvim'] = {
			url = 'glepnir/galaxyline.nvim',
			branch = 'main',
			-- should_load_config = true,
			dependencies = {
				-- post = { 'Avimitin/nerd-galaxyline' },
			},
		},
		['rcarriga/nvim-notify'] = {
			url = 'rcarriga/nvim-notify',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['kdheepak/tabline.nvim'] = {
			url = 'kdheepak/tabline.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['romgrk/barbar.nvim'] = {
			url = 'romgrk/barbar.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = { 'kyazdani42/nvim-web-devicons', 'ryanoasis/vim-devicons' }
			}
		},
		['akinsho/nvim-bufferline.lua'] = {
			url = 'akinsho/nvim-bufferline.lua',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = { 'kyazdani42/nvim-web-devicons', 'ryanoasis/vim-devicons' }
			}
		},
		['hoob3rt/lualine.nvim'] = {
			url = 'hoob3rt/lualine.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['vim-airline/vim-airline'] = {
			url = 'vim-airline/vim-airline',
			dependencies = {
				post = {
					'vim-airline/vim-airline-themes',
					'augustold/vim-airline-colornum',
					'paranoida/vim-airlineish',
				},
			},
		},
		['itchyny/lightline.vim'] = {
			url = 'itchyny/lightline.vim',
			dependencies = {
				post = {
					'mengelbrecht/lightline-bufferline',
				}
			},
		},
		['mengelbrecht/lightline-bufferline'] = {
			url = 'mengelbrecht/lightline-bufferline',
			dependencies = {
				pre = {
					'mengelbrecht/lightline',
				},
			},
		},
		['SmiteshP/nvim-gps'] = {
			url = 'SmiteshP/nvim-gps',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = { 'nvim-treesitter/nvim-treesitter' },
			},
		},
		['lukas-reineke/headlines.nvim'] = {
			url = 'lukas-reineke/headlines.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},

		--editor/graphics
		['edluffy/hologram.nvim'] = {
			url = 'edluffy/hologram.nvim',
			is_enabled = function()
				return (
					vim.fn.has('nvim-0.5') == 1 or
					vim.fn.has('macunix') == 1 or
					vim.fn.has('unix') == 1 or
					vim.fn.has('linux') == 1
				)
			end,
		},
		--BUFFER
		--buffer/general
		['kazhala/close-buffers.nvim'] = {
			url = 'kazhala/close-buffers.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['karb94/neoscroll.nvim'] = {
			url = 'karb94/neoscroll.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1 and vim.fn.exists('neovide') == 0 and vim.fn.exists('goneovim') == 0
			end,
		},
		['psliwka/vim-smoothie'] = {
			url = 'psliwka/vim-smoothie',
			is_enabled = function()
				return (
					(vim.fn.has('nvim-0.3') == 1 or vim.v.version >= 800) and
					vim.fn.exists('neovide') == 0 and
					vim.fn.exists('goneovim') == 0
				)
			end,
		},
		['joeytwiddle/sexy_scroller.vim'] = {
			url = 'joeytwiddle/sexy_scroller.vim',
			is_enabled = function()
				return vim.fn.exists('neovide') == 0 and vim.fn.exists('goneovim') == 0
			end,
		},

		--buffer/editing
		['terryma/vim-multiple-cursors'] = {
			url = 'terryma/vim-multiple-cursors',
		},
		['jbyuki/venn.nvim'] = {
			url = 'jbyuki/venn.nvim',
			is_enabled = function()
				return vim.fn.has('nvim') == 1
			end,
		},

		--buffer/ui
		['lukas-reineke/indent-blankline.nvim'] = {
			url = 'lukas-reineke/indent-blankline.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1 and vim.fn.exists('neovide') == 0 and vim.fn.has('goneovim') == 0
			end,
		},
		['mvllow/modes.nvim'] = {
			url = 'mvllow/modes.nvim',
		},
		['ironhouzi/starlite-nvim'] = {
			url = 'ironhouzi/starlite-nvim',
			is_enabled = function()
				return vim.fn.has('nvim') == 1
			end,
		},
		['kevinhwang91/nvim-hlslens'] = {
			url = 'kevinhwang91/nvim-hlslens',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},

		--buffer/colors
		['norcalli/nvim-colorizer.lua'] = {
			url = 'norcalli/nvim-colorizer.lua',
			is_enabled = function()
				return vim.fn.has('nvim') == 1
			end,
		},
		['axlebedev/footprints'] = {
			url = 'axlebedev/footprints',
		},
		['folke/todo-comments.nvim'] = {
			url = 'folke/todo-comments.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},

		--WINDOW
		--window.general
		['sindrets/winshift.nvim'] = {
			url = 'sindrets/winshift.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},

		--window/ui
		['sunjon/Shade.nvim'] = {
			url = 'sunjon/Shade.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.4') == 1
			end,
		},
		['beauwilliams/focus.nvim'] = {
			url = 'beauwilliams/focus.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},

		--TABS

		--SYSTEM
		--system/search
		['junegunn/fzf'] = {
			url = 'junegunn/fzf',
			directory = '~/.fzf',
			post_install = ':call fzf#install()',
		},
		['junegunn/fzf.vim'] = {
			url = 'junegunn/fzf.vim',
			config = 'fzf-vim.vim',
			dependencies = {
				pre = { 'junegunn/fzf' },
			},
		},
		['pbogut/fzf-mru.vim'] = {
			url = 'pbogut/fzf-mru.vim',
			dependencies = {
				pre = { 'junegunn/fzf' },
			},
		},
		['dominickng/fzf-session.vim'] = {
			url = 'dominickng/fzf-session.vim',
			dependencies = {
				pre = { 'junegunn/fzf' },
			},
		},
		['yuki-ycino/fzf-preview.vim'] = {
			url = 'yuki-ycino/fzf-preview.vim',
			branch = 'release/rpc',
			dependencies = {
				pre = { 'junegunn/fzf' },
			},
		},
		['nvim-telescope/telescope.nvim'] = {
			url = 'nvim-telescope/telescope.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' },
			},
		},
		['kyazdani42/nvim-tree.lua'] = {
			url = 'kyazdani42/nvim-tree.lua',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},

		--system/terminal
		['lambdalisue/guise.vim'] = {
			url = 'lambdalisue/guise.vim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = { 'vim-denops/denops.vim' },
			},
		},

		--system/filesystem

		--PROGRAMMING
		--programming/lsp
		['neoclide/coc.nvim'] = {
			url = 'neoclide/coc.nvim',
			branch = 'release',
			is_enabled = function()
				return (
					vim.fn.has('node') == 1 and not (vim.fn.has('nvim-0.5') == 1) and (
						vim.v.version >= 800 or
						vim.fn.has('nvim-0.4') == 1
					)
				)
			end,
			dependencies = {
				post = {
					'Shougo/neco-vim',
					'neoclide/coc-neco',
				},
			},
		},
		['neovim/nvim-lspconfig'] = {
			url = 'neovim/nvim-lspconfig',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			should_load_config = true,
			dependencies = {
				post = { 'williamboman/nvim-lsp-installer' },
			},
			--config = function()
			--	vim.cmd [[ nnoremap <Leader>l.s :LspStart<space> ]]
			--	vim.cmd [[ nnoremap <Leader>l.r :LspRestart<space> ]]
			--	vim.cmd [[ nnoremap <Leader>l.k :LspStop<space> ]]
			--	vim.cmd [[ nnoremap <silent> <Leader>l.i <cmd>LspInfo<cr> ]]
			--end,
		},
		['williamboman/nvim-lsp-installer'] = {
			url = 'williamboman/nvim-lsp-installer',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['creativenull/diagnosticls-nvim'] = {
			url = 'creativenull/diagnosticls-nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			should_load_config = false,
		},
		['nvim-lua/lsp-status.nvim'] = {
			url = 'nvim-lua/lsp-status.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},

		--programming/random
		['b3nj5m1n/kommentary'] = {
			url = 'b3nj5m1n/kommentary',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},

		--programming/treesitter
		['nvim-treesitter/nvim-treesitter'] = {
			url = 'nvim-treesitter/nvim-treesitter',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			post_install = ':TSUpdate',
			hooks = {
				after_plugin_install = function()
					vim.cmd('TSInstall all')
				end
			},
		},
		['nvim-treesitter/playground'] = {
			url = 'nvim-treesitter/playground',
			dependencies = {
				pre = {
					'nvim-treesitter/nvim-treesitter',
				},
			},
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['nvim-treesitter/nvim-treesitter-textobjects'] = {
			url = 'nvim-treesitter/nvim-treesitter-textobjects',
			dependencies = {
				pre = { 'nvim-treesitter/nvim-treesitter' },
			},
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['Jason-M-Chan/ts-textobjects'] = {
			url = 'Jason-M-Chan/ts-textobjects',
			dependencies = {
				pre = { 'nvim-treesitter/nvim-treesitter' },
			},
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['singlexyz/treesitter-frontend-textobjects'] = {
			url = 'singlexyz/treesitter-frontend-textobjects',
			dependencies = {
				pre = {
					'nvim-treesitter/nvim-treesitter',
				},
			},
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['mfussenegger/nvim-ts-hint-textobject'] = {
			url = 'mfussenegger/nvim-ts-hint-textobject',
			dependencies = {
				pre = {
					'nvim-treesitter/nvim-treesitter',
				},
			},
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['JoosepAlviste/nvim-ts-context-commentstring'] = {
			url = 'JoosepAlviste/nvim-ts-context-commentstring',
			dependencies = {
				pre = {
					'nvim-treesitter/nvim-treesitter',
				},
			},
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['romgrk/nvim-treesitter-context'] = {
			url = 'romgrk/nvim-treesitter-context',
			dependencies = {
				pre = { 'nvim-treesitter/nvim-treesitter' },
			},
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['haringsrob/nvim_context_vt'] = {
			url = 'haringsrob/nvim_context_vt',
			dependencies = {
				pre = { 'nvim-treesitter/nvim-treesitter' },
			},
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['nvim-treesitter/nvim-treesitter-refactor'] = {
			url = 'nvim-treesitter/nvim-treesitter-refactor',
			dependencies = {
				pre = { 'nvim-treesitter/nvim-treesitter' },
			},
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['p00f/nvim-ts-rainbow'] = {
			url = 'p00f/nvim-ts-rainbow',
			dependencies = {
				pre = { 'nvim-treesitter/nvim-treesitter' },
			},
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['windwp/nvim-ts-autotag'] = {
			url = 'windwp/nvim-ts-autotag',
			dependencies = {
				pre = { 'nvim-treesitter/nvim-treesitter' },
			},
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},

		--programming/completion
		['hrsh7th/nvim-cmp'] = {
			url = 'hrsh7th/nvim-cmp',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = {},
				post = {},
			},
		},
		['hrsh7th/nvim-compe'] = {
			url = 'hrsh7th/nvim-compe',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = {
					--'L3MON4D3/LuaSnip',
					--'SirVer/ultisnips',
					--'hrsh7th/vim-vsnip',
				},
				--post = { 'tzachar/compe-tabnine' },
			},
		},
		['tzachar/compe-tabnine'] = {
			url = 'tzachar/compe-tabnine',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = { 'hrsh7th/nvim-compe' },
			},
			post_install = './install.sh'
		},
		['L3MON4D3/LuaSnip'] = {
			url = 'L3MON4D3/LuaSnip',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				post = { 'rafamadriz/friendly-snippets' },
			},
		},
		['hrsh7th/vim-vsnip'] = {
			url = 'hrsh7th/vim-vsnip',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				post = {
					'hrsh7th/vim-vsnip-integ',
					'rafamadriz/friendly-snippets',
				},
			},
		},
		['SirVer/ultisnips'] = {
			url = 'SirVer/ultisnips',
			dependencies = {
				post = {
					'honza/vim-snippets',
					'epilande/vim-react-snippets',
				},
			},
			is_enabled = function()
				return vim.fn.has('python3') == 1
			end,
		},
		['ms-jpq/coq_nvim'] = {
			url = 'ms-jpq/coq_nvim',
			branch = 'coq',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				post = { 'ms-jpq/coq.artifacts' },
			},
		},
		['ms-jpq/coq.artifacts'] = {
			url = 'ms-jpq/coq.artifacts',
			branch = 'artifacts',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['jameshiew/nvim-magic'] = {
			url = 'jameshiew/nvim-magic',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			tag = 'v0.2.1',  -- recommended to pin to a tag and update manually as there may be breaking changes
			dependencies = {
				pre = { 'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim' },
			},
			config = function()
				require('nvim-magic').setup({
					use_default_keymap = false,
					backends = {
						default = require('nvim-magic-openai').new({
							api_endpoint = 'https://api.openai.com/v1/engines/cushman-codex/completions',
						}),
					},
				})
			end,
		},

		--programming/vcs
		['TimUntersberger/neogit'] = {
			url = 'TimUntersberger/neogit',
			is_enabled = function()
				return vim.fn.executable('git') == 1 and vim.fn.has('nvim-0.5') == 1
			end,
		},
		['tanvirtin/vgit.nvim'] = {
			url = 'tanvirtin/vgit.nvim',
			is_enabled = function()
				return vim.fn.executable('git') == 1 and vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = { 'nvim-lua/plenary.nvim' },
			},
		},
		['lewis6991/gitsigns.nvim'] = {
			url = 'lewis6991/gitsigns.nvim',
			is_enabled = function()
				return vim.fn.executable('git') == 1 and vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = { 'nvim-lua/plenary.nvim' },
			},
		},
		['sindrets/diffview.nvim'] = {
			url = 'sindrets/diffview.nvim',
			is_enabled = function()
				return vim.fn.executable('git') == 1 and vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = { 'kyazdani42/nvim-web-devicons' },
			},
		},
		['ruifm/gitlinker.nvim'] = {
			url = 'ruifm/gitlinker.nvim',
			is_enabled = function()
				return vim.fn.executable('git') == 1 and vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = { 'nvim-lua/plenary.nvim' },
			},
		},
		['pwntester/octo.nvim'] = {
			url = 'pwntester/octo.nvim',
			is_enabled = function()
				return (
					vim.fn.executable('git') == 1 and
					vim.fn.executable('gh') == 1 and
					vim.fn.has('nvim-0.5') == 1
				)
			end,
		},

		--programming/testing
		['vim-test/vim-test'] = {
			url = 'vim-test/vim-test',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				post = { 'rcarriga/vim-ultest' },
			},
		},
		['rcarriga/vim-ultest'] = {
			url = 'rcarriga/vim-ultest',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = {
					'vim-test/vim-test',
					'roxma/nvim-yarp',
					'roxma/vim-hug-neovim-rpc',
				},
			}
		},

		--programming/debugging
		['mfussenegger/nvim-dap'] = {
			url = 'mfussenegger/nvim-dap',
			is_enabled = function()
				return vim.fn.has('nvim-0.5')
			end,
			dependencies = {
				pre = { 'jbyuki/one-small-step-for-vimkind' },
				post = {
					'Pocco81/DAPInstall.nvim',
					'rcarriga/nvim-dap-ui',
					'theHamsta/nvim-dap-virtual-text',
				},
			},
		},
		['theHamsta/nvim-dap-virtual-text'] = {
			url = 'theHamsta/nvim-dap-virtual-text',
			config = function()
				-- virtual text deactivated (default)
				-- vim.g.dap_virtual_text = false

				-- show virtual text for current frame (recommended)
				vim.g.dap_virtual_text = true

				-- request variable values for all frames (experimental)
				-- vim.g.dap_virtual_text = 'all frames'
			end,
		},

		--programming/miscelleanous
		['tpope/vim-dadbod'] = {
			url = 'tpope/vim-dadbod',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				post = { 'kristijanhusak/vim-dadbod-ui' },
			}
		},
		['kristijanhusak/vim-dadbod-ui'] = {
			url = 'kristijanhusak/vim-dadbod-ui',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = { 'tpope/vim-dadbod' },
			}
		},
		['kkoomen/vim-doge'] = {
			url = 'kkoomen/vim-doge',
			post_install = ':call doge#install()',
		},
		['vuki656/package-info.nvim'] = {
			url = 'vuki656/package-info.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = { 'MunifTanjim/nui.nvim' },
			},
		},

		--CLIENTS
		['glacambre/firenvim'] = {
			url = 'glacambre/firenvim',
			post_install = ':call firenvim#install(0)',
		},

		--RANDOM
		['iamcco/markdown-preview.nvim'] = {
			url = 'iamcco/markdown-preview.nvim',
			lazyload = {
				filetypes = { 'markdown', 'vim-plug' },
			},
			post_install = ':call mkdp#util#install()',
		},
		['vhyrro/neorg'] = {
			url = 'vhyrro/neorg',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = { 'nvim-lua/plenary.nvim' },
			},
		},
	},
	modes = {
		core		 = core,
		minimal  = concat({core, editor}),
		default  = concat({core, editor, configuration, default}),
		ide			 = concat({core, editor, configuration, default, ide}),
		featured = concat({core, editor, configuration, default, ide, featured, markup}),
		testing  = concat({core, editor, configuration, default, ide, featured, markup, testing}),
	},
}
