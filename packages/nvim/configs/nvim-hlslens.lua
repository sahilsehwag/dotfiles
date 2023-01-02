require('hlslens').setup({
  -- enable hlslens after searching
  -- type: boolean
  auto_enable = true,

  enable_incsearch = true,
  nearest_only = false,
  float_shadow_blend = 50,
  virt_priority = 100,

  -- auto|always|never
  nearest_float_when = 'auto',

  -- if calm_down is true, stop hlslens when cursor is out of position range
  calm_down = false,

  -- hackable function for customizing the virtual text
  -- type: function(lnum, loc, idx, r_idx, count, hls_ns)
  -- override_line_lens = nil,
  -- override_line_lens = function(lnum, loc, idx, r_idx, count, hls_ns)
  --   local sfw = vim.v.searchforward == 1
  --   local indicator, text, chunks
  --   local a_r_idx = math.abs(r_idx)
  --   if a_r_idx > 1 then
  --     indicator = string.format('%d%s', a_r_idx, sfw ~= (r_idx > 1) and '?' or '?')
  --   elseif a_r_idx == 1 then
  --     indicator = sfw ~= (r_idx == 1) and '?' or '?'
  --   else
  --     indicator = ''
  --   end

  --   if loc ~= 'c' then
  --     text = string.format('[%s %d]', indicator, idx)
  --     chunks = {{' ', 'Ignore'}, {text, 'HlSearchLens'}}
  --   else
  --     if indicator ~= '' then
  --       text = string.format('[%s %d/%d]', indicator, idx, count)
  --     else
  --       text = string.format('[%d/%d]', idx, count)
  --     end
  --     chunks = {{' ', 'Ignore'}, {text, 'HlSearchLensCur'}}
  --     vim.api.nvim_buf_clear_namespace(0, hls_ns, lnum - 1, lnum)
  --   end
  --   vim.api.nvim_buf_set_virtual_text(0, hls_ns, lnum - 1, chunks, {})
  -- end,
})

-- vim.cmd [[ noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR> ]]
-- vim.cmd [[ noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR> ]]
-- vim.cmd [[ noremap * *<Cmd>lua require('hlslens').start()<CR> ]]
-- vim.cmd [[ noremap # #<Cmd>lua require('hlslens').start()<CR> ]]
-- vim.cmd [[ noremap g* g*<Cmd>lua require('hlslens').start()<CR> ]]
-- vim.cmd [[ noremap g# g#<Cmd>lua require('hlslens').start()<CR> ]]
-- vim.cmd [[ nnoremap <silent> <Leader>b.h :noh<CR> ]]
