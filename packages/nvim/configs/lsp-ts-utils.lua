require('nvim-lsp-ts-utils').setup({})

vim.cmd [[ nnoremap <Leader>laq :LspFixCurrent<CR> ]]
vim.cmd [[ nnoremap <Leader>lao :LspOrganize<CR> ]]
vim.cmd [[ nnoremap <Leader>lai :LspImportAll<CR> ]]
vim.cmd [[ nnoremap <Leader>lar :LspRenameFile<CR> ]]
