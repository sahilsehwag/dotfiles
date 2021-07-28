-- MAPPINGS
	vim.cmd [[ nnoremap <silent> <Leader>l.s <cmd>LspStart<cr> ]]
	vim.cmd [[ nnoremap <silent> <Leader>l.r <cmd>LspRestart<cr> ]]
	vim.cmd [[ nnoremap <silent> <Leader>l.k <cmd>LspStop<space> ]]
	vim.cmd [[ nnoremap <silent> <Leader>l.i <cmd>LspInfo<cr> ]]
-- SERVERS
	local SERVERS = {
		--'efm',
		--'diagnosticls',
		--'codeqlls',

		--'vimls',
		--'sumneko_lua',
		--'pyright',
		--'jedi_language_server',
		--'pyls',
		--'pyls_ms',

		--'html',
		--'cssls',
		--'eslintls',
		'tsserver',
		--'denols',
		--'flow',
		--'rome',
		--'vuels',
		--'svelte',
		--'angularls',

		--'hls',
		--'fsautocomplete',
		--'elmls',
		--'nimls',
		--'clojure_lsp',
		--'purescriptls',
		--'ocamlls',
		--'ocamllsp',
		--'elixirls',
		--'erlangls',
		--'groovyls',

		--'ccls',
		--'clangd',
		--'gopls',
		--'rust_analyzer',
		--'rls',
		--'sourcekit',

		--'solargraph',
		--'sorbet',
		--'perlls',

		--'jdtls',
		--'metals',
		--'omnisharp',
		--'kotlin_language_server',

		--'r_language_server',

		--'sqlls',
		--'graphql',
		--'bashls',
		--'rnix',
		--'jsonls',
		--'yamlls',
		--'cmake',
		--'dockerls',
		--'terraformls',
		--'texlab',
		--'dhall_lsp_server',

		--error
		-- 'dartls',
		--'haxe_language_server',
		--'julials',
		--'scry',
	}

	for _,server in ipairs(SERVERS) do
		local path = vim.g.config.paths.configs .. '/nvim-lspconfig/servers' .. '/' .. server

		if vim.fn.filereadable(path) == 1 then
			require(path)
			-- require('lspconfig')[server].setup(require(path))
		else
			require('lspconfig')[server].setup({})
		end
	end
-- MESS
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			'documentation',
			'detail',
			'additionalTextEdits',
		}
	}
