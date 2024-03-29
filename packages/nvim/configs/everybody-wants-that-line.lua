require("everybody-wants-that-line").setup({
	buffer = {
		enabled = false,
		prefix = "B:",
		-- Symbol before buffer number, e.g. '0000.'.
		-- If you don't want additional symbols to be displayed, set `buffer.max_symbols = 0`.
		symbol = "0",
		-- Maximum number of symbols including buffer number.
		max_symbols = 5,
	},
	diagnostics = {
		enabled = true,
	},
	quickfix_list = {
		enabled = true,
	},
	git_status = {
		enabled = true,
	},
	ruller = {
		enabled = true,
	},
	filepath = {
		enabled = false,
		-- `path` can be one of these:
		-- 'tail' - file name only
		-- 'relative' - relative to working directory
		-- 'full' - full path to the file
		path = "relative",
		-- If `true` the path will be shortened, e.g. '/a/b/c/filename.lua'.
		-- It only works if `path` is 'relative' or 'full'.
		shorten = true,
	},
	filename = {
		enabled = false,
	},
	filesize = {
		-- `metric` can be:
		-- 'decimal' - 1000 bytes == 1 kilobyte
		-- 'binary' - 1024 bytes == 1 kibibyte
		enabled = false,
		metric = "decimal",
	},
	-- Separator between blocks, e.g. ' ... │ ... │ ... '
	separator = "│",
})
