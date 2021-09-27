require('litee.lib').setup()
require('litee.gh').setup({
	-- the icon set to use from litee.nvim.
	-- "nerd", "codicons", "default"
	icon_set    = "codicons",
	-- deprecated, around for compatability for now.
	jump_mode   = "invoking",
	-- remap the arrow keys to resize any litee.nvim windows.
	map_resize_keys = false,
	-- do not map any keys inside any gh.nvim buffers.
	disable_keymaps = false,
	-- defines keymaps in gh.nvim buffers.
	keymaps = {
		-- used to open a node in a gh.nvim tree
		open = "<CR>",
		-- expand a node in a gh.nvim tree
		expand = "zo",
		-- collapse the node in a gh.nvim tree
		collapse = "zc",
		-- when cursor is ontop of a '#123' formatted issue reference, open a
		-- new tab with the issue details and comments.
		goto_issue = "gd",
		-- show details associated with a node, for example the commit message
		-- for a commit node in the gh.nvim tree.
		details = "d"
	},
})

vim.cmd("FzfLua register_ui_select")

require'which-key'.register({
	G = {
		name = "+git-client",
		['.'] = {'<cmd>GH<cr>', "operations"},
		c = {
			name = "+Commits",
			c = { "<cmd>GHCloseCommit<cr>", "Close" },
			e = { "<cmd>GHExpandCommit<cr>", "Expand" },
			o = { "<cmd>GHOpenToCommit<cr>", "Open To" },
			p = { "<cmd>GHPopOutCommit<cr>", "Pop Out" },
			z = { "<cmd>GHCollapseCommit<cr>", "Collapse" },
		},
		i = {
			name = "+Issues",
			p = { "<cmd>GHPreviewIssue<cr>", "Preview" },
		},
		l = {
			name = "+Litee",
			t = { "<cmd>LTPanel<cr>", "Toggle Panel" },
		},
		r = {
			name = "+Review",
			b = { "<cmd>GHStartReview<cr>", "Begin" },
			c = { "<cmd>GHCloseReview<cr>", "Close" },
			d = { "<cmd>GHDeleteReview<cr>", "Delete" },
			e = { "<cmd>GHExpandReview<cr>", "Expand" },
			s = { "<cmd>GHSubmitReview<cr>", "Submit" },
			z = { "<cmd>GHCollapseReview<cr>", "Collapse" },
		},
		p = {
			name = "+Pull Request",
			c = { "<cmd>GHClosePR<cr>", "Close" },
			d = { "<cmd>GHPRDetails<cr>", "Details" },
			e = { "<cmd>GHExpandPR<cr>", "Expand" },
			o = { "<cmd>GHOpenPR<cr>", "Open" },
			p = { "<cmd>GHPopOutPR<cr>", "PopOut" },
			r = { "<cmd>GHRefreshPR<cr>", "Refresh" },
			t = { "<cmd>GHOpenToPR<cr>", "Open To" },
			z = { "<cmd>GHCollapsePR<cr>", "Collapse" },
		},
		t = {
			name = "+Threads",
			c = { "<cmd>GHCreateThread<cr>", "Create" },
			n = { "<cmd>GHNextThread<cr>", "Next" },
			t = { "<cmd>GHToggleThread<cr>", "Toggle" },
		},
	},
}, { prefix = "<leader>" })
