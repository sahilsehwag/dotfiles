local luasnip = require('luasnip')

vim.o.completeopt = 'menuone,noselect'

require('compe').setup({
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
  documentation = {
    border = 'rounded',
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    luasnip = { priority = 10000000 },
    ultisnips = { priority = 10000000 },
    vsnip = { priority = 10000000 },
    --snippets_nvim = { priority = 10000000 },

    nvim_lsp = { priority = 1000000 },
    nvim_lua = { priority = 1000000 },

    tabnine    = { priority = 1000 },
    treesitter = { priority = 100000 },

    tags   = { priority = 10000 },
    buffer = { priority = 10000 },
    spell  = { priority = 10000 },
    path   = { priority = 10000 },

    tmux = { priority = 1000 },
    calc = { priority = 1000 },
    neorg = true,
  };
})

local replace_term_codes = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_backspace = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return replace_term_codes('<C-n>')
  elseif luasnip and luasnip.expand_or_jumpable() then
    return replace_term_codes('<cmd>lua require"luasnip".expand_or_jump()<cr>')
  elseif vim.fn['UltiSnips#CanExpandSnippet']() == 1 or vim.fn['UltiSnips#CanJumpForwards']() == 1 then
    return replace_term_codes('<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>')
  elseif vim.fn.call('vsnip#available', {1}) == 1 then
    return replace_term_codes('<Plug>(vsnip-expand-or-jump)')
  elseif check_backspace() then
    return replace_term_codes('<Tab>')
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return replace_term_codes('<C-p>')
  elseif luasnip and luasnip.jumpable(-1) then
    return replace_term_codes('<cmd>lua require"luasnip".jump(-1)<cr>')
  elseif vim.fn['UltiSnips#CanJumpBackwards']() == 1 then
    return vim.api.nvim_replace_termcodes('<C-R>=UltiSnips#JumpBackwards()<CR>', true, true, true)
  elseif vim.fn.call('vsnip#jumpable', {-1}) == 1 then
    return replace_term_codes('<Plug>(vsnip-jump-prev)')
  else
    return replace_term_codes('<S-Tab>')
  end
end

vim.api.nvim_set_keymap('i' , '<Tab>'   , 'v:lua.tab_complete()'   , { noremap = true , expr = true , silent = true})
vim.api.nvim_set_keymap('s' , '<Tab>'   , 'v:lua.tab_complete()'   , { noremap = true , expr = true , silent = true})
vim.api.nvim_set_keymap('i' , '<S-Tab>' , 'v:lua.s_tab_complete()' , { noremap = true , expr = true , silent = true})
vim.api.nvim_set_keymap('s' , '<S-Tab>' , 'v:lua.s_tab_complete()' , { noremap = true , expr = true , silent = true})
vim.api.nvim_set_keymap('i' , '<CR>'    , 'compe#confirm("<CR>")'  , { noremap = true , expr = true , silent = true})

vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})
