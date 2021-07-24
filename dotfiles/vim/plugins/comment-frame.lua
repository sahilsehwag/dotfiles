require('nvim-comment-frame').setup({
	disable_default_keymap = false,
	keymap = 'gkf',
	frame_width = 70,
	line_wrap_len = 50,
	auto_indent = true,
	add_comment_above = true,
	languages = {
		--lua = {
		--  start_str = '--[[',
		--  end_str = ']]--',
		--  fill_char = '*',
		--  frame_width = 70,
		--  line_wrap_len = 50,
		--  auto_indent = true,
		--  add_comment_above = true,
		--},
	},
})
