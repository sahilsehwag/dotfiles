local concat = require('libs.utils').table.list.concat

local is_installed = function(names, handler)
	handler = handler or function(name)
		print(name .. ' is not installed')
	end

	local flag = true
	for _, name in ipairs(names) do
		if vim.fn.executable(name) ~= 1 then
			handler(name)
			flag = false
		end
	end
	return flag
end

local core = {
	--'wbthomason/packer.nvim',

	--general
	--'Tastyep/structlog.nvim',
	'lewis6991/impatient.nvim',
	'tpope/vim-capslock',
	{ 'kana/vim-repeat', 'tpope/vim-repeat' },
	'samjwill/nvim-unception',
	'kana/vim-niceblock',
	'smjonas/live-command.nvim',
	'vim-scripts/LargeFile',
	'thalesmello/nvim-better-operator-message',
	--'haolian9/redostr.nvim',
	--'miversen33/import.nvim',
		--TODO:test

	--arglist
	--'idbrii/vim-argedit',
		--TODO:not working due to :Scratch command, interefering with scratch.vim
	'joechrisellis/vim-git-arglist',

	{
		--'glepnir/mcc.nvim',
		--'kana/vim-smartchr',
	},
	{
    'Pocco81/AbbrevMan.nvim',
    'tpope/vim-abolish',
  },
	'0styx0/abbreinder.nvim',
	'kana/vim-arpeggio',

  --libs.grammar
	'kana/vim-operator-user',
	'kana/vim-textobj-user',
	--'doy/vim-textobj',
	'osyo-manga/vim-textobj-blockwise',
	'osyo-manga/vim-operator-blockwise',
	'wellle/targets.vim',
	--'saulaxel/EXtend.vim',
	--'osyo-manga/vim-operator-stay-cursor',
	--'osyo-manga/vim-operator-exec_command',
	--'osyo-manga/vim-textobj-multitextobj',
	--'osyo-manga/vim-textobj-from_regexp',
	--'thinca/vim-operator-sequence',
	--'lumiliet/vim-smart-object',
	--'johmsalas/shake.nvim',
	--'arsham/archer.nvim',
	--'jeanCarloMachado/vim-toop',
	--'paradigm/TextObjectify',
	--'inkarkat/vim-CountJump',
	--'d4ku/vim-pushover',
	--'jonatan-branting/nvim-better-n',
		--FIX: not working | to avoid overriding insert in last
	--'vim-scripts/repeatable-motions.vim',
	--{'vim-scripts/repmo.vim', 'Houl/repmo-vim'},
	--'hgiesel/vim-motion-sickness',
	--'vim-scripts/motpat.vim',
	--'toupeira/vim-movealong',
	--'leafoftree/vim-blink',
	--'alexeymuranov/vim-maptosideeffects',
	--'zdcthomas/yop.nvim',
	--'liushapku/vim-operator-api',

  --libs.cmds
	--'kana/vim-altercmd',
	--'kana/vim-advice',
	--'coachshea/neo-pipe',

  --libs.modal
	{
		'anuvyklack/hydra.nvim',
		--{'Iron-E/nvim-libmodal', 'Iron-E/vim-libmodal'},
		--'kana/vim-submode',
		--'vim-scripts/vim-easy-submode',
		--'tommcdo/vim-express',
		--'neitanod/vim-sade',
		--'vim-scripts/Omap.vim',
	},
	'anuvyklack/keymap-amend.nvim',

	--{ 't9md/vim-transform', 'inkarkat/vim-TextTransform', --'obxhdx/vim-action-mapper' },
	--'vigoux/architext.nvim',
	--'kana/vim-metarw',
		--'kana/vim-metarw-git',
	--'kana/vim-gf-user',
	--'furkanzmc/options.nvim',

  --intelligence
	--'VonHeikemen/lsp-zero.nvim',
	'neovim/nvim-lspconfig',
	'nvim-treesitter/nvim-treesitter',

	--operator
	'haya14busa/vim-operator-flashy',
	{ 'kylechui/nvim-surround', 'tpope/vim-surround' },
	--'syngan/vim-operator-furround',
		-- FIX: mappings overriding other mappings like dd
	--'gbprod/substitute.nvim',
		-- TODO: not working
		-- INFO: vim-subversive + vim-exchange
	'svermeulen/vim-subversive' ,
	'tommcdo/vim-exchange',
	'junegunn/vim-easy-align',
	'JRasmusBm/vim-peculiar',
	{
    'kana/vim-operator-replace',
    'romgrk/replace.vim',
	},
	'kana/vim-grex',
	{
    --'johmsalas/text-case.nvim',
    'arthurxavierx/vim-caser',
  },
	'gustavo-hms/vim-duplicate',
	'rjayatilleka/vim-operator-goto',
	{ 'tommcdo/vim-ninja-feet', 'bagohart/vim-operator-insert-append' },
	'osyo-manga/vim-operator-search',
	'vim-scripts/operator-star',
	'osyo-manga/vim-operator-highlighter',
	--'osyo-manga/vim-operator-block',
		-- FIX: not-working
	--'svermeulen/vim-cutlass',
	--'rgrinberg/vim-operator-gsearch',
	--'kusabashira/vim-operator-exrange',
	--'benjamin-glitsos/vim-operator-ToFile',
	--'kusabashira/vim-operator-fill',
	--'tyru/operator-reverse.vim',
	--'osyo-manga/vim-operator-jump_side',
	--'rhysd/vim-operator-filled-with-blank',
	--'tommcdo/vim-nowchangethat',
	--'lambdalisue/vim-operator-breakline',
	--'tek/vim-operator-assign',
	--'hiecaq/vim-operator-end',
	--'teddywing/vim-searchop',

	--editing
	'otavioschwanck/cool-substitute.nvim',
	{
		--'mg979/vim-visual-multi',
			-- TODO: configure
		'terryma/vim-multiple-cursors',
	},

	--objects.modifier
	--'svermeulen/vim-next-object',

	--objects
	--'pgdouyon/vim-apparate',
	'coderifous/textobj-word-column.vim',
	'rhysd/vim-textobj-anyblock',
	'thinca/vim-textobj-between',
	'michaeljsmith/vim-indent-object',
	--'glts/vim-textobj-indblock',
	{
		'saaguero/vim-textobj-pastedtext',
		--'gilligan/textobj-lastpaste',
	},
	'rhysd/vim-textobj-lastinserted',
	'Raimondi/vim_search_objects',
		-- TODO: not sure
	--'raimondi/vim_search_objects',
	--'deton/textobj-nonblankchars.vim',
	--'tkhren/vim-textobj-samechars',
	--'adriaanzon/vim-textobj-matchit',
	--'lukelbd/vim-succinct',
  --'kana/vim-textobj-fold',
	--'kana/vim-textobj-lastpat',
	--'Chun-Yang/vim-textobj-chunk',
	--'saihoooooooo/vim-textobj-space',
  --'osyo-manga/vim-textobj-multiblock',
	--'beloglazov/vim-textobj-punctuation',
	--'hchbaw/textobj-motionmotion.vim',
	--'rhysd/vim-textobj-continuous-line',
	--'deathlyfrantic/vim-textobj-blanklines',
	--'BjornMulder/vim-textobjects',
	--'beyarkay/select_inner.vim',
	--'inkarkat/vim-AdvancedDeleteOperators',
	--'yomotherboard/do-more-in.vim',

	--objects.programming
	--'andrewferrier/textobj-diagnostic.nvim',
	--'vim-scripts/text-object-left-and-right',
	--'romgrk/equal.operator',
	--'rhysd/vim-textobj-conflict',
	'Julian/vim-textobj-variable-segment',
	'machakann/vim-textobj-delimited',
	{
    'syngan/vim-textobj-postexpr',
		'machakann/vim-textobj-functioncall',
    'anyakichi/vim-textobj-xbrackets',
  },
	'thalesmello/vim-textobj-methodcall',
	{ 'machakann/vim-swap', 'sgur/vim-textobj-parameter' },
	'glts/vim-textobj-comment',
	--'Julian/vim-textobj-assignment',
  --'vimtaku/vim-textobj-keyvalue',
	--'coachshea/vim-textobj-markdown',
	--'jasonlong/vim-textobj-css',
	--'jceb/vim-textobj-uri',
	--'osyo-manga/vim-textobj-context',
	--'mjbrownie/html-textobjects',
	'justinj/vim-textobj-reactprop',

	--objects.treesitter
	'nvim-treesitter/nvim-treesitter-textobjects',
	--'RRethy/nvim-treesitter-textsubjects',
	'David-Kunz/treesitter-unit',
	'singlexyz/treesitter-frontend-textobjects',
	--'Jason-M-Chan/ts-textobjects',

	--motions
	--'spiiph/vim-space',
	{ 'chaoren/vim-wordmotion', 'kana/vim-smartword' },
	--'haya14busa/vim-edgemotion',
	{'terryma/vim-expand-region', 'gcmt/wildfire.vim'},
	--'vim-scripts/JumpToLastOccurrence',
	--'rbong/vim-vertical',

  --motions.treesitter
	--{ 'Dkendal/nvim-treeclimber', 'ziontee113/syntax-tree-surfer', 'drybalka/tree-climber.nvim' },
	--'mfussenegger/nvim-treehopper',
	--'Wansmer/sibling-swap.nvim',
	--'Wansmer/binary-swap.nvim',

	--jumps
	'buztard/vim-rel-jump',
	'kana/vim-exjumplist',
		-- FIX:
	'kwkarlwang/bufjump.nvim',
	{'andymass/vim-matchup', 'theHamsta/nvim-treesitter-pairs'},
	{'chentoast/marks.nvim', 'kshenoy/vim-signature'},
	'arp242/jumpy.vim',
		-- FIX:
	--'fergdev/vim-cursor-hist',

	--search
	--'haya14busa/incsearch.vim',
	--'haya14busa/incsearch-fuzzy.vim',
	'bronson/vim-visual-star-search',
	--'haya14busa/vim-asterisk',
	--{'ironhouzi/starlite-nvim', 'ironhouzi/vim-stim'},
	'romainl/vim-cool',

	--search.fFtT
	'unblevable/quick-scope',
	{
    'rhysd/clever-f.vim',
		--'chrisbra/improvedft',
		--'dahu/vim-fanfingtastic',
		'justinmk/vim-sneak',
	},
	'kevinhwang91/nvim-ffhighlight',
		-- FIX: highlight | keymaps

	--operations
	--'sickill/vim-pasta',
	{
		'Wansmer/treesj',
		'aarondiel/spread.nvim',
		'AndrewRadev/splitjoin.vim',
  },
	{
		--'AckslD/nvim-trevJ.lua',
		--'AckslD/nvim-revJ.lua',
	},
	--'jeetsukumaran/vim-linearly',
	'osyo-manga/vim-jplus',
	'sQVe/sort.nvim',
		-- TODO: configure|define-operator(s)

  --operations.miscelleanous
	'dkarter/bullets.vim',
	--'kabbamine/lazylist.vim',
	'dhruvasagar/vim-table-mode',
	'rasukarusan/nvim-select-multi-line',
	'lambdalisue/reword.vim',
	{'jiangmiao/auto-pairs', 'windwp/nvim-autopairs'},
	'abecodes/tabout.nvim',
	'windwp/nvim-ts-autotag',
	{'NTBBloodbath/color-converter.nvim', 'amadeus/vim-convert-color-to'},
	{'zirrostig/vim-schlepp', 'matze/vim-move'},
	--'svermeulen/vim-yoink',
	'tenfyzhong/axring.vim',
	'leothelocust/vim-makecols',
	'monaqa/dial.nvim',

	--comment
	{
    'scrooloose/nerdcommenter',
    'tpope/vim-commentary',
    'b3nj5m1n/kommentary',
  },
	'LudoPinelli/comment-box.nvim',
	's1n7ax/nvim-comment-frame',
	'JoosepAlviste/nvim-ts-context-commentstring',

	--treesitter
	'nvim-treesitter/nvim-treesitter-refactor',
	'winston0410/smart-cursor.nvim',
	--'nvim-treesitter/nvim-tree-docs',

	--aesthetics
	'p00f/nvim-ts-rainbow',
	{'RRethy/vim-illuminate', 'itchyny/vim-cursorword'},
	'markonm/traces.vim',

	--random
  'editorconfig/editorconfig-vim',
	{
		'NMAC427/guess-indent.nvim',
		--'Darazaki/indent-o-matic',
		--'tpope/vim-sleuth',
		--'zsugabubus/crazy8.nvim',
		--'ciaranm/detectindent',
	},
	'tyru/open-browser.vim',
	'jbyuki/nabla.nvim',
	'AllenDang/nvim-expand-expr',
  -- TODO: not sure how to use it
  --'skywind3000/vim-dict',
	--'vim-scripts/motion.vim',

	--dependencies
	'Shougo/vimproc.vim',
}
local editor = {
	--jumps
	'nacro90/numb.nvim',

	--editor.general
	'nanotee/zoxide.vim',
	'gelguy/wilder.nvim',
	{
		--'linty-org/key-menu.nvim',
    'folke/which-key.nvim',
    'liuchengxu/vim-which-key',
  },
	'abdalrahman-ali/vim-remembers',
	'rcarriga/nvim-notify',
	{
		'mbbill/undotree',
		--'simnalamburt/vim-mundo',
	},
	--'debugloop/telescope-undo.nvim',
	'ntpeters/vim-better-whitespace',
	{ 'svermeulen/vim-macrobatics', {'dohsimpson/vim-macroeditor', 'rbong/vim-buffest'} },
	'notomo/cmdbuf.nvim',
	'kopischke/vim-fetch',
	'crusj/bookmarks.nvim',
	{
		--'chrisbra/NrrwRgn',
		'kana/vim-narrow',
		--'jkramer/vim-narrow',
	},
	{
		-- FIX:
		'edluffy/specs.nvim',
		'stonelasley/flare.nvim',
		'DanilaMihailov/beacon.nvim',
		'inside/vim-search-pulse',
	},
	--'tpope/vim-obsession',
	--'junegunn/vim-peekaboo',

	--system
	'lambdalisue/guise.vim',

	--quickfix
	{'kevinhwang91/nvim-bqf', 'romainl/vim-qf'},
	'weilbith/vim-loche',
	'weilbith/vim-quickname',

	'xiyaowong/nvim-transparent',
	-- colorschemes
	--'raddari/last-color.nvim',
	{
		--testing
		--'Yazeed1s/oh-lucy.nvim',
		--'kvrohit/mellow.nvim',
		--'kartikp10/noctis.nvim',
		--'Yazeed1s/minimal.nvim',
		--'wadackel/vim-dogrun',
		--'cpea2506/one_monokai.nvim',
		--'rebelot/kanagawa.nvim',

		--best.eccentric
		--{'aswathkk/DarkScene.vim', 'challenger-deep-theme/vim'},
		--{'eddyekofo94/gruvbox-flat.nvim', 'morhetz/gruvbox'},
		--'cseelus/vim-colors-lucid',
		--'FrenzyExists/aquarium-vim',
		--'yonlu/omni.vim',

		--best.vibrant
		--{ 'B4mbus/oxocarbon-lua.nvim', 'shaunsingh/oxocarbon.nvim' },
		--'NvChad/nvim-base16.lua',
		'projekt0n/github-nvim-theme',
		--{'folke/tokyonight.nvim', 'ghifarit53/tokyonight-vim'},
		--'tiagovla/tokyodark.nvim',
		--'Pocco81/Catppuccino.nvim',
		--'Mangeshrex/uwu.vim',
		--'pacokwon/onedarkhc.vim',
		--{'kaicataldo/material.vim', 'marko-cerovac/material.nvim'},
		--'olimorris/onedarkpro.nvim',
		--'nxvu699134/vn-night.nvim',

		--best.soft
		--'EdenEast/nightfox.nvim',

		--best.dull
		--{'kvrohit/substrata.nvim', 'arzg/vim-substrata'},

		--best.minimal
		'Domeee/mosel.nvim',
		'kdheepak/monochrome.nvim',

		--best.stable
		{'martinsione/darkplus.nvim', 'Mofiqul/vscode.nvim', 'tomasiser/vim-code-dark'},

		--good
		'ayu-theme/ayu-vim',
		'cseelus/vim-colors-tone',
		'wuelnerdotexe/vim-enfocado',

		--eccentric
		'yashguptaz/calvera-dark.nvim',
		'lawsdontapplytopigs/black_cherries',
		'Shadorain/shadotheme',
		'haishanh/night-owl.vim',

		--minimal
		'danishprakash/vim-yami',

		--soft
		'drewtempelmeyer/palenight.vim',
		'joshdick/onedark.vim',
		'tyrannicaltoucan/vim-quantum',
		'sonph/onehalf',
		'novakne/kosmikoa.nvim',

		--dull
		'rockerBOO/boo-colorscheme-nvim',
		'ulwlu/elly.vim',

		--normal
		'KabbAmine/yowish.vim',

		--okish
		'arzg/vim-corvine',
		'raphamorim/lucario',
		'KeitaNakamura/neodark.vim',
		'sindresorhus/focus',

		--collections
		{'RRethy/nvim-base16', 'chriskempson/base16-vim'},
		'christianchiarulli/nvcode-color-schemes.vim',
		'flazz/vim-colorschemes',
		'rafi/awesome-vim-colorschemes',
		'i3d/vim-jimbothemes',
	},

	--editor.aesthetics
	{
		--'kdheepak/tabline.nvim',
		--'nanozuki/tabby.nvim',
		--'rafcamlet/tabline-framework.nvim',
		--'noib3/nvim-cokeline',

		'akinsho/bufferline.nvim',
		'akinsho/nvim-bufferline.lua', --same as above just the legacy config
		'romgrk/barbar.nvim',
		'bling/vim-bufferline',
	},
	{
		'strash/everybody-wants-that-line.nvim',
		'feline-nvim/feline.nvim',
		'glepnir/galaxyline.nvim',
		'hoob3rt/lualine.nvim',
		'vim-airline/vim-airline',
		'itchyny/lightline.vim',
	},
	{
		'utilyre/barbecue.nvim',
		--TODO: setup
		'SmiteshP/nvim-navic',
		--TODO: not sure
		--'b0o/incline.nvim',
	},

	--buffer
	{'kevinhwang91/nvim-hlslens', 'osyo-manga/vim-anzu'},
	'rktjmp/highlight-current-n.nvim',
	'lukas-reineke/indent-blankline.nvim',
	'itchyny/vim-highlighturl',
	'kazhala/close-buffers.nvim',
	'pseewald/vim-anyfold',
	'anuvyklack/fold-preview.nvim',
		-- TODO: configure properly
	--'whatyouhide/vim-lengthmatters',
	--'arecarn/vim-fold-cycle',
	--'haya14busa/vim-over',
	--'ghillb/cybu.nvim',

	-- window
	'vim-scripts/navigation_enhancer.vim',
	'nvim-zh/colorful-winsep.nvim',
	'sindrets/winshift.nvim',
	'luukvbaal/stabilize.nvim',
	'szw/vim-maximizer',
	--'TaDaa/vimade',
	--'beauwilliams/focus.nvim',
	'wellle/visual-split.vim',
	--'declancm/windex.nvim',

	--winbar

	--tab
	--not-working
	--'boson-joe/vimwintab',
	--'noscript/taberian.vim',

	-- clients
	'glacambre/firenvim',

	--random
	'aca/vidir.nvim',
}
local default = {
	--dependencies
	'MunifTanjim/nui.nvim',
	'RishabhRD/popfix',
	'mattn/webapi-vim',

	--operators
	--'haya14busa/vim-easyoperator-line',
	--'haya14busa/vim-easyoperator-phrase',

	--system
	'junegunn/fzf',
	'nvim-telescope/telescope.nvim',
	'skywind3000/asyncrun.vim',
	{
    'voldikss/vim-floaterm',
    'akinsho/toggleterm.nvim',
  },
	{
		--'nvim-neo-tree/neo-tree.nvim',
		'kyazdani42/nvim-tree.lua',
		'ms-jpq/chadtree',
	},
	{
		'elihunter173/dirbuf.nvim',
		'X3eRo0/dired.nvim',
	},
	'is0n/fm-nvim',

	--search
	--'easymotion/vim-easymotion',
	--'haya14busa/incsearch-easymotion.vim',
	{'windwp/nvim-spectre', 'brooth/far.vim'},
	{
		'ripxorip/aerojump.nvim',
		--'lambdalisue/lista.nvim',
		'osyo-manga/vim-hopping',
	},

	--editor.general
	--{ 'mhinz/vim-startify', 'glepnir/dashboard-nvim', 'goolord/alpha-nvim', 'startup-nvim/startup.nvim' },
	'mtth/scratch.vim',
	-- TODO: not working
	'kana/vim-scratch',
	{'jbyuki/venn.nvim', 'gyim/vim-boxdraw'},
	'lfv89/vim-foldfocus',
	--'GustavoKatel/sidebar.nvim',
	'rexagod/samwise.nvim',
	--TO-TEST
	--'hood/popui.nvim',

	--vim.ui
	'stevearc/dressing.nvim',
	--'doums/suit.nvim',

	--buffer.general
	{
		--TOFIX:
		--'petertriho/nvim-scrollbar',
		'dstein64/nvim-scrollview',
		'Xuyuanp/scrollbar.nvim',
	},
	{
    -- TODO: not working figure out
		--'gen740/SmoothCursor.nvim',
    'karb94/neoscroll.nvim',
    'psliwka/vim-smoothie',
    'joeytwiddle/sexy_scroller.vim',
  },
	'el-iot/buffer-tree-explorer',
	'xiyaowong/link-visitor.nvim',

	--window
	'camspiers/animate.vim',
	--'camspiers/lens.vim',
	--'blueyed/vim-diminactive',
	's1n7ax/nvim-window-picker',

	--random
	'edluffy/hologram.nvim',
	--TODO: configure|setup
	'potamides/pantran.nvim',
}
local ide = {
	--editor.general
	--'wfxr/minimap.vim',
	'SmiteshP/nvim-gps',
	{
		--'haringsrob/nvim_context_vt',
		--'wellle/context.vim',
		'nvim-treesitter/nvim-treesitter-context',
  },

	--buffer.aesthetics
	'folke/todo-comments.nvim',
	{'folke/zen-mode.nvim', 'junegunn/goyo.vim'},
	{'folke/twilight.nvim', 'junegunn/limelight.vim'},
	'koenverburg/peepsight.nvim',
	--'axlebedev/footprints',
	--'NarutoXY/dim.lua',

	--programming.completion
	{
		'L3MON4D3/LuaSnip',
		'hrsh7th/vim-vsnip',
		'SirVer/ultisnips',
		'norcalli/snippets.nvim',
	},
	{
		--'noib3/nvim-compleet',
		'hrsh7th/nvim-cmp',
		'hrsh7th/nvim-compe',
		'ms-jpq/coq_nvim',
	},
	'ziontee113/icon-picker.nvim',

	--programming.documentation
	{
		'kkoomen/vim-doge',
		'danymat/neogen',
		'glepnir/prodoc.nvim',
	},

	--programming.ai
	--to setup/fix
	--'aduros/ai.vim',
	--'jameshiew/nvim-magic',
	--'ashzero2/VimPilot',
	--'tom-doerr/vim_codex',
	--'github/copilot.vim',
	--'zbirenbaum/copilot.lua',
	--'jackMort/ChatGPT.nvim',
	--'dense-analysis/neural',

	--programming.lsp
	--'neoclide/coc.nvim',
	'folke/lsp-colors.nvim',
	-- TODO:setup
	--'nanotee/nvim-lsp-basics',
	-- TODO:wait for patch/fix
	'RishabhRD/nvim-lsputils',
	'rmagatti/goto-preview',
	'DNLHC/glance.nvim',
	--'ldelossa/nvim-ide',
	'folke/trouble.nvim',
	{
		--'vigoux/notifier.nvim',
		'j-hui/fidget.nvim',
	},
	'kosayoda/nvim-lightbulb',
	'ldelossa/litee.nvim',
	'jose-elias-alvarez/nvim-lsp-ts-utils',
	{'tami5/lspsaga.nvim', 'glepnir/lspsaga.nvim'},
	--'smjonas/inc-rename.nvim',
		--TODO: not working
	'JASONews/glow-hover',
	'weilbith/nvim-code-action-menu',
	'ray-x/lsp_signature.nvim',
	'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim',
	'whynothugo/lsp_lines.nvim',
	'onsails/lspkind-nvim',
  --'amrbashir/nvim-docs-view',
  --TODO: broken...wait
	'wiliamks/nice-reference.nvim',
	'cseickel/diagnostic-window.nvim',
  --FIX:broken
	'joechrisellis/lsp-format-modifications.nvim',
	--'jose-elias-alvarez/null-ls.nvim',
	--not-working
	--'lewis6991/spellsitter.nvim',
	--setup
	--'creativenull/diagnosticls-nvim',
	--'weilbith/nvim-floating-tag-preview',
	--'nvim-lua/lsp-status.nvim',
	--'doums/lsp_spinner.nvim',
	--not-working
	--'onsails/vimway-lsp-diag.nvim',
	--'Mofiqul/trld.nvim',

	--progrmaming.general
	'ludovicchabant/vim-gutentags',
	{ 'liuchengxu/vista.vim', 'majutsushi/tagbar' },

	--programming.syntax
	'Galicarnax/vim-regex-syntax',
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
	{'lewis6991/gitsigns.nvim', 'airblade/vim-gitgutter'},
	'tanvirtin/vgit.nvim',
	'pwntester/octo.nvim',
	{ 'TimUntersberger/neogit', 'tpope/vim-fugitive' },
	{
    'ldelossa/gh.nvim',
    --TODO:
    'skanehira/denops-gh.vim',
    'skanehira/gh.vim',
  },
	--'ttys3/nvim-blamer.lua',
	'sindrets/diffview.nvim',
	{'rhysd/conflict-marker.vim', 'akinsho/git-conflict.nvim'},
	'rhysd/git-messenger.vim',
	'ruifm/gitlinker.nvim',
	'drzel/vim-repo-edit',

	--programming.testing
	{
    --TODO: configure
		--'klen/nvim-test',
		'vim-test/vim-test',
	},

	--programming.debugging
	--'mfussenegger/nvim-dap',
	{
		'rareitems/printer.nvim',
		'smartpde/debuglog',
		'andrewferrier/debugprint.nvim',
	},

	--programming.databases
	'tpope/vim-dadbod',

	--frontend
	'mattn/emmet-vim',

	--lua
	'rafcamlet/nvim-luapad',

	--python
	--'AckslD/swenv.nvim',

	--javascript
	--'vuki656/package-info.nvim',
	'tomarrell/vim-npr',
	--using null-ls/executioner instead
	'prettier/vim-prettier',
	'napmn/react-extract.nvim',
	'Azeirah/nvim-redux',
	'axelvc/template-string.nvim',
	'pantharshit00/vim-prisma',

	--programming.random
	--'alpertuna/vim-header',
	--'shanzi/autoHEADER',

	--temp
	{
    --TODO
		--'linty-org/key-menu.nvim',
		'folke/which-key.nvim',
		'liuchengxu/vim-which-key',
	},
	'powerman/vim-plugin-AnsiEsc',
}
local configuration = {
	--random
	--'fadein/vim-FIGlet',
	'tpope/vim-scriptease',
	{
		--'AckslD/messages.nvim',
		'AndrewRadev/bufferize.vim',
	},
	--'tyru/capture.vim',
	--{ 'dstein64/vim-startuptime', 'henriquehbr/nvim-startup.lua' },

	--'dokwork/vim-hp',

	--api
	'tweekmonster/nvim-api-viewer',
	'folke/lua-dev.nvim',

  -- TODO:
	'ziontee113/query-secretary',

	--colors
	'tjdevries/colorbuddy.nvim',
	'vim-scripts/ScrollColors',
	'zefei/vim-colortuner',
	'rktjmp/lush.nvim',
	'guns/xterm-color-table.vim',
}
local markup = {
	--'kristijanhusak/orgmode.nvim',
	--'akinsho/org-bullets.nvim',
	--'nvim-neorg/neorg',
	'nvim-orgmode/orgmode',
	'AckslD/nvim-FeMaco.lua',
}
local featured = {
	--system
	--'edkolev/tmuxline.vim',
	--'edkolev/promptline.vim',
	--'vim-scripts/WholeLineColor',

	--operations
	'tpope/vim-speeddating',

	--authoring
	'antoyo/vim-licenses',
	'reedes/vim-pencil',
	'panozzaj/vim-autocorrect',
	'vim-scripts/autoscroll.vim',
	'natw/keyboard_cat.vim',
	--not-working = clone and fix highlight
	--'dbmrq/vim-redacted',

	--random
	--'MrPeterLee/VimWordpress',
	'itchyny/calendar.vim',
	'samodostal/image.nvim',
}
local testing = {
	--'cbochs/portal.nvim',
	--'lpoto/actions.nvim',
	--'cvigilv/esqueleto.nvim',
	--'nyngwang/suave.lua',
	--'danielvolchek/tailiscope.nvim',
	--'hudclark/grpc-nvim',
	--'ellisonleao/dotenv.nvim',
	'tamton-aquib/stuff.nvim',
	'sunjon/stylish.nvim',
	--'rareitems/hl_match_area.nvim',
	--'lalitmee/browse.nvim',
	--'vinnymeller/swagger-preview.nvim',
	--'folke/paint.nvim',
	--'folke/neoconf.nvim',
	--'folke/styler.nvim',
	--'xorid/swap-split.nvim',
	--'katawful/kreative',
  --'https://gitlab.com/madyanov/svart.nvim',
	--'GnikDroy/projections.nvim',
	--'nyngwang/fzf-lua-projections.nvim',
	--'chrisgrieser/nvim-recorder',
	--'chrisgrieser/nvim-genghis',
	--'TimotheeSai/git-sessions.nvim',
	'j-morano/buffer_manager.nvim',
	--'nat-418/scamp.nvim',
	--'LintaoAmons/scratch.nvim',
	--'mrded/nvim-zond',
	--'princejoogie/dir-telescope.nvim',
	--'dimfred/resize-mode.nvim',
	--'nat-418/boole.nvim',
	--'phelipetls/jsonpath.nvim',
	--'melkster/modicator.nvim',
	--'gorbit99/codewindow.nvim',
	--'nat-418/termitary.nvim',
	--'LukasPietzschmann/telescope-tabs',
	--'haolian9/reveal.nvim',
	--'ziontee113/query-secretary',
	--'PatschD/zippy.nvim',
	--'MrcJkb/haskell-tools.nvim',
	--'cbochs/grapple.nvim',
	--'Weissle/easy-action',
	--'diegoulloao/nvim-file-location',
	--'narutoxy/silicon.lua',
	--'olrtg/nvim-rename-state',
	--'almo7aya/openingh.nvim',
  -- TODO: TRIAL
	--'justinmk/vim-dirvish',
	--'lewis6991/brodir.nvim',
	--'zegervdv/nrpattern.nvim',
	--'nat-418/dbm.nvim',
	--'TheBlob42/drex.nvim',
	--'itmecho/bufterm.nvim',
	--'sbulav/nredir.nvim',
	--'TimUntersberger/neofs',
	--'SidOfc/carbon.nvim',
	--'obaland/vfiler.vim',
  --'antoinemadec/openrgb.nvim',
  --'kensyo/nvim-scrlbkun',
	--'mong8se/buffish.nvim',

	--'Slyces/hierarchy.nvim',
	--'danielfalk/smart-open.nvim',
	--'ranjithshegde/ccls.nvim',
	--'crusj/hierarchy-tree-go.nvim',
	--'ggandor/leap-ast.nvim',
	--'Ostralyan/scribe.nvim',
	--'kiran94/s3edit.nvim',
	--'gennaro-tedesco/nvim-jqx',

	--'anuvyklack/windows.nvim',
	--'abenz1267/nvim-databasehelper',
	--'simrat39/symbols-outline.nvim',
	--'axkirillov/easypick.nvim',
	--'woosaaahh/sj.nvim',
	--'smartpde/neoscopes',
	--'olimorris/persisted.nvim',
	--'rmagatti/auto-session',

	--'vigoux/notifier.nvim',
	--'numToStr/prettierrc.nvim',
	--'Djancyp/better-comments.nvim',
	--'Djancyp/regex.nvim',
	--'Vonr/align.nvim',
	--'gaoDean/autolist.nvim',
	'phaazon/mind.nvim',
	--'echasnovski/mini.nvim',
	--'smartpde/neoscopes',
	--'nvim-colortils/colortils.nvim',

	--'Pocco81/true-zen.nvim',
	--'smolovk/projector.nvim',
	--'Dax89/ide.nvim',
	--'charludo/projectmgr.nvim',

	--'ldelossa/buffertag',

	--'andythigpen/nvim-coverage',

	--'ray-x/web-tools.nvim',
	--'levouh/tint.nvim',
	--'superhawk610/ascii-blocks.nvim',
	--'romainchapou/confiture.nvim',
	--'krady21/compiler-explorer.nvim',
	--'farfanoide/inflector.vim',
	--'jonmorehouse/vim-flow',
	--'paulkass/jira-vim',
	--'n0v1c3/vira',

	--'anuvyklack/animation.nvim',
	--'uga-rosa/ccc.nvim',
	--'Vonr/foldcus.nvim',
	--'jesseleite/vim-agriculture',
	--'vim-scripts/Area-search',
	--'zenbro/mirror.vim',
	--'psychollama/further.vim',
	--'numToStr/Comment.nvim',
	--'winston0410/commented.nvim',
	--'terrortylor/nvim-comment',
	--'cometsong/CommentFrame.vim',

	--'https://gitlab.com/yorickpeterse/nvim-window.git',
	--'https://gitlab.com/yorickpeterse/nvim-pqf.git',

	--'ckarnell/antonys-macro-repeater',
	--'jacobchrismarsh/vim-macro-repeat',

	--'stevearc/overseer.nvim',
	--'arp242/batchy.vim',
	--'dkprice/vim-easygrep',
	--'eugen0329/vim-esearch',
	--'lewis6991/satellite.nvim',
	--'inkarkat/vim-advancedsorters',
	--'idanarye/vim-merginal',
	--'junegunn/vim-fn',
	--'junegunn/vim-pseudocl',
	--'junkblocker/git-time-lapse',
	--'linden-project/linny.vim',
	--'gbprod/yanky.nvim',

	--'abenz1267/nvim-databasehelper',
	--'zakharykaplan/nvim-retrail',
	--'brenoprata10/nvim-highlight-colors',
	--'aadv1k/gdoc.vim',
	--'vigoux/complementree.nvim',
	--'pierreglaser/folding-nvim',
  --'rktjmp/fwatch.nvim',
  --'MasterMedo/anonymizer.nvim',

	--'0x100101/lab.nvim',
	--'skanehira/k8s.vim',
	--'dgrbrady/nvim-docker',
	--'gbprod/stay-in-place.nvim',

	-- FIX: not working properly, figure out
	--'thinca/vim-partedit',

	--'sheodox/projectlaunch.nvim',
	--'rhysd/committia.vim',
	--'junegunn/gv.vim',
	{
		--'mattn/vim-gist',
		--'lambdalisue/vim-gista',
		--'vim-scripts/Gist.vim',
	},
	--'tpope/vim-rhubarb',

	--'willthbill/opener.nvim',
	--'jakewvincent/mkdnflow.nvim',
	--'ggandor/leap.nvim',
	--'ggandor/leap-spooky.nvim',
	--'ethanjwright/toolwindow.nvim',
	--'glts/vim-radical',
	--'s1n7ax/nvim-lazy-inner-block',

	--'tpope/vim-characterize',

	--'rbong/vim-buffest',
	--'wesq3/vim-windowswap',
	--'zef/vim-cycle',
	--'andrewradev/switch.vim',
	--'acksld/nvim-anywise-reg.lua',
	--'amirrezaask/actions.nvim',

	--vim-scripts
	--'vim-scripts/Smart-Tabs',
	--'vim-scripts/SearchAlternatives',
	--'vim-scripts/log4j.vim',
	--'vim-scripts/CommandWithMutableRange',
	--'vim-scripts/quit_another_window',
	--'vim-scripts/cmdalias.vim',
	--'vim-scripts/vis',
	--'vim-scripts/visualrepeat',
	--'vim-scripts/multiselect',
	--'vim-scripts/git-file.vim',
	--'vim-scripts/marvim',
	--'vim-scripts/DirDiff.vim',
	--'vim-scripts/diffchar.vim',
	--'vim-scripts/diffchanges.vim',
	--'vim-scripts/BlockDiff',
	--'vim-scripts/DiffGoFile',
	--'vim-scripts/Threesome',
	--'vim-scripts/diffwindow_movement',
	--{
	--  'vim-scripts/multiwindow-source-code-browsing',
	--  'vim-scripts/gtags-multiwindow-browsing',
	--},
	--'vim-scripts/dbext.vim',
	--'vim-scripts/EnhancedJumps',
	--'vim-scripts/CountJump',
	--'vim-scripts/SudoEdit.vim',
	--'vim-scripts/MultipleSearch',
	--'vim-scripts/searchfold.vim',
	--'vim-scripts/allfold',
	--'vim-scripts/Tabmerge',
	--'vim-scripts/AdvancedSorters',
	--'vim-scripts/LogViewer',
	--'vim-scripts/httplog',
	--'vim-scripts/excel.vim',
	--'vim-scripts/spreadsheet.vim',
	--'vim-scripts/vim-geeknote',
	--'vim-scripts/thumbnail.vim',
	--'vim-scripts/confluencewiki.vim',
	--'vim-scripts/txt.vim',
	--'vim-scripts/vim-pipe',
	--'vim-scripts/auto_autoread.vim',
	--'vim-scripts/tcd.vim',
	--'vim-scripts/nvi.vim',
	--'vim-scripts/increment.vim--Natter',
	--'vim-scripts/locator',
	--'vim-scripts/Vimacs',
	--'vim-scripts/autoswap.vim',
	--'vim-scripts/vim-addon-actions',
	--'vim-scripts/EasyOpts',
	--'vim-scripts/eregex.vim',
	--'vim-scripts/SpitVspit',
	--'vim-scripts/emacs-like-macro-recorder',
	--'vim-scripts/gsearch',
	--'sandeepcr529/Buffet.vim',
	--'vim-scripts/lookup.vim',
	--'vim-scripts/mathematic.vim',
	--'vim-scripts/eighties.vim',
	--'vim-scripts/layoutManager',
	--'powerman/vim-plugin-viewdoc',

	--'vim-scripts/YankRing.vim',
	--'vim-scripts/Directory-specific-settings',
	--'vim-scripts/buffers_search_and_replace',
	--'vim-scripts/Vimblr',
	--'vim-scripts/a.vim',
	--{ 'hrj/vim-DrawIt', 'vim-scripts/DrawIt'},
	--'vim-scripts/sketch.vim',
	--'vim-scripts/FuzzyFinder',
	--{
	--  'vim-scripts/bufexplorer.zip',
	--  'vim-scripts/bufferlist.vim',
	--  'vim-scripts/SelectBuf',
	--  'vim-scripts/easybuffer.vim',
	--  'vim-scripts/QuickBuf',
		--'vim-scripts/qnamebuf',
	--},
	--'vim-scripts/zzsplash',
	--'vim-scripts/TaskList.vim',
	--'vim-scripts/VOoM',
	--'vim-scripts/bash-support.vim',
	--'vim-scripts/SQLUtilities',
	--'vim-scripts/utl.vim',
	--'vim-scripts/grep.vim',
	--'vim-scripts/EasyGrep',
	--'vim-scripts/greplace.vim',
	--'fmoralesc/vim-pad',
	--'vim-scripts/ag.vim',
	--'vim-scripts/scrollfix',
	--'vim-scripts/Speech',
	--'vim-scripts/psearch.vim',
	--'vim-scripts/vim-forrestgump',

	--'ahmedkhalf/jupyter-nvim',
  --'ameertaweel/todo.nvim',
  --'cyansprite/extract',
	--'wincent/ferret',
	--'fholgado/minibufexpl.vim',
	--'acksld/nvim-neoclip.lu',
	--'lpinilla/vim-codepainter'
	--'thinca/vim-poslist',
	--'tssm/nvim-snitch',
	--'axkirillov/easypick.nvim',
	--'glepnir/template.nvim',
	--'GustavoKatel/tasks.nvim',
	--'Pocco81/AutoSave.nvim',
	--'wincent/loupe',
	--'jessekelighine/vindent.vim',
	--'Issafalcon/lsp-overloads.nvim',
	--'tzachar/fuzzy.nvim',
	--'nvim-telescope/telescope-fzf-native.nvim',
	--'jameshiew/nvim-magic',
	--'AckslD/nvim-neoclip.lua',
	--'gennaro-tedesco/nvim-peekup',
	--'LionC/nest.nvim',
	--'strash/no-one-wants-to-restart.nvim',
	--'itmecho/neoterm.nvim',
	--'kevinhwang91/nvim-ufo',
	--'anuvyklack/pretty-fold.nvim',
	--'doums/suit.nvim',
	--'EtiamNullam/relative-source.nvim',
	--'kyoh86/backgroundfile.nvim',
	--'kyoh86/gitstat.nvim',
	--'tamago324/lsp-preview-hover-doc.nvim',
	--'hexium310/diffmt.nvim',
	--'akshettrj/ts-manipulator.nvim',
	--'natecraddock/nvim-find',
	--'gbprod/open-related.nvim',
	--'micmine/jumpwire.nvim',
	--'rhysd/wandbox-vim',
	--'rajprakharpatel/wandbox.nvim',
	--'s1n7ax/nvim-terminal',
	--'Saverio976/music.nvim',
	--'arsham/arshamiser.nvim',
	--'akinsho/clock.nvim',
	--'arjunmahishi/run-code.nvim',
	--'jose-elias-alvarez/typescript.nvim',
  --'groves/reterm.nvim',
	--'arsham/fzfmania.nvim',
	--'arsham/listish.nvim',
	--'gabrielpoca/replacer.nvim',
	--'stefandtw/quickfix-reflector.vim',
	--'arsham/matchmaker.nvim',
	--'arsham/yanker.nvim',
	--'arsham/figurine',
	--'RobertAudi/junkfile.nvim',
	--'tssm/nvim-reflex',
	--'delphinus/auto-cursorline.nvim',
	--'FraserLee/ScratchPad',
	--'uga-rosa/translate.nvim',
	--'tamago324/nlsp-settings.nvim',
	--'natecraddock/workspaces.nvim',
	--'b0o/SchemaStore.nvim',
	--'vimpostor/vim-tpipeline',
	--'stevearc/stickybuf.nvim',
	--'rmagatti/session-lens',
	--'Pocco81/HighStr.nvim',
	--'sbdchd/neoformat',
	--'davidgranstrom/nvim-markdown-preview',
	--'boson-joe/YANP',
	--'rliang/macrosearch.vim',
	--'kvngvikram/rightclick-macros',
	--'dbatten5/vim-macroscope',
	--'chamindra/marvim',
	--'RRethy/nvim-carom',
	--'fflorent/macrobug.nvim',
	--'code-biscuits/nvim-biscuits',
	--'gaborvecsei/memento.nvim',
	--'gaborvecsei/cryptoprice.nvim',
	--'booperlv/nvim-gomove',
	--'ruanyl/vim-gh-line',
	--'KadoBOT/nvim-spotify',
	--'sidebar-nvim/sections-dap',
	--'nvim-plugnplay/plugnplay.nvim',
	--'nvim-telescope/telescope-file-browser.nvim',
	--'chrsm/impulse.nvim',
	--'jedrzejboczar/toggletasks.nvim',
	--'xeluxee/competitest.nvim',
	--'askfiy/nvim-picgo',
	--'benfowler/telescope-luasnip.nvim',
	--'nvim-telescope/telescope-frecency.nvim',
	--'onsails/diaglist.nvim',
	--'someone-stole-my-name/yaml-companion.nvim',
	--'frabjous/knap',
	--'m-demare/attempt.nvim',
	--'tkmpypy/chowcho.nvim',
	--'rlch/github-notifications.nvim',
	--'hrsh7th/vim-searchx',
	--'LhKipp/nvim-locationist',
	--'ahmedkhalf/project.nvim',
	--'t9md/vim-quickhl',
	--'mizlan/iswap.nvim',
	--'cljoly/telescope-repo.nvim',
	----WIP
	--'miversen33/netman.nvim',
	--'jbyuki/instant.nvim',
	--'mvllow/modes.nvim',
	--'winston0410/cmd-parser.nvim',
	--'ray-x/sad.nvim',
	--'ginsburgnm/rich.nvim',
	--'arnarg/todo-prompt.nvim',
	--'NFrid/due.nvim',
	--'arsham/matchmaker.nvim',
	--'azabiong/vim-highlighter',
	--'luk400/vim-jukit',
	--'mfussenegger/nvim-lint',
	--'michaelb/sniprun',
	--'mbpowers/nvimager',
	--'sebcode/nvim-buftitle',
	--'arsham/listish.nvim',
	--'azabiong/vim-board',
	--'Chaitanyabsprip/present.nvim',
	--'gpanders/nvim-moonwalk',
	--'PyGamer0/font_changer.vim',
	--'PyGamer0/colorscheme_changer.vim',
	--'dsych/blanket.nvim',
	--'yogeshdhamija/terminal-command-motion.vim',
	--'lukas-reineke/virt-column.nvim',
	--'smjonas/snippet-converter.nvim',
	--{'ethanholz/nvim-lastplace', 'farmergreg/vim-lastplace'},
	--'tjdevries/stackmap.nvim',
	--'NTBBloodbath/rest.nvim',
	--'FeiyouG/command_center.nvim',
	--'gbprod/yanky.nvim',
	--'declancm/cinnamon.nvim',
	--'stevearc/gkeep.nvim',
	--'is0n/jaq-nvim',
	--'axieax/urlview.nvim',
	--'mrjones2014/legendary.nvim',
	--'toppair/reach.nvim',
	--'rgroli/other.nvim',
	--'tjdevries/vlog.nvim',
	--'jghauser/fold-cycle.nvim',
	--'AckslD/nvim-gfold.lua',
	--'ellisonleao/carbon-now.nvim',
	--'bennypowers/nvim-regexplainer',
	--'ThePrimeagen/refactoring.nvim',
	--'ThePrimeagen/jvim.nvim',
	--'ThePrimeagen/vim-apm',
	--'ThePrimeagen/harpoon',
	--'mrjones2014/smart-splits.nvim',
	--'r1ri/suffer',
	--'ZhiyuanLck/smart-pairs',
	--'hoschi/yode-nvim',
	--'EthanJWright/vs-tasks.nvim',
	--'LhKipp/nvim-git-fixer',
	--'VonHeikemen/searchbox.nvim',
	--'VonHeikemen/fine-cmdline.nvim',
	--'rlane/pounce.nvim',
	--'tpope/vim-unimpaired',
	--'EgZvor/vimproviser',
	--'luukvbaal/nnn.nvim',
	--'kdheepak/panvimdoc',
	--'ziontee113/color-picker.nvim',
	--'jedrzejboczar/possession.nvim',
	--'klen/nvim-config-local',
	--'morphisjustfun/nvim-code2text',
	--'tamton-aquib/staline.nvim',
	--'kwkarlwang/bufresize.nvim',
	--'vigoux/templar.nvim',
	--'pianocomposer321/yabs.nvim',
	--'ray-x/guihua.lua',
	--'stevearc/qf_helper.nvim',
	--'sunjon/extmark-toy.nvim',
	--'dyng/ctrlsf.vim',
	--'kyoh86/vim-editerm',
	--'lambdalisue/askpass.vim',
	--'metalelf0/witch-nvim',
	--'tamago324/telescope-openbrowser.nvim',
	--'jubnzv/mdeval.nvim',
	--'phaazon/hop.nvim',
	--'Shatur/neovim-session-manager',
	--'quintik/snip',
	--'CRAG666/code_runner.nvim',
	--'oberblastmeister/neuron.nvim',
	--'lambdalisue/nerdfont.vim',
	--'tjdevries/cyclist.vim',
	--'AckslD/nvim-whichkey-setup.lua',
	--'lambdalisue/fern.vim',
	--'numToStr/Navigator.nvim',
	--'christoomey/vim-tmux-navigator',
	--'tversteeg/registers.nvim',
	--'LoricAndre/oneterm',
	--'famiu/nvim-reload',
	--'DoeringChristian/VimIT',
	--'lambdalisue/glyph-palette.vim',
	--'folke/devmoji',
	--'windwp/windline.nvim',
	--'aonemd/fmt.vim',
	--'EthanJWright/toolwindow.nvim',
	--'ahmedkhalf/lsp-rooter.nvim',
	--'kdav5758/HighStr.nvim',
	--'simrat39/symbols-outline.nvim',
	--'jenterkin/vim-autosource',
	--'ray-x/navigator.lua',
	--'Pocco81/TrueZen.nvim',
	--'Pocco81/NoCLC.nvim',
	--'Pocco81/whid.nvim',
	--'amirrezaask/actions.nvim',
	--'tek/vim-fieldtrip',
	--'sunaku/vim-shortcut',
	--'Pocco81/ISuckAtSpelling.nvim',
	--'matbme/JABS.nvim',
	--'cdchawthorne/nvim-tbufferline',
	--'NTBBloodbath/cheovim',
	--'dhruvasagar/vim-dotoo',
	--'dhruvasagar/vim-zoom',
	--'dhruvasagar/vim-markify',
	--'lervag/wiki.vim',
	--'jakewvincent/texmagic.nvim',
	--'chipsenkbeil/distant.nvim',
	--'Iron-E/nvim-highlite',
	--'yamatsum/nvim-nonicons',
	--'arcticlimer/djanho',
	--'dlrudie/Snip',
	--'henriquehbr/ataraxis.lua',
	--'obcat/vim-ipos',
	--'cuducos/yaml.nvim',
	--'booperlv/cyclecolo.lua',
	--'antonk52/bad-practices.nvim',
	--'winston0410/mark-radar.nvim',
	--'salsifis/vim-transpose',
	--'https://git.sr.ht/~sircmpwn/gmni/',
	--'szymonmaszke/vimpyter',
	--'lspcontainers/lspcontainers.nvim',
	--'notomo/gesture.nvim',
	--'cohama/lexima.vim',
	--'David-Kunz/jester',
	--'luissimas/eval.nvim',
	--'folke/persistence.nvim',
	--'lazytanuki/nvim-mapper',
	--'lukas-reineke/lsp-format.nvim',
	--'Yagua/nebulous.nvim',
	--'roosta/fzf-folds.vim',
	--'tjdevries/train.nvim',
	--'ggandor/lightspeed.nvim',
	--'fmoralesc/nvimfs',
	--'dccsillag/magma-nvim',
	--'Dkendal/nvim-minor-mode',
	--'mrjones2014/load-all.nvim',
	--'lambdalisue/suda.vim',
	--'AckslD/nvim-neoclip.lua',
	--'projekt0n/circles.nvim',
	--'sudormrfbin/cheatsheet.nvim',
	--'pechorin/any-jump.vim',
	--'SidOfc/mkdx',
	--'Groctel/vim-keytree',
	--'adelarsq/vim-matchit',
	--'ourigen/skyline.vim',
	--'turbio/bracey.vim',
	--'airblade/vim-rooter',
	--'jez/as-tree',
	--'whatever555/vanity',
	--'adelarsq/vim-emoji-icon-theme',
	--'junegunn/vim-emoji',
	--'thaerkh/vim-workspace',
	--'dagrejs/graphlib-dot',
	--'wincent/ferret',
	--'nagy135/capture-nvim',
	--'nvim-telescope/telescope-media-files.nvim',
	--'kamykn/spelunker.vim',
	--'jasonlong/lavalamp',
	--'ernstwi/vim-secret',
	--'VOID001/graph-easy-vim',
	--'vimcki/vim-quickfile',
	--'obcat/vim-hitspop',
	--'ms-jpq/kok.nvim',
	--'skywind3000/Leaderf-snippet',
	--'zefei/vim-wintabs',
	--'Xuyuanp/yanil',
	--'el-iot/buffer-minimalism',
	--'el-iot/vim-wikipedia-browser',
	--'beauwilliams/statusline.lua',
	--'skywind3000/vim-rt-format',
	--'gotbletu/shownotes/tree/master/fzf_nova',
	--'carlosrocha/vim-chrome-devtools',
	--'rbong/vim-crystalline',
	--'bbli/filter-jump.nvim',
	--'pit-ray/win-vind',
	--'RRethy/vim-hexokinase',
	--'Thyrum/vim-stabs',
	--'bryall/contextprint.nvim',
	--'zhimsel/vim-stay',
	--'ChristianChiarulli/nvim',
	--'yehuohan/popc',
	--'yehuohan/popset',
	--'shoumodip/helm.nvim',
	--'pwntester/codeql.nvim',
	--'shoumodip/ido.nvim',
	--'tools-life/taskwiki',
	--'kristijanhusak/vim-dadbod-completion',
	--'ojroques/nvim-lspfuzzy',
	--'dpretet/vim-leader-mapper',
	--'jbyuki/instant.nvim',
	--'rafcamlet/nvim-whid',
	--'ojroques/vim-scrollstatus',
	--'obcat/vim-sclow',
	--'nvim-lua/popup.nvim',
	--'hkupty/impromptu.nvim',
	--'ElPiloto/sidekick.nvim',
	--'akinsho/nvim-toggleterm.lua',
	--'akinsho/dependency-assist.nvim',
	--'akinsho/lightline-statuslinetabs',
	--'numToStr/FTerm.nvim',
	--'datwaft/bubbly.nvim',
	--'jubnzv/virtual-types.nvim',
	--'nvim-telescope/telescope-packer.nvim',
	--'nvim-telescope/telescope-github.nvim',
	--'GeneZharov/vim-scrollmode',
	--'tolgraven/metabuffer.nvim',
	--'IMOKURI/line-number-interval.nvim',
	--'adelarsq/neoline.vim',
	--'nvim-lua/lsp_extensions.nvim',
	--'dsummersl/nvim-sluice',
	--'tanrax/terminal-AdvancedNewFile',
	--'ZhiyuanLck/vim-float-terminal',
	--'puremourning/vimspector#neovim-differences',
	--'amix/vim-zenroom2',
	--'Timoses/vim-venu',
	--'skywind3000/vim-auto-popmenu',
	--'liuchengxu/graphviz.vim',
	--'MattesGroeger/vim-bookmarks',
	--'romgrk/todoist.nvim',
	--'mortepau/codicons.nvim',
	--'jamestthompson3/nvim-remote-containers',
	--'gaborvecsei/memento.nvim',
	--'mcauley-penney/tidy.nvim',
	--'andweeb/presence.nvim',
	--'milisims/nvim-luaref',
	--'m00qek/baleia.nvim',
	--'hkupty/iron.nvim',
	--'bfredl/nvim-ipy',
	--'https://gitlab.com/HiPhish/repl.nvim',
	--'roxma/nvim-completion-manager',
	--'nicwest/vim-camelsnek',
	--'prabirshrestha/asyncomplete.vim',
	--'embear/vim-localvimrc',
	--'amiorin/vim-project',
	--'Yilin-Yang/vim-markbar',
	--'vimwiki/vimwiki',
	--'skywind3000/asynctasks.vim',
	--'laher/fuzzymenu.vim',
	--'GideonWolfe/vim.reaper',
	--'machakann/vim-columnmove',
	--'machakann/vim-patternjump',
	--'dstein64/vim-win',
	--'chrisbra/unicode.vim',
	--'junegunn/vim-slash',
	--'pgdouyon/vim-evanesco',
	--'tibabit/vim-templates',
	--'goldfeld/vim-seek',
	--'t9md/vim-smalls',
	--'lifepillar/vim-colortemplate',
	--'samuelsimoes/vim-drawer',
	--'lervag/vimtex',
	--'tmsvg/pear-tree',
	--'hyiltiz/vim-plugins-profile',
	--'mg979/vim-xtabline',
	--'lfv89/vim-interestingwords',
	--'ahw/vim-hooks',
	--'gennaro-tedesco/boilit',
	--'voldikss/vim-skylight',
	--'google/vim-maktaba',
	--'zeekay/vim-html2jade',
	--'lambdalisue/shareboard.vim',
	--'sotte/presenting.vim',
	--'hotoo/vimlide',
	--'tybenz/vimdeck',
	--'ingydotnet/vroom-pm',
	--'inside/vim-presentation',
	--'trapd00r/vimpoint',
	--'blindFS/vim-reveal',
	--'dbmrq/vim-dialect',
	--'dbmrq/vim-howdy',
	--'mhinz/neovim-remote',
	--'ivanov/vim-ipython',
	--'lambdalisue/neovim-prompt',
	--'FriedSock/smeargle',
	--'kciter/vimgolf-finder',
	--'nelstrom/vimprint',
	--'dira/vimmish',
	--'lambdalisue/gina.vim',
	--'lambdalisue/vim-gita',
	--'lambdalisue/vim-pager',
	--'lambdalisue/battery.vim',
	--'lambdalisue/wifi.vim',
	--'lambdalisue/vital-Vim-Prompt',
	--'lambdalisue/vim-backslash',
	--'jreybert/vimagit',
	--'cldwalker/vimdb',
	--'zhaocai/GoldenView.Vim',
	--'djmoch/vim-makejob',
	--'dhruvasagar/vim-marp',
	--'vim-scripts/c.vim',
	--'haya14busa/vim-gtrans',
	--'jsim2010/vim-strike',
	--'kristijanhusak/vim-hybrid-material',
	--'nightsense/seabird',
	--'Alok/notational-fzf-vim',
	--'bpierce1/fzf-index.vim',
	--'vimoutliner/vimoutliner',
	--'aaronbieber/vim-quicktask',
	--'xolox/vim-notes',
	--'jceb/vim-orgmode',
	--'vim-pandoc/vim-pandoc',
	--'jpalardy/vim-slime',
	--'gevann/vim-centered',
	--'LeafCage/yankround.vim',
	--'tomtom/tregisters_vim',
	--'kovisoft/slimv',
	--'Shougo/neossh.vim',
	--'thinca/vim-github',
	--'lokikl/shellbridge',
	--'rhysd/warp.vim',
	--'jalvesaq/vimcmdline',
	--'kbairak/ColumnTags.vim',
	--'Olical/vim-syntax-expand',
	--'fweep/vim-tabber',
	--'baruchel/vim-notebook',
	--'julienr/vim-cellmode',
	--'wdicarlo/vim-notebook',
	--'janko-m/vim-test',
	--'vim-scripts/DoxygenToolkit.vim',
	--'mhinz/vim-randomtag',
	--'rupa/v',
	--'jrosiek/vim-mark',
	--'tyru/karakuri.vim/blob/master/autoload/karakuri.vim',
	--'tyru/current-func-info.vim',
	--'tyru/emap.vim',
	--'vim-scripts/ccase.vim',
	--'tpope/vim-sexp-mappings-for-regular-people',
	--'guns/vim-sexp',
	--'ryym/mapping.vim',
	--'vim-scripts/mappinggroup.vim',
	--'obxhdx/vim-action-mapper',
	--'tyru/foldballoon.vim',
	--'tyru/savemap.vim',
	--'tyru/pummode.vim/',
	--'godlygeek/csapprox',
	--'cocopon/pgmnt.vim',
	--'cocopon/snapbuffer.vim',
	--'cocopon/colorswatch.vim',
	--'jlxz/TaskVim',
	--'jarolrod/vim-python-ide',
	--'bpstahlman/txtfmt',
	--'junegunn/vim-github-dashboard',
	--'google/ijaas',
	--'boucherm/ShowMotion',
	--'toupeira/vim-movealong',
	--'okcompute/vim-python-motions',
	--'mattn/googlesuggest-complete-vim',
	--'makerj/vim-transit',
	--'Kazark/vim-http-client',
	--'tasuten/gcalc.vim',
	--'iamcco/dict.vim',
	--'eschao/vim-dict',
	--'ntnn/vim-diction',
	--'drmikehenry/vim-extline',
	--'hauleth/sad.vim',
	--'xtal8/traces.vim',
	--'AndrewRadev/inline_edit.vim',
	--'AndrewRadev/deleft.vim',
	--'AndrewRadev/sideways.vim',
	--'AndrewRadev/whitespaste.vim',
	--'AndrewRadev/linediff.vim',
	--'AndrewRadev/yankwin.vim',
	--'AndrewRadev/dsf.vim',
	--'AndrewRadev/undoquit.vim',
	--'ckarnell/Antonys-macro-repeater',
	--'Rykka/mathematic.vim',
	--'tpope/vim-dispatch',
	--'Badacadabra/Vimpressionist',
	--'ryanfmurphy/vimsed',
	--'b4b4r07/zsh-vimode-visual',
	--'vim-jp/vital.vim',
	--'haya14busa/underscore.vim',
	--'amoffat/snake',
	--'pocket7878/curses-vim',
	--'LucHermitte/lh-vim-lib',
	--'rbtnn/rabbit-ui.vim',
	--'ViKomprenas/scratch.vim',
	--'ehamberg/vim-cute-python',
	--'nyngwang/NeoRoot.lua',
	--'nyngwang/NeoZoom.lua',
	--'Yggdroot/LeaderF',
	--'dylanaraps/pywal',
	--'cirala/vifm_devicons',
	--'chrisbra/matchit',
	--'fszymanski/fzf-quickfix',
	--'tamago324/LeaderF-filer',
	--'RishabhRD/lspactions',
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
		['Pocco81/AbbrevMan.nvim'] = {
			url = 'Pocco81/AbbrevMan.nvim',
			is_enabled = function()
				return vim.fn.has('nvim') == 1
			end,
		},
		['0styx0/abbreinder.nvim'] = {
			url = '0styx0/abbreinder.nvim',
			is_enabled = function()
				return vim.fn.has('nvim') == 1
			end,
			dependencies = {
				pre = { '0styx0/abbremand.nvim' },
			},
		},
		['MunifTanjim/nui.nvim'] = {
			url = 'MunifTanjim/nui.nvim',
			should_load_config = false,
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['kana/vim-arpeggio'] = {
			url = 'kana/vim-arpeggio',
			is_enabled = function()
				return true
			end,
			should_load_config = false,
			hooks = {
				after_config_load = function()
					vim.cmd [[ nnoremap <LocalLeader>zc :runtime configs/vim-arpeggio.vim<CR> ]]
				end,
			},
		},
		['smjonas/live-command.nvim'] = {
			url = 'smjonas/live-command.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.8') == 1
			end,
		},

		--EDITING
		['anuvyklack/hydra.nvim'] = {
			url = 'anuvyklack/hydra.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = { 'anuvyklack/keymap-layer.nvim' },
			},
		},
		--editing/operators
		['kylechui/nvim-surround'] = {
			url = 'kylechui/nvim-surround',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['osyo-manga/vim-operator-blockwise'] = {
			url = 'osyo-manga/vim-operator-blockwise',
			is_enabled = function()
				return true
			end,
			dependencies = {
				pre = { 'osyo-manga/vim-textobj-blockwise' },
			},
		},
		['syngan/vim-operator-furround'] = {
			url = 'syngan/vim-operator-furround',
			is_enabled = function()
				return true
			end,
			dependencies = {
				pre = { 'kana/vim-operator-user' },
			}
		},
		--editing/motions
		['jonatan-branting/nvim-better-n'] = {
			url = 'jonatan-branting/nvim-better-n',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
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
		['chentau/marks.nvim'] = {
			url = 'chentau/marks.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
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
		['AllenDang/nvim-expand-expr'] = {
			url = 'AllenDang/nvim-expand-expr',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},

		--EDITOR
		--editor/feature
		['nanotee/zoxide.vim'] = {
			url = 'nanotee/zoxide.vim',
			is_enabled = function()
				return is_installed({'zoxide'})
			end,
		},
		['windwp/nvim-spectre'] = {
			url = 'windwp/nvim-spectre',
			is_enabled = function()
				return (
					vim.fn.has('nvim-0.5') == 1 and
					is_installed({'rg', 'sed'})
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
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['goolord/alpha-nvim'] = {
			url = 'goolord/alpha-nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['gelguy/wilder.nvim'] = {
			url = 'gelguy/wilder.nvim',
			is_enabled = function()
				return (
					(vim.fn.has('nvim-0.3') == 1 or vim.v.version >= 810) and
					vim.fn.has('python3') == 1
				)
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
		['henriquehbr/nvim-startup.lua'] = {
			url = 'https://git.sr.ht/~henriquehbr/nvim-startup.lua',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['osyo-manga/vim-over'] = {
			url = 'osyo-manga/vim-over',
			is_enabled = function()
				return vim.fn.has('nvim') ~= 1
			end,
		},
		['xiyaowong/nvim-transparent'] = {
			url = 'xiyaowong/nvim-transparent',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
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
		['martinsione/darkplus.nvim'] = {
			url = 'martinsione/darkplus.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['Domeee/mosel.nvim'] = {
			url = 'Domeee/mosel.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1 and vim.fn.has('termguicolors') == 1
			end,
		},
		['olimorris/onedarkpro.nvim'] = {
			url = 'olimorris/onedarkpro.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['NvChad/nvim-base16.lua'] = {
			url = 'NvChad/nvim-base16.lua',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			config = function()
				local base16 = require('base16')

				local theme = base16.themes('javacafe')
				--local theme = base16.themes('onedark')
				--local theme = base16.themes('tokyonight')
				--local theme = base16.themes('uwu')

				--local theme = base16.themes('mountain')
				--local theme = base16.themes('gruvchad')
				--local theme = base16.themes('jellybeans')
				--local theme = base16.themes('one-light')
				--local theme = base16.themes('onejelly')

				--local theme = base16.themes('aquarium')
				--local theme = base16.themes('blossom')
				--local theme = base16.themes('chadracula')
				--local theme = base16.themes('doom-chad')
				--local theme = base16.themes('everforest')
				--local theme = base16.themes('gruvbox')
				--local theme = base16.themes('lfgruv')
				--local theme = base16.themes('nord')
				--local theme = base16.themes('onenord')
				--local theme = base16.themes('tomorrow-night')

				base16(theme, true)
			end,
			dependencies = {
				pre = {
					'norcalli/nvim.lua',
					--'norcalli/nvim-base16.lua',
				},
			},
		},
		['RRethy/nvim-base16'] = {
			url = 'RRethy/nvim-base16',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['FrenzyExists/aquarium-vim'] = {
			url = 'FrenzyExists/aquarium-vim',
			branch = 'vimscript_version',
		},
		['joshdick/onedark.vim'] = {
			url = 'joshdick/onedark.vim',
			config = function()
				vim.cmd('colorscheme onedark')
			end
		},
		['sonph/onehalf'] = {
			url = 'sonph/onehalf',
			rtp = 'vim/',
		},
		['kvrohit/substrata.nvim'] = {
			url = 'kvrohit/substrata.nvim',
			is_enabled = function()
				return vim.fn.has('nvim') == 1
			end,
			config = function()
				vim.cmd('colorscheme substrata')
			end,
		},
		['arzg/vim-substrata'] = {
			url = 'arzg/vim-substrata',
			config = function()
				vim.cmd('colorscheme substrata')
			end,
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
		['tiagovla/tokyodark.nvim'] = {
			url = 'tiagovla/tokyodark.nvim',
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
		},
		['rockerBOO/boo-colorscheme-nvim'] = {
			url = 'rockerBOO/boo-colorscheme-nvim',
			config = function()
				vim.cmd [[
					if (has("termguicolors")) == 1
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
		['folke/which-key.nvim'] = {
			url = 'folke/which-key.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
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
			dependencies = {
				post = {
					'tyru/open-browser-github.vim',
					--'tyru/open-browser-unicode.vim',
				}
			},
		},
		['j-morano/buffer_manager.nvim'] = {
			url = 'j-morano/buffer_manager.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = { 'nvim-lua/plenary.nvim' },
			},
		},
		['xiyaowong/link-visitor.nvim'] = {
			url = 'xiyaowong/link-visitor.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['glepnir/galaxyline.nvim'] = {
			url = 'glepnir/galaxyline.nvim',
			branch = 'main',
			-- should_load_config = true,
			dependencies = {
				-- post = { 'Avimitin/nerd-galaxyline' },
			},
		},
		['feline-nvim/feline.nvim'] = {
			url = 'feline-nvim/feline.nvim',
			dependencies = {
				pre = {
					'kyazdani42/nvim-web-devicons',
				},
				post = { },
			},
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
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
			dependencies = {
				post = {
					'hoob3rt/lualine.nvim',
					'kyazdani42/nvim-web-devicons',
				},
			},
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
		['akinsho/bufferline.nvim'] = {
			url = 'akinsho/bufferline.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.7') == 1
			end,
			dependencies = {
				pre = { 'kyazdani42/nvim-web-devicons', 'ryanoasis/vim-devicons' },
				post = { 'tiagovla/scope.nvim' },
			}
		},
		['akinsho/nvim-bufferline.lua'] = {
			url = 'akinsho/nvim-bufferline.lua',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['nanozuki/tabby.nvim'] = {
			url = 'nanozuki/tabby.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = { 'kyazdani42/nvim-web-devicons', 'ryanoasis/vim-devicons' },
				post = { 'tiagovla/scope.nvim' },
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
		['edluffy/specs.nvim'] = {
			url = 'edluffy/specs.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['hood/popui.nvim'] = {
			url = 'hood/popui.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = { 'RishabhRD/popfix' },
			},
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
		['petertriho/nvim-scrollbar'] = {
			url = 'petertriho/nvim-scrollbar',
			is_enabled = function()
				return vim.fn.has('nvim-0.5.1') == 1
			end,
			dependencies = {
				pre = { 'kevinhwang91/nvim-hlslens' },
			},
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
		['stonelasley/flare.nvim'] = {
			url = 'stonelasley/flare.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.7') == 1
			end,
		},
		['DanilaMihailov/beacon.nvim'] = {
			url = 'DanilaMihailov/beacon.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.7') == 1
			end,
		},
		['NarutoXY/dim.lua'] = {
			url = 'NarutoXY/dim.lua',
			is_enabled = function()
				return vim.fn.has('nvim-0.6') == 1
			end,
		},
		['kevinhwang91/nvim-hlslens'] = {
			url = 'kevinhwang91/nvim-hlslens',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['lambdalisue/lista.nvim'] = {
			url = 'lambdalisue/lista.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1 and vim.fn.has('python3') == 1
			end,
		},
		['ripxorip/aerojump.nvim'] = {
			url = 'ripxorip/aerojump.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			post_install = ':UpdateRemotePlugins',
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
		['luukvbaal/stabilize.nvim'] = {
			url = 'luukvbaal/stabilize.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			--after_plugin_load = function()
			--	require('stabilize').setup()
			--end,
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
		['skywind3000/asyncrun.vim'] = {
			url = 'skywind3000/asyncrun.vim',
			dependencies = {
				pre = { 'preservim/vimux' },
				post = { 'skywind3000/asyncrun.extra' },
			},
		},
		['is0n/fm-nvim'] = {
			url = 'is0n/fm-nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['junegunn/fzf'] = {
			url = 'junegunn/fzf',
			directory = '~/.fzf',
			post_install = ':call fzf#install()',
			dependencies = {
				post = {
					'junegunn/fzf.vim',
					--'yuki-yano/fzf-preview.vim',

					'vijaymarupudi/nvim-fzf',
					'ibhagwan/fzf-lua',

					'dominickng/fzf-session.vim',
					'pbogut/fzf-mru.vim',
				},
			},
		},
		['junegunn/fzf.vim'] = {
			url = 'junegunn/fzf.vim',
			config = 'fzf-vim.vim',
			dependencies = {
				pre = { 'junegunn/fzf' },
			},
		},
		['yuki-ycino/fzf-preview.vim'] = {
			url = 'yuki-ycino/fzf-preview.vim',
			branch = 'release/rpc',
			is_enabled = function()
				return vim.fn.has('node') == 1
			end,
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
				post = {
					--'gfeiyou/command-center.nvim',
					-- TODO: FIX: figure out to keep or not or fix it its working
					--'ilAYAli/scMRU.nvim',
					--'nvim-telescope/telescope-ui-select.nvim',
				},
			},
		},
		['stevearc/dressing.nvim'] = {
			url = 'stevearc/dressing.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = {
					'nvim-telescope/telescope.nvim',
					'ibhagwan/fzf-lua',
					'junegunn/fzf',
					--'MunifTanjim/nui.nvim'
				},
			}
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
		['X3eRo0/dired.nvim'] = {
			url = 'X3eRo0/dired.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.6') == 1
			end,
			dependencies = {
				pre = { 'MunifTanjim/nui.nvim' },
			},
		},
		['elihunter173/dirbuf.nvim'] = {
			url = 'elihunter173/dirbuf.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.6') == 1
			end,
		},
		['kyazdani42/nvim-tree.lua'] = {
			url = 'kyazdani42/nvim-tree.lua',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['ms-jpq/chadtree'] = {
			url = 'ms-jpq/chadtree',
			is_enabled = function()
				return vim.fn.has('nvim-0.4.3') == 1
			end,
			branch = 'chad',
			post_install = 'python3 -m chadtree deps',
		},

		--PROGRAMMING
		--programming/general
		['ludovicchabant/vim-gutentags'] = {
			url = 'ludovicchabant/vim-gutentags',
			is_enabled = function()
				return not is_installed({'tagrity'})
			end,
			dependencies = {
				post = { 'skywind3000/gutentags_plus' },
			},
		},

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
		['whynothugo/lsp_lines.nvim'] = {
			url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['neovim/nvim-lspconfig'] = {
			url = 'neovim/nvim-lspconfig',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			should_load_config = true,
			dependencies = {
				post = {
					--'williamboman/mason.nvim',
					'williamboman/nvim-lsp-installer',
				},
			},
		},
		['cseickel/diagnostic-window.nvim'] = {
			url = 'cseickel/diagnostic-window.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['wiliamks/nice-reference.nvim'] = {
			url = 'wiliamks/nice-reference.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = {
					'kyazdani42/nvim-web-devicons',
					'rmagatti/goto-preview',
				},
			},
		},
		['amrbashir/nvim-docs-view'] = {
			url = 'amrbashir/nvim-docs-view',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			lazyload = {
				cmds = 'DocsViewToggle',
			}
		},
		['SmiteshP/nvim-navic'] = {
			url = 'SmiteshP/nvim-navic',
			is_enabled = function()
				return vim.fn.has('nvim-0.7') == 1
			end,
			dependencies = {
				pre = { 'neovim/nvim-lspconfig' },
			},
		},
		['utilyre/barbecue.nvim'] = {
			url = 'utilyre/barbecue.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.8') == 1
			end,
			dependencies = {
				pre = {
					'neovim/nvim-lspconfig',
					'SmiteshP/nvim-navic',
					'kyazdani42/nvim-web-devicons', -- optional
				},
			},
		},
		['folke/trouble.nvim'] = {
			url = 'folke/trouble.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['kosayoda/nvim-lightbulb'] = {
			url = 'kosayoda/nvim-lightbulb',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['smjonas/inc-rename.nvim'] = {
			url = 'smjonas/inc-rename.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.8') == 1
			end,
		},
		['rmagatti/goto-preview'] = {
			url = 'rmagatti/goto-preview',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['nanotee/nvim-lsp-basics'] = {
			url = 'nanotee/nvim-lsp-basics',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['RishabhRD/nvim-lsputils'] = {
			url = 'RishabhRD/nvim-lsputils',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['folke/lsp-colors.nvim'] = {
			url = 'folke/lsp-colors.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['onsails/lspkind-nvim'] = {
			url = 'onsails/lspkind-nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['ray-x/lsp_signature.nvim'] = {
			url = 'ray-x/lsp_signature.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['weilbith/nvim-code-action-menu'] = {
			url = 'weilbith/nvim-code-action-menu',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['glepnir/lspsaga.nvim'] = {
			url = 'glepnir/lspsaga.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['jose-elias-alvarez/nvim-lsp-ts-utils'] = {
			url = 'jose-elias-alvarez/nvim-lsp-ts-utils',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['j-hui/fidget.nvim'] = {
			url = 'j-hui/fidget.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.6') == 1
			end,
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
		['ldelossa/litee.nvim'] = {
			url = 'ldelossa/litee.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				post = {
					'ldelossa/litee-symboltree.nvim',
					'ldelossa/litee-calltree.nvim',
					'ldelossa/litee-filetree.nvim',
				},
			},
		},
		['nvim-lua/lsp-status.nvim'] = {
			url = 'nvim-lua/lsp-status.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['jose-elias-alvarez/null-ls.nvim'] = {
			url = 'jose-elias-alvarez/null-ls.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['joechrisellis/lsp-format-modifications.nvim'] = {
			url = 'joechrisellis/lsp-format-modifications.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.8')
			end,
		},

		--programming/random
		['b3nj5m1n/kommentary'] = {
			url = 'b3nj5m1n/kommentary',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['skanehira/k8s.vim'] = {
			url = 'skanehira/k8s.vim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = { 'vim-denops/denops.vim' },
			},
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
			dependencies = {
				post = { 'nvim-treesitter/playground' },
			},
		},
		['mfussenegger/nvim-treehopper'] = {
			url = 'mfussenegger/nvim-treehopper',
			dependencies = {
				pre = {
					'nvim-treesitter/nvim-treesitter',
				},
			},
			is_enabled = function()
				return vim.fn.has('nvim-0.7') == 1
			end,
		},
		['ziontee113/syntax-tree-surfer'] = {
			url = 'ziontee113/syntax-tree-surfer',
			dependencies = {
				pre = {
					'nvim-treesitter/nvim-treesitter',
				},
			},
			is_enabled = function()
				return vim.fn.has('nvim-0.7') == 1
			end,
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
		['nvim-treesitter/nvim-treesitter-context'] = {
			url = 'nvim-treesitter/nvim-treesitter-context',
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
		['github/copilot.vim'] = {
			url = 'github/copilot.vim',
			post_install = ':Copilot setup',
			is_enabled = function()
				return vim.fn.has('nvim-0.6') == 1
			end,
		},
		['hrsh7th/nvim-cmp'] = {
			url = 'hrsh7th/nvim-cmp',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				post = {
					'hrsh7th/cmp-nvim-lsp',
					'saadparwaiz1/cmp_luasnip',
					--'hrsh7th/cmp-vsnip',
					'hrsh7th/cmp-nvim-lua',
					'hrsh7th/cmp-nvim-lsp-signature-help',
					--'quangnguyen30192/cmp-nvim-tags',
					'lukas-reineke/cmp-rg',

					'hrsh7th/cmp-buffer',
					'hrsh7th/cmp-path',
					--'tzachar/cmp-tabnine',
					--'ray-x/cmp-treesitter',

					'tamago324/cmp-zsh',
					'andersevenrud/cmp-tmux',
					'David-Kunz/cmp-npm',
					'petertriho/cmp-git',
					'hrsh7th/cmp-cmdline',

					'f3fora/cmp-spell',
					--'hrsh7th/cmp-calc',
					--'octaltree/cmp-look',
					--'hrsh7th/cmp-emoji',
					--'chrisgrieser/cmp-nerdfont',
					--'amarakon/nvim-cmp-buffer-lines',
					--'tzachar/cmp-fuzzy-buffer',
					--'tzachar/cmp-fuzzy-path',
					--'rcarriga/cmp-dap',
					--'KadoBOT/cmp-plugins',
					--'barklan/cmp-gitlog',
					--'kdheepak/cmp-latex-symbols',
					--'quangnguyen30192/cmp-nvim-ultisnips',
					--'lukas-reineke/cmp-under-comparator',
					--'hrsh7th/cmp-copilot',
					--'zbirenbaum/copilot-cmp',
					--'lttr/cmp-jira',
					--'aspeddro/cmp-pandoc.nvim',
					--'uga-rosa/cmp-dictionary',
					--'bydlw98/cmp-env',
					--'amarakon/nvim-cmp-fonts',
					--'wxxxcxx/cmp-browser-source',
					--'dcampos/cmp-emmet-vim',
					--'pschmitt/cmp-brotab',
					--'jcha0713/cmp-tw2css',
					--'uga-rosa/cmp-dynamic',
					--'doxnit/cmp-luasnip-choice',
					--'phenax/cmp-graphql',
					--'Dosx001/cmp-commit',
				},
			},
		},
		['noib3/nvim-compleet'] = {
			url = 'noib3/nvim-compleet',
			post_install = 'cargo build --release && make install',
			is_enabled = function()
				return vim.fn.has('nvim-0.7') == 1 and is_installed({ 'make', 'ar', 'rustc', 'rustup' }) == 1
			end,
		},
		['tzachar/cmp-tabnine'] = {
			url = 'tzachar/cmp-tabnine',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			post_install = './install.sh',
		},
		['Wansmer/treesj'] = {
			url = 'Wansmer/treesj',
			is_enabled = function()
				return vim.fn.has('nvim-0.8')
			end,
			dependencies = {
				pre = { 'nvim-treesitter/nvim-treesitter' },
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
				return is_installed({'git'}) and vim.fn.has('nvim-0.5') == 1
			end,
		},
		['tanvirtin/vgit.nvim'] = {
			url = 'tanvirtin/vgit.nvim',
			is_enabled = function()
				return is_installed({'git'}) and vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = {
					'nvim-lua/plenary.nvim',
					'kyazdani42/nvim-web-devicons',
				},
			},
		},
		['ldelossa/gh.nvim'] = {
			url = 'ldelossa/gh.nvim',
			is_enabled = function()
				return is_installed({'git', 'gh'}) and vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = { 'ldelossa/litee.nvim' },
			},
		},
		['skanehira/gh.vim'] = {
			url = 'skanehira/gh.vim',
			is_enabled = function()
				return is_installed({'git', 'gh'}) and vim.fn.has('nvim-0.5') == 1
			end,
		},
		['lewis6991/gitsigns.nvim'] = {
			url = 'lewis6991/gitsigns.nvim',
			is_enabled = function()
				return is_installed({'git'}) and vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = { 'nvim-lua/plenary.nvim' },
			},
		},
		['sindrets/diffview.nvim'] = {
			url = 'sindrets/diffview.nvim',
			is_enabled = function()
				return is_installed({'git'}) and vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = { 'kyazdani42/nvim-web-devicons' },
			},
		},
		['ruifm/gitlinker.nvim'] = {
			url = 'ruifm/gitlinker.nvim',
			is_enabled = function()
				return is_installed({'git'}) and vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = { 'nvim-lua/plenary.nvim' },
			},
		},
		['pwntester/octo.nvim'] = {
			url = 'pwntester/octo.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1 and is_installed({'git', 'gh'}) == 1
			end,
		},
		['akinsho/git-conflict.nvim'] = {
			url = 'akinsho/git-conflict.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.7') == 1 and is_installed({'git'}) == 1
			end,
		},

		--programming/testing
		['vim-test/vim-test'] = {
			url = 'vim-test/vim-test',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				post = {
					--'rcarriga/neotest',
					'rcarriga/vim-ultest', --deprecated
        },
			},
		},
		['rcarriga/neotest'] = {
			url = 'rcarriga/neotest',
			dependencies = {
				pre = {
					"nvim-lua/plenary.nvim",
					"nvim-treesitter/nvim-treesitter",
					"antoinemadec/FixCursorHold.nvim",
          'haydenmeade/neotest-jest',
				},
			}
		},
		['rcarriga/vim-ultest'] = {
			url = 'rcarriga/vim-ultest',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1 and vim.fn.has('python3') == 1
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
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = { 'jbyuki/one-small-step-for-vimkind' },
				post = {
					'Pocco81/DAPInstall.nvim',
					'rcarriga/nvim-dap-ui',
					'theHamsta/nvim-dap-virtual-text',
					'Weissle/persistent-breakpoints.nvim',
					'ofirgall/goto-breakpoints.nvim',
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
		['JASONews/glow-hover'] = {
			url = 'JASONews/glow-hover',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1 and is_installed({'glow'}) == 1
			end,
		},
		['antonk52/npm_scripts.nvim'] = {
			url = 'antonk52/npm_scripts.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1 and is_installed({'npm'}) == 1
			end,
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
		['prettier/vim-prettier'] = {
			url = 'prettier/vim-prettier',
			is_enabled = function()
				return vim.v.version >= 800 and is_installed({'node'}) == 1
			end,
		},
		['napmn/react-extract.nvim'] = {
			url = 'napmn/react-extract.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
		},
		['Azeirah/nvim-redux'] = {
			url = 'Azeirah/nvim-redux',
			is_enabled = function()
				return vim.fn.has('nvim-0.5') == 1
			end,
			dependencies = {
				pre = { 'nvim-telescope/telescope.nvim' },
			},
		},
		['0x100101/lab.nvim'] = {
			url = '0x100101/lab.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.7.2') == 1 and is_installed({'node'}) == 1
			end,
			post_install = 'cd js && npm ci',
			dependencies = {
				pre = { 'nvim-lua/plenary.nvim' },
			},
		},

		--CLIENTS
		['glacambre/firenvim'] = {
			url = 'glacambre/firenvim',
			post_install = ':call firenvim#install(0)',
		},

		--RANDOM
		['potamides/pantran.nvim'] = {
			url = 'potamides/pantran.nvim',
			is_enabled = function()
				return vim.fn.has('nvim-0.7') == 1
			end,
		},
		['iamcco/markdown-preview.nvim'] = {
			url = 'iamcco/markdown-preview.nvim',
			lazyload = {
				filetypes = { 'markdown', 'vim-plug' },
			},
			post_install = 'cd app && yarn install',
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
		['itchyny/dictionary.vim'] = {
			url = 'itchyny/dictionary.vim',
			is_enabled = function()
				return vim.fn.IsNix() == 1
			end,
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
