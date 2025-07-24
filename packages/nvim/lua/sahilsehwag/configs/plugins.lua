local concat = require("libs.utils").table.list.concat

local is_installed = function(names, handler)
	handler = handler or function(name)
		print(name .. " is not installed")
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
	"lewis6991/impatient.nvim",
	"tpope/vim-capslock", --1+
	{ "kana/vim-repeat", "tpope/vim-repeat" }, --1+
	"kana/vim-niceblock",
	"smjonas/live-command.nvim",
	"vim-scripts/LargeFile",
	"thalesmello/nvim-better-operator-message",
	--'haolian9/redostr.nvim',
	--TODO:test

	--nested neovim instances
	{
		"willothy/flatten.nvim",
		"samjwill/nvim-unception",
	},

	--arglist
	--'idbrii/vim-argedit',
	--TODO:not working due to :Scratch command, interefering with scratch.vim
	"joechrisellis/vim-git-arglist",

	{
		--'glepnir/mcc.nvim',
		--'kana/vim-smartchr',
	},
	{
		--"Pocco81/AbbrevMan.nvim",
		"tpope/vim-abolish",
	},
	"0styx0/abbreinder.nvim",
	"kana/vim-arpeggio",

	--libs.grammar
	"kana/vim-operator-user",
	"kana/vim-textobj-user",
	--'doy/vim-textobj',
	"osyo-manga/vim-textobj-blockwise",
	"osyo-manga/vim-operator-blockwise",
	"wellle/targets.vim",
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
	"jonatan-branting/nvim-better-n", --1+
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
		--'nvimtools/hydra.nvim', -- TODO: try
		"anuvyklack/hydra.nvim",
		--{'Iron-E/nvim-libmodal', 'Iron-E/vim-libmodal'},
		--'kana/vim-submode',
		--'vim-scripts/vim-easy-submode',
		--'tommcdo/vim-express',
		--'neitanod/vim-sade',
		--'vim-scripts/Omap.vim',
	},
	"anuvyklack/keymap-amend.nvim",

	--{ 't9md/vim-transform', 'inkarkat/vim-TextTransform', --'obxhdx/vim-action-mapper' },
	--'vigoux/architext.nvim',
	--'kana/vim-metarw',
	--'kana/vim-metarw-git',
	--'kana/vim-gf-user',
	--'furkanzmc/options.nvim',

	--intellisence
	"nvim-treesitter/nvim-treesitter", --1+

	--operator
	"haya14busa/vim-operator-flashy",
	{
		"kylechui/nvim-surround", --1+
		"tpope/vim-surround",
	},
	--'syngan/vim-operator-furround',
	-- FIX: mappings overriding other mappings like dd
	--'gbprod/substitute.nvim',
	-- TODO: not working
	-- INFO: vim-subversive + vim-exchange
	"svermeulen/vim-subversive", --1+
	"tommcdo/vim-exchange", --1+
	"junegunn/vim-easy-align", --1+
	"JRasmusBm/vim-peculiar", --1+
	{
		"kana/vim-operator-replace", --1+
		"romgrk/replace.vim",
	},
	"kana/vim-grex", --2+
	{
		--'johmsalas/text-case.nvim',
		"arthurxavierx/vim-caser",
	},
	"gustavo-hms/vim-duplicate", --2+
	"rjayatilleka/vim-operator-goto",
	{
		"tommcdo/vim-ninja-feet", --1+
		"bagohart/vim-operator-insert-append",
	},
	"osyo-manga/vim-operator-search",
	"vim-scripts/operator-star",
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
	--TODO: change keymaps
	--'otavioschwanck/cool-substitute.nvim',
	{
		--'mg979/vim-visual-multi',
		-- TODO: configure
		"terryma/vim-multiple-cursors",
	},

	--objects.modifier
	--'svermeulen/vim-next-object',

	--objects
	--'pgdouyon/vim-apparate',
	"coderifous/textobj-word-column.vim", --1
	"rhysd/vim-textobj-anyblock", --1
	"thinca/vim-textobj-between", --1
	"michaeljsmith/vim-indent-object", --1,
	--'glts/vim-textobj-indblock',
	{
		"saaguero/vim-textobj-pastedtext", --1
		--'gilligan/textobj-lastpaste',
	},
	"rhysd/vim-textobj-lastinserted",
	"Raimondi/vim_search_objects",
	-- TODO: not sure
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
	"Julian/vim-textobj-variable-segment", --1
	"machakann/vim-textobj-delimited", --1
	{
		"syngan/vim-textobj-postexpr",
		"machakann/vim-textobj-functioncall",
		"anyakichi/vim-textobj-xbrackets",
	},
	"thalesmello/vim-textobj-methodcall",
	{
		"machakann/vim-swap", --1+
		"sgur/vim-textobj-parameter",
	},
	"glts/vim-textobj-comment", --1
	--'Julian/vim-textobj-assignment',
	--'vimtaku/vim-textobj-keyvalue',
	--'coachshea/vim-textobj-markdown',
	--'jasonlong/vim-textobj-css',
	--'jceb/vim-textobj-uri',
	--'osyo-manga/vim-textobj-context',
	--'mjbrownie/html-textobjects',
	"justinj/vim-textobj-reactprop",
	--'chrisgrieser/nvim-various-textobjs',

	--objects.treesitter
	"nvim-treesitter/nvim-treesitter-textobjects", --1+
	--'RRethy/nvim-treesitter-textsubjects',
	"David-Kunz/treesitter-unit",
	--'Jason-M-Chan/ts-textobjects',
	--"ziontee113/SelectEase", --TODO: configure

	--motions
	--'spiiph/vim-space',
	{
		"chaoren/vim-wordmotion", --1+
		"kana/vim-smartword",
	},
	--'haya14busa/vim-edgemotion',
	{ "terryma/vim-expand-region", "gcmt/wildfire.vim" },
	--'vim-scripts/JumpToLastOccurrence',
	--'rbong/vim-vertical',

	--motions.treesitter
	--'gsuuon/tshjkl.nvim', --TODO: 1+
	--{ 'Dkendal/nvim-treeclimber', 'ziontee113/syntax-tree-surfer', 'drybalka/tree-climber.nvim' }, --1*
	--'mfussenegger/nvim-treehopper', --1*
	--'roobert/tabtree.nvim', --1*
	--'Wansmer/sibling-swap.nvim',
	--'Wansmer/binary-swap.nvim',

	--search.treesitter
	"Marskey/telescope-sg", --1+

	--jumps
	"buztard/vim-rel-jump",
	"kana/vim-exjumplist",
	-- FIX:
	"kwkarlwang/bufjump.nvim",
	{ "andymass/vim-matchup", "theHamsta/nvim-treesitter-pairs" },
	{ "chentoast/marks.nvim", "kshenoy/vim-signature" },
	--'fnune/recall.nvim', -- TODO: try
	--"arp242/jumpy.vim", --TODO: MAPPINGS =1+
	-- FIX:
	--'fergdev/vim-cursor-hist',

	--search
	{
		"folke/flash.nvim", --1+
		"ggandor/leap.nvim", --1+
		--'haya14busa/incsearch.vim',
		--'haya14busa/incsearch-fuzzy.vim',
	},
	"bronson/vim-visual-star-search",
	--'haya14busa/vim-asterisk',
	--{'ironhouzi/starlite-nvim', 'ironhouzi/vim-stim'},
	"romainl/vim-cool",

	--search.fFtT
	"unblevable/quick-scope", --2+
	{
		--"rhysd/clever-f.vim",
		--'chrisbra/improvedft',
		--'dahu/vim-fanfingtastic',
		--"justinmk/vim-sneak",
	},
	--"kevinhwang91/nvim-ffhighlight",
	-- FIX: highlight | keymaps

	--operations
	--'sickill/vim-pasta',
	{
		"Wansmer/treesj", --1+
		"aarondiel/spread.nvim",
		"AndrewRadev/splitjoin.vim",
	},
	{
		--'AckslD/nvim-trevJ.lua',
		--'AckslD/nvim-revJ.lua',
	},
	--'jeetsukumaran/vim-linearly',
	"osyo-manga/vim-jplus",
	"sQVe/sort.nvim",
	-- TODO: configure|define-operator(s)

	--operations.miscelleanous
	"dkarter/bullets.vim",
	--'kabbamine/lazylist.vim',
	"dhruvasagar/vim-table-mode",
	"rasukarusan/nvim-select-multi-line",
	"lambdalisue/reword.vim",
	{'windwp/nvim-autopairs', 'jiangmiao/auto-pairs'},
	"abecodes/tabout.nvim",
	"windwp/nvim-ts-autotag",
	{ "NTBBloodbath/color-converter.nvim", "amadeus/vim-convert-color-to" },
	{ "zirrostig/vim-schlepp", "matze/vim-move" },
	--'svermeulen/vim-yoink',
	"tenfyzhong/axring.vim",
	"leothelocust/vim-makecols",
	"monaqa/dial.nvim",

	--comment
	{
		"scrooloose/nerdcommenter",
		"tpope/vim-commentary",
		"b3nj5m1n/kommentary",
	},
	"LudoPinelli/comment-box.nvim", --2
	"s1n7ax/nvim-comment-frame", --2
	"JoosepAlviste/nvim-ts-context-commentstring", --2

	--treesitter
	--"nvim-treesitter/nvim-treesitter-refactor",
	"winston0410/smart-cursor.nvim",
	--'nvim-treesitter/nvim-tree-docs',

	--aesthetics
	--"p00f/nvim-ts-rainbow",
	{
		"tzachar/local-highlight.nvim",
		"RRethy/vim-illuminate",
		"itchyny/vim-cursorword",
	},
	"markonm/traces.vim",

	--random
	"editorconfig/editorconfig-vim",
	{
		"NMAC427/guess-indent.nvim",
		--'Darazaki/indent-o-matic',
		--'tpope/vim-sleuth',
		--'zsugabubus/crazy8.nvim',
		--'ciaranm/detectindent',
	},
	{
		--'lalitmee/browse.nvim', --TODO: 1+
		"tyru/open-browser.vim",
	},
	"jbyuki/nabla.nvim",
	"AllenDang/nvim-expand-expr", --3
	-- TODO: not sure how to use it
	--'skywind3000/vim-dict',
	--'vim-scripts/motion.vim',

	--dependencies
	"Shougo/vimproc.vim",
}
local editor = {
	--jumps
	"nacro90/numb.nvim",

	--editor.general
	"nanotee/zoxide.vim",
	"gelguy/wilder.nvim", --1+
	{
		--'linty-org/key-menu.nvim',
		--'Cassin01/wf.nvim',
		"folke/which-key.nvim", --1+
		"liuchengxu/vim-which-key",
	},
	"abdalrahman-ali/vim-remembers",
	"rcarriga/nvim-notify", --1+
	--TODO: setup =1+
	--'liangxianzhe/nap.nvim',
	{
		"mbbill/undotree", --1+
		--'simnalamburt/vim-mundo',
	},
	"ntpeters/vim-better-whitespace",
	{
		--'desdic/macrothis.nvim', TODO: 1+
		"svermeulen/vim-macrobatics",
		{ "dohsimpson/vim-macroeditor", "rbong/vim-buffest" },
	},
	"notomo/cmdbuf.nvim",
	"kopischke/vim-fetch",
	"crusj/bookmarks.nvim",
	{
		--'chrisbra/NrrwRgn',
		"kana/vim-narrow",
		--'jkramer/vim-narrow',
	},
	--{
	--	-- FIX:
	--	'edluffy/specs.nvim',
	--	'stonelasley/flare.nvim',
	--	'DanilaMihailov/beacon.nvim',
	--	'inside/vim-search-pulse',
	--},
	--'tpope/vim-obsession',
	--'junegunn/vim-peekaboo',

	--colorcolumn
	{
		"m4xshen/smartcolumn.nvim",
		--'lukas-reineke/virt-column.nvim',
	},

	--libraries
	"s1n7ax/nvim-window-picker",

	-- analytics
	"gaborvecsei/usage-tracker.nvim",

	--system
	--'lambdalisue/guise.vim',

	--tabs
	{
		--"backdround/tabscope.nvim", --TODO: 1+
		"tiagovla/scope.nvim", --1+
	},

	--quickfix
	{
		"kevinhwang91/nvim-bqf", --1
		"romainl/vim-qf",
	},
	"weilbith/vim-loche",
	"weilbith/vim-quickname",

	"xiyaowong/nvim-transparent", --1+
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
		"catppuccin/nvim", -- 1+
		--"projekt0n/github-nvim-theme", -- 1
		--{ 'B4mbus/oxocarbon-lua.nvim', 'shaunsingh/oxocarbon.nvim' },
		--'NvChad/nvim-base16.lua',
		--{'folke/tokyonight.nvim', 'ghifarit53/tokyonight-vim'},
		--'tiagovla/tokyodark.nvim',
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
		"Domeee/mosel.nvim",
		"kdheepak/monochrome.nvim",

		--best.stable
		{ "martinsione/darkplus.nvim", "Mofiqul/vscode.nvim", "tomasiser/vim-code-dark" },

		--good
		"ayu-theme/ayu-vim",
		"cseelus/vim-colors-tone",
		"wuelnerdotexe/vim-enfocado",

		--eccentric
		"yashguptaz/calvera-dark.nvim",
		"lawsdontapplytopigs/black_cherries",
		"Shadorain/shadotheme",
		"haishanh/night-owl.vim",

		--minimal
		"danishprakash/vim-yami",

		--soft
		"drewtempelmeyer/palenight.vim",
		"joshdick/onedark.vim",
		"tyrannicaltoucan/vim-quantum",
		"sonph/onehalf",
		"novakne/kosmikoa.nvim",

		--dull
		"rockerBOO/boo-colorscheme-nvim",
		"ulwlu/elly.vim",

		--normal
		"KabbAmine/yowish.vim",

		--okish
		"arzg/vim-corvine",
		"raphamorim/lucario",
		"KeitaNakamura/neodark.vim",
		"sindresorhus/focus",

		--collections
		{ "RRethy/nvim-base16", "chriskempson/base16-vim" },
		"christianchiarulli/nvcode-color-schemes.vim",
		"flazz/vim-colorschemes",
		"rafi/awesome-vim-colorschemes",
		"i3d/vim-jimbothemes",
	},

	--editor.aesthetics
	{
		--'kdheepak/tabline.nvim',
		--'nanozuki/tabby.nvim',
		--'rafcamlet/tabline-framework.nvim',
		--'noib3/nvim-cokeline',

		"akinsho/bufferline.nvim", --1+
		"akinsho/nvim-bufferline.lua", --same as above just the legacy config
		"romgrk/barbar.nvim",
		"bling/vim-bufferline",
	},
	{
		--"strash/everybody-wants-that-line.nvim", --1
		--"feline-nvim/feline.nvim",
		--"glepnir/galaxyline.nvim",
		--"hoob3rt/lualine.nvim",
		--"vim-airline/vim-airline",
		--"itchyny/lightline.vim",
		--'tamton-aquib/staline.nvim',
	},

	--buffer
	{ "kevinhwang91/nvim-hlslens", "osyo-manga/vim-anzu" },
	--'rktjmp/highlight-current-n.nvim',
	{
		--"shellRaining/hlchunk.nvim", --TODO: CONFIGURE
		"lukas-reineke/indent-blankline.nvim",
	},
	"itchyny/vim-highlighturl",
	"kazhala/close-buffers.nvim",
	"pseewald/vim-anyfold",
	"anuvyklack/fold-preview.nvim",
	--'yaocccc/nvim-foldsign',
	--'arecarn/vim-fold-cycle',
	--'haya14busa/vim-over',
	--'ghillb/cybu.nvim',

	-- window
	--'tamton-aquib/flirt.nvim', TODO: setup =1+
	--"nvim-zh/colorful-winsep.nvim",
	"sindrets/winshift.nvim",
	"luukvbaal/stabilize.nvim",
	"szw/vim-maximizer",
	--'TaDaa/vimade',
	--'beauwilliams/focus.nvim',
	"wellle/visual-split.vim",
	--'declancm/windex.nvim',

	--winbar
	{
		"Bekaboo/dropbar.nvim", --1+
		"utilyre/barbecue.nvim", --1
		"fgheng/winbar.nvim",
		"mrjones2014/winbarbar.nvim",
		--'b0o/incline.nvim',
		--'SmiteshP/nvim-gps',
	},

	--tab
	--not-working
	--'boson-joe/vimwintab',
	--'noscript/taberian.vim',

	-- clients
	"glacambre/firenvim",

	--random
	"aca/vidir.nvim",
}
local default = {
	--dependencies
	"mattn/webapi-vim",

	--operators
	--'haya14busa/vim-easyoperator-line',
	--'haya14busa/vim-easyoperator-phrase',

	--system
	"junegunn/fzf", --1+
	"nvim-telescope/telescope.nvim", --1+
	"skywind3000/asyncrun.vim",
	{
		"voldikss/vim-floaterm",
		"akinsho/toggleterm.nvim",
	},
	{
		"nvim-neo-tree/neo-tree.nvim", --1+
		"kyazdani42/nvim-tree.lua", --1
		"ms-jpq/chadtree",
	},
	{
		"elihunter173/dirbuf.nvim", --1+
		"X3eRo0/dired.nvim",
		--'stevearc/oil.nvim', --INFO: reference
	},
	--"is0n/fm-nvim",

	--search
	--'easymotion/vim-easymotion',
	--'haya14busa/incsearch-easymotion.vim',
	{
		"windwp/nvim-spectre", --1+
		"brooth/far.vim",
	},
	--'ray-x/sad.nvim', TODO: 1
	--'AckslD/muren.nvim', --TODO:1+
	{
		"ripxorip/aerojump.nvim",
		--'lambdalisue/lista.nvim',
		"osyo-manga/vim-hopping",
	},

	--editor.general
	--{
	--  'kungfusheep/randomquote.nvim',
	--  'mhinz/vim-startify',
	--  'glepnir/dashboard-nvim',
	--  'goolord/alpha-nvim',
	--  'startup-nvim/startup.nvim',
	--},
	{ "jbyuki/venn.nvim", "gyim/vim-boxdraw" },
	-- "lfv89/vim-foldfocus", -- FIX:
	"rexagod/samwise.nvim",
	--TO-TEST
	--'hood/popui.nvim',

	--vim.ui
	"stevearc/dressing.nvim", --1+
	--'doums/suit.nvim',

	--buffer.general
	{
		--'petertriho/nvim-scrollbar', --TODO:
		"dstein64/nvim-scrollview", --1+
		"Xuyuanp/scrollbar.nvim",
	},
	{
		-- TODO: not working figure out
		"gen740/SmoothCursor.nvim",
		"karb94/neoscroll.nvim",
		"psliwka/vim-smoothie",
		"joeytwiddle/sexy_scroller.vim",
	},
	"el-iot/buffer-tree-explorer", --2+
	"j-morano/buffer_manager.nvim",
	--'Hajime-Suzuki/vuffers.nvim',--TODO: not working
	"xiyaowong/link-visitor.nvim",

	--window
	"camspiers/animate.vim",
	--'camspiers/lens.vim',
	--'blueyed/vim-diminactive',
	"s1n7ax/nvim-window-picker",

	--random
	"edluffy/hologram.nvim",
	--TODO: configure|setup
	"potamides/pantran.nvim",
}
local ide = {
	--editor.general
	--'wfxr/minimap.vim',
	"Jxstxs/conceal.nvim", --1+
	--'ldelossa/nvim-ide',
	{
		--'haringsrob/nvim_context_vt',
		--'wellle/context.vim',
		"nvim-treesitter/nvim-treesitter-context",
	},

	--buffer.aesthetics
	"folke/todo-comments.nvim", --1+
	{
		"folke/zen-mode.nvim", --2+
		"junegunn/goyo.vim",
	},
	{
		"folke/twilight.nvim", --2+
		"koenverburg/peepsight.nvim",
		"junegunn/limelight.vim",
	},
	--'axlebedev/footprints',
	{
		"zbirenbaum/neodim",
		"NarutoXY/dim.lua",
	},

	--programming.completion
	{
		"L3MON4D3/LuaSnip", --1+
		"hrsh7th/vim-vsnip",
		"SirVer/ultisnips",
		"norcalli/snippets.nvim",
	},
	{
		--'noib3/nvim-compleet',
		"hrsh7th/nvim-cmp", --1
		"hrsh7th/nvim-compe",
		"ms-jpq/coq_nvim",
	},
	"ziontee113/icon-picker.nvim",
	"piersolenski/telescope-import.nvim", --1

	--programming.documentation
	{
		"kkoomen/vim-doge",
		"danymat/neogen",
		"glepnir/prodoc.nvim",
	},
	--'Zeioth/dooku.nvim',

	--programming.help
	"luckasRanarison/nvim-devdocs", --1+
	--'bennypowers/nvim-regexplainer',

	--programming.ai
	"github/copilot.vim",
	--FIX:
	--"piersolenski/wtf.nvim",
	--FIX:
	--"james1236/backseat.nvim",
	--FIX:
	--"vibovenkat123/rgpt.nvim",
	--"Exafunction/codeium.vim",
	--"dpayne/CodeGPT.nvim",
	--to setup/fix
	--'aduros/ai.vim',
	--'jameshiew/nvim-magic',
	--'ashzero2/VimPilot',
	--'tom-doerr/vim_codex',
	--'github/copilot.vim',
	--'zbirenbaum/copilot.lua',
	--'jackMort/ChatGPT.nvim',
	--'dense-analysis/neural',

	--programming.libs
	--'VonHeikemen/lsp-zero.nvim',
	"williamboman/mason.nvim", --1+
	"neovim/nvim-lspconfig", --1+
	-- archived ??
	--"jose-elias-alvarez/null-ls.nvim",
	{ "mhartington/formatter.nvim", "sbdchd/neoformat" },
	"klen/nvim-test",
	"rcarriga/neotest", -- FIX:
	"mfussenegger/nvim-dap", --1

	--programming.lsp
	"SmiteshP/nvim-navbuddy",
	"folke/lsp-colors.nvim",
	"DNLHC/glance.nvim", --1+
	"rmagatti/goto-preview", --1+
	"folke/trouble.nvim", --1+
	{
		--'vigoux/notifier.nvim',
		"j-hui/fidget.nvim", --1+
	},
	"kosayoda/nvim-lightbulb",
	"ldelossa/litee.nvim",
	--"jose-elias-alvarez/typescript.nvim",
	{
		"nvimdev/lspsaga.nvim", --1+
		"jinzhongjia/LspUI.nvim",
	},
	-- TODO:setup
	--'nanotee/nvim-lsp-basics',
	-- TODO:wait for patch/fix
	"RishabhRD/nvim-lsputils",
	--'smjonas/inc-rename.nvim',
	{
		--TODO: not working
		--"JASONews/glow-hover",
		--TODO: not working
		--"Fildo7525/pretty_hover",
	},
	"VidocqH/lsp-lens.nvim",
	"jubnzv/virtual-types.nvim",
	--"weilbith/nvim-code-action-menu",
	--"ray-x/lsp_signature.nvim",
	--"WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
	"ivanjermakov/troublesum.nvim", --1
	"roobert/hoversplit.nvim",
	"chrisgrieser/nvim-rulebook", --1
	"whynothugo/lsp_lines.nvim", --1
	"onsails/lspkind-nvim", --1+
	"antosha417/nvim-lsp-file-operations",
	--'amrbashir/nvim-docs-view',
	--TODO: broken...wait
	--"wiliamks/nice-reference.nvim",

	"cseickel/diagnostic-window.nvim", --2+
	-- FIX: not working
	--'davidosomething/format-ts-errors.nvim',
	--FIX:broken
	--"joechrisellis/lsp-format-modifications.nvim",

	--not-working
	--'lewis6991/spellsitter.nvim',
	--setup
	--'weilbith/nvim-floating-tag-preview',
	--'nvim-lua/lsp-status.nvim',
	--'doums/lsp_spinner.nvim',
	--not-working
	--'onsails/vimway-lsp-diag.nvim',
	--'Mofiqul/trld.nvim',

	--progrmaming.general
	--"ludovicchabant/vim-gutentags",
	{ "liuchengxu/vista.vim", "majutsushi/tagbar" },

	--programming.syntax
	"Galicarnax/vim-regex-syntax",
	"luochen1990/rainbow",
	"vim-syntastic/syntastic",
	"coachshea/jade-vim",
	"sheerun/vim-polyglot",
	"jparise/vim-graphql",
	"chrisbra/csv.vim",
	"norcalli/nvim-colorizer.lua",
	{
		"MeanderingProgrammer/render-markdown.nvim",
		"prurigro/vim-markdown-concealed",
		"plasticboy/vim-markdown",
	},

	--programming.execution
	"metakirby5/codi.vim",
	"arkwright/vim-whiteboard",
	{
		"iamcco/markdown-preview.nvim",
		"suan/vim-instant-markdown",
		"davidgranstrom/nvim-markdown-preview",
	},

	--programming.vcs
	{
		"lewis6991/gitsigns.nvim", --1+
		"airblade/vim-gitgutter",
	},
	"tanvirtin/vgit.nvim", --1+
	{
		"TimUntersberger/neogit", --1+
		"tpope/vim-fugitive",
	},
	{
		"pwntester/octo.nvim", --1+
		"ldelossa/gh.nvim", --1+
		"skanehira/denops-gh.vim",
		"skanehira/gh.vim",
	},
	--"harrisoncramer/gitlab.nvim", --1+
	--'ttys3/nvim-blamer.lua',
	"sindrets/diffview.nvim", --1+
	--'isak102/telescope-git-file-history.nvim', -- TODO: try
	{
		"rhysd/conflict-marker.vim", --1+
		"akinsho/git-conflict.nvim",
	},
	"rhysd/git-messenger.vim", --1+
	{
		--"9seconds/repolink.nvim",
		"ruifm/gitlinker.nvim", --1+
	},
	{
		--"moyiz/git-dev.nvim",
		"drzel/vim-repo-edit", --1+
	},

	--programming.testing

	--programming.project
	{
		"rgroli/other.nvim",
		"otavioschwanck/telescope-alternate.nvim",
	},
	--'KDesp73/project-starter.nvim', -- TODO: try

	--programming.debugging
	{
		"andrewferrier/debugprint.nvim", --1+
		"rareitems/printer.nvim",
	},
	--'kungfusheep/randomword.nvim', -- TODO: try

	--programming.databases
	"tpope/vim-dadbod",

	--frontend
	"mattn/emmet-vim",
	"MaximilianLloyd/tw-values.nvim",

	--lua
	"rafcamlet/nvim-luapad",

	--python
	--'AckslD/swenv.nvim',

	--javascript
	--'vuki656/package-info.nvim',
	"tomarrell/vim-npr", --1
	--"prettier/vim-prettier",
	"axelvc/template-string.nvim",
	--"pantharshit00/vim-prisma",

	--react
	"napmn/react-extract.nvim",
	"Azeirah/nvim-redux",

	--typescript
	"dmmulroy/tsc.nvim",
	"dmmulroy/ts-error-translator.nvim",

	--kmonad
	"kmonad/kmonad-vim",

	--programming.random
	--'alpertuna/vim-header',
	--'shanzi/autoHEADER',

	-- programming.api
	--"NTBBloodbath/rest.nvim", --1

	--TEMP
	{
		--TODO
		--'linty-org/key-menu.nvim',
		--'Cassin01/wf.nvim',
		"folke/which-key.nvim",
		"liuchengxu/vim-which-key",
	},
	"powerman/vim-plugin-AnsiEsc",
}
local configuration = {
	--random
	--https://fsymbols.com/generators/carty/
	--https://manytools.org/hacker-tools/ascii-banner/
	--'fadein/vim-FIGlet',
	"tpope/vim-scriptease",
	{
		--'AckslD/messages.nvim',
		"AndrewRadev/bufferize.vim", --1
	},
	--'tyru/capture.vim',
	--{ 'dstein64/vim-startuptime', 'henriquehbr/nvim-startup.lua' },

	--plugin development
	--"smartpde/debuglog",

	--'dokwork/vim-hp',

	--api
	"tweekmonster/nvim-api-viewer",
	--"Tyler-Barham/floating-help.nvim",
	{
		"folke/neodev.nvim",
		"folke/lua-dev.nvim",
	},

	-- TODO:
	"ziontee113/query-secretary",

	--colors
	--"tjdevries/colorbuddy.nvim",
	--"vim-scripts/ScrollColors",
	--"zefei/vim-colortuner",
	--"rktjmp/lush.nvim",
	--"guns/xterm-color-table.vim",
}
local markup = {
	--'kristijanhusak/orgmode.nvim',
	--'nvim-orgmode/orgmode',
	--'akinsho/org-bullets.nvim',
	--"nvim-neorg/neorg", -- plug not supported bcz of luarocks
	--"letieu/jot.lua", -- TODO:try
	--"2KAbhishek/tdo.nvim", -- TODO:try
	"phaazon/mind.nvim", --1+
	"antonk52/markdowny.nvim",
	"Zeioth/markmap.nvim",
	--'AckslD/nvim-FeMaco.lua',
	"osyo-manga/vim-operator-highlighter",
	{
		"mtth/scratch.vim", --1
		"kana/vim-scratch",
	},
}
local featured = {
	--system
	--'edkolev/tmuxline.vim',
	--'edkolev/promptline.vim',
	--'vim-scripts/WholeLineColor',

	--vanity
	--'tamton-aquib/zone.nvim',
	--'blumaa/ohne-accidents.nvim', --TODO: try
	--'mcauley-penney/visual-whitespace.nvim', --TODO: try

	--operations
	"tpope/vim-speeddating",

	--authoring
	"antoyo/vim-licenses",
	"reedes/vim-pencil",
	"panozzaj/vim-autocorrect",
	"vim-scripts/autoscroll.vim",
	"natw/keyboard_cat.vim",
	--not-working = clone and fix highlight
	--'dbmrq/vim-redacted',

	--random
	--'MrPeterLee/VimWordpress',
	"itchyny/calendar.vim",
	"samodostal/image.nvim",
}
local testing = {
	--'gsuuon/note.nvim', --TODO: 1
	"Wansmer/symbol-usage.nvim",
	--'hrsh7th/nvim-pasta', --TODO:1
	--'KaitlynEthylia/TreePin', --TODO: 1
	--'roobert/activate.nvim', --TODO: 1
	--'OscarCreator/rsync.nvim', --TODO:1
	--'chrisgrieser/nvim-alt-substitute', TODO:1
	--'axkirillov/hbac.nvim', TODO:1+
	--'topaxi/gh-actions.nvim', TODO:1
	--'Bekaboo/deadcolumn.nvim', TODO:1
	--'roobert/action-hints.nvim', TODO:1
	--'sQVe/bufignore.nvim', --TODO:1
	--'niuiic/code-shot.nvim',
	--'roobert/hoversplit.nvim', --TODO:1+
	--'linrongbin16/fzfx.nvim', --TODO:1+
	--'00sapo/visual.nvim',
	--'tomiis4/BufferTabs.nvim',
	--'dgagn/diagflow.nvim',
	--'malbertzard/inline-fold.nvim', --TODO:1+
	--'Robitx/gp.nvim',
	--'chrisgrieser/nvim-dr-lsp', --TODO:1+
	--'ashfinal/qfview.nvim',
	--'MarcHamamji/runner.nvim',
	--'ecthelionvi/NeoComposer.nvim', -- TODO:1+
	--'otavioschwanck/tmux-awesome-manager.nvim',
	--'mrjones2014/smart-splits.nvim',
	--'epwalsh/obsidian.nvim',
	--'ofirgall/open.nvim'
	--'cbochs/portal.nvim',
	--'romgrk/kui.nvim',
	--'gennaro-tedesco/nvim-possession,
	--'niuiic/divider.nvim',
	--'niuiic/part-edit.nvim',
	--'niuiic/translate.nvim',
	--'lpoto/actions.nvim',
	--'roobert/search-replace.nvim',
	--'anuvyklack/animation.nvim',
	--'XXiaoA/ns-textobject.nvim',
	--'idanarye/nvim-moonicipal', --TODO: try +1
	--'idanarye/nvim-buffls',
	--'desdic/greyjoy.nvim',--INFO: task
	--'emileferreira/nvim-strict',
	-- TODO: setup
	--'marcuscaisey/olddirs.nvim',
	--'princejoogie/chafa.nvim',
	--'cvigilv/esqueleto.nvim',
	--'nyngwang/suave.lua',
	--'danielvolchek/tailiscope.nvim',
	--'hudclark/grpc-nvim',
	--'ellisonleao/dotenv.nvim',
	--'tamton-aquib/stuff.nvim',
	--'sunjon/stylish.nvim',
	--'rareitems/hl_match_area.nvim',
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
	--'nat-418/scamp.nvim',
	--'LintaoAmons/scratch.nvim',
	--'mrded/nvim-zond',
	--'dimfred/resize-mode.nvim',
	--'nat-418/boole.nvim',
	--'phelipetls/jsonpath.nvim',
	--'melkster/modicator.nvim',
	--'gorbit99/codewindow.nvim',
	--'nat-418/termitary.nvim',
	--'haolian9/reveal.nvim',
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
	--'olimorris/persisted.nvim', --TODO: 1
	'rmagatti/auto-session',

	--'numToStr/prettierrc.nvim',
	--'Djancyp/better-comments.nvim',
	--'Djancyp/regex.nvim',
	--'Vonr/align.nvim',
	--'gaoDean/autolist.nvim',
	--'echasnovski/mini.nvim',
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
	--'ggandor/leap-spooky.nvim',
	--'glts/vim-radical',
	--'s1n7ax/nvim-lazy-inner-block',

	--'tpope/vim-characterize',

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
	--	'vim-scripts/multiwindow-source-code-browsing',
	--	'vim-scripts/gtags-multiwindow-browsing',
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
	--	'vim-scripts/bufexplorer.zip',
	--	'vim-scripts/bufferlist.vim',
	--	'vim-scripts/SelectBuf',
	--	'vim-scripts/easybuffer.vim',
	--	'vim-scripts/QuickBuf',
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
	--'glepnir/template.nvim',
	--'GustavoKatel/tasks.nvim',
	--'Pocco81/AutoSave.nvim',
	--'wincent/loupe',
	--'jessekelighine/vindent.vim',
	--'Issafalcon/lsp-overloads.nvim',
	--'tzachar/fuzzy.nvim',
	--'gennaro-tedesco/nvim-peekup',
	--'LionC/nest.nvim',
	--'strash/no-one-wants-to-restart.nvim',
	--'itmecho/neoterm.nvim',
	--'kevinhwang91/nvim-ufo',
	--'anuvyklack/pretty-fold.nvim',
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
	--'gabrielpoca/replacer.nvim', --TODO: 1
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
	--'b0o/SchemaStore.nvim',
	--'vimpostor/vim-tpipeline',
	--'stevearc/stickybuf.nvim',
	--'rmagatti/session-lens',
	--'Pocco81/HighStr.nvim',
	--'boson-joe/YANP',
	--'rliang/macrosearch.vim',
	--'kvngvikram/rightclick-macros',
	--'dbatten5/vim-macroscope',
	--'chamindra/marvim',
	--'RRethy/nvim-carom',
	--'fflorent/macrobug.nvim',
	--'code-biscuits/nvim-biscuits',
	--'gaborvecsei/cryptoprice.nvim',
	--'booperlv/nvim-gomove',
	--'ruanyl/vim-gh-line',
	--'KadoBOT/nvim-spotify',
	--'nvim-plugnplay/plugnplay.nvim',
	--'chrsm/impulse.nvim',
	--'jedrzejboczar/toggletasks.nvim',
	--'xeluxee/competitest.nvim',
	--'Dhanus3133/Leetbuddy.nvim',
	--'askfiy/nvim-picgo',
	--'onsails/diaglist.nvim',
	--'someone-stole-my-name/yaml-companion.nvim',
	--'frabjous/knap',
	--'m-demare/attempt.nvim',
	--'tkmpypy/chowcho.nvim',
	--'rlch/github-notifications.nvim',
	--'hrsh7th/vim-searchx',
	--'LhKipp/nvim-locationist',
	--'natecraddock/workspaces.nvim',
	--'ahmedkhalf/project.nvim',
	--'t9md/vim-quickhl',
	--'mizlan/iswap.nvim',
	----WIP
	--'miversen33/netman.nvim',
	--'jbyuki/instant.nvim',
	--'mvllow/modes.nvim',
	--'winston0410/cmd-parser.nvim',
	--'ginsburgnm/rich.nvim',
	--'arnarg/todo-prompt.nvim',
	--'NFrid/due.nvim',
	--'azabiong/vim-highlighter',
	--'luk400/vim-jukit',
	--'mfussenegger/nvim-lint',
	--'michaelb/sniprun',
	--'mbpowers/nvimager',
	--'sebcode/nvim-buftitle',
	--'azabiong/vim-board',
	--'Chaitanyabsprip/present.nvim',
	--'gpanders/nvim-moonwalk',
	--'PyGamer0/font_changer.vim',
	--'PyGamer0/colorscheme_changer.vim',
	--'dsych/blanket.nvim',
	--'yogeshdhamija/terminal-command-motion.vim',
	--'smjonas/snippet-converter.nvim',
	--{'ethanholz/nvim-lastplace', 'farmergreg/vim-lastplace'},
	--'tjdevries/stackmap.nvim',
	--'FeiyouG/command_center.nvim',
	--'gbprod/yanky.nvim',
	--'declancm/cinnamon.nvim',
	--'stevearc/gkeep.nvim',
	--'is0n/jaq-nvim',
	--'axieax/urlview.nvim',
	--'mrjones2014/legendary.nvim',
	--'toppair/reach.nvim',
	--'tjdevries/vlog.nvim',
	--'jghauser/fold-cycle.nvim',
	--'AckslD/nvim-gfold.lua',
	--'ellisonleao/carbon-now.nvim',
	--'ThePrimeagen/refactoring.nvim',
	--'ThePrimeagen/jvim.nvim',
	--'ThePrimeagen/vim-apm',
	--'ThePrimeagen/harpoon',
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
	--'jenterkin/vim-autosource',
	--'ray-x/navigator.lua',
	--'Pocco81/TrueZen.nvim',
	--'Pocco81/NoCLC.nvim',
	--'Pocco81/whid.nvim',
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
	--'nagy135/capture-nvim',
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
local vscode = {
	-- incomplete trying out stuff
	"lewis6991/impatient.nvim",
	"tpope/vim-capslock", --1+
	{ "kana/vim-repeat", "tpope/vim-repeat" }, --1+
	"kana/vim-niceblock",
	"smjonas/live-command.nvim",
	"thalesmello/nvim-better-operator-message",
	"kana/vim-operator-user",
	"kana/vim-textobj-user",
	"osyo-manga/vim-textobj-blockwise",
	"osyo-manga/vim-operator-blockwise",
	"wellle/targets.vim",
	--"jonatan-branting/nvim-better-n", --1+
	"haya14busa/vim-operator-flashy",
	{
		"kylechui/nvim-surround", --1+
		"tpope/vim-surround",
	},
	"svermeulen/vim-subversive", --1+
	"tommcdo/vim-exchange", --1+
	"junegunn/vim-easy-align", --1+
	"JRasmusBm/vim-peculiar", --1+
	{
		"kana/vim-operator-replace", --1+
		"romgrk/replace.vim",
	},
	"kana/vim-grex", --2+
	{
		--'johmsalas/text-case.nvim',
		"arthurxavierx/vim-caser",
	},
	"gustavo-hms/vim-duplicate", --2+
	"rjayatilleka/vim-operator-goto",
	{
		"tommcdo/vim-ninja-feet", --1+
		"bagohart/vim-operator-insert-append",
	},
	"osyo-manga/vim-operator-search",
	"vim-scripts/operator-star",
	"terryma/vim-multiple-cursors",
	"coderifous/textobj-word-column.vim", --1
	"rhysd/vim-textobj-anyblock", --1
	"thinca/vim-textobj-between", --1
	"michaeljsmith/vim-indent-object", --1,
	{
		"saaguero/vim-textobj-pastedtext", --1
		--'gilligan/textobj-lastpaste',
	},
	"rhysd/vim-textobj-lastinserted",
	"Raimondi/vim_search_objects",
	"Julian/vim-textobj-variable-segment", --1
	"machakann/vim-textobj-delimited", --1
	{
		"syngan/vim-textobj-postexpr",
		"machakann/vim-textobj-functioncall",
		"anyakichi/vim-textobj-xbrackets",
	},
	"thalesmello/vim-textobj-methodcall",
	{
		"machakann/vim-swap", --1+
		"sgur/vim-textobj-parameter",
	},
	"glts/vim-textobj-comment", --1
	"justinj/vim-textobj-reactprop",
}

return {
	setup = function() end,
	hooks = {
		--TODO
		vimEnter = function() end,
		vimExit = function() end,
	},
	plugins = {
		["author/name"] = {
			url = "",
			branch = "",
			tag = "",
			commit = "",
			alias = "",
			rtp = "",
			directory = "",
			dependencies = {
				pre = {},
				post = {},
			},
			is_enabled = function() end,
			is_locked = function() end,
			config = "",
			should_load_config = true,
			post_install = "",
			lazyload = {
				events = {},
				cmds = {},
				filetypes = {},
			},
			hooks = {
				before_plugin_install = function() end,
				after_plugin_install = function() end,
				before_plugin_load = function() end,
				after_plugin_load = function() end,
				before_config_load = function() end,
				after_config_load = function() end,
			},
		},

		--libraries
		["Pocco81/AbbrevMan.nvim"] = {
			url = "Pocco81/AbbrevMan.nvim",
			is_enabled = function()
				return vim.fn.has("nvim") == 1
			end,
		},
		["0styx0/abbreinder.nvim"] = {
			url = "0styx0/abbreinder.nvim",
			is_enabled = function()
				return vim.fn.has("nvim") == 1
			end,
			dependencies = {
				pre = { "0styx0/abbremand.nvim" },
			},
		},
		["MunifTanjim/nui.nvim"] = {
			url = "MunifTanjim/nui.nvim",
			should_load_config = false,
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["kana/vim-arpeggio"] = {
			url = "kana/vim-arpeggio",
			is_enabled = function()
				return true
			end,
			should_load_config = false,
			hooks = {
				after_config_load = function()
					vim.cmd([[ nnoremap <LocalLeader>zc :runtime configs/vim-arpeggio.vim<CR> ]])
				end,
			},
		},
		["smjonas/live-command.nvim"] = {
			url = "smjonas/live-command.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.8") == 1
			end,
		},
		["echasnovski/mini.bracketed"] = {
			url = "echasnovski/mini.bracketed",
			is_enabled = function()
				return vim.fn.has("nvim-0.8") == 1
			end,
			config = function()
				require("mini.bracketed").setup()
			end,
		},

		--EDITING
		["anuvyklack/hydra.nvim"] = {
			url = "anuvyklack/hydra.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				pre = { "anuvyklack/keymap-layer.nvim" },
			},
		},
		--editing/operators
		["kylechui/nvim-surround"] = {
			url = "kylechui/nvim-surround",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["osyo-manga/vim-operator-blockwise"] = {
			url = "osyo-manga/vim-operator-blockwise",
			is_enabled = function()
				return true
			end,
			dependencies = {
				pre = { "osyo-manga/vim-textobj-blockwise" },
			},
		},
		["syngan/vim-operator-furround"] = {
			url = "syngan/vim-operator-furround",
			is_enabled = function()
				return true
			end,
			dependencies = {
				pre = { "kana/vim-operator-user" },
			},
		},
		--editing/motions
		["jonatan-branting/nvim-better-n"] = {
			url = "jonatan-branting/nvim-better-n",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		--editing/objects
		--editing/search
		--editing/jump
		["kwkarlwang/bufjump.nvim"] = {
			url = "kwkarlwang/bufjump.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			config = function()
				require("bufjump").setup({
					backward = "<C-S-o>",
					forward = "<C-S-i>",
				})
			end,
		},
		["chentau/marks.nvim"] = {
			url = "chentau/marks.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		--editing/random
		["Rasukarusan/nvim-select-multi-line"] = {
			url = "Rasukarusan/nvim-select-multi-line",
			is_enabled = function()
				return vim.fn.has("nvim-0.4") == 1
			end,
		},
		["jbyuki/nabla.nvim"] = {
			url = "jbyuki/nabla.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			config = function()
				vim.cmd([[
					nnoremap <Leader>em :lua require("nabla").action()<CR>
				]])
			end,
		},
		["Iron-E/nvim-libmodal"] = {
			url = "Iron-E/nvim-libmodal",
			branch = "master",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["windwp/nvim-autopairs"] = {
			url = "windwp/nvim-autopairs",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["AllenDang/nvim-expand-expr"] = {
			url = "AllenDang/nvim-expand-expr",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},

		--EDITOR
		--editor/feature
		["nanotee/zoxide.vim"] = {
			url = "nanotee/zoxide.vim",
			is_enabled = function()
				return is_installed({ "zoxide" })
			end,
		},
		["windwp/nvim-spectre"] = {
			url = "windwp/nvim-spectre",
			is_enabled = function()
				return (vim.fn.has("nvim-0.5") == 1 and is_installed({ "rg", "sed" }))
			end,
			dependencies = {
				pre = {
					"nvim-lua/plenary.nvim",
					"nvim-lua/popup.nvim",
					"kyazdani42/nvim-web-devicons",
					"ryanoasis/vim-devicons",
				},
			},
		},
		["rexagod/samwise.nvim"] = {
			url = "rexagod/samwise.nvim",
			is_enabled = function()
				return vim.fn.has("nvim") == 1
			end,
		},
		["glepnir/dashboard-nvim"] = {
			url = "glepnir/dashboard-nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["goolord/alpha-nvim"] = {
			url = "goolord/alpha-nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["gelguy/wilder.nvim"] = {
			url = "gelguy/wilder.nvim",
			is_enabled = function()
				return ((vim.fn.has("nvim-0.3") == 1 or vim.v.version >= 810) and vim.fn.has("python3") == 1)
			end,
			post_install = ":UpdateRemotePlugins",
			dependencies = {
				pre = {
					"roxma/nvim-yarp",
					"roxma/vim-hug-neovim-rpc",
					"nixprime/cpsm",
				},
			},
		},
		["dstein64/vim-startuptime"] = {
			url = "dstein64/vim-startuptime",
			is_enabled = function()
				return vim.fn.has("nvim-0.3.1") == 1 or vim.v.version >= 810
			end,
		},
		["henriquehbr/nvim-startup.lua"] = {
			url = "https://git.sr.ht/~henriquehbr/nvim-startup.lua",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["osyo-manga/vim-over"] = {
			url = "osyo-manga/vim-over",
			is_enabled = function()
				return vim.fn.has("nvim") ~= 1
			end,
		},
		["xiyaowong/nvim-transparent"] = {
			url = "xiyaowong/nvim-transparent",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},

		--editor/colorschemes
		["EdenEast/nightfox.nvim"] = {
			url = "EdenEast/nightfox.nvim",
			config = function()
				vim.cmd("colorscheme nightfox")
			end,
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			hooks = {
				after_plugin_load = function()
					-- focus.nvim
					-- #1d2836 #1f2a38
					vim.cmd("hi UnfocusedWindow guibg=#1f2a38")
				end,
			},
		},
		["martinsione/darkplus.nvim"] = {
			url = "martinsione/darkplus.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["Domeee/mosel.nvim"] = {
			url = "Domeee/mosel.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1 and vim.fn.has("termguicolors") == 1
			end,
		},
		["olimorris/onedarkpro.nvim"] = {
			url = "olimorris/onedarkpro.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["NvChad/nvim-base16.lua"] = {
			url = "NvChad/nvim-base16.lua",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			config = function()
				local base16 = require("base16")

				local theme = base16.themes("javacafe")
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
					"norcalli/nvim.lua",
					--'norcalli/nvim-base16.lua',
				},
			},
		},
		["RRethy/nvim-base16"] = {
			url = "RRethy/nvim-base16",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["FrenzyExists/aquarium-vim"] = {
			url = "FrenzyExists/aquarium-vim",
			branch = "vimscript_version",
		},
		["joshdick/onedark.vim"] = {
			url = "joshdick/onedark.vim",
			config = function()
				vim.cmd("colorscheme onedark")
			end,
		},
		["sonph/onehalf"] = {
			url = "sonph/onehalf",
			rtp = "vim/",
		},
		["kvrohit/substrata.nvim"] = {
			url = "kvrohit/substrata.nvim",
			is_enabled = function()
				return vim.fn.has("nvim") == 1
			end,
			config = function()
				vim.cmd("colorscheme substrata")
			end,
		},
		["arzg/vim-substrata"] = {
			url = "arzg/vim-substrata",
			config = function()
				vim.cmd("colorscheme substrata")
			end,
		},
		["wuelnerdotexe/vim-enfocado"] = {
			url = "wuelnerdotexe/vim-enfocado",
			config = function()
				vim.cmd("set termguicolors")
				vim.cmd("colorscheme enfocado")
				--vim.cmd('autocmd VimEnter * ++nested colorscheme enfocado')
			end,
		},
		["projekt0n/github-nvim-theme"] = {
			url = "projekt0n/github-nvim-theme",
			config = function()
				--vim.cmd('colorscheme github_dimmed')
				--vim.cmd('colorscheme github_dark')
				--vim.cmd('colorscheme github_light')
				vim.cmd("colorscheme github_dark_high_contrast")
				--vim.cmd('colorscheme github_light_default')
			end,
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["challenger-deep-theme/vim"] = {
			url = "challenger-deep-theme/vim",
			config = function()
				vim.cmd([[ colorscheme challenger_deep ]])
			end,
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			alias = "challenger-deep",
		},
		["Mofiqul/vscode.nvim"] = {
			url = "Mofiqul/vscode.nvim",
			config = function()
				vim.cmd([[
					let g:vscode_style = "dark"
					colorscheme vscode
				]])
			end,
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["folke/tokyonight.nvim"] = {
			url = "folke/tokyonight.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["tiagovla/tokyodark.nvim"] = {
			url = "tiagovla/tokyodark.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["catppuccin/nvim"] = {
			url = "catppuccin/nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			config = function()
				require("configs.catppuccin")
			end,
		},
		["Mangeshrex/uwu.vim"] = {
			url = "Mangeshrex/uwu.vim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["yashguptaz/calvera-dark.nvim"] = {
			url = "yashguptaz/calvera-dark.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.4") == 1
			end,
			config = function()
				vim.cmd([[ colorscheme calvera ]])
			end,
		},
		["Shadorain/shadotheme"] = {
			url = "Shadorain/shadotheme",
			config = function()
				vim.cmd([[ colorscheme xshado ]])
			end,
		},
		["christianchiarulli/nvcode-color-schemes.vim"] = {
			url = "christianchiarulli/nvcode-color-schemes.vim",
			config = function()
				vim.cmd([[ colorscheme aurora ]])
			end,
		},
		["marko-cerovac/material.nvim"] = {
			url = "marko-cerovac/material.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			config = function()
				vim.g.material_style = "deep ocean"
				vim.cmd([[ colorscheme material ]])
			end,
		},
		["eddyekofo94/gruvbox-flat.nvim"] = {
			url = "eddyekofo94/gruvbox-flat.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["rockerBOO/boo-colorscheme-nvim"] = {
			url = "rockerBOO/boo-colorscheme-nvim",
			config = function()
				vim.cmd([[
					if (has("termguicolors")) == 1
						set termguicolors
					endif
					colorscheme boo
				]])
			end,
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["sindresorhus/focus"] = {
			url = "sindresorhus/focus",
			config = function()
				vim.cmd("colorscheme focus")
			end,
			rtp = "vim",
		},

		--editor/ui
		["liuchengxu/vim-which-key"] = {
			url = "liuchengxu/vim-which-key",
		},
		["folke/which-key.nvim"] = {
			url = "folke/which-key.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.9.4") == 1
			end,
			dependencies = {
				pre = {
					"echasnovski/mini.icons",
					"kyazdani42/nvim-web-devicons",
				},
			},
		},
		["wfxr/minimap.vim"] = {
			url = "wfxr/minimap.vim",
			post_install = ":!cargo install --locked code-minimap",
			is_enabled = function()
				return vim.fn.exists("neovide") == 0 and vim.fn.exists("goneovim") == 0
			end,
		},
		["tyru/open-browser.vim"] = {
			url = "tyru/open-browser.vim",
			dependencies = {
				post = {
					"tyru/open-browser-github.vim",
					--'tyru/open-browser-unicode.vim',
				},
			},
		},
		["j-morano/buffer_manager.nvim"] = {
			url = "j-morano/buffer_manager.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				pre = { "nvim-lua/plenary.nvim" },
			},
		},
		["xiyaowong/link-visitor.nvim"] = {
			url = "xiyaowong/link-visitor.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["glepnir/galaxyline.nvim"] = {
			url = "glepnir/galaxyline.nvim",
			branch = "main",
			-- should_load_config = true,
			dependencies = {
				-- post = { 'Avimitin/nerd-galaxyline' },
			},
		},
		["feline-nvim/feline.nvim"] = {
			url = "feline-nvim/feline.nvim",
			dependencies = {
				pre = {
					"kyazdani42/nvim-web-devicons",
				},
				post = {},
			},
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["rcarriga/nvim-notify"] = {
			url = "rcarriga/nvim-notify",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["kdheepak/tabline.nvim"] = {
			url = "kdheepak/tabline.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				post = {
					"hoob3rt/lualine.nvim",
					"kyazdani42/nvim-web-devicons",
				},
			},
		},
		["romgrk/barbar.nvim"] = {
			url = "romgrk/barbar.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				pre = { "kyazdani42/nvim-web-devicons", "ryanoasis/vim-devicons" },
			},
		},
		["akinsho/bufferline.nvim"] = {
			url = "akinsho/bufferline.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.7") == 1
			end,
			dependencies = {
				pre = { "kyazdani42/nvim-web-devicons", "ryanoasis/vim-devicons" },
				post = {
					"roobert/bufferline-cycle-windowless.nvim",
				},
			},
		},
		["akinsho/nvim-bufferline.lua"] = {
			url = "akinsho/nvim-bufferline.lua",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["nanozuki/tabby.nvim"] = {
			url = "nanozuki/tabby.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				pre = { "kyazdani42/nvim-web-devicons", "ryanoasis/vim-devicons" },
				post = { "tiagovla/scope.nvim" },
			},
		},
		["hoob3rt/lualine.nvim"] = {
			url = "hoob3rt/lualine.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["vim-airline/vim-airline"] = {
			url = "vim-airline/vim-airline",
			dependencies = {
				post = {
					"vim-airline/vim-airline-themes",
					"augustold/vim-airline-colornum",
					"paranoida/vim-airlineish",
				},
			},
		},
		["itchyny/lightline.vim"] = {
			url = "itchyny/lightline.vim",
			dependencies = {
				post = {
					"mengelbrecht/lightline-bufferline",
				},
			},
		},
		["mengelbrecht/lightline-bufferline"] = {
			url = "mengelbrecht/lightline-bufferline",
			dependencies = {
				pre = {
					"mengelbrecht/lightline",
				},
			},
		},
		["SmiteshP/nvim-gps"] = {
			url = "SmiteshP/nvim-gps",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				pre = { "nvim-treesitter/nvim-treesitter" },
			},
		},
		["lukas-reineke/headlines.nvim"] = {
			url = "lukas-reineke/headlines.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["edluffy/specs.nvim"] = {
			url = "edluffy/specs.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["hood/popui.nvim"] = {
			url = "hood/popui.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				pre = { "RishabhRD/popfix" },
			},
		},

		--editor/graphics
		["edluffy/hologram.nvim"] = {
			url = "edluffy/hologram.nvim",
			is_enabled = function()
				return (
					vim.fn.has("nvim-0.5") == 1
					or vim.fn.has("macunix") == 1
					or vim.fn.has("unix") == 1
					or vim.fn.has("linux") == 1
				)
			end,
		},
		--BUFFER
		--buffer/general
		["kazhala/close-buffers.nvim"] = {
			url = "kazhala/close-buffers.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["petertriho/nvim-scrollbar"] = {
			url = "petertriho/nvim-scrollbar",
			is_enabled = function()
				return vim.fn.has("nvim-0.5.1") == 1
			end,
			dependencies = {
				pre = { "kevinhwang91/nvim-hlslens" },
			},
		},
		["karb94/neoscroll.nvim"] = {
			url = "karb94/neoscroll.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1 and vim.fn.exists("neovide") == 0 and vim.fn.exists("goneovim") == 0
			end,
		},
		["psliwka/vim-smoothie"] = {
			url = "psliwka/vim-smoothie",
			is_enabled = function()
				return (
					(vim.fn.has("nvim-0.3") == 1 or vim.v.version >= 800)
					and vim.fn.exists("neovide") == 0
					and vim.fn.exists("goneovim") == 0
				)
			end,
		},
		["joeytwiddle/sexy_scroller.vim"] = {
			url = "joeytwiddle/sexy_scroller.vim",
			is_enabled = function()
				return vim.fn.exists("neovide") == 0 and vim.fn.exists("goneovim") == 0
			end,
		},

		--buffer/editing
		["terryma/vim-multiple-cursors"] = {
			url = "terryma/vim-multiple-cursors",
		},
		["jbyuki/venn.nvim"] = {
			url = "jbyuki/venn.nvim",
			is_enabled = function()
				return vim.fn.has("nvim") == 1
			end,
		},

		--buffer/ui
		["lukas-reineke/indent-blankline.nvim"] = {
			url = "lukas-reineke/indent-blankline.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1 and vim.fn.exists("neovide") == 0 and vim.fn.has("goneovim") == 0
			end,
		},
		["mvllow/modes.nvim"] = {
			url = "mvllow/modes.nvim",
		},
		["ironhouzi/starlite-nvim"] = {
			url = "ironhouzi/starlite-nvim",
			is_enabled = function()
				return vim.fn.has("nvim") == 1
			end,
		},
		["stonelasley/flare.nvim"] = {
			url = "stonelasley/flare.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.7") == 1
			end,
		},
		["DanilaMihailov/beacon.nvim"] = {
			url = "DanilaMihailov/beacon.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.7") == 1
			end,
		},
		["NarutoXY/dim.lua"] = {
			url = "NarutoXY/dim.lua",
			is_enabled = function()
				return vim.fn.has("nvim-0.6") == 1
			end,
		},
		["kevinhwang91/nvim-hlslens"] = {
			url = "kevinhwang91/nvim-hlslens",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["lambdalisue/lista.nvim"] = {
			url = "lambdalisue/lista.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1 and vim.fn.has("python3") == 1
			end,
		},
		["ripxorip/aerojump.nvim"] = {
			url = "ripxorip/aerojump.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			post_install = ":UpdateRemotePlugins",
		},
		["tzachar/local-highlight.nvim"] = {
			url = "tzachar/local-highlight.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.9.4") == 1
			end,
			dependencies = {
				pre = {
					"folke/snacks.nvim",
				},
			},
		},

		--buffer/colors
		["norcalli/nvim-colorizer.lua"] = {
			url = "norcalli/nvim-colorizer.lua",
			is_enabled = function()
				return vim.fn.has("nvim") == 1
			end,
		},
		["axlebedev/footprints"] = {
			url = "axlebedev/footprints",
		},
		["folke/todo-comments.nvim"] = {
			url = "folke/todo-comments.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},

		--WINDOW
		--window.general
		["sindrets/winshift.nvim"] = {
			url = "sindrets/winshift.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["luukvbaal/stabilize.nvim"] = {
			url = "luukvbaal/stabilize.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			--after_plugin_load = function()
			--	require('stabilize').setup()
			--end,
		},

		--window/ui
		["sunjon/Shade.nvim"] = {
			url = "sunjon/Shade.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.4") == 1
			end,
		},
		["beauwilliams/focus.nvim"] = {
			url = "beauwilliams/focus.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},

		--TABS

		--SYSTEM
		--system/search
		["skywind3000/asyncrun.vim"] = {
			url = "skywind3000/asyncrun.vim",
			dependencies = {
				pre = { "preservim/vimux" },
				post = { "skywind3000/asyncrun.extra" },
			},
		},
		["is0n/fm-nvim"] = {
			url = "is0n/fm-nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["junegunn/fzf"] = {
			url = "junegunn/fzf",
			directory = "~/.fzf",
			post_install = ":call fzf#install()",
			dependencies = {
				post = {
					"junegunn/fzf.vim",
					--'yuki-yano/fzf-preview.vim',

					"vijaymarupudi/nvim-fzf",
					"ibhagwan/fzf-lua",

					"dominickng/fzf-session.vim",
					"pbogut/fzf-mru.vim",
				},
			},
		},
		["junegunn/fzf.vim"] = {
			url = "junegunn/fzf.vim",
			config = "fzf-vim.vim",
			dependencies = {
				pre = { "junegunn/fzf" },
			},
		},
		["ibhagwan/fzf-lua"] = {
			url = "ibhagwan/fzf-lua",
			dependencies = {
				pre = { "junegunn/fzf" },
				post = {
					--"aaronhallaert/advanced-git-search.nvim", --TODO:1
				},
			},
		},
		["yuki-ycino/fzf-preview.vim"] = {
			url = "yuki-ycino/fzf-preview.vim",
			branch = "release/rpc",
			is_enabled = function()
				return vim.fn.has("node") == 1
			end,
			dependencies = {
				pre = { "junegunn/fzf" },
			},
		},
		["aaronhallaert/advanced-git-search.nvim"] = {
			url = "aaronhallaert/advanced-git-search.nvim",
			dependencies = {
				pre = {
					"ibhagwan/fzf-lua",
					"nvim-telescope/telescope.nvim",
					"tpope/vim-fugitive",
					"tpope/vim-rhubarb",
					"sindrets/diffview.nvim",
				},
			},
		},
		["piersolenski/telescope-import.nvim"] = {
			url = "piersolenski/telescope-import.nvim",
			dependencies = {
				pre = {
					"nvim-telescope/telescope.nvim",
				},
			},
		},
		["danielfalk/smart-open.nvim"] = {
			url = "danielfalk/smart-open.nvim",
			dependencies = {
				pre = { "kkharji/sqlite.lua" },
			},
		},
		["nvim-telescope/telescope.nvim"] = {
			url = "nvim-telescope/telescope.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				pre = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
				post = {
					"danielfalk/smart-open.nvim",
					"danielpieper/telescope-tmuxinator.nvim",
					--'gfeiyou/command-center.nvim',
					--'debugloop/telescope-undo.nvim',
					--'princejoogie/dir-telescope.nvim',
					--'LukasPietzschmann/telescope-tabs',
					--'nvim-telescope/telescope-fzf-native.nvim',
					--'nvim-telescope/telescope-file-browser.nvim',
					--'benfowler/telescope-luasnip.nvim',
					--'nvim-telescope/telescope-frecency.nvim',
					--'cljoly/telescope-repo.nvim',
					--'tamago324/telescope-openbrowser.nvim',
					--'nvim-telescope/telescope-media-files.nvim',
					--'nvim-telescope/telescope-packer.nvim',
					--'nvim-telescope/telescope-github.nvim',
					-- FIX: figure out to keep or not or fix it its working
					--'ilAYAli/scMRU.nvim',
				},
			},
		},
		["stevearc/dressing.nvim"] = {
			url = "stevearc/dressing.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				pre = {
					"ibhagwan/fzf-lua",
					"junegunn/fzf",
					--'MunifTanjim/nui.nvim'
					"nvim-telescope/telescope.nvim",
				},
			},
		},

		--system/terminal
		["lambdalisue/guise.vim"] = {
			url = "lambdalisue/guise.vim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				pre = { "vim-denops/denops.vim" },
			},
		},

		--system/filesystem
		["X3eRo0/dired.nvim"] = {
			url = "X3eRo0/dired.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.6") == 1
			end,
			dependencies = {
				pre = { "MunifTanjim/nui.nvim" },
			},
		},
		["elihunter173/dirbuf.nvim"] = {
			url = "elihunter173/dirbuf.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.6") == 1
			end,
		},
		["kyazdani42/nvim-tree.lua"] = {
			url = "kyazdani42/nvim-tree.lua",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["ms-jpq/chadtree"] = {
			url = "ms-jpq/chadtree",
			is_enabled = function()
				return vim.fn.has("nvim-0.4.3") == 1
			end,
			branch = "chad",
			post_install = "python3 -m chadtree deps",
		},

		--PROGRAMMING
		--programming/general
		["ludovicchabant/vim-gutentags"] = {
			url = "ludovicchabant/vim-gutentags",
			is_enabled = function()
				return not is_installed({ "tagrity" })
			end,
			dependencies = {
				post = { "skywind3000/gutentags_plus" },
			},
		},

		--programming/lsp
		["neoclide/coc.nvim"] = {
			url = "neoclide/coc.nvim",
			branch = "release",
			is_enabled = function()
				return (
					vim.fn.has("node") == 1
					and not (vim.fn.has("nvim-0.5") == 1)
					and (vim.v.version >= 800 or vim.fn.has("nvim-0.4") == 1)
				)
			end,
			dependencies = {
				post = {
					"Shougo/neco-vim",
					"neoclide/coc-neco",
				},
			},
		},
		["whynothugo/lsp_lines.nvim"] = {
			url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["williamboman/mason-lspconfig.nvim"] = {
			url = "williamboman/mason-lspconfig.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				pre = {
					"williamboman/mason.nvim",
				},
			},
		},
		["neovim/nvim-lspconfig"] = {
			url = "neovim/nvim-lspconfig",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			should_load_config = true,
			dependencies = {
				pre = { "williamboman/mason-lspconfig.nvim" },
				post = { "hinell/lsp-timeout.nvim" },
			},
		},
		["cseickel/diagnostic-window.nvim"] = {
			url = "cseickel/diagnostic-window.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["wiliamks/nice-reference.nvim"] = {
			url = "wiliamks/nice-reference.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				pre = {
					"kyazdani42/nvim-web-devicons",
					"rmagatti/goto-preview",
				},
			},
		},
		["DNLHC/glance.nvim"] = {
			url = "DNLHC/glance.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.7") == 1
			end,
			lazyload = {
				--cmds = { "Glance" },
			},
		},
		["amrbashir/nvim-docs-view"] = {
			url = "amrbashir/nvim-docs-view",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			lazyload = {
				cmds = "DocsViewToggle",
			},
		},
		["SmiteshP/nvim-navic"] = {
			url = "SmiteshP/nvim-navic",
			is_enabled = function()
				return vim.fn.has("nvim-0.7") == 1
			end,
			dependencies = {
				pre = { "neovim/nvim-lspconfig" },
			},
		},
		["utilyre/barbecue.nvim"] = {
			url = "utilyre/barbecue.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.8") == 1
			end,
			dependencies = {
				pre = {
					"neovim/nvim-lspconfig",
					"SmiteshP/nvim-navic",
					"kyazdani42/nvim-web-devicons", -- optional
				},
			},
		},
		["VidocqH/lsp-lens.nvim"] = {
			url = "VidocqH/lsp-lens.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.8") == 1
			end,
		},
		["folke/trouble.nvim"] = {
			url = "folke/trouble.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["kosayoda/nvim-lightbulb"] = {
			url = "kosayoda/nvim-lightbulb",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["smjonas/inc-rename.nvim"] = {
			url = "smjonas/inc-rename.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.8") == 1
			end,
		},
		["rmagatti/goto-preview"] = {
			url = "rmagatti/goto-preview",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["nanotee/nvim-lsp-basics"] = {
			url = "nanotee/nvim-lsp-basics",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["RishabhRD/nvim-lsputils"] = {
			url = "RishabhRD/nvim-lsputils",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["folke/lsp-colors.nvim"] = {
			url = "folke/lsp-colors.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["onsails/lspkind-nvim"] = {
			url = "onsails/lspkind-nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["ray-x/lsp_signature.nvim"] = {
			url = "ray-x/lsp_signature.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["weilbith/nvim-code-action-menu"] = {
			url = "weilbith/nvim-code-action-menu",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["glepnir/lspsaga.nvim"] = {
			url = "glepnir/lspsaga.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["SmiteshP/nvim-navbuddy"] = {
			url = "SmiteshP/nvim-navbuddy",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				pre = {
					"neovim/nvim-lspconfig",
					"SmiteshP/nvim-navic",
					"MunifTanjim/nui.nvim",
				},
			},
		},
		["jose-elias-alvarez/nvim-lsp-ts-utils"] = {
			url = "jose-elias-alvarez/nvim-lsp-ts-utils",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["j-hui/fidget.nvim"] = {
			url = "j-hui/fidget.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.6") == 1
			end,
			tag = "legacy",
		},
		["williamboman/nvim-lsp-installer"] = {
			url = "williamboman/nvim-lsp-installer",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["creativenull/diagnosticls-nvim"] = {
			url = "creativenull/diagnosticls-nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			should_load_config = false,
		},
		["ldelossa/litee.nvim"] = {
			url = "ldelossa/litee.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				post = {
					"ldelossa/litee-symboltree.nvim",
					"ldelossa/litee-calltree.nvim",
					"ldelossa/litee-filetree.nvim",
				},
			},
		},
		["nvim-lua/lsp-status.nvim"] = {
			url = "nvim-lua/lsp-status.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["jose-elias-alvarez/null-ls.nvim"] = {
			url = "jose-elias-alvarez/null-ls.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				post = {
					"jay-babu/mason-null-ls.nvim",
				},
			},
		},
		["joechrisellis/lsp-format-modifications.nvim"] = {
			url = "joechrisellis/lsp-format-modifications.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.8")
			end,
		},

		--programming/random
		["b3nj5m1n/kommentary"] = {
			url = "b3nj5m1n/kommentary",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["skanehira/k8s.vim"] = {
			url = "skanehira/k8s.vim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				pre = { "vim-denops/denops.vim" },
			},
		},

		--programming/treesitter
		["nvim-treesitter/nvim-treesitter"] = {
			url = "nvim-treesitter/nvim-treesitter",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			post_install = ":TSUpdate",
			hooks = {
				after_plugin_install = function()
					vim.cmd("TSInstall all")
				end,
			},
			dependencies = {
				post = { "nvim-treesitter/playground" },
			},
		},
		["mfussenegger/nvim-treehopper"] = {
			url = "mfussenegger/nvim-treehopper",
			dependencies = {
				pre = {
					"nvim-treesitter/nvim-treesitter",
				},
			},
			is_enabled = function()
				return vim.fn.has("nvim-0.7") == 1
			end,
		},
		["ziontee113/syntax-tree-surfer"] = {
			url = "ziontee113/syntax-tree-surfer",
			dependencies = {
				pre = {
					"nvim-treesitter/nvim-treesitter",
				},
			},
			is_enabled = function()
				return vim.fn.has("nvim-0.7") == 1
			end,
		},
		["nvim-treesitter/playground"] = {
			url = "nvim-treesitter/playground",
			dependencies = {
				pre = {
					"nvim-treesitter/nvim-treesitter",
				},
			},
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["nvim-treesitter/nvim-treesitter-textobjects"] = {
			url = "nvim-treesitter/nvim-treesitter-textobjects",
			dependencies = {
				pre = { "nvim-treesitter/nvim-treesitter" },
			},
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["Jason-M-Chan/ts-textobjects"] = {
			url = "Jason-M-Chan/ts-textobjects",
			dependencies = {
				pre = { "nvim-treesitter/nvim-treesitter" },
			},
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["singlexyz/treesitter-frontend-textobjects"] = {
			url = "singlexyz/treesitter-frontend-textobjects",
			dependencies = {
				pre = {
					"nvim-treesitter/nvim-treesitter",
				},
			},
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["JoosepAlviste/nvim-ts-context-commentstring"] = {
			url = "JoosepAlviste/nvim-ts-context-commentstring",
			dependencies = {
				pre = {
					"nvim-treesitter/nvim-treesitter",
				},
			},
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["nvim-treesitter/nvim-treesitter-context"] = {
			url = "nvim-treesitter/nvim-treesitter-context",
			dependencies = {
				pre = { "nvim-treesitter/nvim-treesitter" },
			},
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["haringsrob/nvim_context_vt"] = {
			url = "haringsrob/nvim_context_vt",
			dependencies = {
				pre = { "nvim-treesitter/nvim-treesitter" },
			},
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["nvim-treesitter/nvim-treesitter-refactor"] = {
			url = "nvim-treesitter/nvim-treesitter-refactor",
			dependencies = {
				pre = { "nvim-treesitter/nvim-treesitter" },
			},
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["p00f/nvim-ts-rainbow"] = {
			url = "p00f/nvim-ts-rainbow",
			dependencies = {
				pre = { "nvim-treesitter/nvim-treesitter" },
			},
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["windwp/nvim-ts-autotag"] = {
			url = "windwp/nvim-ts-autotag",
			dependencies = {
				pre = { "nvim-treesitter/nvim-treesitter" },
			},
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},

		--programming/completion
		["github/copilot.vim"] = {
			url = "github/copilot.vim",
			post_install = ":Copilot setup",
			is_enabled = function()
				return vim.fn.has("nvim-0.6") == 1
			end,
		},
		["hrsh7th/nvim-cmp"] = {
			url = "hrsh7th/nvim-cmp",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				post = {
					"hrsh7th/cmp-nvim-lsp",
					"saadparwaiz1/cmp_luasnip",
					--'hrsh7th/cmp-vsnip',
					"hrsh7th/cmp-nvim-lua",
					"hrsh7th/cmp-nvim-lsp-signature-help",
					--'quangnguyen30192/cmp-nvim-tags',
					"lukas-reineke/cmp-rg",

					"hrsh7th/cmp-buffer",
					"hrsh7th/cmp-path",
					--'tzachar/cmp-tabnine',
					--'ray-x/cmp-treesitter',

					"tamago324/cmp-zsh",
					"andersevenrud/cmp-tmux",
					"David-Kunz/cmp-npm",
					"petertriho/cmp-git",
					"hrsh7th/cmp-cmdline",

					"tzachar/cmp-ai",

					"f3fora/cmp-spell",
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
		["noib3/nvim-compleet"] = {
			url = "noib3/nvim-compleet",
			post_install = "cargo build --release && make install",
			is_enabled = function()
				return vim.fn.has("nvim-0.7") == 1 and is_installed({ "make", "ar", "rustc", "rustup" })
			end,
		},
		["tzachar/cmp-tabnine"] = {
			url = "tzachar/cmp-tabnine",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			post_install = "./install.sh",
		},
		["Wansmer/treesj"] = {
			url = "Wansmer/treesj",
			is_enabled = function()
				return vim.fn.has("nvim-0.8")
			end,
			dependencies = {
				pre = { "nvim-treesitter/nvim-treesitter" },
			},
		},
		["hrsh7th/nvim-compe"] = {
			url = "hrsh7th/nvim-compe",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
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
		["tzachar/compe-tabnine"] = {
			url = "tzachar/compe-tabnine",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				pre = { "hrsh7th/nvim-compe" },
			},
			post_install = "./install.sh",
		},
		["L3MON4D3/LuaSnip"] = {
			url = "L3MON4D3/LuaSnip",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				post = { "rafamadriz/friendly-snippets" },
			},
		},
		["hrsh7th/vim-vsnip"] = {
			url = "hrsh7th/vim-vsnip",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				post = {
					"hrsh7th/vim-vsnip-integ",
					"rafamadriz/friendly-snippets",
				},
			},
		},
		["SirVer/ultisnips"] = {
			url = "SirVer/ultisnips",
			dependencies = {
				post = {
					"honza/vim-snippets",
					"epilande/vim-react-snippets",
				},
			},
			is_enabled = function()
				return vim.fn.has("python3") == 1
			end,
		},
		["ms-jpq/coq_nvim"] = {
			url = "ms-jpq/coq_nvim",
			branch = "coq",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				post = { "ms-jpq/coq.artifacts" },
			},
		},
		["ms-jpq/coq.artifacts"] = {
			url = "ms-jpq/coq.artifacts",
			branch = "artifacts",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["jameshiew/nvim-magic"] = {
			url = "jameshiew/nvim-magic",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			tag = "v0.2.1", -- recommended to pin to a tag and update manually as there may be breaking changes
			dependencies = {
				pre = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
			},
			config = function()
				require("nvim-magic").setup({
					use_default_keymap = false,
					backends = {
						default = require("nvim-magic-openai").new({
							api_endpoint = "https://api.openai.com/v1/engines/cushman-codex/completions",
						}),
					},
				})
			end,
		},
		["dpayne/CodeGPT.nvim"] = {
			url = "dpayne/CodeGPT.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				pre = {
					"nvim-lua/plenary.nvim",
					"MunifTanjim/nui.nvim",
				},
			},
		},

		--programming/vcs
		["TimUntersberger/neogit"] = {
			url = "TimUntersberger/neogit",
			is_enabled = function()
				return is_installed({ "git" }) and vim.fn.has("nvim-0.5") == 1
			end,
		},
		["tanvirtin/vgit.nvim"] = {
			url = "tanvirtin/vgit.nvim",
			is_enabled = function()
				return is_installed({ "git" }) and vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				pre = {
					"nvim-lua/plenary.nvim",
					"kyazdani42/nvim-web-devicons",
				},
			},
		},
		["ldelossa/gh.nvim"] = {
			url = "ldelossa/gh.nvim",
			is_enabled = function()
				return is_installed({ "git", "gh" }) and vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				pre = { "ldelossa/litee.nvim" },
			},
		},
		["skanehira/gh.vim"] = {
			url = "skanehira/gh.vim",
			is_enabled = function()
				return is_installed({ "git", "gh" }) and vim.fn.has("nvim-0.5") == 1
			end,
		},
		["lewis6991/gitsigns.nvim"] = {
			url = "lewis6991/gitsigns.nvim",
			is_enabled = function()
				return is_installed({ "git" }) and vim.fn.has("nvim-0.9") == 1
			end,
			dependencies = {
				pre = { "nvim-lua/plenary.nvim" },
			},
		},
		["sindrets/diffview.nvim"] = {
			url = "sindrets/diffview.nvim",
			is_enabled = function()
				return is_installed({ "git" }) and vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				pre = { "kyazdani42/nvim-web-devicons" },
			},
		},
		["ruifm/gitlinker.nvim"] = {
			url = "ruifm/gitlinker.nvim",
			is_enabled = function()
				return is_installed({ "git" }) and vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				pre = { "nvim-lua/plenary.nvim" },
			},
		},
		["pwntester/octo.nvim"] = {
			url = "pwntester/octo.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1 and is_installed({ "git", "gh" })
			end,
		},
		["akinsho/git-conflict.nvim"] = {
			url = "akinsho/git-conflict.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.7") == 1 and is_installed({ "git" })
			end,
		},

		--programming/testing
		["vim-test/vim-test"] = {
			url = "vim-test/vim-test",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				post = { "rcarriga/vim-ultest" },
			},
		},
		["rcarriga/neotest"] = {
			url = "rcarriga/neotest",
			dependencies = {
				pre = {
					"nvim-lua/plenary.nvim",
					"nvim-treesitter/nvim-treesitter",
					"antoinemadec/FixCursorHold.nvim",
					"haydenmeade/neotest-jest",
					"nvim-neotest/nvim-nio",
				},
			},
		},
		["rcarriga/vim-ultest"] = {
			url = "rcarriga/vim-ultest",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1 and vim.fn.has("python3") == 1
			end,
			dependencies = {
				pre = {
					"vim-test/vim-test",
					"roxma/nvim-yarp",
					"roxma/vim-hug-neovim-rpc",
				},
			},
		},

		--programming/debugging
		["mfussenegger/nvim-dap"] = {
			url = "mfussenegger/nvim-dap",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				pre = {
					"jbyuki/one-small-step-for-vimkind",
				},
				post = {
					"jay-babu/mason-nvim-dap.nvim",
					--'mxsdev/nvim-dap-vscode-js', -- TODO:
					--'rcarriga/nvim-dap-ui',
					"theHamsta/nvim-dap-virtual-text",
					"Weissle/persistent-breakpoints.nvim",
					"ofirgall/goto-breakpoints.nvim",
					--'David-Kunz/jester', --FIX: ???
					--'nvim-telescope/telescope-dap.nvim',
				},
			},
		},
		["rcarriga/nvim-dap-ui"] = {
			url = "rcarriga/nvim-dap-ui",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				post = { "mortepau/codicons.nvim" },
			},
		},
		["mxsdev/nvim-dap-vscode-js"] = {
			url = "mxsdev/nvim-dap-vscode-js",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["mhartington/formatter.nvim"] = {
			url = "mhartington/formatter.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				post = {
					-- under-dev not for use
					--'princejoogie/mason-formatter.nvim',
				},
			},
		},
		["theHamsta/nvim-dap-virtual-text"] = {
			url = "theHamsta/nvim-dap-virtual-text",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},

		--programming/miscelleanous
		["tpope/vim-dadbod"] = {
			url = "tpope/vim-dadbod",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				post = { "kristijanhusak/vim-dadbod-ui" },
			},
		},
		["kristijanhusak/vim-dadbod-ui"] = {
			url = "kristijanhusak/vim-dadbod-ui",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				pre = { "tpope/vim-dadbod" },
			},
		},
		["kkoomen/vim-doge"] = {
			url = "kkoomen/vim-doge",
			post_install = ":call doge#install()",
		},
		["JASONews/glow-hover"] = {
			url = "JASONews/glow-hover",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1 and is_installed({ "glow" })
			end,
		},
		["antonk52/npm_scripts.nvim"] = {
			url = "antonk52/npm_scripts.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1 and is_installed({ "npm" })
			end,
		},
		["vuki656/package-info.nvim"] = {
			url = "vuki656/package-info.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				pre = { "MunifTanjim/nui.nvim" },
			},
		},
		["prettier/vim-prettier"] = {
			url = "prettier/vim-prettier",
			is_enabled = function()
				return vim.v.version >= 800 and is_installed({ "node" })
			end,
		},
		["napmn/react-extract.nvim"] = {
			url = "napmn/react-extract.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
		},
		["Azeirah/nvim-redux"] = {
			url = "Azeirah/nvim-redux",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			dependencies = {
				pre = { "nvim-telescope/telescope.nvim" },
			},
		},
		["0x100101/lab.nvim"] = {
			url = "0x100101/lab.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.7.2") and is_installed({ "node" })
			end,
			post_install = "cd js && npm ci",
			dependencies = {
				pre = { "nvim-lua/plenary.nvim" },
			},
		},

		--CLIENTS
		["glacambre/firenvim"] = {
			url = "glacambre/firenvim",
			post_install = ":call firenvim#install(0)",
		},

		--RANDOM
		["potamides/pantran.nvim"] = {
			url = "potamides/pantran.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.7") == 1
			end,
		},
		["MeanderingProgrammer/render-markdown.nvim"] = {
			url = "MeanderingProgrammer/render-markdown.nvim",
			--lazyload = {
			--  filetypes = { "markdown", "mkdc" },
			--},
			dependencies = {
				pre = {
					'nvim-treesitter/nvim-treesitter',
					'echasnovski/mini.nvim',
				}
			},
			--config = function()
			--  require('render-markdown').setup({})
			--end,
		},
		["iamcco/markdown-preview.nvim"] = {
			url = "iamcco/markdown-preview.nvim",
			lazyload = {
				filetypes = { "markdown", "vim-plug", "mkdc" },
			},
			post_install = "cd app && yarn install",
		},
		["nvim-neorg/neorg"] = {
			url = "nvim-neorg/neorg",
			is_enabled = function()
				return vim.fn.has("nvim-0.5") == 1
			end,
			post_install = ":Neorg sync-parsers",
			dependencies = {
				pre = {
					"nvim-lua/plenary.nvim",
					"nvim-neorg/lua-utils.nvim",
				},
			},
		},
		["Zeioth/markmap.nvim"] = {
			url = "Zeioth/markmap.nvim",
			post_install = "yarn global add markmap-cli",
			is_installed = function()
				return is_installed({ "yarn" })
			end,
			lazyload = {
				cmd = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
			},
		},
		["itchyny/dictionary.vim"] = {
			url = "itchyny/dictionary.vim",
			is_enabled = function()
				return vim.fn.IsNix() == 1
			end,
		},
		["princejoogie/chafa.nvim"] = {
			url = "princejoogie/chafa.nvim",
			is_enabled = function()
				return vim.fn.has("nvim-0.7")
			end,
			dependencies = {
				pre = {
					"nvim-lua/plenary.nvim",
					"m00qek/baleia.nvim",
				},
			},
		},
	},
	modes = {
		core = core,
		minimal = concat({ core, editor }),
		default = concat({ core, editor, configuration, default }),
		ide = concat({ core, editor, configuration, default, ide }),
		featured = concat({ core, editor, configuration, default, ide, featured, markup }),
		testing = concat({ core, editor, configuration, default, ide, featured, markup, testing }),
	},
}
