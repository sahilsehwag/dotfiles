require('refactoring').setup({})

local opts = { silent = true }

-- Visual mode refactors
vim.keymap.set("x", "<leader>re", ":Refactor extract ",
	vim.tbl_extend('force', opts, { desc = "Refactor: Extract" })
)
vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ",
	vim.tbl_extend('force', opts, { desc = "Refactor: Extract to file" })
)
vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ",
	vim.tbl_extend('force', opts, { desc = "Refactor: Extract variable" })
)

-- Normal + Visual mode
vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var",
	vim.tbl_extend('force', opts, { desc = "Refactor: Inline variable" })
)

-- Normal mode refactors
vim.keymap.set("n", "<leader>rI", ":Refactor inline_func",
	vim.tbl_extend('force', opts, { desc = "Refactor: Inline function" })
)
vim.keymap.set("n", "<leader>rb", ":Refactor extract_block",
	vim.tbl_extend('force', opts, { desc = "Refactor: Extract block" })
)
vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file",
	vim.tbl_extend('force', opts, { desc = "Refactor: Extract block to file" })
)
