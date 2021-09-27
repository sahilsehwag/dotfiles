--MAPPINGS
	--GOTO
		F.nvim.nmap('<Leader>lgd', '<cmd>lua vim.lsp.buf.definition()<CR>')
		F.nvim.nmap('<Leader>lgD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
		F.nvim.nmap('<Leader>lgt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
		F.nvim.nmap('<Leader>lgi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
		F.nvim.nmap('<Leader>lgr', '<cmd>lua vim.lsp.buf.references()<CR>')

		F.nvim.nmap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
		F.nvim.nmap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
		--F.nvim.nmap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
		F.nvim.nmap('gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
		F.nvim.nmap('gr', '<cmd>lua vim.lsp.buf.references()<CR>')
	--DOCUMENTATION
		F.nvim.nmap('<Leader>lhh', '<cmd>lua vim.lsp.buf.hover()<CR>')
		F.nvim.nmap('<Leader>lhs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
	--DIAGNOSTICS
		F.nvim.nmap('<Leader>leq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
		F.nvim.nmap('<Leader>lel', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
		F.nvim.nmap('[e', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
		F.nvim.nmap(']e', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
	--CODE-ACTIONS
		F.nvim.nmap('<Leader>laa', '<cmd>lua vim.lsp.buf.code_action()<CR>')
		F.nvim.nmap('<Leader>laa', '<cmd>lua vim.lsp.buf.range_code_action()<CR>')
	--SYMBOLS
		F.nvim.nmap('<Leader>lsr', '<cmd>lua vim.lsp.buf.rename()<CR>')
		F.nvim.nmap('<Leader>lsd', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
		F.nvim.nmap('<Leader>lsw', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
		F.nvim.nmap('<Leader>lsi', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
		F.nvim.nmap('<Leader>lso', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
	--FORMATTING
		F.nvim.nmap('<Leader>laf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
		F.nvim.nmap('<Leader>laf', '<cmd>lua vim.lsp.buf.range_formatting()<CR>')
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
