require('react-extract').setup()
vim.keymap.set({ "v" }, "<Leader>lre", require("react-extract").extract_to_new_file)
