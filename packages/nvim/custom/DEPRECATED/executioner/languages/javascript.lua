local getProjectRoot = function(directory)
	local directory = directory or vim.fn.expand('%:p:h')

	local gitRoot			= vim.fn.fnamemodify(vim.fn.finddir('.git', directory .. ';'), ':h')
	local packageRoot = vim.fn.fnamemodify(vim.fn.findfile('package.json', directory .. ';'), ':h')

	if #gitRoot > 0 then
		return gitRoot
	elseif #packageRoot > 0 then
		return packageRoot
	end
end

local isTestFile = function(filename)
	return string.match(filename, 'spec%.') or string.match(filename, 'test%.')
end

local isFixtureFile = function(filename)
	return string.match(filename, 'fixture%.')
end

local isSourceFile = function(filename)
	return not (isTestFile(filename) or isFixtureFile(filename))
end

local getSourceFileFromTestFile = function(filename)
	-- if string.match(filename, '%.spec') then
	--	 return vim.fn.fnamemodify(filename, ':r:r') .. '.' .. vim.fn.fnamemodify(filename, ':e')
	-- elseif string.match(filename, '%.test') then
	--	 return vim.fn.split(filename, '\\.test\\.')
	-- end
	return vim.fn.fnamemodify(filename, ':r:r') .. '.' .. vim.fn.fnamemodify(filename, ':e')
end

local getSourceFileFromFixtureFile = function(filename)
	-- return vim.fn.split(filename, '\\.fixture\\.')
	return vim.fn.fnamemodify(filename, ':r:r') .. '.' .. vim.fn.fnamemodify(filename, ':e')
end

local getTestFileFromSourceFile = function(filename)
	return vim.fn.fnamemodify(filename, ':r') .. '.test.' .. vim.fn.fnamemodify(filename, ':e')
end

local getSpecFileFromSourceFile = function(filename)
	return vim.fn.fnamemodify(filename, ':r') .. '.spec.' .. vim.fn.fnamemodify(filename, ':e')
end

local getFixtureFileFromSourceFile = function(filename)
	return vim.fn.fnamemodify(filename, ':r') .. '.fixture.' .. vim.fn.fnamemodify(filename, ':e')
end

local getSourceFile = function(filename, directory)
	local sourceFile = (
		isTestFile(filename) and
			getSourceFileFromTestFile(filename) or
			getSourceFileFromFixtureFile(filename)
	)

	sourceFile = vim.fn.findfile(sourceFile, directory)
	if vim.fn.filereadable(sourceFile) == 1 then
		return sourceFile
	end
end

--TODO for other types
local find_test_file = function(filename, directory)
	local sourceFile = (
		isFixtureFile(filename) and getSourceFileFromFixtureFile(filename) or
		filename
	)

	local specFilename = directory .. getSpecFileFromSourceFile(sourceFile)
	local testFilename = directory .. getTestFileFromSourceFile(sourceFile)

	if vim.fn.filereadable(specFilename) == 1 then
		return specFilename
	elseif vim.fn.filereadable(testFilename) == 1 then
		return testFilename
	end
end

local get_test_file = function(filename, directory)
	local directory = (
		(directory == nil or directory == '') and ''
		or (directory .. '/')
	)

	return (
		isTestFile(filename) and
			(directory .. filename) or
			find_test_file(filename, directory)
	)
end

local getFixtureFile = function(filename, directory)
	local directory = (
		(directory == nil or directory == '') and
		''
		or (directory .. '/')
	)

	local sourceFile = (
		isTestFile(filename) and
			getSourceFileFromTestFile(filename) or
			filename
	)

	local fixtureFile = directory .. getFixtureFileFromSourceFile(sourceFile)
	if vim.fn.filereadable(fixtureFile) == 1 then
		return fixtureFile
	end
end

local getExecutable = function(cmd)
	local projectBin = getProjectRoot() .. '/node_modules/.bin/' .. cmd
	local bin = (
		(vim.fn.executable(projectBin) == 1 and projectBin) or
		(vim.fn.executable(cmd) == 1 and cmd) or
		nil
	)

	if bin then return bin else vim.notify('"' .. cmd .. '" not found', 'error') end
end

local _getArgs = function(args)
	return (
		(type(args) == 'table' and vim.fn.join(args, ' ')) or
		args or
		''
	)
end

return {
	config = {
		paths = {
			tests = '__tests__',
			fixtures = '__fixtures__',
			mocks = '__mocks__',
		},
		defaults = {
			runners = 'node',
			repls = 'node',
			linters = 'eslint',
			formatters = 'prettier',
			testers = 'jest',
			installers = 'npm',
		},
		setup = {},
	},
	patterns = {
		--TOOD
		test = '%:p:r:S.test.js'
	},
	extenisons = {
		'js',
		'jsx',
	},
	filetypes = {
		'javascript',
		'javascriptreact',
	},
	operations = {
		run = {
			config = {
				default = 'node',
			},
			commands = {
				node = 'node',
				deno = 'deno',
			},
		},
		repl = {
			config = {
				default = 'node',
			},
			commands = {
				node = 'node',
			},
		},
		format = {
			config = {
				default = 'prettier',
			},
			commands = {
				prettier = {
					cmd = function()
						return getExecutable('prettier')
					end,
					args = '--write',
				},
			},
		},
		lint = {
			config = {
				default = 'eslint',
			},
			commands = {
				eslint = {
					cmd = function()
						return getExecutable('eslint')
					end,
				},
			},
		},
		test = {
			config = {
				default = 'jest',
			},
			commands = {
				jest = {
					cmd = function()
						return getExecutable('jest')
					end,
				},
			},
		},
	},
	helpers = {
		getProjectRoot							 = getProjectRoot,
		isTestFile									 = isTestFile,
		isFixtureFile								 = isFixtureFile,
		isSourceFile								 = isSourceFile,
		getSourceFileFromTestFile		 = getSourceFileFromTestFile,
		getSourceFileFromFixtureFile = getSourceFileFromFixtureFile,
		getTestFileFromSourceFile		 = getTestFileFromSourceFile,
		getSpecFileFromSourceFile		 = getSpecFileFromSourceFile,
		getFixtureFileFromSourceFile = getFixtureFileFromSourceFile,
		getSourceFile								 = getSourceFile,
		getTestFile									 = get_test_file,
		getFixtureFile							 = getFixtureFile,
		getExecutable								 = getExecutable,
	},
}
