
-- === Config: define what the operator DOES on each target ===
-- You can change this at runtime (e.g., from a command) to do different things.
_G.GO_ACTION = function(bufnr, text)
  -- EXAMPLE action: uppercase the target text
  return string.upper(text)
end

-- === Helper: capture a "text object" selection range by simulating visual selection ===
local function select_textobj_and_get_range(obj_keys)
  -- save view
  local view = vim.fn.winsaveview()
  -- enter visual and perform textobject selection exactly as the user would
  vim.api.nvim_feedkeys('v' .. obj_keys, 'nx', false)
  vim.cmd('silent! normal! o')             -- normalize visual start/end order
  local srow, scol = unpack(vim.api.nvim_buf_get_mark(0, '<'))
  local erow, ecol = unpack(vim.api.nvim_buf_get_mark(0, '>'))
  -- restore view (cursor will be at visual start anyway; we keep it manageable)
  vim.fn.winrestview(view)
  return srow, scol, erow, ecol
end

-- === Helper: get text within a range (inclusive visual range semantics) ===
local function get_text(srow, scol, erow, ecol)
  return table.concat(vim.api.nvim_buf_get_text(0, srow-1, scol, erow-1, ecol+1, {}), "\n")
end

-- === Helper: set text within a range ===
local function set_text(srow, scol, erow, ecol, new_text)
  local lines = vim.split(new_text, "\n", { plain = true })
  -- Note: replace [srow,scol]..[erow,ecol] (visual inclusive), so erow, ecol+1
  vim.api.nvim_buf_set_text(0, srow-1, scol, erow-1, ecol+1, lines)
end

-- === Core: run GO_ACTION for each <target> inside <context> ===
local function run_on_targets_in_context(target_keys, context_keys)
  -- 1) Find the context region
  local view = vim.fn.winsaveview()
  local curpos = vim.api.nvim_win_get_cursor(0)
  local csrow, cscol, cerow, cecol = select_textobj_and_get_range(context_keys)
  if not csrow then return end

  -- helpers
  local function cursor_lt(a_row, a_col, b_row, b_col)
    return (a_row < b_row) or (a_row == b_row and a_col < b_col)
  end

  -- iteration state
  local bufnr = 0
  local row, col = csrow, cscol
  local last_end_row, last_end_col = csrow, cscol - 1
  vim.api.nvim_win_set_cursor(0, { csrow, math.max(cscol, 0) })

  local done_guard = 20000
  while done_guard > 0 do
    done_guard = done_guard - 1
    vim.api.nvim_win_set_cursor(0, { row, math.max(col, 0) })

    local tsrow, tscol, terow, tecol = select_textobj_and_get_range(target_keys)
    if not tsrow then break end

    -- decide whether to "continue" by nudging forward
    local need_nudge =
      cursor_lt(terow, tecol, csrow, cscol) or               -- ends before context
      cursor_lt(cerow, cecol, tsrow, tscol) or               -- starts after context
      not cursor_lt(last_end_row, last_end_col, terow, tecol) -- not advancing

    if need_nudge then
      -- nudge one char forward; stop if past context
      if cursor_lt(row, col, cerow, cecol) then
        if col < 1e6 then col = col + 1 else row = row + 1; col = 0 end
      else
        break
      end
    else
      -- apply action
      local old = get_text(tsrow, tscol, terow, tecol)
      local repl = _G.GO_ACTION(bufnr, old)
      if repl and repl ~= old then
        set_text(tsrow, tscol, terow, tecol, repl)
        -- adjust context end if line count changed
        local old_nl = select(2, old:gsub("\n", "\n"))
        local new_nl = select(2, repl:gsub("\n", "\n"))
        local delta = new_nl - old_nl
        if delta ~= 0 then cerow = cerow + delta end
        -- next cursor after replacement
        row, col = tsrow, tscol + #repl
        last_end_row, last_end_col = tsrow, tscol + #repl
      else
        -- no change; still advance
        row, col = terow, tecol + 1
        last_end_row, last_end_col = terow, tecol + 1
      end
    end

    -- stop if we’ve moved beyond context
    if not cursor_lt(row, col, cerow, cecol + 1) then break end
  end

  vim.fn.winrestview(view)
  vim.api.nvim_win_set_cursor(0, curpos)
end

-- === Keymap: go<target><context> ===
-- Reads two "textobject" key sequences from the user and runs the core.
vim.keymap.set("n", "go", function()
  -- read target textobject keys (commonly 2 keystrokes like 'iw', 'aw', 'af', etc.)
  local target = vim.fn.getcharstr()
  -- some text objects are 2 chars starting with i/a; if first is i/a, read next immediately
  if target == 'i' or target == 'a' then
    target = target .. vim.fn.getcharstr()
  end

  -- read context textobject keys
  local context = vim.fn.getcharstr()
  if context == 'i' or context == 'a' then
    context = context .. vim.fn.getcharstr()
  end

  run_on_targets_in_context(target, context)
end, { desc = "Apply GO_ACTION to <target textobj> inside <context textobj>" })
