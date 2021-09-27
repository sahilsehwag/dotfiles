return F.pipe(
  require('mani.utils.get_current_workspace'),
  F.append('/mani.yaml'),
  F.nvim.on_select('e')
)
