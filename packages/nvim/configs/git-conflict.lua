require('git-conflict').setup({
	default_mappings = false,
})

vim.keymap.set('n', '<Leader>gcn', '<Plug>(git-conflict-none)')
vim.keymap.set('n', '<Leader>gco', '<Plug>(git-conflict-ours)')
vim.keymap.set('n', '<Leader>gct', '<Plug>(git-conflict-theirs)')
vim.keymap.set('n', '<Leader>gcb', '<Plug>(git-conflict-both)')
vim.keymap.set('n', '<Leader>gc.', '<cmd>GitConflictListQf<cr>')
vim.keymap.set('n', ']x', '<Plug>(git-conflict-next-conflict)')
vim.keymap.set('n', '[x', '<Plug>(git-conflict-prev-conflict)')

--vim.api.nvim_create_autocmd('User', {
--  pattern = 'GitConflictDetected',
--  callback = function()
--    vim.notify('Conflict detected in ' .. vim.fn.expand('<afile>'))
--  end,
--})
