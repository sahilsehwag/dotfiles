vim.cmd [[
	autocmd filetype txt nnoremap <silent> <CR> <cmd>lua require'expand_expr'.expand()<CR>
]]
