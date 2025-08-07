local utils = require('libs.utils')
local merge = utils.table.dict.merge
local get_path = utils.table.dict.get_path

local CONFIG = require('executioner.config')
local LANGUAGES = CONFIG.languages

local terminal_cmd = CONFIG.cmds.terminal
local window_cmd = CONFIG.cmds.window

local get_lang_cfg_from_filetype = function(filetype)
	for _, config in pairs(LANGUAGES or {}) do
		for _, ft in ipairs(config.filetypes or {}) do
			if filetype == ft then
				return config
			end
		end
	end
end

local get_lang_cfg_from_extension = function(extension)
	for _, config in pairs(LANGUAGES or {}) do
		for _, ext in ipairs(config.extensions or {}) do
			if extension == ext then
				return config
			end
		end
	end
end

local get_language_config = function(config)
	local filetype = config.filetype or vim.bo.filetype
	local extension = config.extension or vim.fn.expand('%:e')

	local languageConfig = (
		LANGUAGES[config.language] or
		LANGUAGES[filetype] or
		LANGUAGES[extension] or
		get_lang_cfg_from_filetype(filetype) or
		get_lang_cfg_from_extension(extension)
	)

	if languageConfig then return languageConfig
	else
		vim.notify('Language config for filetype "' .. filetype .. '" or with extension".' .. extension .. '" not found', 'debug')
	end
end

local get_args = function(args)
	if type(args) == 'function' then
		args = args()
	end

	return (
		(type(args) == 'table' and vim.fn.join(args, ' ')) or
		args or
		''
	)
end

local get_field_cmd = function(field_name, field_value, config)
	local language = get_language_config(config)

	if not language[field_name] then
		vim.notify('Operation(' .. field_name .. ') not supported for this file')
		return
	end

	local default_field_value = get_path(language, 'config.defaults.' .. field_name) or language[field_name].default
	local field = language[field_name][field_value or default_field_value]

	local cmd = (
		(type(field) == 'string') and field or
		(type(field) == 'function') and field() or
		(type(field.cmd) == 'function' and field.cmd()) or
		(type(field.cmd) == 'string' and field.cmd) or
		''
	)
	local args = get_args(config.args or field.args)

	return cmd .. ' ' .. args
end

local get_filenames = function(config)
	local language = get_language_config(config)
	local patterns = language.patterns or {}

	return {
		vim.fn.expand(patterns.source or '%:p:S'),
		vim.fn.expand(patterns.target or '%:p:S'),
		--TODO
		vim.fn.expand(patterns.test or '%:p:S'),
	}
end

local run_cmd = function(runner, cmd)
	if type(runner) == 'string' then
		vim.cmd(runner .. ' '.. cmd)
	elseif type(runner) == 'function' then
		runner(cmd)
	else
    --TODO
		vim.notify('Invalid type for runner')
	end
end

local pacman_operation = function(operation, config)
	local language = get_language_config(config)
	local pacman = language.installers[language.installers.default]
	local cmd = pacman.core
	local operation = pacman[operation]

	local cmd = vim.fn.join({
		config.cmd or (cmd .. ' ' .. operation.cmd),
		get_args(config.args or operation.args),
		config.package or '',
	}, ' ')

	run_cmd(config.vim_runner or terminal_cmd, cmd)
end

local get_tmp_path = function(text)
end

--operation = {
--	cmd = '',
--	args = '',
--	filename = '',
--	vim_runner = '',
--	field = '',
--	mode = 'buffer|selection|line',
--}

