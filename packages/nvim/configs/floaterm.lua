local ft = require("floaterm")
local api = require("floaterm.api")

require('floaterm').setup({
	border = 'single', -- Border style for the floating terminal
	width = 0.8,      -- Width of the floating terminal
	height = 0.8,     -- Height of the floating terminal
	autoclose = true, -- Automatically close the terminal when exiting
})

vim.keymap.set({ "n", "t" }, "<C-`>", ft.toggle, { buffer = buf, desc = "Floaterm: Toggle" })
vim.keymap.set("t", "<C-a>", api.new_term, { buffer = buf, desc = "Floaterm: New terminal" })

-- FIX: plugin logic only works when in sidebar
--vim.keymap.set("t", "<C-e>", api.edit_name, { buffer = buf, desc = "Floaterm: Edit name" })
