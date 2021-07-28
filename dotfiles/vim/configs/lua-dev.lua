local luadev = require('lua-dev').setup({
	lspconfig = {
		on_attach = function()
			require('plugins/lsp/lsp_signature').attach()
		end,
	},
})

require('lspconfig').sumneko_lua.setup(luadev)
