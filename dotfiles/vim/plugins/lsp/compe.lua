local luasnip = require('luasnip')

vim.o.completeopt = 'menuone,noselect'

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 150;
  max_menu_width = 150;
  documentation = true;

  source = {
    luasnip       = { priority = 10000000 };
    --vsnip         = { priority = 10000000 };
    ultisnips     = { priority = 10000000 };
    snippets_nvim = { priority = 10000000 };

    nvim_lsp = { priority = 1000000 };
    nvim_lua = { priority = 1000000 };

    tabnine    = { priority = 1000 };
    treesitter = { priority = 100000 };

    tags   = { priority = 10000 };
    buffer = { priority = 10000 };
    spell  = { priority = 10000 };
    path   = { priority = 10000 };

    tmux = { priority = 1000 };
    calc = { priority = 1000 };
  };
}

local replaceTermcodes = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local checkBackspace = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return replaceTermcodes('<C-n>')
  elseif luasnip and luasnip.expand_or_jumpable() then
    return replaceTermcodes('<Plug>luasnip-expand-or-jump')
  --elseif vim.fn.call('vsnip#available', {1}) == 1 then
  --  return t '<Plug>(vsnip-expand-or-jump)'
  elseif vim.fn['UltiSnips#CanExpandSnippet']() == 1 or vim.fn['UltiSnips#CanJumpForwards']() == 1 then
    return replaceTermcodes('<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>')
  elseif checkBackspace() then
    return replaceTermcodes('<Tab>')
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return replaceTermcodes('<C-p>')
  elseif luasnip and luasnip.jumpable(-1) then
    return replaceTermcodes('<Plug>luasnip-jump-prev')
  --elseif vim.fn.call('vsnip#jumpable', {-1}) == 1 then
  --  return t '<Plug>(vsnip-jump-prev)'
  elseif vim.fn['UltiSnips#CanJumpBackwards']() == 1 then
    return vim.api.nvim_replace_termcodes('<C-R>=UltiSnips#JumpBackwards()<CR>', true, true, true)
  else
    return replaceTermcodes('<S-Tab>')
  end
end

--_G.cr_complete = function()
--  if vim.fn.pumvisible() == 1 then
--    _G.tab_complete()
--    vim.fn['compe#confirm']("<CR>")
--    --vim.fn['compe#complete']()
--    return replaceTermcodes('')
--    --return replaceTermcodes('compe#confirm("<CR>")')
--    --return replaceTermcodes('compe#complete()')
--  else
--    return replaceTermcodes('<CR>')
--  end
--end

vim.api.nvim_set_keymap('i', '<Tab>',   'v:lua.tab_complete()',   { noremap = true, expr = true, silent = true})
vim.api.nvim_set_keymap('s', '<Tab>',   'v:lua.tab_complete()',   { noremap = true, expr = true, silent = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', { noremap = true, expr = true, silent = true})
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', { noremap = true, expr = true, silent = true})
--vim.api.nvim_set_keymap('i', '<CR>',    'v:lua.cr_complete()',    { noremap = true, expr = true, silent = true})

