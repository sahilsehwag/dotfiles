require'bufferline-cycle-windowless'.setup({
	default_enabled = true,
})

vim.api.nvim_set_keymap("n", "<C-n>", "<CMD>BufferLineCycleWindowlessNext<CR>",
	{ noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-p>", "<CMD>BufferLineCycleWindowlessPrev<CR>",
	{ noremap = true, silent = true })
