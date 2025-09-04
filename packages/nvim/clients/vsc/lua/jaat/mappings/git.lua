local vscode = require('vscode')

-- gui
vim.keymap.set('n', '<Leader>g.', function()
	vscode.action('workbench.action.terminal.newWithProfile', {
		args = {
			profileName = "lazygit",
			location = "editor"
		}
	})
end)

vim.cmd [[
	"hunks
	nnoremap <Leader>ghs <cmd>call VSCodeNotify('git.stageSelectedRanges')<CR>
	nnoremap <Leader>ghr <cmd>call VSCodeNotify('git.revertSelectedRanges')<CR>

	"diff
	nnoremap <Leader>gdp <cmd>call VSCodeNotify('git.viewChanges')<CR>
	nnoremap <Leader>gdf <cmd>call VSCodeNotify('git.openChange')<CR>

	"miscellaneous
	nnoremap <Leader>gi <cmd>call VSCodeNotify('git.ignore')<CR>

	"motions
	nnoremap [g <cmd>call VSCodeNotify('workbench.action.editor.previousChange')<CR>
	nnoremap ]g <cmd>call VSCodeNotify('workbench.action.editor.nextChange')<CR>

	"remotes
  nnoremap <Leader>grp <cmd>call VSCodeNotify('git.pull')<CR>
  nnoremap <Leader>grP <cmd>call VSCodeNotify('git.pullFrom')<CR>
  nnoremap <Leader>grr <cmd>call VSCodeNotify('git.rebase')<CR>
]]
