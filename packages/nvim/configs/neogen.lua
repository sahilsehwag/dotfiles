require('neogen').setup({
	enabled = true,							--if you want to disable Neogen
	input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
	jump_map = "<tab>"					-- The keymap in order to jump in the annotation fields (in insert mode)
})

vim.cmd [[nnoremap <silent> <Leader>laa <cmd>Neogen<cr>]]
