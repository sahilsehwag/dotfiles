return {
  edit_config   = F.always('mani edit'),
  sync_projects = F.always('mani sync'),

  list_projects = F.always('mani list projects | rg -iv "project|[-].+|^$"'),
  list_tasks    = F.always('mani list tasks | rg -iv "task|[-].+|^$"'),

  get_project = function(project)
    return 'mani describe projects ' .. project .. ' | rg -v "^$"'
  end,
  get_task = function(task)
    return 'mani describe tasks ' .. task .. ' | rg -v "^$"'
  end,

  run_task = function(name)
    return 'mani run --all ' .. name
  end,
  exec_cmd = function(cmd)
    return 'mani exec ' .. cmd
  end,
}
