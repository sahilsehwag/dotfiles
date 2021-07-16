local ROOT = 'plugins/lsp/luasnip'

luasnip = require('luasnip')

--snippets
local SNIPPETS = {
  'typescript',
}

luasnip.snippets = {}
for i,filetype in ipairs(SNIPPETS) do
	luasnip.snippets[filetype] = require(ROOT .. '/' .. filetype)
end

--mappings
--vim.cmd [[ imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'  ]]
--vim.cmd [[ inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr> ]]

--vim.cmd [[ snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr> ]]
--vim.cmd [[ snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr> ]]

--vim.cmd [[ imap <silent><expr> <C-CR> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-CR>' ]]
--vim.cmd [[ smap <silent><expr> <C-CR> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-CR>' ]]
