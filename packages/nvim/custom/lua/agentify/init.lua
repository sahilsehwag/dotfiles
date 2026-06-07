-- agentify/init.lua
local runner    = require('agentify.runner')
local selection = require('agentify.selection')
local providers = require('agentify.providers')

local CONFIG = {
	sdk = 'omp', -- 'omp' | 'claude' | 'pi'
	sdk_args = {
		omp    = { '--auto-approve', '--no-session' },
		claude = { '--auto-approve' },
		pi     = { '--auto-approve' },
	},
}

-- ---------------------------------------------------------------------------
-- Git root helper (used for session lookup)
-- ---------------------------------------------------------------------------

local find_git_root = function(dir)
	local result = vim.fn.systemlist(
		'git -C ' .. vim.fn.shellescape(dir) .. ' rev-parse --show-toplevel 2>/dev/null'
	)
	if result and #result > 0 and result[1] ~= '' then return result[1] end
	return dir
end

-- ---------------------------------------------------------------------------
-- Core actions
-- ---------------------------------------------------------------------------

local run = function(sel, user_prompt, opts)
	local provider = providers.get(CONFIG.sdk)
	local filepath = vim.fn.expand('%:p')

	local prompt_template = opts and opts.resume_id
		and 'Context: file %s, lines %d-%d.\n\nRequest: %s'
		or  'Edit file %s, focusing on lines %d-%d.\n\nRequest: %s'

	local prompt = string.format(
		prompt_template,
		filepath, sel.start_line, sel.end_line, user_prompt
	)

	local tmpfile = vim.fn.tempname()
	vim.fn.writefile(vim.split(prompt, '\n', { plain = true }), tmpfile)

	local argv = provider.build_argv(CONFIG, opts)
	argv[#argv + 1] = '@' .. tmpfile

	runner.run(argv, CONFIG.sdk, provider)
end

local run_with_context = function(sel, user_prompt)
	local provider = providers.get(CONFIG.sdk)
	local filepath = vim.fn.expand('%:p')
	local root     = find_git_root(vim.fn.fnamemodify(filepath, ':h'))

	local session_id = provider.find_session(root)
	if not session_id then
		vim.notify(
			'Agentify(' .. CONFIG.sdk .. '): No session found for ' .. root,
			vim.log.levels.WARN
		)
		return
	end

	run(sel, user_prompt, { resume_id = session_id })
end

local ask = function(sel, fn)
	local ok, input = pcall(vim.fn.input, 'Agentify> ')
	if ok and input and input ~= '' then fn(sel, input) end
end

-- ---------------------------------------------------------------------------

return {
	setup = function(config)
		CONFIG = vim.tbl_deep_extend('force', CONFIG, config or {})
	end,

	act_line   = function() ask(selection.line(),   run) end,
	act_visual = function() ask(selection.visual(), run) end,
	act_file   = function() ask(selection.file(),   run) end,

	act_context_line   = function() ask(selection.line(),   run_with_context) end,
	act_context_visual = function() ask(selection.visual(), run_with_context) end,
	act_context_file   = function() ask(selection.file(),   run_with_context) end,
}
