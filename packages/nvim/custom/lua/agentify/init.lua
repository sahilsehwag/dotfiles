local CONFIG = {
	sdk = 'omp', -- 'omp' | 'claude' | 'pi'
	sdk_args = {
		omp    = { '--auto-approve', '--no-session' },
		claude = { '--auto-approve' },
		pi     = { '--auto-approve' },
	},
}

local SDKS = {
	omp    = 'omp',
	claude = 'claude',
	pi     = 'pi',
}

local build_argv = function()
	local bin  = SDKS[CONFIG.sdk] or SDKS.omp
	local args = ((CONFIG.sdk_args or {})[CONFIG.sdk]) or {}
	local argv = { bin, '--mode', 'json', '-p' }
	for _, a in ipairs(args) do
		if a ~= '' then argv[#argv + 1] = a end
	end
	return argv
end

-- ---------------------------------------------------------------------------
-- Bottom-right status badge
-- ---------------------------------------------------------------------------

local SPINNER = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }

local Badge = {}
Badge.__index = Badge

function Badge.new()
	local buf = vim.api.nvim_create_buf(false, true)
	vim.bo[buf].bufhidden = 'wipe'

	local self = setmetatable({
		buf   = buf,
		win   = nil,
		_text = '',
		_frame = 1,
		_timer = vim.uv.new_timer(),
	}, Badge)

	-- open the window on the first tick so columns/lines are settled
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

-- Update the label shown next to the spinner.
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

-- ---------------------------------------------------------------------------
-- JSON event → human label
-- ---------------------------------------------------------------------------

local tool_label = function(name)
	return ({
		read   = 'reading',
		edit   = 'editing',
		write  = 'writing',
		bash   = 'running shell',
		find   = 'finding',
		search = 'searching',
		lsp    = 'lsp',
		grep   = 'grep',
	})[name] or name
end

-- ---------------------------------------------------------------------------
-- Core runner
-- ---------------------------------------------------------------------------

