require('lsp_signature').on_attach({
  -- This is mandatory, otherwise border config won't get registered.
  -- If you want to hook lspsaga or other signature handler, pls set to false
  bind = true,
  -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
  -- set to 0 if you DO NOT want any API comments be shown
  -- This setting only take effect in insert mode, it does not affect signature help in normal
  -- mode, 10 by default
  doc_lines = 2,
  -- show hint in a floating window, set to false for virtual text only mode
  floating_window = true,
  -- set to true, the floating window will not auto-close until finish all parameters
  fix_pos = false,
  -- virtual hint enable
  hint_enable = true,
  -- Panda for parameter
  hint_prefix = "()", 
  hint_scheme = "String",
  -- set to true if you want to use lspsaga popup
  use_lspsaga = true,
  -- how your parameter will be highlight
  hi_parameter = "Search",
  -- max height of signature floating_window, if content is more than max_height, you can scroll down
  -- to view the hiding contents
  max_height = 12,
  -- max_width of signature floating_window, line will be wrapped if exceed max_width
    max_width = 120,
  handler_opts = {
    -- double, single, shadow, none
    border = "shadow"
  },
  -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
    extra_trigger_chars = {'(', ','}
  -- deprecate !!
  -- decorator = {"`", "`"}  -- this is no longer needed as nvim give me a handler and it allow me to highlight active parameter in floating_window
})
