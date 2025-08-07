local get_formatted_string = function(data, formatter, default_formatter)
	if formatter then
		return formatter(data)
	elseif default_formatter then
		return default_formatter(data)
	elseif type(data) == 'string' then
		return data
	else
		return ''
	end
end

return {
	helpers = {},
	components = {
		general = {
			operation = function()
			end,
			spacer = function()
			end,
			search = function()
			end,
			jumplist = function()
			end,
		},
		buffer = {
			path = function()
			end,
			buffertype = function()
			end,
			filetype = function()
			end,
			status = function()
			end,
			trailing_whitespace = function()
			end,
			mixed_indent = function()
			end,
			line = function()
			end,
			column = function()
			end,
			percentage = function()
			end,
			alternative = function()
			end,
			size = function()
			end,
			encoding = function()
			end,
			formatting = function()
			end,
			icon = function()
			end,
			permissions = function()
			end,
			buffers = function()
			end,
		},
		project = {
			root = function()
			end,
			type = function()
			end,
		},
		git = {
			branch = function()
			end,
			changes = {
				added = function()
				end,
				deleted = function()
				end,
				changed = function()
				end,
			},
			remote = function()
			end,
			root = function()
			end,
		},
		lsp = {
			servers = function(formatter)
				local bufnr = vim.fn.bufnr('')
				local clients = vim.lsp.buf_get_clients(bufnr)
				local clientNames = {}

				for _,client in pairs(clients) do
					if client.name then
						table.insert(clientNames, client.name)
					end
				end

				return get_formatted_string(clientNames, formatter, function(data)
					return table.concat(data, ',')
				end)
			end,
			diagnostics = {
				errors = function()
				end,
				warnings = function()
				end,
				hints = function()
				end,
				infos = function()
				end,
			},
		},
		treesitter = {
			context = function()
			end,
			symbol = function()
			end,
			node = function()
			end,
		},
		vim = {
			mode = function(formatter)
				return get_formatted_string(vim.fn.mode(), formatter)
			end,
			client = function()
				if vim.fn.exists('g:vscode') == 1 then
					return 'vscode'
				elseif vim.fn.exists('g:started_by_firenvim') == 1 then
					return 'firenvim'
				elseif vim.fn.exists('neovide') == 1 then
					return 'neovide'
				elseif vim.fn.exists('nvui') == 1 then
					return 'nvui'
				elseif vim.fn.exists('goneovim') == 1 then
					return 'goneovim'
				end
			end,
			version = function(formatter)
				return get_formatted_string(vim.v.version, formatter)
			end,
		},
		system = {
			datetime = function()
			end,
			battery = function()
			end,
			network = function()
			end,
			ip = function()
			end,
			user = function()
			end,
			os = function(formatter)
				if vim.fn.has('mac') == 1 then
					return get_formatted_string('mac', formatter, function()
						return 'MacOS'
					end)
				elseif vim.fn.has('unix') == 1 then
					return get_formatted_string('unix', formatter, function()
						return 'Unix'
					end)
				elseif vim.fn.has('linux') == 1 then
					return get_formatted_string('linux', formatter, function()
						return 'Linux'
					end)
				end
			end,
			shell = function(formatter)
			end,
			terminal = function(formatter)
			end,
		},
		random = { },
		integration = {
			['vim-capslock'] = function(formatter)
				return get_formatted_string(
					vim.fn.exists('*CapsLockStatusline') == 1 and vim.fn.CapsLockStatusline('CAPS') or '',
					formatter
				)
			end,
		}
	},
	animations = {
		loaders = {},
		progress = {},
	},
	seperators = {
		square = function()
		end,
		parallelogram = function()
		end,
		semicircle = function()
		end,
		bullet = function()
		end,
		triangle = function()
		end,
		trapezoid = function()
		end,
	},
}
