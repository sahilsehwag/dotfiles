-- badge.lua
local SPINNER = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }

local Badge = {}
Badge.__index = Badge

function Badge.new()
	local buf = vim.api.nvim_create_buf(false, true)
	vim.bo[buf].bufhidden = 'wipe'
	local self = setmetatable({
		buf    = buf,
		win    = nil,
		_text  = '',
		_frame = 1,
		_timer = vim.uv.new_timer(),
	}, Badge)
	self._timer:start(0, 120, vim.schedule_wrap(function() self:_tick() end))
	return self
end

function Badge:_open_win(text)
	local w = math.max(1, vim.fn.strdisplaywidth(text))
	self.win = vim.api.nvim_open_win(self.buf, false, {
		relative  = 'editor',
		anchor    = 'SE',
		row       = vim.o.lines   - 2,
		col       = vim.o.columns - 1,
		width     = w,
		height    = 1,
		style     = 'minimal',
		border    = 'none',
		focusable = false,
		noautocmd = true,
		zindex    = 50,
	})
	vim.wo[self.win].winhl = 'Normal:Comment'
end

function Badge:_tick()
	local spin = SPINNER[self._frame]
	self._frame = (self._frame % #SPINNER) + 1
	local text = spin .. ' ' .. self._text
	if not self.win or not vim.api.nvim_win_is_valid(self.win) then
		self:_open_win(text)
	else
		local w = math.max(1, vim.fn.strdisplaywidth(text))
		vim.api.nvim_win_set_width(self.win, w)
	end
	if vim.api.nvim_buf_is_valid(self.buf) then
		vim.api.nvim_buf_set_lines(self.buf, 0, -1, false, { text })
	end
end

function Badge:set(text) self._text = text end

function Badge:close()
	self._timer:stop()
	self._timer:close()
	vim.schedule(function()
		if self.win and vim.api.nvim_win_is_valid(self.win) then
			vim.api.nvim_win_close(self.win, true)
		end
	end)
end

return Badge
