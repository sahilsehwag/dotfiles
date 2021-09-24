return {
	get_expansion_string = function(occupied_space, fill_char)
		local width = (
			vim.fn.winwidth(0) -
			vim.o.foldcolumn -
			((vim.o.number or vim.o.relativenumber) and vim.o.numberwidth or 0)
		)
		return vim.fn['repeat'](fill_char, width - occupied_space)
	end,
}
