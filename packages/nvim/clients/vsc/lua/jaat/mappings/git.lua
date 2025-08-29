local vscode = require('vscode')

-- branches
-- worktrees
-- remotes
-- commiting

-- gui
vim.keymap.set('n', '<Leader>g.', function()
	vscode.action('workbench.action.terminal.newWithProfile', {
		args = {
			profileName = "lazygit",
			location = "editor"
		}
	})
end)

-- staging
vim.keymap.set({ 'n', 'v' }, '<Leader>ghs', function()
	vscode.action('git.stageSelectedRanges')
end)

-- diffing
vim.keymap.set('n', '<Leader>gdp', function()
	vscode.action('git.viewChanges')
end)

vim.keymap.set('n', '<Leader>gdf', function()
	vscode.action('git.openChange')
end)

-- revert
vim.keymap.set({ 'n', 'v' }, '<Leader>ghr', function()
	vscode.action('git.revertSelectedRanges')
end)

-- miscellaneous
vim.keymap.set('n', '<Leader>gzi', function()
	vscode.action('git.ignore')
end)

-- motions
vim.keymap.set('n', '[g', function()
	vscode.action('workbench.action.editor.previousChange')
end)

vim.keymap.set('n', ']g', function()
	vscode.action('workbench.action.editor.nextChange')
end)
