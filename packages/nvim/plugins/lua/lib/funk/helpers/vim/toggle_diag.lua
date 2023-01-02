local flag = true
return function()
  flag = not flag
  if flag then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end
