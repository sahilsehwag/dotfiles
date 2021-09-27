require'window-picker'.setup()
F.nvim.nmap('<leader>wp', '<cmd>lua require("window-picker").pick_window()<cr>')
