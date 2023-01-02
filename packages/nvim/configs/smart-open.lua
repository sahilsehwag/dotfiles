require'telescope'.load_extension('smart_open')

vim.api.nvim_set_keymap(
  'n',
  '<C-R>',
  '<Cmd>lua require("telescope").extensions.smart_open.smart_open()<CR>',
  {noremap = true, silent = true}
)
