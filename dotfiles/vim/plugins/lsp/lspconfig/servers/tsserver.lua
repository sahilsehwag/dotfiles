--utilities
local rootPattern = require('lspconfig').util.root_pattern

require('lspconfig').tsserver.setup({
	on_attach = function()
		require('plugins/lsp/lsp_signature').attach()
	end,
	cmd = {"typescript-language-server", "--stdio"};
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_dir = rootPattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
	--root_dir = rootPattern("node_modules", "tsconfig.json", "jsconfig.json", ".git"),
	capabilities = capabilities,
})
