return function()
  return F.any({
    vim.fn.has('unix'),
    vim.fn.has('mac'),
    vim.fn.has('macunix'),
    vim.fn.has('linux'),
    vim.fn.has('win32unix'),
  })
end
