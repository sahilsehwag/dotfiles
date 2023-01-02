require("tabscope").setup({})

-- To remove tab local buffer, use remove_tab_buffer:
vim.keymap.set("n", "<C-S-d>", require("tabscope").remove_tab_buffer)
