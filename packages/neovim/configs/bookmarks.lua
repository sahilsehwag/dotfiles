-- TODO: better root for bookmarks insted of <Leader>j
require'bookmarks'.setup({
	keymap = {
		toggle = '<Leader>jt', -- toggle bookmarks
		add    = '<Leader>ja', -- add bookmarks
		jump   = '<CR>',       -- jump from bookmarks
		delete = 'dd',         -- delete bookmarks
		order  = '<LocalLeader>s', -- order bookmarks by frequency or updated_time
	},
	hl_cursorline = 'guibg=Gray guifg=White' -- hl bookmarsk window cursorline
})

vim.cmd [[
	autocmd FileType bookmarks nnoremap <LocalLeader>q :q<CR>
]]
