return F.pipe(
  require('mani.utils.get_current_workspace'),
  F.append('/mani.yaml'),
  F.vim.on_select('e')
)
