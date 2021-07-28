
--MAPPINGS
vim.api.nvim_set_keymap("n" , "<Leader>la." , "<cmd>Lspsaga code_action<CR>"           , { noremap = true , silent = true })
vim.api.nvim_set_keymap("v" , "<Leader>la." , "<cmd>Lspsaga range_code_action<CR>"     , { noremap = true , silent = true })

vim.api.nvim_set_keymap("n" , "<Leader>lsr" , "<cmd>Lspsaga rename<CR>"                , { noremap = true , silent = true })

vim.api.nvim_set_keymap("n" , "[e"          , "<cmd>Lspsaga diagnostic_jump_prev<CR>"  , { noremap = true , silent = true })
vim.api.nvim_set_keymap("n" , "]e"          , "<cmd>Lspsaga diagnostic_jump_next<CR>"  , { noremap = true , silent = true })
vim.api.nvim_set_keymap("n" , "<Leader>ldl" , "<cmd>Lspsaga show_line_diagnostics<CR>" , { noremap = true , silent = true })

vim.api.nvim_set_keymap("n" , "K"           , "<cmd>Lspsaga hover_doc<CR>"             , { noremap = true , silent = true })
vim.api.nvim_set_keymap("n" , "<C-space>"   , "<cmd>Lspsaga signature_help<CR>"        , { noremap = true , silent = true })
vim.api.nvim_set_keymap("i" , "<C-space>"   , "<cmd>Lspsaga signature_help<CR>"        , { noremap = true , silent = true })

vim.api.nvim_set_keymap("n" , "<Leader>lgr" , "<cmd>Lspsaga lsp_finder<CR>"            , { noremap = true , silent = true })
vim.api.nvim_set_keymap("n" , "<Leader>lgp" , "<cmd>Lspsaga preview_definition<CR>"    , { noremap = true , silent = true })

--AUTOMATIC-SIGNATURE
--require('plugins/lsp/lspsaga/auto-signature-help')
