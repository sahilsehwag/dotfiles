F.vim.nmap('<Leader>b;', ':bufdo norm<space>', { silent = false })
F.vim.nmap('<Leader>b:', ':bufdo<space>',      { silent = false })

F.vim.nmap('<Leader>ban', ':enew<CR>')
F.vim.nmap('<Leader>bas', ':call ScratchBuffer("e")<CR>')
F.vim.nmap('<Leader>baS', ':call ScratchBuffer("e", 1)<CR>')

F.vim.nmap('<Leader>bcc', ':bprevious<bar>split<bar>bnext<bar>bdelete<CR>')
F.vim.nmap('<Leader>bcC', ':bprevious<bar>split<bar>bnext<bar>bdelete!<CR>')
--F.vim.nmap('<Leader>bca', ':bufdo bp<bar>sp<bar>bn<bar>bd<CR>')
--F.vim.nmap('<Leader>bcA', ':bufdo bp<bar>sp<bar>bn<bar>bd!<CR>')
--F.vim.nmap('<Leader>bco', ':%bp<bar>sp<bar>bn<bar>bd<bar>e#<CR>')
--F.vim.nmap('<Leader>bcO', ':%bp<bar>sp<bar>bn<bar>bd!<bar>e#<CR>')

F.vim.nmap('<Leader>bdc', ':bdelete<CR>')
F.vim.nmap('<Leader>bdC', ':bdelete!<CR>')
F.vim.nmap('<Leader>bda', ':%bdelete<CR>')
F.vim.nmap('<Leader>bdA', ':%bdelete!<CR>')
F.vim.nmap('<Leader>bdo', ':%bdelete<bar>edit#<bar>bnext<bar>bdelete<CR>')
F.vim.nmap('<Leader>bdO', ':%bdelete!<bar>edit#<bar>bnext<bar>bdelete!<CR>')

F.vim.nmap('<Leader>bwc', ':write<CR>')
F.vim.nmap('<Leader>bwC', ':write!<CR>')
F.vim.nmap('<Leader>bwa', ':wall<CR>')
F.vim.nmap('<Leader>bwA', ':wall!<CR>')

F.vim.nmap('<Leader>bl', ':buffers<CR>')

F.vim.nmap('<Leader>br', ':e<CR>')
F.vim.nmap('<Leader>bR', ':e!<CR>')

--SHORTCUTS
F.vim.nmap('<Leader>`', '<C-^>')
F.vim.nmap('<C-p>',     ':bprevious<CR>')
F.vim.nmap('<C-n>',     ':bnext<CR>')

F.vim.nmap('<C-s>',   ':write<CR>')
F.vim.nmap('<C-S-s>', ':wall<CR>')
F.vim.imap('<C-s>',   '<escape>:write<CR>')
F.vim.imap('<C-S-s>', '<escape>:wall<CR>')

F.vim.nmap('<C-S-d>',           ':bp<bar>sp<bar>bn<bar>bd<CR>')
F.vim.nmap('<Leader><Leader>d', ':bp<bar>sp<bar>bn<bar>bd<CR>')
