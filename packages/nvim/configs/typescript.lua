--utils
local rootPattern = require("lspconfig").util.root_pattern

local on_attach = function(client, bufnr)
	--require("configs.lsp_signature").attach()
	require("nvim-navbuddy").attach(client, bufnr)
	require("lsp-format-modifications").attach(client, bufnr, { format_on_save = false })
end

require("typescript").setup({
	disable_commands = false, -- prevent the plugin from creating Vim commands
	debug = false, -- enable debug logging for commands
	go_to_source_definition = {
		fallback = true, -- fall back to standard LSP definition on failure
	},
	server = { -- pass options to lspconfig's setup method
		on_attach = on_attach,
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		root_dir = rootPattern("package.json", "tsconfig.json", "jsconfig.json", "node_modules", ".git"),
		-- capabilities = capabilities,
	},
})
