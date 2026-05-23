require('fff').setup({
	debug = {
		enabled = true,
		show_scores = true,
	},
})

local map = function(lhs, rhs, desc)
	vim.keymap.set('n', lhs, rhs, { noremap = true, silent = true, desc = desc })
end

map('<Leader>pf', function() require('fff').find_files() end, 'FFF: find files')
map('<Leader>p/', function() require('fff').live_grep() end, 'FFF: live grep')
map('<Leader>p?', function()
	require('fff').live_grep({ grep = { modes = { 'fuzzy', 'plain' } } })
end, 'FFF: live fuzzy grep')
map('<Leader>pw', function()
	require('fff').live_grep({ query = vim.fn.expand("<cword>") })
end, 'FFF: search current word')
