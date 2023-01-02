F.vim.nmap(';', '<nop>')
F.vim.nmap(',', '<nop>')

F.vim.nmap(';', ':', {
	silent = false,
})

vim.g.mapleader      = ' '
vim.g.maplocalleader = ','

vim.g.insert_leader   = ';'
vim.g.command_leader  = ';'
vim.g.terminal_leader = ';'

vim.g.action_leader = 'A'
vim.g.mode_leader   = 'C-A'
vim.g.motion_leader = 'C-S'
