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

	"remotes
  "nnoremap <Leader>grp <cmd>call VSCodeNotify('git.pull')<CR>
  "nnoremap <Leader>grP <cmd>call VSCodeNotify('git.pullFrom')<CR>
  nnoremap <Leader>grp <cmd>call VSCodeNotify('git.pullRebase')<CR>
  nnoremap <Leader>grP <cmd>call VSCodeNotify('git.rebase')<CR>

  nnoremap <Leader>grr <cmd>call VSCodeNotify('git.rebase')<CR>
	nnoremap <Leader>grR <cmd>call VSCodeNotify('git.syncRebase')<CR>

  nnoremap <Leader>grm <cmd>call VSCodeNotify('git.merge')<CR>

	"commit
  nnoremap <Leader>gcu <cmd>call VSCodeNotify('git.undoCommit')<CR>

  nnoremap <Leader>gcc <cmd>call VSCodeNotify('git.commit')<CR>
  nnoremap <Leader>gcC <cmd>call VSCodeNotify('git.commitAmend')<CR>

  nnoremap <Leader>gcs <cmd>call VSCodeNotify('git.commitStaged')<CR>
  nnoremap <Leader>gcS <cmd>call VSCodeNotify('git.commitStagedAmend')<CR>

  nnoremap <Leader>gca <cmd>call VSCodeNotify('git.commitAll')<CR>
  nnoremap <Leader>gcA <cmd>call VSCodeNotify('git.commitAllAmend')<CR>

	"stash
  nnoremap <Leader>gsn <cmd>call VSCodeNotify('git.stash')<CR>

	"branches
  nnoremap <Leader>gbc <cmd>call VSCodeNotify('git.checkout')<CR>
  nnoremap <Leader>gbC <cmd>call VSCodeNotify('git.checkoutDetached')<CR>

  nnoremap <Leader>gbn <cmd>call VSCodeNotify('git.branch')<CR>
  nnoremap <Leader>gbN <cmd>call VSCodeNotify('git.branchFrom')<CR>

  nnoremap <Leader>gbd <cmd>call VSCodeNotify('git.deleteBranch')<CR>
  nnoremap <Leader>gbD <cmd>call VSCodeNotify('git.deleteRemoteBranch')<CR>

  nnoremap <Leader>gbr <cmd>call VSCodeNotify('git.renameBranch')<CR>

  nnoremap <Leader>gbp <cmd>call VSCodeNotify('git.publishBranch')<CR>

	"motions
	nnoremap [g <cmd>call VSCodeNotify('workbench.action.editor.previousChange')<CR>
	nnoremap ]g <cmd>call VSCodeNotify('workbench.action.editor.nextChange')<CR>

	"miscellaneous
	nnoremap <Leader>gi <cmd>call VSCodeNotify('git.ignore')<CR>
]]
