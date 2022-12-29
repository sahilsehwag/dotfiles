--mappings
vim.api.nvim_set_keymap('x', '<space>iu', ':lua require"treesitter-unit".select()<CR>',          {noremap=true})
vim.api.nvim_set_keymap('x', '<space>au', ':lua require"treesitter-unit".select(true)<CR>',      {noremap=true})
vim.api.nvim_set_keymap('o', '<space>iu', ':<c-u>lua require"treesitter-unit".select()<CR>',     {noremap=true})
vim.api.nvim_set_keymap('o', '<space>au', ':<c-u>lua require"treesitter-unit".select(true)<CR>', {noremap=true})

F.vim.nmap('vu', ':lua require"treesitter-unit".select()<CR>')
F.vim.nmap('du', ':lua require"treesitter-unit".delete()<CR>')
F.vim.nmap('cu', ':lua require"treesitter-unit".change()<CR>')
