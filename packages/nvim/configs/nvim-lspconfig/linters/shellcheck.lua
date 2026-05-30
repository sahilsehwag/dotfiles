local ns = vim.api.nvim_create_namespace('shellcheck')

return {
	setup = function()
		vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost' }, {
			pattern  = { '*.sh', '*.bash' },
			callback = function(ev)
				local fname = vim.api.nvim_buf_get_name(ev.buf)
				if fname == '' then return end
				vim.system(
					{ 'shellcheck', '--format=json', fname },
					{ text = true },
					function(result)
						local diagnostics = {}
						local out = result.stdout ~= '' and result.stdout or result.stderr
						if out and out ~= '' then
							local ok, data = pcall(vim.json.decode, out)
							if ok and data then
								for _, item in ipairs(data) do
									table.insert(diagnostics, {
										lnum     = (item.line or 1) - 1,
										col      = (item.column or 1) - 1,
										end_lnum = (item.endLine or item.line or 1) - 1,
										end_col  = (item.endColumn or item.column or 1) - 1,
										message  = item.message,
										severity = item.level == 'error'   and vim.diagnostic.severity.ERROR
										        or item.level == 'warning' and vim.diagnostic.severity.WARN
										        or                             vim.diagnostic.severity.INFO,
										source   = 'shellcheck(SC' .. (item.code or '') .. ')',
										code     = item.code,
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
