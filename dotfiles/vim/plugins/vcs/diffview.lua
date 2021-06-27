-- Lua
local cb = require'diffview.config'.diffview_callback

require'diffview'.setup({
  diff_binaries = false,    -- Show diffs for binaries
  file_panel = {
    width = 35,
    use_icons = true        -- Requires nvim-web-devicons
  },
  key_bindings = {
    disable_defaults = true,
    -- The `view` bindings are active in the diff buffers, only when the current
    -- tabpage is a Diffview.
    view = {
      ["<TAB>"]          = cb("select_next_entry"),  -- Open the diff for the next file
      ["<S-TAB>"]        = cb("select_prev_entry"),  -- Open the diff for the previous file
      ["<LocalLeader>f"] = cb("toggle_files"),       -- Toggle the files panel.
      ["<LocalLeader>F"] = cb("focus_files"),        -- Bring focus to the files panel
    },
    file_panel = {
      ["<TAB>"]          = cb("select_next_entry"),
      ["<S-TAB>"]        = cb("select_prev_entry"),
      ["j"]              = cb("next_entry"),         -- Bring the cursor to the next file entry
      ["k"]              = cb("prev_entry"),         -- Bring the cursor to the previous file entry.
      ["<CR>"]           = cb("select_entry"),       -- Open the diff for the selected entry.
      ["<LocalLeader>s"] = cb("stage_all"),          -- Stage all entries.
      ["<LocalLeader>u"] = cb("unstage_all"),        -- Unstage all entries.
      ["<LocalLeader>t"] = cb("toggle_stage_entry"), -- Stage / unstage the selected entry.
      ["<LocalLeader>r"] = cb("refresh_files"),      -- Update stats and entries in the file list.
      ["<LocalLeader>f"] = cb("toggle_files"),
      ["<LocalLeader>F"] = cb("focus_files"),
    }
  }
})

vim.cmd [[ nnoremap <silent> <Leader>gd. <cmd>DiffviewOpen<CR> ]]
