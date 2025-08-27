-- TODO: better root for bookmarks insted of <Leader>j
require'bookmarks'.setup({
	keymap = {
		toggle     = '<Leader>jt', -- toggle bookmarks
		add        = '<Leader>ja', -- add bookmarks
		add_global = '<Leader>jg', -- add bookmarks
		order      = '<LocalLeader>s', -- order bookmarks by frequency or updated_time
		jump       = '<CR>',       -- jump from bookmarks
		delete     = 'dd',         -- delete bookmarks
		close      = "q", -- close bookmarks (buf keymap)
	},
	hl_cursorline = 'guibg=Gray guifg=White', -- hl bookmarks window cursorline
	virt_pattern = {},
})

require("telescope").load_extension("bookmarks")

vim.keymap.set('n', '<Leader>jl', ':Telescope bookmarks<cr>')
