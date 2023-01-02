local run_cmd = F.rt('mani.cmds').run_task
local get_tasks = F.rf('mani.utils.get_tasks')

local run_in_tmux_hpane = F.pipe(
  run_cmd,
  F.tmux.run_in_hpane({ autoclose = false })
)

return function()
  vim.ui.select(
    get_tasks(),
    { prompt = 'Select task to run: ' },
    F.if_else(
      F.is_nil,
      F.noop,
      F.run_in_tmux_hpane
    )
  )
end
