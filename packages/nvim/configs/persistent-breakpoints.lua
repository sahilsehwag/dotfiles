require("persistent-breakpoints").setup({
	load_breakpoints_event = {
		"BufReadPost",
	},
})

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Save breakpoints to file automatically.
keymap("n", "<Leader>lbb", "<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>", opts)
keymap("n", "<Leader>lbc", "<cmd>lua require('persistent-breakpoints.api').set_conditional_breakpoint(vim.fn.input('Condition :> '))<cr>", opts)
keymap("n", "<Leader>lbC", "<cmd>lua require('persistent-breakpoints.api').clear_all_breakpoints()<cr>", opts)
