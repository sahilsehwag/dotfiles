--utilities
local rootPattern = require('lspconfig').util.root_pattern

return function(config)
	require('lspconfig').tsserver.setup({
		on_attach = config.on_attach,
		cmd = {
			"typescript-language-server",
			"--stdio",
		};
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		root_dir = rootPattern('jsconfig.json', 'tsconfig.json', 'package.json', 'node_modules', '.git'),
		-- capabilities = capabilities,
	})
end
