require('nvim-treesitter').setup()

local select = require('nvim-treesitter-textobjects.select')
local move = require('nvim-treesitter-textobjects.move')

require('nvim-treesitter-textobjects').setup({
	select = {
		lookahead = true,
	},
	move = {
		set_jumps = true,
	},
})

-- SELECT textobjects
local sel = function(lhs, query)
	vim.keymap.set({ 'x', 'o' }, lhs, function()
		select.select_textobject(query, 'textobjects')
	end, { noremap = true, silent = true })
end

sel('<space>i/', '@comment.inner')
sel('<space>a/', '@comment.outer')
sel('<space>is', '@statement.inner')
sel('<space>as', '@statement.outer')
sel('<space>ib', '@block.inner')
sel('<space>ab', '@block.outer')
sel('<space>il', '@loop.inner')
sel('<space>al', '@loop.outer')
sel('<space>ic', '@conditional.inner')
sel('<space>ac', '@conditional.outer')
sel('<space>if', '@function.inner')
sel('<space>af', '@function.outer')
sel('<space>i(', '@call.inner')
sel('<space>a(', '@call.outer')
sel('<space>i,', '@parameter.inner')
sel('<space>a,', '@parameter.outer')
sel('<space>aC', '@class.outer')
sel('<space>iC', '@class.inner')
sel('<space>ix', '@attribute.inner')
sel('<space>ax', '@attribute.outer')
sel('<space>it', '@tag.inner')
sel('<space>at', '@tag.outer')
sel('<space>im', '@import.inner')
sel('<space>am', '@import.outer')
sel('<space>ik', '@key.inner')
sel('<space>ak', '@key.outer')
sel('<space>iv', '@value.inner')
sel('<space>av', '@value.outer')
sel('<space>iL', '@lhs.inner')
sel('<space>aL', '@lhs.outer')
sel('<space>iR', '@rhs.inner')
sel('<space>aR', '@rhs.outer')
sel('<space>id', '@declaration.inner')
sel('<space>ad', '@declaration.outer')
sel('<space>ir', '@rule.inner')
sel('<space>ar', '@rule.outer')

-- MOVE textobjects
local nxt_s = function(lhs, query)
	vim.keymap.set({ 'n', 'x', 'o' }, lhs, function()
		move.goto_next_start(query, 'textobjects')
	end, { noremap = true, silent = true })
end
local prv_s = function(lhs, query)
	vim.keymap.set({ 'n', 'x', 'o' }, lhs, function()
		move.goto_previous_start(query, 'textobjects')
	end, { noremap = true, silent = true })
end

nxt_s(']<space>s', '@statement.inner')
nxt_s(']<space>S', '@statement.outer')
nxt_s(']<space>b', '@block.inner')
nxt_s(']<space>B', '@block.outer')
nxt_s(']<space>l', '@loop.inner')
nxt_s(']<space>L', '@loop.outer')
nxt_s(']<space>c', '@conditional.inner')
nxt_s(']<space>C', '@conditional.outer')
nxt_s(']<space>f', '@function.inner')
nxt_s(']<space>F', '@function.outer')
nxt_s(']<space>a', '@call.inner')
nxt_s(']<space>A', '@call.outer')
nxt_s(']<space>p', '@parameter.inner')
nxt_s(']<space>P', '@parameter.outer')
nxt_s(']<space>/', '@comment.inner')
nxt_s(']<space>?', '@comment.outer')

prv_s('[<space>s', '@statement.inner')
prv_s('[<space>S', '@statement.outer')
prv_s('[<space>b', '@block.inner')
prv_s('[<space>B', '@block.outer')
prv_s('[<space>l', '@loop.inner')
prv_s('[<space>L', '@loop.outer')
prv_s('[<space>c', '@conditional.inner')
prv_s('[<space>C', '@conditional.outer')
prv_s('[<space>f', '@function.inner')
prv_s('[<space>F', '@function.outer')
prv_s('[<space>(', '@call.inner')
prv_s('[<space>)', '@call.outer')
prv_s('[<space>,', '@parameter.inner')
prv_s('[<space><', '@parameter.outer')
prv_s('[<space>/', '@comment.inner')
prv_s('[<space>?', '@comment.outer')

-- FOLDS
vim.cmd [[ set foldmethod=expr ]]
vim.cmd [[ set foldexpr=v:lua.vim.treesitter.foldexpr() ]]
