require("telescope").load_extension("import")
require("telescope").setup({
  extensions = {
    import = {
      -- Add imports to the top of the file keeping the cursor in place
      insert_at_top = false,
    },
  },
})

F.vim.imap(';i', '<cmd>Telescope import<cr>')
