--mappings
vim.api.nvim_set_keymap('n', 'vx', ':lua require"treesitter-unit".select()<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', 'dx', ':lua require"treesitter-unit".delete()<CR>', {noremap=true})
vim.api.nvim_set_keymap('n', 'cx', ':lua require"treesitter-unit".change()<CR>', {noremap=true})
