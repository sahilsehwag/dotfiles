require('close_buffers').setup({
  filetype_ignore = {},
  preserve_window_layout = { 'this', 'hidden' }, 
	next_buffer_cmd = function(windows)
		require('bufferline').cycle(1)
		local bufnr = vim.api.nvim_get_current_buf()

		for _, window in ipairs(windows) do
			vim.api.nvim_win_set_buf(window, bufnr)
		end
	end,
})

--mappings
vim.api.nvim_set_keymap(
	'n',
	'<Leader>bcr',
	[[:BDelete all regex=]],
	{ noremap = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<Leader>bcg',
	[[:BDelete all glob=]],
	{ noremap = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<Leader>bcc',
	[[<cmd>lua require('close_buffers').delete({type = 'this'})<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<Leader>bca',
	[[<cmd>lua require('close_buffers').delete({type = 'all'})<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<Leader>bco',
	[[<cmd>lua require('close_buffers').delete({type = 'other'})<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<Leader>bcv',
	[[<cmd>lua require('close_buffers').delete({type = 'hidden'})<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<Leader>bcn',
	[[<cmd>lua require('close_buffers').delete({type = 'nameless'})<CR>]],
	{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
	'n',
	'<Leader>bcR',
	[[:BDelete! all regex=]],
	{ noremap = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<Leader>bcG',
	[[:BDelete! all glob=]],
	{ noremap = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<Leader>bcC',
	[[<cmd>lua require('close_buffers').delete({type = 'this', force = true})<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<Leader>bcA',
	[[<cmd>lua require('close_buffers').delete({type = 'all', force = true})<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<Leader>bcO',
	[[<cmd>lua require('close_buffers').delete({type = 'other', force = true})<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<Leader>bcV',
	[[<cmd>lua require('close_buffers').delete({type = 'hidden', force = true})<CR>]],
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<Leader>bcN',
	[[<cmd>lua require('close_buffers').delete({type = 'nameless', force = true})<CR>]],
	{ noremap = true, silent = true }
)
