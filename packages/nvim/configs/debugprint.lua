require("debugprint").setup()

vim.keymap.set("n", "g?d", function()
	vim.cmd("Debugprint delete")
end, {
	desc = "[Debugprint] Delete debug print",
})

vim.keymap.set("n", "g?/", function()
	vim.cmd("Debugprint search")
end, {
	desc = "[Debugprint] Search debug prints",
})

vim.keymap.set("n", "g?q", function()
	vim.cmd("Debugprint quickfix")
end, {
	desc = "[Debugprint] Quickfix debug prints",
})

vim.keymap.set("n", "g?k", function()
	vim.cmd("Debugprint commenttoggle")
end, {
	desc = "[Debugprint] Toggle comment on debug print",
})
