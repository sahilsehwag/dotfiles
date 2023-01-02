require("telescope").setup({
	extensions = {
		ast_grep = {
			command = {
				"sg",
				"--json=stream",
			}, -- must have --json=stream
			grep_open_files = false, -- search in opened files
			lang = nil, -- string value, specify language for ast-grep `nil` for default
		},
	},
})
