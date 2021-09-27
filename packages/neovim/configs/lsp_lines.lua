require'lsp_lines'.setup()

vim.diagnostic.config({
  virtual_text = false,
})


F.nvim.nmap('<leader>letv', require'lsp_lines'.toggle)
