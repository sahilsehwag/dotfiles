require("trouble").setup({
	height = 10,
	icons = true,
	mode = "workspace",
	--fold_open = "",
	--fold_closed = "",
	action_keys = {
			close = "q",
			refresh = "r",
			jump = "<cr>",
			toggle_mode = "m",
			preview = "p",
			toggle_preview = "P",
			cancel = "<esc>",
			open_folds = "zR",
			close_folds = "zM",
			previous = "k",
			next = "j"
	},
	indent_lines = true,
	auto_open = false,
	auto_close = false,
	auto_preview = true,
	signs = {
			-- icons / text used for a diagnostic
			error = "?",
			warning = "?",
			hint = "?",
			information = "?"
	},
	use_lsp_diagnostic_signs = true,
})

--vim.cmd [[ highlight! link LspTroubleSignError JatErrorFG ]]
--vim.cmd [[ highlight! link LspTroubleSignWarning JatWarningFG ]]
--vim.cmd [[ highlight! link LspTroubleSignHint JatHintFG ]]
--vim.cmd [[ highlight! link LspTroubleSignInfo JatInfoFG ]]

vim.api.nvim_set_keymap(
	"n",
	"<Leader>ld.",
	"<cmd>LspTroubleToggle<CR>",
  {silent = true, noremap = true}
)
