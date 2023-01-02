require('lspsaga').setup({
  beacon = {
    enable = false,
  },
  diagnostic = {
    show_code_action = false,
    extend_relatedInformation = true,
  },
})

--MAPPINGS
vim.api.nvim_set_keymap("n" , "<Leader>la." , "<cmd>Lspsaga code_action<CR>"           , { noremap = true , silent = true })
vim.api.nvim_set_keymap("v" , "<Leader>la." , "<cmd>Lspsaga range_code_action<CR>"     , { noremap = true , silent = true })
vim.api.nvim_set_keymap("s" , "<Leader>la." , "<cmd>Lspsaga range_code_action<CR>"     , { noremap = true , silent = true })

vim.api.nvim_set_keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>",      { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gP", "<cmd>Lspsaga peek_type_definition<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gr", "<cmd>Lspsaga finder<CR>",               { noremap = true, silent = true })

vim.api.nvim_set_keymap("n" , "<Leader>lsr" , "<cmd>Lspsaga rename<CR>"                , { noremap = true , silent = true })

vim.api.nvim_set_keymap("n" , "[e"          , "<cmd>Lspsaga diagnostic_jump_prev<CR>"  , { noremap = true , silent = true })
vim.api.nvim_set_keymap("n" , "]e"          , "<cmd>Lspsaga diagnostic_jump_next<CR>"  , { noremap = true , silent = true })

vim.api.nvim_set_keymap("n", "<Leader>lel", "<cmd>Lspsaga show_line_diagnostics<CR>",      { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>led", "<cmd>Lspsaga show_buf_diagnostics<CR>",       { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>lew", "<cmd>Lspsaga show_workspace_diagnostics<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n" , "K"           , "<cmd>Lspsaga hover_doc<CR>"             , { noremap = true , silent = true })
vim.api.nvim_set_keymap("n" , "<C-space>"   , "<cmd>Lspsaga signature_help<CR>"        , { noremap = true , silent = true })
vim.api.nvim_set_keymap("i" , "<C-space>"   , "<cmd>Lspsaga signature_help<CR>"        , { noremap = true , silent = true })

vim.api.nvim_set_keymap("n" , "<Leader>lgr" , "<cmd>Lspsaga lsp_finder<CR>"            , { noremap = true , silent = true })
vim.api.nvim_set_keymap("n" , "<Leader>lpd" , "<cmd>Lspsaga preview_definition<CR>"    , { noremap = true , silent = true })
vim.api.nvim_set_keymap("n" , "<Leader>lpd" , "<cmd>Lspsaga preview_definition<CR>"    , { noremap = true , silent = true })

--AUTOMATIC-SIGNATURE
--require('plugins/lsp/lspsaga/auto-signature-help')
