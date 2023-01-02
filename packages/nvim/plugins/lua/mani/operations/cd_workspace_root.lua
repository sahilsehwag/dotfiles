return F.pipe(
  F.rf('mani.utils.get_current_workspace'),
  F.vim.cd
)
