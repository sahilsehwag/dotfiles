-- providers/omp.lua
local M = {}

local TOOL_LABELS = {
	read   = 'reading',
	edit   = 'editing',
	write  = 'writing',
	bash   = 'running shell',
	find   = 'finding',
	search = 'searching',
	lsp    = 'lsp',
	grep   = 'grep',
}

-- build_argv returns the argv table for jobstart.
-- config = full CONFIG table, opts = { resume_id?: string }
function M.build_argv(config, opts)
	local args = (config.sdk_args or {}).omp or {}
	local argv = { 'omp', '--mode', 'json', '-p' }
	for _, a in ipairs(args) do
		if a ~= '' then argv[#argv + 1] = a end
	end
	if opts and opts.resume_id then
		-- remove --no-session when resuming (it would start a fresh ephemeral session)
		local filtered = {}
		for _, a in ipairs(argv) do
			if a ~= '--no-session' then filtered[#filtered + 1] = a end
		end
		argv = filtered
		argv[#argv + 1] = '-r'
		argv[#argv + 1] = opts.resume_id
	end
	return argv
end

-- parse_event returns a status string when interesting, nil otherwise.
function M.parse_event(ev)
	if ev.type ~= 'tool_execution_start' then return nil end
	local label = TOOL_LABELS[ev.toolName] or ev.toolName or ''
	local path  = ''
	if ev.arguments then
		local p = ev.arguments.path or ev.arguments.file or ''
		if p ~= '' then path = ' ' .. vim.fn.fnamemodify(p, ':t') end
	end
	return label .. path
end

-- find_session returns the most recent session id for a cwd, or nil.
function M.find_session(root)
	local slug = root:gsub('^/', ''):gsub('/', '-')
	local dir  = vim.fn.expand('~/.omp/agent/sessions/') .. slug
	local entries = vim.fn.glob(dir .. '/*.jsonl', false, true)
	if #entries == 0 then return nil end
	table.sort(entries)
	local newest = entries[#entries]
	return newest:match('_([^/]+)%.jsonl$')
end

return M
