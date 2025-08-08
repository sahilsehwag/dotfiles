require'lsp_lines'.setup()

--vim.diagnostic.config({
--  virtual_text = false,
--  virtual_lines = false,
--  signs = false,
--})

F.vim.nmap('<leader>letv', require'lsp_lines'.toggle)
