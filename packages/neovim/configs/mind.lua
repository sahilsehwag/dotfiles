require'mind'.setup()

F.nvim.nmap('<leader>no', '<cmd>MindOpenMain<cr>')
F.nvim.nmap('<leader>np', '<cmd>MindOpenProject<cr>')
F.nvim.nmap('<leader>nc', '<cmd>MindClose<cr>')

--vim.cmd [[
--  augroup Mind
--    autocmd! Mind
--    autocmd FileType mind set norelativenumber
--    autocmd FileType mind set nonumber
--  augroup end
--]]
