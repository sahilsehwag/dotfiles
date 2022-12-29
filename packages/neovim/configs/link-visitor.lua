require'link-visitor'.setup()

F.vim.nmap('<Leader>fw.', '<cmd>VisitLinkInBuffer<cr>')
F.vim.nmap('<Leader>fwo', '<cmd>VisitLinkNearCursor<cr>')
F.vim.nmap('<Leader>fwO', '<cmd>VisitLinkUnderCursor<cr>')
