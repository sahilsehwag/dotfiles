require'lsp_lines'.setup()

vim.diagnostic.config({
  virtual_text = false,
})


F.vim.nmap('<leader>letv', require'lsp_lines'.toggle)
