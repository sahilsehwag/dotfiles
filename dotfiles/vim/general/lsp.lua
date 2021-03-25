--MAPPINGS
	--GOTO
		vim.cmd [[ nnoremap <silent> <Leader>lgd <cmd>lua vim.lsp.buf.definition()<CR> ]]
		vim.cmd [[ nnoremap <silent> <Leader>lgD <cmd>lua vim.lsp.buf.declaration()<CR> ]]
		vim.cmd [[ nnoremap <silent> <Leader>lgt <cmd>lua vim.lsp.buf.type_definition()<CR> ]]
		vim.cmd [[ nnoremap <silent> <Leader>lgi <cmd>lua vim.lsp.buf.implementation()<CR> ]]
		vim.cmd [[ nnoremap <silent> <Leader>lgr <cmd>lua vim.lsp.buf.references()<CR> ]]

		--vim.cmd [[ nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR> ]]
		vim.cmd [[ nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR> ]]
		vim.cmd [[ nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR> ]]
	--DOCUMENTATION
		vim.cmd [[ nnoremap <silent> <Leader>lhh <cmd>lua vim.lsp.buf.hover()<CR> ]]
		vim.cmd [[ nnoremap <silent> <Leader>lhs <cmd>lua vim.lsp.buf.signature_help()<CR> ]]
	--DIAGNOSTICS
		vim.cmd [[ nnoremap <silent> <Leader>lda <cmd>lua vim.lsp.diagnostic.set_loclist()<CR> ]]
		vim.cmd [[ nnoremap <silent> <Leader>ldl <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR> ]]
		vim.cmd [[ nnoremap <silent> <Leader>ldn <cmd>lua vim.lsp.diagnostic.goto_prev()<CR> ]]
		vim.cmd [[ nnoremap <silent> <Leader>ldp <cmd>lua vim.lsp.diagnostic.goto_next()<CR> ]]
	--CODE-ACTIONS
		vim.cmd [[ nnoremap <silent> <Leader>laa <cmd>lua vim.lsp.buf.code_action()<CR> ]]
		vim.cmd [[ vnoremap <silent> <Leader>laa <cmd>lua vim.lsp.buf.range_code_action()<CR> ]]
	--SYMBOLS
		vim.cmd [[ nnoremap <silent> <Leader>lsr <cmd>lua vim.lsp.buf.rename()<CR> ]]
		vim.cmd [[ nnoremap <silent> <Leader>lsd <cmd>lua vim.lsp.buf.document_symbol()<CR> ]]
		vim.cmd [[ nnoremap <silent> <Leader>lsw <cmd>lua vim.lsp.buf.workspace_symbol()<CR> ]]
	--FORMATTING
		vim.cmd [[ nnoremap <silent> <Leader>laf <cmd>lua vim.lsp.buf.formatting()<CR> ]]
		vim.cmd [[ vnoremap <silent> <Leader>laf <cmd>lua vim.lsp.buf.range_formatting()<CR> ]]
--FORMATTING
	vim.cmd [[ autocmd BufWritePre *.js  lua vim.lsp.buf.formatting_sync(nil, 100) ]]
	vim.cmd [[ autocmd BufWritePre *.ts  lua vim.lsp.buf.formatting_sync(nil, 100) ]]
	vim.cmd [[ autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100) ]]
	vim.cmd [[ autocmd BufWritePre *.tsx lua vim.lsp.buf.formatting_sync(nil, 100) ]]
	vim.cmd [[ autocmd BufWritePre *.py  lua vim.lsp.buf.formatting_sync(nil, 100) ]]
--DIAGNOSTICS
	--SIGNS
		vim.fn.sign_define("LspDiagnosticsSignError"			 , {text = " " , texthl="JatErrorFG"		, numhl = "" , linehl = ""})
		vim.fn.sign_define("LspDiagnosticsSignWarning"		 , {text = " " , texthl="JatWarningFG" , numhl = "" , linehl = ""})
		vim.fn.sign_define("LspDiagnosticsSignInformation" , {text = " " , texthl="JatInfoFG"		, numhl = "" , linehl = ""})
		vim.fn.sign_define("LspDiagnosticsSignHint"				 , {text = " " , texthl="JatHintFG"		, numhl = "" , linehl = ""})
	--VIRTUAL-TEXT
		vim.cmd [[ highlight! link LspDiagnosticsVirtualTextError JatErrorFG ]]
		vim.cmd [[ highlight! link LspDiagnosticsVirtualTextWarning JatWarningFGFG ]]
		vim.cmd [[ highlight! link LspDiagnosticsVirtualTextInformation JatInfoFG ]]
		vim.cmd [[ highlight! link LspDiagnosticsVirtualTextHint JatHintFG ]]
