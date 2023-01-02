require("gitsigns").setup({
	signs = {
		-- add          = {text = ' █'},
		-- change       = {text = ' █'},
		-- delete       = {text = ' '},
		-- topdelete    = {text = ' '},

		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "▎" },
		topdelete = { text = "▎" },
		changedelete = { text = "~" },
		--untracked = { text = "" },

		-- add          = {text = '▋'},
		-- change       = {text = '▋'},
		-- delete       = {text = '▋'},
		-- topdelete    = {text = '▋'},
		-- changedelete = {text = '~'},
	},
	signs_staged_enable = false,
	signs_staged = {
		-- add          = {text = ' █', },
		-- change       = {text = ' █', FG'},
		-- delete       = {text = ' ', FG'},
		-- topdelete    = {text = ' ', FG'},

		add = { hl = "JatAddFG", text = "▎", linehl = "JatAddFG" },
		change = { hl = "JatChangeFG", text = "▎", linehl = "JatChangeFG" },
		delete = { hl = "JatDeleteFG", text = "▎", linehl = "JatDeleteFG" },
		topdelete = { hl = "JatDeleteFG", text = "▎", linehl = "JatDeleteFG" },
		changedelete = { hl = "JatChangeDeleteFG", text = "~", linehl = "JatChangeDeleteFG" },
		--untracked = { hl = "", text = "", numhl = "", linehl = "" },

		-- add          = {hl = 'JatAddFG',          text = '▋', numhl='', linehl='JatAddFG'},
		-- change       = {hl = 'JatChangeFG',       text = '▋', numhl='', linehl='JatChangeFG'},
		-- delete       = {hl = 'JatDeleteFG',       text = '▋', numhl='', linehl='JatDeleteFG'},
		-- topdelete    = {hl = 'JatDeleteFG',       text = '▋', numhl='', linehl='JatDeleteFG'},
		-- changedelete = {hl = 'JatChangeDeleteFG', text = '~', numhl='', linehl='JatChangeDeleteFG'},
	},
	numhl = false,
	linehl = false,
	word_diff = true, -- Toggle with `:Gitsigns toggle_word_diff`
  auto_attach = true,
	attach_to_untracked = true,
	preview_config = {
		-- Options passed to nvim_open_win
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
	watch_gitdir = {
		follow_files = true,
		interval = 1000,
	},
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	diff_opts = {
		internal = true,
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]g", function()
			if vim.wo.diff then
				return "]g"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		map("n", "[g", function()
			if vim.wo.diff then
				return "[g"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		-- Actions
		map("n", "<leader>ghs", gs.stage_hunk)
		map("n", "<leader>ghr", gs.reset_hunk)

		map("v", "<leader>ghs", function()
			gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)
		map("v", "<leader>ghr", function()
			gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)

		map("n", "<leader>ghS", gs.stage_buffer)
		map("n", "<leader>ghR", gs.reset_buffer)

		map("n", "<leader>ghu", gs.undo_stage_hunk)

		map("n", "<leader>ghp", gs.preview_hunk)

		map("n", "<leader>gb", function()
			gs.blame_line({ full = true })
		end)
		--map("n", "<leader>gB", gs.toggle_current_line_blame)

		map("n", "<leader>ghd", gs.diffthis)
		map("n", "<leader>ghD", function()
			gs.diffthis("~")
		end)

		--map("n", "<leader>td", gs.toggle_deleted)

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})


vim.api.nvim_set_hl(0, 'GitSignsAdd',            { link = 'JatAddFG' })
vim.api.nvim_set_hl(0, 'GitSignsAddLn',          { link = 'JatAddFG' })
vim.api.nvim_set_hl(0, 'GitSignsChange',         { link = 'JatChangeFG' })
vim.api.nvim_set_hl(0, 'GitSignsChangeLn',       { link = 'JatChangeFG' })
vim.api.nvim_set_hl(0, 'GitSignsChangedelete',   { link = 'JatChangeDeleteFG' })
vim.api.nvim_set_hl(0, 'GitSignsChangedeleteLn', { link = 'JatChangeDeleteFG' })
vim.api.nvim_set_hl(0, 'GitSignsChangedeleteLn', { link = 'JatChangeDeleteFG' })
vim.api.nvim_set_hl(0, 'GitSignsDelete',         { link = 'JatDeleteFG' })
vim.api.nvim_set_hl(0, 'GitSignsDeleteLn',       { link = 'JatDeleteFG' })
vim.api.nvim_set_hl(0, 'GitSignsTopdelete',      { link = 'JatDeleteFG' })
vim.api.nvim_set_hl(0, 'GitSignsTopdeleteLn',    { link = 'JatDeleteFG' })
