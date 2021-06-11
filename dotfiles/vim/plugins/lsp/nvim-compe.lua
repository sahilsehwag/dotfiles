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
    ultisnips     = { priority = 10000000 };
    vsnip         = { priority = 10000000 };
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

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-n>'
  elseif check_back_space() then
    return t '<Tab>'
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-p>'
  else
    return t '<S-Tab>'
  end
end

vim.api.nvim_set_keymap('i', '<Tab>'  , 'v:lua.tab_complete()'  , { noremap = true , expr = true , silent = true})
vim.api.nvim_set_keymap('s', '<Tab>'  , 'v:lua.tab_complete()'  , { noremap = true , expr = true , silent = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', { noremap = true , expr = true , silent = true})
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', { noremap = true , expr = true , silent = true})
vim.api.nvim_set_keymap('i', '<CR>'   , 'compe#confirm("<CR>")' , { noremap = true , expr = true , silent = true})


