F.vim.nmap('<Leader>t;', ':tabdo norm<space>', { silent = false })
F.vim.nmap('<Leader>t:', ':tabdo<space>', { silent = false })

F.vim.nmap('<Leader>ta', ':tabnew<CR>')
F.vim.nmap('<Leader>td', ':tabclose<CR>')
F.vim.nmap('<Leader>to', ':tabonly<CR>')

--F.vim.nmap('<Leader>tn', ':tabnext<CR>')
--F.vim.nmap('<Leader>tp', ':tabprevious<CR>')
--F.vim.nmap('<Leader>tN', ':tabmove +<CR>')
--F.vim.nmap('<Leader>tP', ':tabmove -<CR>')

F.vim.nmap('<C-9>', ':tabprevious<CR>')
F.vim.nmap('<C-0>', ':tabnext<CR>')
--FIX:
--F.vim.nmap('<C-(>', ':tabmove -<CR>')
--FIX:
--F.vim.nmap('<C-)>', ':tabmove +<CR>')
F.vim.nmap('<Leader>tn', ':tabmove +<CR>')
F.vim.nmap('<Leader>tp', ':tabmove -<CR>')
