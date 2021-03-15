require'nvim-blamer'.setup({
	enable = true,
	format = '%committer ● %committer-time-human ● %summary',
})

vim.cmd [[call nvimblamer#auto()]]
vim.cmd [[autocmd! VimEnter * NvimBlamerToggle]]

vim.api.nvim_set_keymap('n', '<Leader>gB', ':NvimBlamerToggle<CR>', { noremap = true, silent = true })

