return {
	config = {
		filetypes = {
			'javascript',
			'javascriptreact',
			'javascript.jsx',
			'typescript',
			'typescriptreact',
			'typescript.tsx',
		},
		init_options = {
			maxTsServerMemory = 16384, -- MB; raised for large monorepos (default ~3072)
		},
	},
	on_attach = function(client, bufnr)
		local lsp_fmt = require 'lsp-format-modifications'
		lsp_fmt.attach(client, bufnr, { format_on_save = false })
	end,
}
