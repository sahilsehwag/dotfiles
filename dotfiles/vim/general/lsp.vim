"AUTOCOMMANDS
autocmd BufWritePre *.js  lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.ts  lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.tsx lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.py  lua vim.lsp.buf.formatting_sync(nil, 100)

"MAPPINGS
"GOTO
nnoremap <silent> <Leader>lgd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <Leader>lgD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <Leader>lgt <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <Leader>lgi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <Leader>lgr <cmd>lua vim.lsp.buf.references()<CR>

nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>

"DOCUMENTATION
nnoremap <silent> <Leader>lhh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <Leader>lhs <cmd>lua vim.lsp.buf.signature_help()<CR>

"DIAGNOSTICS
nnoremap <silent> <Leader>ldd <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> <Leader>ldl <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> <Leader>ldn <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <Leader>ldp <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

"CODE-ACTIONS
nnoremap <silent> <Leader>laa <cmd>lua vim.lsp.buf.code_action()<CR>
vnoremap <silent> <Leader>laa <cmd>lua vim.lsp.buf.range_code_action()<CR>

"SYMBOLS
nnoremap <silent> <Leader>lsr <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <Leader>lsd <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> <Leader>lsw <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

"FORMATTING
nnoremap <silent> <Leader>laf <cmd>lua vim.lsp.buf.formatting()<CR>
vnoremap <silent> <Leader>laf <cmd>lua vim.lsp.buf.range_formatting()<CR>

