--utilities
local rootPattern = require('lspconfig').util.root_pattern

--constants
local ROOT_PATH = 'plugins/lsp/lspconfig'
local SERVERS_PATH = ROOT_PATH .. '/servers'

local SERVERS = {
	--'efm',
	--'diagnosticls',
	--'codeqlls',

	'vimls',
	--'sumneko_lua',
	'pyright',
	--'jedi_language_server',
	--'pyls',
	--'pyls_ms',

	'html',
	'cssls',
	'tsserver',
	--'denols',
	--'flow',
	--'rome',
	'vuels',
	'svelte',
	'angularls',

	'hls',
	'fsautocomplete',
	'elmls',
	'nimls',
	'clojure_lsp',
	'purescriptls',
	'ocamlls',
	'ocamllsp',
	'elixirls',
	'erlangls',
	'groovyls',

	'ccls',
	'clangd',
	'gopls',
	'rust_analyzer',
	--'rls',
	'sourcekit',

	'solargraph',
	--'sorbet',
	'perlls',

	'jdtls',
	'metals',
	'omnisharp',
	'kotlin_langauge_server',

	'r_language_server',

	'sqlls',
	'graphql',
	'bashls',
	'rnix',
	'jsonls',
	'yamlls',
	'cmake',
	'dockerls',
	'terraformls',
	'texlab',
	'dhall_lsp_server',

	'dartls',
	'haxe_language_server',
	'julials',
	'scry',
}

for i,server in ipairs(SERVERS) do
	require(SERVERS_PATH .. '/' .. server)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		'documentation',
		'detail',
		'additionalTextEdits',
	}
}

