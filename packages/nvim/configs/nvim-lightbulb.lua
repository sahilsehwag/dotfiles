require('nvim-lightbulb').update_lightbulb({
  sign = {
    enabled = false,
    priority = 1000,
  },
  float = {
    enabled = false,
    text = "💡",
    -- Available keys for window options:
    -- - height     of floating window
    -- - width      of floating window
    -- - wrap_at    character to wrap at for computing height
    -- - max_width  maximal width of floating window
    -- - max_height maximal height of floating window
    -- - pad_left   number of columns to pad contents at left
    -- - pad_right  number of columns to pad contents at right
    -- - pad_top    number of lines to pad contents at top
    -- - pad_bottom number of lines to pad contents at bottom
    -- - offset_x   x-axis offset of the floating window
    -- - offset_y   y-axis offset of the floating window
    -- - anchor     corner of float to place at the cursor (NW, NE, SW, SE)
    -- - winblend   transparency of the window (0-100)
    win_opts = {},
  },
  virtual_text = {
    enabled = true,
    text = " ",
  },
  status_text = {
    enabled = false,
    text = "💡",
    text_unavailable = ""
  }
})

vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb({ sign = { enabled = false }, virtual_text = { enabled = true, text = '' } })]]

