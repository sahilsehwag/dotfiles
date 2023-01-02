require('winshift').setup({
	highlight_moving_win = true,	-- Highlight the window being moved
	focused_hl_group = 'Visual',	-- The highlight group used for the moving window
	moving_win_options = {
		-- These are local options applied to the moving window while it's
		-- being moved. They are unset when you leave Win-Move mode.
		wrap = false,
		cursorline = false,
		cursorcolumn = false,
		colorcolumn = '',
	}
})

vim.cmd [[ 
	nnoremap <Leader>w. <Cmd>WinShift<CR>

	"nnoremap <C-M-H> <Cmd>WinShift left<CR>
	"nnoremap <C-M-J> <Cmd>WinShift down<CR>
	"nnoremap <C-M-K> <Cmd>WinShift up<CR>
	"nnoremap <C-M-L> <Cmd>WinShift right<CR>
	"nnoremap <C-M-H> <Cmd>WinShift far_left<CR>
	"nnoremap <C-M-J> <Cmd>WinShift far_down<CR>
	"nnoremap <C-M-K> <Cmd>WinShift far_up<CR>
	"nnoremap <C-M-L> <Cmd>WinShift far_right<CR>
]]
