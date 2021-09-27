require'link-visitor'.setup()

F.nvim.nmap('<Leader>fw.', '<cmd>VisitLinkInBuffer<cr>')
F.nvim.nmap('<Leader>fwo', '<cmd>VisitLinkNearCursor<cr>')
F.nvim.nmap('<Leader>fwO', '<cmd>VisitLinkUnderCursor<cr>')
