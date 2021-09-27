--utilities
local rootPattern = require('lspconfig').util.root_pattern

require('lspconfig').tsserver.setup({
	on_attach = function()
		require('plugins/lsp_signature').attach()
	end,
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
