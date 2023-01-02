require("buffer_manager").setup({ })

F.vim.nmap('<Leader>bl', require("buffer_manager.ui").toggle_quick_menu)
