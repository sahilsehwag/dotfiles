local is_TS = Funk.match
local is_installed = Funk.complement(Funk.match)('not installed')

local is_TS_and_installed = Funk.all_pass(is_TS, is_installed)

-- FIX:
return function(ts)
  return Funk.pipe(
    vim.api.nvim_command_output,
    Funk.split('\n'),
    Funk.filter(Funk.match(ts)),
    Funk.filter(is_installed),
    --Funk.filter(is_TS_and_installed(ts)),
    Funk.is_not_empty
  )('TSInstallInfo')
end