local run_agent = function(argv)
	local sdk   = CONFIG.sdk or 'omp'
	local badge = Badge.new()
	badge:set('Agentify(' .. sdk .. ')…')

	local all_lines = {}
	local err_lines = {}

	local handle_event = function(line)
		if line == '' then return end
		local ok, ev = pcall(vim.fn.json_decode, line)
		if not ok or type(ev) ~= 'table' then return end

		local t = ev.type
		if t == 'tool_execution_start' then
			local label = tool_label(ev.toolName or '')
			local path  = ''
			if ev.arguments then
				local p = ev.arguments.path or ev.arguments.file or ''
				if p ~= '' then path = ' ' .. vim.fn.fnamemodify(p, ':t') end
			end
			badge:set('Agentify(' .. sdk .. '): ' .. label .. path)
		elseif t == 'tool_execution_end' then
			badge:set('Agentify(' .. sdk .. ')…')
		end
	end

	vim.fn.jobstart(argv, {
		-- buffered = true: all output arrives in on_exit order, after the process finishes.
		-- No reassembly needed; each element in data is already a complete line.
		stdout_buffered = true,
		stderr_buffered = true,

		on_stdout = function(_, data)
			for _, line in ipairs(data or {}) do
				all_lines[#all_lines + 1] = line
			end
		end,

		on_stderr = function(_, data)
			for _, line in ipairs(data or {}) do
				if line ~= '' then err_lines[#err_lines + 1] = line end
			end
		end,

		on_exit = function(_, code)
			-- Parse events first, then close badge and reload.
			for _, line in ipairs(all_lines) do
				handle_event(line)
			end
			badge:close()
			vim.schedule(function()
				if code == 0 then
					for _, b in ipairs(vim.api.nvim_list_bufs()) do
						if vim.api.nvim_buf_is_loaded(b) then
							vim.api.nvim_buf_call(b, function()
								vim.cmd('silent! checktime')
							end)
						end
					end
					vim.notify('Agentify(' .. sdk .. '): Done', vim.log.levels.INFO)
				else
					local tail = {}
					for i = math.max(1, #err_lines - 5), #err_lines do
						tail[#tail + 1] = err_lines[i]
					end
					vim.notify(
						'Agentify(' .. sdk .. '): Failed (exit ' .. code .. ')\n'
							.. table.concat(tail, '\n'),
						vim.log.levels.ERROR
					)
				end
			end)
		end,
	})
end

-- ---------------------------------------------------------------------------
-- Selection helpers
-- ---------------------------------------------------------------------------

local get_visual_selection = function()
	local s = vim.fn.getpos("'<")
	local e = vim.fn.getpos("'>")
	return { start_line = s[2], end_line = e[2] }
end

local get_current_line = function()
	local l = vim.fn.line('.')
	return { start_line = l, end_line = l }
end

local get_file_selection = function()
	return { start_line = 1, end_line = vim.api.nvim_buf_line_count(0) }
end

-- ---------------------------------------------------------------------------
-- Session resume helpers
-- ---------------------------------------------------------------------------

-- Encode an absolute path the same way omp does: leading / dropped, rest / → -
local cwd_to_session_slug = function(cwd)
	return cwd:gsub('^/', ''):gsub('/', '-')
end

-- Find the most recent session id for a given cwd slug.
-- Returns the id prefix string, or nil if none found.
local find_latest_session = function(cwd)
	local slug    = cwd_to_session_slug(cwd)
	local dir     = vim.fn.expand('~/.omp/agent/sessions/') .. slug
	local entries = vim.fn.glob(dir .. '/*.jsonl', false, true)
	if #entries == 0 then return nil end
	-- glob returns sorted by name; filenames start with ISO timestamp so last = newest
	table.sort(entries)
	local newest = entries[#entries]
	-- filename: TIMESTAMP_SESSIONID.jsonl — extract the id
	local id = newest:match('_([^/]+)%.jsonl$')
	return id
end

-- Walk up from dir until we find a .git root, return it or dir itself.
local find_git_root = function(dir)
	local result = vim.fn.systemlist('git -C ' .. vim.fn.shellescape(dir) .. ' rev-parse --show-toplevel 2>/dev/null')
	if result and #result > 0 and result[1] ~= '' then
		return result[1]
	end
	return dir
end

-- ---------------------------------------------------------------------------
-- Entry point
-- ---------------------------------------------------------------------------

local agentify = function(selection, user_prompt)
	local filepath = vim.fn.expand('%:p')
	local prompt = string.format(
		'Edit file %s, focusing on lines %d-%d.\n\nRequest: %s',
		filepath, selection.start_line, selection.end_line, user_prompt
	)

	local tmpfile = vim.fn.tempname()
	vim.fn.writefile(vim.split(prompt, '\n', { plain = true }), tmpfile)

	local argv = build_argv()
	argv[#argv + 1] = '@' .. tmpfile
	run_agent(argv)
end

local agentify_context = function(selection, user_prompt)
	local filepath = vim.fn.expand('%:p')
	local filedir  = vim.fn.fnamemodify(filepath, ':h')
	local root     = find_git_root(filedir)

	local session_id = find_latest_session(root)
	if not session_id then
		vim.notify('Agentify: no session found for ' .. root, vim.log.levels.WARN)
		return
	end

	local prompt = string.format(
		'Context: file %s, lines %d-%d.\n\nRequest: %s',
		filepath, selection.start_line, selection.end_line, user_prompt
	)

	local tmpfile = vim.fn.tempname()
	vim.fn.writefile(vim.split(prompt, '\n', { plain = true }), tmpfile)

	local sdk = CONFIG.sdk or 'omp'
	local bin = SDKS[sdk] or SDKS.omp
	local argv = { bin, '--mode', 'json', '-p', '--auto-approve', '-r', session_id, '@' .. tmpfile }
	run_agent(argv)
end

local ask_and_run = function(selection, fn)
	local ok, input = pcall(vim.fn.input, 'Agentify> ')
	if ok and input and input ~= '' then
		fn(selection, input)
	end
end

-- ---------------------------------------------------------------------------

return {
	setup = function(config)
		CONFIG = vim.tbl_deep_extend('force', CONFIG, config or {})
	end,

	act_visual   = function() ask_and_run(get_visual_selection(), agentify) end,
	act_line     = function() ask_and_run(get_current_line(),     agentify) end,
	act_file     = function() ask_and_run(get_file_selection(),   agentify) end,

	-- Send current context into the most recent omp session for this project.
	act_context_visual = function() ask_and_run(get_visual_selection(), agentify_context) end,
	act_context_line   = function() ask_and_run(get_current_line(),     agentify_context) end,
	act_context_file   = function() ask_and_run(get_file_selection(),   agentify_context) end,
}
