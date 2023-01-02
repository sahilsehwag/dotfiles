vim.keymap.set('i', '<C-E>', function ()
	return vim.fn['codeium#Accept']()
end, { expr = true })
