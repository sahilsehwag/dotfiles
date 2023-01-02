require'mind'.setup()

F.vim.nmap('<leader>no', '<cmd>MindOpenMain<cr>')
F.vim.nmap('<leader>np', '<cmd>MindOpenProject<cr>')
F.vim.nmap('<leader>nc', '<cmd>MindClose<cr>')

--vim.cmd [[
--  augroup Mind
--    autocmd! Mind
--    autocmd FileType mind set norelativenumber
--    autocmd FileType mind set nonumber
--  augroup end
--]]
