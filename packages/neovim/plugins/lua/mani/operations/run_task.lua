local run_cmd = F.rt('mani.cmds').run_task
local get_tasks = F.rf('mani.utils.get_tasks')

return function()
  vim.ui.select(get_tasks(), {
    prompt = 'Select task to run: ',
  }, function(task)
    if not task then return end
    F.pipe(run_cmd, F.tmux.run_in_hpane({ autoclose = false }))(task)
  end)
end
