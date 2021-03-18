require'nvim-treesitter.configs'.setup {
  highlight = { enable = true, },
  indent    = { enable = true, },
  rainbow   = { enable = true, },
  textobjects = {
    select = {
      enable = true,
      keymaps = { },
    },
    move = {
      enable = true,
      keymaps = { },
    },
    swap = {
      enable = true,
      keymaps = { },
    },
  },
}

vim.cmd [[set foldmethod=expr]]
vim.cmd [[set foldexpr=nvim_treesitter#foldexpr()]]
