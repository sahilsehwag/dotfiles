--vim.api.nvim_set_keymap('n', 'o', 'o<cmd>lua require("smart-cursor").indent_cursor()<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', 'o', 'ox<BS><cmd>lua require("smart-cursor").indent_cursor()<CR>', {silent = true, noremap = true})
