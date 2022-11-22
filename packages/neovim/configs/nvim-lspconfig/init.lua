-- MAPPINGS
	F.nvim.nmap('<Leader>l.s', '<cmd>LspStart<cr>')
	F.nvim.nmap('<Leader>l.r', '<cmd>LspRestart<cr>')
	F.nvim.nmap('<Leader>l.k', '<cmd>LspStop<space>')
	F.nvim.nmap('<Leader>l.i', '<cmd>LspInfo<cr>')
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

	for _, server in ipairs(SERVERS) do
		local path = vim.g.config.paths.configs .. '/nvim-lspconfig/servers' .. '/' .. server

		local on_attach = function(client, bufnr)
			require('plugins/lsp_signature').attach()

			local lsp_format_modifications = require'lsp-format-modifications'
			lsp_format_modifications.attach(client, bufnr, { format_on_save = false })
		end

		if vim.fn.filereadable(path) == 1 then
			require(path).setup({
				on_attach = on_attach,
			})
		else
			require('lspconfig')[server].setup({
				on_attach = on_attach,
      })
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
