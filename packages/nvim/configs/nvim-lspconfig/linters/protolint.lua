local ns = vim.api.nvim_create_namespace('protolint')

return {
	setup = function()
		vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost' }, {
			pattern  = '*.proto',
			callback = function(ev)
				local fname = vim.api.nvim_buf_get_name(ev.buf)
				if fname == '' then return end
				vim.system(
					{ 'protolint', 'lint', '--reporter', 'json', fname },
					{ text = true },
					function(result)
						local diagnostics = {}
						if result.stdout and result.stdout ~= '' then
							local ok, data = pcall(vim.json.decode, result.stdout)
							if ok and data and data.lints then
								for _, lint in ipairs(data.lints) do
									table.insert(diagnostics, {
										lnum     = (lint.line or 1) - 1,
										col      = (lint.column or 1) - 1,
										message  = lint.message,
										severity = lint.severity == 'error'
											and vim.diagnostic.severity.ERROR
											or  vim.diagnostic.severity.WARN,
										source   = 'protolint(' .. (lint.rule or '') .. ')',
									})
								end
							end
						end
						vim.schedule(function()
							vim.diagnostic.set(ns, ev.buf, diagnostics)
						end)
					end
				)
			end,
		})
	end,
}
