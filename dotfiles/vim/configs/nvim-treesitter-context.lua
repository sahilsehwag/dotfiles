require('treesitter-context.config').setup({
  enable = true,
  throttle = false,
})

vim.cmd [[ highlight! link TreesitterContext TabLine ]]

