require("mason-null-ls").setup({
	ensure_installed = {
		'shfmt',
		'shellcheck',
	},
	automatic_installation = true,
	handlers = {},
})
