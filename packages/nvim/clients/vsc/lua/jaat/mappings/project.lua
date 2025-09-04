local vscode = require('vscode')

vim.cmd [[
  nnoremap <Leader>pr <CMD>call VSCodeNotify('workbench.action.openRecent')<CR>
  nnoremap <Leader>pt <CMD>call VSCodeNotify('workbench.view.explorer')<CR>
]]

vim.keymap.set('n', '<Leader>pe', function()
	vscode.action('workbench.action.terminal.newWithProfile', {
		args = {
			profileName = "vifm",
			location = "editor"
		}
	})
end)
