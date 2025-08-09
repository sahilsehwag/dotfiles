vim.keymap.set("n", "qe", function()
	require('macrograph').open()
end, { desc = "Edit macros" })
