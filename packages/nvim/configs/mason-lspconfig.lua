require('mason-lspconfig').setup({
	ensure_installed = {
		'vimls',
		'lua_ls',

		'html',
		'cssls',
		'eslint',
		'ts_ls',

		'protols',

		'sqlls',
		'bashls',
		'jsonls',
		'yamlls',
		'dockerls',
		'lemminx',
	},
})

--automatic setup (when no manual initialization using lsp-config)
--:h mason-lspconfig-automatic-server-setup
