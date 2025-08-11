require("macrobank").setup({
	store_path_global = vim.fn.stdpath("config") .. "/tmp/macros.json",
	project_store_paths = { ".nvim/macrobank.json", ".macrobank.json" },
	default_select_register = "r",
	default_play_register = "z",
	nerd_icons = true,
})

vim.keymap.set('n', 'qe', ':MacroBankLive<CR>', { desc = '[Macrobank]: Edit macros' })
vim.keymap.set('n', 'q.', ':MacroBank<CR>', { desc = '[MacroBank] Edit saved macros' })
