require("which-key").setup({
	-- Use classic preset (maintains your familiar layout)
	preset = "classic",

	-- Delay before showing the popup
	delay = function(ctx)
		return ctx.plugin and 0 or 200
	end,

	-- Filter mappings (optional)
	filter = function(mapping)
		return true
	end,

	-- Plugins configuration
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = true, -- adds help for operators like d, y, ...
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},

	-- Key labels and replacements
	replace = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		["<space>"] = "SPC",
		["<cr>"] = "RET",
		["<tab>"] = "TAB",
	},

	-- Icons configuration
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},

	-- Window configuration
	win = {
		-- don't allow the popup to overlap with the cursor
		no_overlap = true,
		padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
		title = true,
		title_pos = "center",
		zindex = 1000,
		wo = {},
	},

	-- Layout configuration
	layout = {
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 4, -- spacing between columns
		align = "center", -- align columns left, center or right
	},

	-- Show help message
	show_help = true,

	-- Scroll keys
	keys = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},

	-- Triggers configuration
	triggers = {
		{ "<auto>", mode = "nxso" },
	},

	-- Defer function for visual modes
	defer = function(ctx)
		return ctx.mode == "V" or ctx.mode == "<C-V>"
	end,
})

-- Register your keymaps (this part remains mostly the same)
require("which-key").register({
	[" "] = {
		name = "miscellanous",
	},
	["'"] = "which_key_ignore",
	["*"] = "which_key_ignore",
	["/"] = "which_key_ignore",
	["1"] = "which_key_ignore",
	["1-9"] = "open-buffer",
	["2"] = "which_key_ignore",
	["3"] = "which_key_ignore",
	["4"] = "which_key_ignore",
	["5"] = "which_key_ignore",
	["6"] = "which_key_ignore",
	["7"] = "which_key_ignore",
	["8"] = "which_key_ignore",
	["9"] = "which_key_ignore",
	["<Tab>"] = "show-mappings",
	["?"] = "which_key_ignore",
	["@"] = "which_key_ignore",
	S = {
		c = "close-session",
		d = "delete-session",
		l = "list-sessions",
		n = "new-session",
		name = "sessions",
		o = "open-session",
		s = "-save-session",
	},
	t = {
		["."] = "tab-mode",
		N = "move-tab-right",
		P = "move-tab-left",
		a = "add-tab",
		d = "delete-tab",
		l = "list-tabs",
		n = "next-tab",
		name = "tabs",
		p = "previous-tab",
	},
	["`"] = "open-last-buffer",
	a = {
		name = "apps",
		e = "explorer",
		g = "git",
		m = "markdown",
		y = "youtube",
		Y = "youtube-music",
		t = "typing-test",

		E = "which_key_ignore",
		G = "which_key_ignore",
		M = "which_key_ignore",
	},
	b = {
		name = "buffers",
		["."] = "buffer-mode",
		["/"] = "search-current-buffer",
		["?"] = "search-all-buffers",
		a = {
			name = "add",
			S = "scratch-buffer-filetype",
			n = "new-buffer",
			s = "scratch-buffer",
		},
		c = {
			name = "close",
			a = "close-all",
			c = "close-current",
			f = "close-all-filetype",
			g = "close-glob",
			h = "close-left",
			l = "close-right",
			n = "close-nameless",
			o = "close-others",
			r = "close-regex",
			v = "close-hidden",

			--A = 'CLOSE-all',
			--C = 'CLOSE-current',
			--F = 'CLOSE-all-filetype',
			--G = 'CLOSE-glob',
			--N = 'CLOSE-nameless',
			--O = 'CLOSE-others',
			--R = 'CLOSE-regex',
			--V = 'CLOSE-hidden',

			A = "which_key_ignore",
			C = "which_key_ignore",
			F = "which_key_ignore",
			G = "which_key_ignore",
			N = "which_key_ignore",
			O = "which_key_ignore",
			R = "which_key_ignore",
			V = "which_key_ignore",
		},
		d = {
			name = "delete",
			a = "delete-all",
			c = "delete-current",
			f = "--delete-all-filetype",
			g = "--delete-glob",
			h = "--delete-left",
			l = "--delete-right",
			n = "--delete-nameless",
			o = "--delete-others",
			r = "--delete-regex",
			v = "--delete-hidden",

			--A = 'DELETE-all',
			--C = 'DELETE-current',
			--F = '--DELETE-all-filetype',
			--G = '--DELETE-glob',
			--N = '--DELETE-nameless',
			--O = '--DELETE-others',
			--R = '--DELETE-regex',
			--V = '--DELETE-hidden',

			A = "which_key_ignore",
			C = "which_key_ignore",
			F = "which_key_ignore",
			G = "which_key_ignore",
			N = "which_key_ignore",
			O = "which_key_ignore",
			R = "which_key_ignore",
			V = "which_key_ignore",
		},
		w = {
			name = "write",
			a = "write-all-buffers",
			c = "write-current-buffer",

			--A = 'WRITE-all-buffers',
			--C = 'WRITE-current-buffer',

			A = "which_key_ignore",
			C = "which_key_ignore",
		},
		r = "reload",
		p = "toggle-pin",
		R = "which_key_ignore",

		g = "goto-buffer",
		f = "change-buffer-filetype",
		l = "list-buffers",
		t = "buffer-tree",
	},
	c = {
		name = "which_key_ignore",
	},
	d = {
		name = "which_key_ignore",
	},
	e = {
		name = "-editors",
		["u"] = "ui",
		["e"] = "explorer",
	},
	f = {
		name = "find",
		["."] = "sources",
		d = {
			name = "directories",
			["/"] = "search-/",
			h = "search-home",
			d = "search-drive",
			p = "search-project",
			c = "search-curent",
			r = "_search-recent",
		},
		f = {
			name = "files",
			["/"] = "search-/",
			h = "search-home",
			d = "search-drive",
			p = "search-project",
			c = "search-curent",
			r = "search-recent",
		},
		t = {
			name = "text",
			["/"] = "search-/",
			h = "search-home",
			d = "search-drive",
			p = "search-project",
			c = "search-curent",
			f = "search-file",
			b = "search-buffers",
		},
		w = {
			name = "web",
			["."] = "open-link-in-buffer",
			o = "open-link",
			g = "search-github",
			G = "search-google",
			d = "search-duckduckgo",
			w = "search-wikipedia",
			v = "search-vim",

			O = "which_key_ignore",
		},
		s = {
			name = "search",
			p = "s&r-in-project",
			f = "s&r-in-file",
			w = "s&r-current-word",
		},
	},
	g = {
		name = "git",
		t = "temp-repo",
		b = "blame-line",
		B = "blame-gutter",
		l = "line-commits",
		["."] = "UI",
		c = {
			name = "conflicts",
			b = "conflict-both",
			B = "conflict-both-reverse",
			n = "conflict-none",
			o = "conflict-ours",
			t = "conflict-theirs",
		},
		C = {
			name = "commits",
			l = "line-commits",
			b = "buffer-commits",
			p = "project-commits",
		},
		d = {
			name = "diff",
			["."] = "diff-view",
			b = "preview-buffer-diff",
			p = "preview-project-diff",
			h = "preview-buffer-history",
			x = "toggle-diff-mode",
		},
		h = {
			name = "hunks",
			s = "stage-hunk",
			u = "unstage-hunk",
			r = "reset-hunk",
			R = "reset-buffer",
			p = "preview-hunks",
			P = "preview-project-hunks",
			q = "project-hunks-qf",
		},
		r = {
			name = "remote",
			y = "yank-link",
		},
		p = {
			name = "projects",
			e = "edit-config",
			s = "sync-projects",
			p = "switch-project",
			w = "switch-workspace",
			c = "execute-cmd",
			t = "run-task",
		},
		w = {
			name = "worktree",
			c = "-clone",
			a = "add",
			A = "add-new",
			r = "remove",
			R = "force-remove",
			s = "switch",
		},
	},
	h = {
		name = "which_key_ignore",
	},
	i = {
		name = "which_key_ignore",
	},
	j = {
		name = "jump",
	},
	k = {
		name = "which_key_ignore",
	},
	l = {
		name = "lsp",
		a = {
			name = "actions",
			["."] = "code-actions",
			a = "annotate",
			o = "organize-imports",
			q = "quickfix",

			f = "format",
		},
		b = {
			name = "breakpoints",
			b = "breakpoint",
			c = "conditional-breakpoint",
			l = "logpoint",
			C = "clear-breakpoints",
			q = "list-breakpoints",
		},
		d = {
			name = "debug",
			s = "start",
			t = "stop",
			p = "continue",
			r = "restart",

			--b = 'breakpoint',
			--c = 'conditional-breakpoint',
			--l = 'logpoint',
			--C = 'clear-breakpoints',
			--q = 'list-breakpoints',

			--j = 'step-in',
			--k = 'step-out',
			--l = 'step-over',
			--l = 'step-back',

			--r = 'repl',
			e = "eval-expression",
			--f = 'restart-frame'
		},
		e = {
			name = "diagnostics",
			["."] = "diagnostics-panel",
			l = "line-diagnostics",
			d = "document-diagnostics",
			w = "workspace-diagnostics",
			q = "open-in-quickfix",
			t = {
				name = "toggles",
				["."] = "toggle-diagnostics",
				u = "toggle-underline",
				s = "toggle-signs",
				v = "toggle-virtual-text",
				i = "toggle-update-in-insert",
			},
		},
		f = {
			name = "file",
			c = "compile",
			e = "run",
			f = "format",
			l = "lint",
			q = "compile-run",
			r = "repl",
			t = "test",
			m = "make",
		},
		g = {
			name = "goto",
			D = "goto-declaration",
			F = "goto-fixture-file",
			S = "goto-source-file",
			T = "goto-test-file",
			d = "goto-definition",
			i = "goto-implementation",
			r = "goto-references",
			t = "goto-type-definition",
		},
		h = {
			name = "help",
			h = "hover-documentation",
			s = "signature-help",
		},
		p = {
			name = "project",
			i = "install",
			I = "init",
			l = "lint",
			f = "format",
			t = "test",
			d = "debug",
			r = "run",
			b = "build",
			R = "release",
			p = "publish",
			D = "deploy",
			s = "scaffold",
		},
		P = {
			name = "preview",
			D = "preview-declaration",
			F = "preview-fixture-file",
			S = "preview-source-file",
			T = "preview-test-file",
			d = "preview-definition",
			i = "preview-implementation",
			t = "preview-type-definition",
			r = "preview-references",
		},
		r = {
			name = "refactor",
			e = "extract",
		},
		s = {
			name = "symbols",
			r = "rename-symbol",
			R = "rename-symbol-treesitter",
			d = "document-symbols",
			w = "workspace-symbols",
			t = "symbols-tree",
			i = "incoming-calls",
			o = "outgoing-calls",
		},
		t = {
			name = "test",
			["."] = "tests-panel",
			f = "test-file",
			l = "test-last",
			n = "test-nearest",
		},
		T = {
			name = "tags",
			b = "buffer-tags",
			p = "project-tags",
		},
	},
	m = {
		name = "mux",
		p = "open-project",
		o = "open-mru",
	},
	n = {
		name = "notes",
		["."] = "toggle-sidebar",
	},
	o = {
		name = "which_key_ignore",
	},
	p = {
		name = "projects",
		["/"] = "search-project",
		o = "open-mru-project",
		O = "open-project",
		f = "open-project-file",
		e = "open-file-explorer",
		t = "open-file-tree",
		g = "open-modified-file",
		r = "open-project-mru",
		R = "open-project-mfu",
		a = "mru-add",
		d = "mru-delete",
	},
	q = {
		name = "quickfix",
		o = "open",
		c = "close",
		n = "next-list",
		p = "previous-list",
		["/"] = "quickfix-history",

		O = "which_key_ignore",
		C = "which_key_ignore",
		N = "which_key_ignore",
		P = "which_key_ignore",
		["?"] = "which_key_ignore",
	},
	r = {
		name = "which_key_ignore",
	},
	s = {
		name = "scratch-window",
		o = "open-scratch",
		p = "preview-scratch",
		s = "send-selection",
	},
	T = {
		name = "terminals",
		l = "--list-terminals",
		h = "horizontal-terminal",
		v = "vertical-terminal",
		b = "buffer-terminal",
		T = "tab-terminal",
		f = "floating-terminal",
		k = "kill-terminal",
		n = "next-terminal",
		p = "previous-terminal",
		t = "toggle-terminal",

		--H = 'new-horizontal-terminal-lcd',
		--V = 'new-vertical-terminal-lcd',
		--B = 'new-buffer-terminal-lcd',
		--F = '--new-floating-terminal-lcd',

		H = "which_key_ignore",
		V = "which_key_ignore",
		B = "which_key_ignore",
		F = "which_key_ignore",
	},
	u = {
		name = "which_key_ignore",
	},
	v = {
		["/"] = "search-history",
		[":"] = "command-history",
		[";"] = "commands",
		["?"] = "helptags",
		c = "open-config",
		name = "vim",
		p = {
			U = "--update-plugin",
			d = "uninstall-plugins",
			i = "install-plugins",
			l = "list-plugins",
			name = "plugin-manager",
			p = "update-plugin-manager",
			u = "update-plugins",
		},
		q = "quit",
		d = "dashboard",
		u = "undotree",
		s = "source-config",
		t = {
			c = "autocorrect-toggle",
			d = "distraction-mode",
			f = "autoformat-toggle",
			l = "limelight",
			name = "toggles",
			p = "pencil-toggle",
			w = "autosave-toggle",
		},
	},
	w = {
		name = "windows",
		["."] = "window-mode",
		c = "close-split",
		h = "horizontal-split",
		v = "vertical-split",
		H = "empty-horizontal-split",
		V = "empty-vertical-split",
		["="] = "equalize-splits",
		m = "maximize-split",
		o = "only-split",
		g = "toggle-golden-ratio",
	},
	x = {
		name = "text",
		n = "run-unix-op",
		t = "spaces-to-tabs",
		s = "tabs-to-spaces",
		w = "strip-whitespace",
		r = "retab",
	},
	y = {
		name = "which_key_ignore",
	},
	z = {
		name = "miscelleanous",
	},
}, {
	mode = "n", -- NORMAL mode
	-- prefix: use '<leader>f' for example for mapping everything related to finding files
	-- the prefix is prepended to every mapping part of `mappings`
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = false, -- use `nowait` when creating keymaps
})
