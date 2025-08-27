vim.cmd [[
	nnoremap gS <CMD>call VSCodeNotify('splitjoin-vscode.split')<CR>
	nnoremap gJ <CMD>call VSCodeNotify('splitjoin-vscode.join')<CR>
	nnoremap gT <CMD>call VSCodeNotify('splitjoin-vscode.toggle')<CR>
]]
