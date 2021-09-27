local vim, fn = vim, vim.fn
local concat = require('libs.utils').table.list.concat

local COMMANDS = {
}

local split_output = F.pipe(
  F.append_to({ 'cd', F.git.get_root(), '&&' }),
  F.join(' '),
  F.sh.run_and_split
)

local should_insert = function(scope, workspace, current_workspace)
  return F.any({
    scope == nil,
    scope == 'project',
    workspace == current_workspace,
  })
end

local get_current_workspace = function(from_buffer)
  local cmd = 'npm root'

  if from_buffer then
    cmd = 'cd ' .. vim.fn.expand('%:p:h') .. ' && ' .. cmd
  end

  local workspace = fn.fnamemodify(F.sh.run(cmd), ':h')

  return split_output('cat ' .. workspace .. '/package.json | jq ".name" -r')[1]
end

local generate_script_options = F.curry(function(scope, workspace_x_scripts)
  local options = {}
  local current_workspace = get_current_workspace(scope == 'buffer')

  for workspace in pairs(workspace_x_scripts) do
    for i, script in ipairs(workspace_x_scripts[workspace].scripts) do
      local name = workspace_x_scripts[workspace].name
      local command = workspace_x_scripts[workspace].commands[i]

      if should_insert(scope, name, current_workspace) then
        table.insert(options, {
          location = workspace,
          name     = name,
          script   = script,
          command  = command,
        })
      end
    end
  end

  return options
end)

local generate_workspace_options = function(workspace_x_scripts)
  local options = {}
  for workspace in pairs(workspace_x_scripts) do
    table.insert(options, {
      name     = workspace_x_scripts[workspace].name,
      location = workspace,
    })
  end
  return options
end

local get_scripts = function()
  local cmd = (
    string.match(F.sh.run('yarn -v'), '^2')
      and 'yarn workspaces list | tail -n +2 | tail -r | tail -n +2 | tail -r | sed "s/: /\\n/g" | sed "/YN/ d"'
      or 'yarn workspaces info | tail -n +2 | tail -r | tail -n +2 | tail -r | jq ".[].location" -r'
  )
  local workspaces = F.concat({'.'}, split_output(cmd))

  local workspace_x_scripts = {}
  for _, workspace in ipairs(workspaces or {}) do
    workspace_x_scripts[workspace] = {
      location = workspace,
      name     = split_output('cat ' .. workspace .. '/package.json | jq ".name" -r')[1],
      scripts  = split_output('cat ' .. workspace .. '/package.json | jq ".scripts" | sed "/^null$/d" | jq "keys | .[]" -r'),
      --commands = split_output('cat ' .. workspace .. '/package.json | jq ".scripts" | sed "/^null$/d" | jq ".[]" -r'),
      commands = ""
    }
  end

  return workspace_x_scripts
end

local render_run_scripts = function(options)
  vim.ui.select(options, {
    prompt = 'Run npm script: ',
    format_item = function(option)
      return '[' .. option.name .. '] ' .. option.script
    end,
  }, function(option)
      if option then
        vim.fn.execute('T lh.h20% yarn workspace ' .. option.name .. ' ' .. option.script)
      end
  end)
end

local render_switch_workspace = function(options)
  vim.ui.select(options, {
    prompt = 'Switch workspace: ',
    format_item = function(option)
      return option.location
    end,
  }, function(option)
      if option then
        vim.fn.execute('cd ' .. F.git.get_root() .. '/' .. option.location)
        vim.notify('Switched to ' .. option.location)
      end
  end)
end

return {
  is_installed = function()
    return fn.executable('yarn')
  end,
  run_script = function(scope)
    F.pipe(
      get_scripts,
      generate_script_options(scope),
      render_run_scripts
    )()
  end,
  switch_workspace = function()
    F.pipe(
      get_scripts,
      generate_workspace_options,
      render_switch_workspace
    )()
  end,
}
