require('nvim-test').setup()

F.vim.nmap('<Leader>lt.', ':TestVisit<CR>')
F.vim.nmap('<Leader>ltf', ':TestFile<CR>')
F.vim.nmap('<Leader>lts', ':TestSuite<CR>')
F.vim.nmap('<Leader>ltn', ':TestNearest<CR>')
F.vim.nmap('<Leader>ltl', ':TestLast<CR>')
