return function(path)
  if path then
    vim.cmd('cd ' .. path)
  end
end
