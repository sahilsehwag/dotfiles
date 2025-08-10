require("macrobank").setup({
	store_path_global = vim.fn.stdpath("config") .. "/tmp/macros.json",
	project_store_paths = { ".macrobank.json", ".nvim/macrobank.json" },
	default_select_register = "r",
	default_play_register = "z",
	nerd_icons = true,
	mappings = {
		open_live = "qe",
		open_bank = "q.",
	},
})
