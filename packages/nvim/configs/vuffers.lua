require("vuffers").setup({
	debug = {
		enabled = true,
		level = "error", -- "error" | "warn" | "info" | "debug" | "trace"
	},
	exclude = {
		-- do not show them on the vuffers list
		filenames = { "term://" },
		filetypes = { "lazygit", "NvimTree", "qf" },
	},
	handlers = {
		-- when deleting a buffer via vuffers list (by default triggered by "d" key)
		on_delete_buffer = function(bufnr)
			vim.api.nvim_command(":bwipeout " .. bufnr)
		end,
	},
	keymaps = {
		use_default = true,
		-- key maps on the vuffers list
		view = {
			open = "<CR>",
			delete = "d",
			pin = "p",
			unpin = "P",
			rename = "r",
			reset_custom_display_name = "R",
			reset_custom_display_names = "<leader>R",
		},
	},
	sort = {
		type = "none", -- "none" | "filename"
		direction = "asc", -- "asc" | "desc"
	},
	view = {
		modified_icon = "󰛿", -- when a buffer is modified, this icon will be shown
		pinned_icon = "󰐾",
		window = {
			auto_resize = false,
			width = 35,
			focus_on_open = false,
		},
	},
})