return {
	setup = function(config)
		CONFIG = merge({ CONFIG, config or {} })
		LANGUAGES = CONFIG.languages

		terminal_cmd = CONFIG.cmds.terminal
		window_cmd = CONFIG.cmds.window
	end,
	compile = function(config)
		local cmd = vim.fn.join({
			get_field_cmd('compilers', config.compiler, config),
			config.filename or get_filenames(config)[1]
		}, ' ')

		run_cmd(config.vim_runner or terminal_cmd, cmd)
	end,
	run = function(config)
		local cmd = vim.fn.join({
			get_field_cmd('runners', config.runner, config),
			config.filename or get_filenames(config)[2]
		}, ' ')

		local ft_runner = (config.FT_X_RUNNER or {})[vim.bo.filetype]

		run_cmd(ft_runner or config.vim_runner or terminal_cmd, cmd)
	end,
	compile_run = function(config)
		local compile_cmd = vim.fn.join({
			get_field_cmd('compilers', config.compiler, config),
			config.filename or get_filenames(config)[1]
		}, ' ')

		local execute_cmd = vim.fn.join({
			get_field_cmd('runners', config.runner, config),
			config.filename or get_filenames(config)[2]
		}, ' ')

		local cmd = vim.fn.join({
			compile_cmd,
			'&&',
			execute_cmd,
		}, ' ')

		run_cmd(config.vim_runner or terminal_cmd, cmd)
	end,
	repl = function(config)
		run_cmd(
			config.vim_runner or terminal_cmd,
			get_field_cmd('repls', config.repl, config)
		)
	end,
	lint = function(config)
		local cmd = vim.fn.join({
			get_field_cmd('linters', config.linter, config),
			config.pattern or get_filenames(config)[1]
		}, ' ')

		run_cmd(config.vim_runner or terminal_cmd, cmd)
	end,
	format = function(config)
		local cmd = vim.fn.join({
			get_field_cmd('formatters', config.formatter, config),
			config.pattern or get_filenames(config)[1]
		}, ' ')

		vim.fn.system(cmd)
	end,
	test = function(config)
		local language = get_language_config(config)

		local directory = vim.fn.finddir(
			language.config.paths.tests,
			vim.fn.expand('%:h') .. ';'
		)

		local cmd = vim.fn.join({
			get_field_cmd('testers', config.tester, config),
			config.pattern or language.helpers.getTestFile(vim.fn.expand('%:t'), directory)
		}, ' ')

		run_cmd(config.vim_runner or terminal_cmd, cmd)
	end,
	debug = function(config)
	end,

	edit_source_file = function(config)
		local language = get_language_config(config)

		local filename = config.filename and vim.fn.fnamemodify(config.filename, ':t')
		local directory = config.filename and vim.fn.fnamemodify(config.filename, ':p:h:h')

		local source_file = language.helpers.getSourceFile(
			(filename and #filename > 0) and filename or vim.fn.expand('%:t'),
			(directory and #directory > 0) and directory or vim.fn.expand('%:p:h:h')
		)

		if source_file then
			run_cmd(config.vim_runner or window_cmd, source_file)
		else
			vim.notify('Source file not found', 'debug')
		end
	end,
	edit_test_file = function(config)
		local language = get_language_config(config)

		local filename = config.filename and vim.fn.fnamemodify(config.filename, ':t')
		local directory = config.filename and vim.fn.fnamemodify(config.filename, ':p:h')

		local directory = vim.fn.finddir(
			language.config.paths.tests,
			(directory and #directory > 0) and directory or vim.fn.expand('%:p:h') .. ';'
		)
		local test_file = language.helpers.getTestFile(
			(filename and #filename > 0) and filename or vim.fn.expand('%:t'),
			directory
		)

		if test_file then
			run_cmd(config.vim_runner or window_cmd, test_file)
		else
			vim.notify('Test file not found', 'debug')
		end
	end,
	edit_fixture_file = function(config)
		local language = get_language_config(config)

		local filename = config.filename and vim.fn.fnamemodify(config.filename, ':t')
		local directory = config.filename and vim.fn.fnamemodify(config.filename, ':p:h')

		local directory = vim.fn.finddir(
			language.config.paths.fixtures,
			(directory and #directory > 0) and directory or vim.fn.expand('%:p:h') .. ';'
		)
		local fixture_file = language.helpers.getFixtureFile(
			(filename and #filename > 0) and filename or vim.fn.expand('%:t'),
			directory
		)

		if fixture_file then
			run_cmd(config.vim_runner or window_cmd, fixture_file)
		else
			vim.notify('Fixture file not found', 'debug')
		end
	end,

	pacman = {
		install = function(config)
			pacman_operation('install', config)
		end,
		uninstall = function(config)
			pacman_operation('uninstall', config)
		end,
		upgrade = function(config)
			pacman_operation('upgrade', config)
		end,
		downgrade = function(config)
			pacman_operation('downgrade', config)
		end,
		update = function(config)
			pacman_operation('update', config)
		end,
		list = function(config)
			pacman_operation('list', config)
		end,
		info = function(config)
			pacman_operation('info', config)
		end,
		help = function(config)
			pacman_operation('help', config)
		end,
	},
}
