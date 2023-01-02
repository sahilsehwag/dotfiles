return F.pipe(
  F.rf('git_workspace.utils.get_current_workspace'),
  F.vim.cd
)
