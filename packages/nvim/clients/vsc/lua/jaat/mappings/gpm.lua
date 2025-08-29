local vscode = require('vscode')

vim.keymap.set('n', '<Leader>po', function()
	vscode.action('gitProjectManager.openProjectNewWindow')
end)

vim.keymap.set('n', '<Leader>pO', function()
	vscode.action('gitProjectManager.openProject')
end)

vim.keymap.set('n', '<Leader>pR', function()
	vscode.action('gitProjectManager.openRecents')
end)

