--MAPPINGS
	--GOTO
		F.nvim.nmap('<Leader>lgd', vim.lsp.buf.definition)
		F.nvim.nmap('<Leader>lgD', vim.lsp.buf.declaration)
		F.nvim.nmap('<Leader>lgt', vim.lsp.buf.type_definition)
		F.nvim.nmap('<Leader>lgi', vim.lsp.buf.implementation)
		F.nvim.nmap('<Leader>lgr', vim.lsp.buf.references)

		F.nvim.nmap('gd', vim.lsp.buf.definition)
		F.nvim.nmap('gD', vim.lsp.buf.declaration)
		F.nvim.nmap('gi', vim.lsp.buf.implementation)
		F.nvim.nmap('gt', vim.lsp.buf.type_definition)
		F.nvim.nmap('gr', vim.lsp.buf.references)
	--DOCUMENTATION
		F.nvim.nmap('<Leader>lhh', vim.lsp.buf.hover)
		F.nvim.nmap('<Leader>lhs', vim.lsp.buf.signature_help)
	--DIAGNOSTICS
		F.nvim.nmap('<Leader>leq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
		F.nvim.nmap('<Leader>lel', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
		F.nvim.nmap('[e', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
		F.nvim.nmap(']e', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
	--CODE-ACTIONS
		F.nvim.nmap('<Leader>laa', vim.lsp.buf.code_action)
		F.nvim.nmap('<Leader>laa', vim.lsp.buf.range_code_action)
	--SYMBOLS
		F.nvim.nmap('<Leader>lsr', vim.lsp.buf.rename)
		F.nvim.nmap('<Leader>lsd', vim.lsp.buf.document_symbol)
		F.nvim.nmap('<Leader>lsw', vim.lsp.buf.workspace_symbol)
		F.nvim.nmap('<Leader>lsi', vim.lsp.buf.incoming_calls)
		F.nvim.nmap('<Leader>lso', vim.lsp.buf.outgoing_calls)
	--FORMATTING
		F.nvim.nmap('<Leader>laf', vim.lsp.buf.formatting)
		F.nvim.nmap('<Leader>laf', vim.lsp.buf.range_formatting)
--FORMATTING
	--vim.cmd [[ autocmd BufWritePre *.js  lua vim.lsp.buf.formatting_sync(nil, 100) ]]
	--vim.cmd [[ autocmd BufWritePre *.ts  lua vim.lsp.buf.formatting_sync(nil, 100) ]]
	--vim.cmd [[ autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100) ]]
	--vim.cmd [[ autocmd BufWritePre *.tsx lua vim.lsp.buf.formatting_sync(nil, 100) ]]
	--vim.cmd [[ autocmd BufWritePre *.py  lua vim.lsp.buf.formatting_sync(nil, 100) ]]

	--to apply all servers sequentially in case of multiple servers
	vim.cmd [[ autocmd BufWritePre *.py  lua vim.lsp.buf.formatting_seq_sync(nil, 100) ]]
--DIAGNOSTICS
	--HANDLERS
		--vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
		--  vim.lsp.diagnostic.on_publish_diagnostics, {
		--    virtual_text = false,
		--    --virtual_text = {
		--    --  prefix = "◼",
		--    --  spacing = 4,
		--    --  severity = '',
		--    --},
		--    signs = true,
		--    underline = true,
		--    update_in_insert = false,
		--    severity_sort = false,
		--  }
		--)
	--DIAGNOSTICS
	--SIGNS
		vim.fn.sign_define('DiagnosticSignError', {
			--✖,
			text = '',
			texthl = 'JatErrorFG',
			numhl = 'JatErrorFG',
			--linehl = 'JatErrorBGTransparent',
		})
		vim.fn.sign_define('DiagnosticSignWarn', {
			-- ,
			text = '',
			texthl = 'JatWarningFG',
			numhl = 'JatWarningFG',
			--linehl = 'JatWarningBGTransparent',
		})
		vim.fn.sign_define('DiagnosticSignInfo', {
			-- ,
			text = '',
			texthl = 'JatInfoFG',
			numhl = 'JatInfoFG',
			--linehl = 'JatInfoBGTransparent',
		})
		vim.fn.sign_define('DiagnosticSignHint', {
			-- ,
			text = '',
			texthl = 'JatHintFG',
			numhl = 'JatHintFG',
			--linehl = 'JatHintBGTransparent',
		})
	--VIRTUAL-TEXT
		vim.cmd [[ highlight! link LspDiagnosticsVirtualTextError JatErrorFG ]]
		vim.cmd [[ highlight! link LspDiagnosticsVirtualTextWarning JatWarningFG ]]
		vim.cmd [[ highlight! link LspDiagnosticsVirtualTextInformation JatInfoFG ]]
		vim.cmd [[ highlight! link LspDiagnosticsVirtualTextHint JatHintFG ]]

		vim.cmd [[ highlight! link LspDiagnosticsVirtualTextError NonText ]]
		vim.cmd [[ highlight! link LspDiagnosticsVirtualTextWarning NonText ]]
		vim.cmd [[ highlight! link LspDiagnosticsVirtualTextInformation NonText ]]
		vim.cmd [[ highlight! link LspDiagnosticsVirtualTextHint NonText ]]
	--UNDERLINE
	--FLOATING
