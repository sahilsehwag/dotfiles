-- lua/macrograph.lua
local M = {}

local state = {
	buf = nil,
	win = nil,
	regs = {},
}

local function readable(keys)
	-- Show as human-friendly keystrokes like <CR>, <Esc>, etc.
	return vim.fn.keytrans(keys)
end

local function to_termcodes(s)
	-- Convert <...> notation + literal chars back into real keycodes
	return vim.api.nvim_replace_termcodes(s, true, true, true)
end

local function get_macro(reg)
	-- Get raw macro contents from a register as typed keys
	return vim.fn.getreg(reg)
end

local function set_macro(reg, text)
	-- Save raw keys as a normal (typed) register
	vim.fn.setreg(reg, text, "n")
end

local function collect_regs()
	local regs = {}
	for c = string.byte('a'), string.byte('z') do
		local r = string.char(c)
		regs[#regs + 1] = r
	end
	return regs
end

local function render_lines()
	local lines = {}
	for _, r in ipairs(state.regs) do
		local raw = get_macro(r)
		local display = readable(raw)
		lines[#lines + 1] = string.format("%s  %s", r, display)
	end
	return lines
end

local function ensure_window()
	if state.buf and vim.api.nvim_buf_is_valid(state.buf) and state.win and vim.api.nvim_win_is_valid(state.win) then
		return
	end

	state.buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_option(state.buf, "buftype", "nofile")
	vim.api.nvim_buf_set_option(state.buf, "bufhidden", "wipe")
	vim.api.nvim_buf_set_option(state.buf, "swapfile", false)
	vim.api.nvim_buf_set_option(state.buf, "filetype", "macrograph")

	local width = math.max(30, math.floor(vim.o.columns * 0.6))
	local height = math.max(10, math.floor(vim.o.lines * 0.6))
	local row = math.floor((vim.o.lines - height) / 2 - 1)
	local col = math.floor((vim.o.columns - width) / 2)

	state.win = vim.api.nvim_open_win(state.buf, true, {
			relative = "editor",
			width = width,
			height = height,
			row = row,
			col = col,
			style = "minimal",
			border = "rounded",
		})

	-- Header (help) line
	local header = {
		"Live Macro Editor — edit right side and save",
		"Keys: <CR>=Save line   S=Save all   r=Run   q=Close",
		"Format: <reg><space><space><keys-as-<...>>   e.g. a  i<CR><Esc>",
		"—",
	}
	vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, header)
	vim.api.nvim_buf_add_highlight(state.buf, -1, "Title", 0, 0, -1)
	vim.api.nvim_buf_add_highlight(state.buf, -1, "Comment", 1, 0, -1)
	vim.api.nvim_buf_add_highlight(state.buf, -1, "Comment", 2, 0, -1)

	-- Fill body
	local body = render_lines()
	vim.api.nvim_buf_set_lines(state.buf, #header, -1, false, body)
	vim.api.nvim_buf_set_option(state.buf, "modifiable", true)

	-- Keymaps (buffer-local)
	local opts = { noremap = true, silent = true, nowait = true, buffer = state.buf }

	-- Save current line back to its register
	vim.keymap.set("n", "<CR>", function()
		local row = vim.api.nvim_win_get_cursor(state.win)[1]
		if row <= 4 then return end
		local line = vim.api.nvim_buf_get_lines(state.buf, row - 1, row, false)[1]
		local reg = string.sub(line, 1, 1)
		local text = string.sub(line, 4) or ""
		set_macro(reg, to_termcodes(text))
		vim.notify("Saved macro @" .. reg, vim.log.levels.INFO)
	end, opts)

-- Save all lines
vim.keymap.set("n", "S", function()
	local lines = vim.api.nvim_buf_get_lines(state.buf, 4, -1, false)
	for _, line in ipairs(lines) do
		local reg = string.sub(line, 1, 1)
		local text = string.sub(line, 4) or ""
		if reg:match("%l") then
			set_macro(reg, to_termcodes(text))
		end
	end
	vim.notify("Saved all macros (a–z).", vim.log.levels.INFO)
end
, opts)

		-- Run macro under cursor with v:count1
		vim.keymap.set("n", "r", function()
			local row = vim.api.nvim_win_get_cursor(state.win)[1]
			if row <= 4 then return end
			local line = vim.api.nvim_buf_get_lines(state.buf, row - 1, row, false)[1]
			local reg = string.sub(line, 1, 1)
			local count = vim.v.count1
			-- Close the editor before running so it runs in your last active window
			M.close()
			vim.schedule(function()
				vim.cmd(string.format("normal! %d@%s", count, reg))
			end)
		end, opts)

	-- Close
	vim.keymap.set("n", "q", function()
		M.close()
	end, opts)
end

function M.open()
	state.regs = collect_regs()
	ensure_window()
end

function M.refresh()
	if not (state.buf and vim.api.nvim_buf_is_valid(state.buf)) then return end
	local start = 4
	local lines = render_lines()
	vim.api.nvim_buf_set_lines(state.buf, start, -1, false, lines)
end

function M.close()
	if state.win and vim.api.nvim_win_is_valid(state.win) then
		vim.api.nvim_win_close(state.win, true)
	end
	state.win = nil
	if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
		vim.api.nvim_buf_delete(state.buf, { force = true })
	end
	state.buf = nil
end

-- Commands
vim.api.nvim_create_user_command("MacroGraph", function() M.open() end, {})
vim.api.nvim_create_user_command("MacroGraphRefresh", function() M.refresh() end, {})

return M
