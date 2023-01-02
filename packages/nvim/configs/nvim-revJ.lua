--NOT-WORKING
require("revj").setup{
	brackets = {first = '([{<', last = ')]}>'},
	new_line_before_last_bracket = true,
	enable_default_keymaps = false,
	keymaps = {
		operator = 'gj',
		line = 'gJ',
		visual = 'gj'
	},
}
