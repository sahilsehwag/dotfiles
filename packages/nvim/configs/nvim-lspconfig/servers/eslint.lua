return {
	config = {
		root_dir = function(bufnr, on_dir)
			local eslint_markers = {
				'.eslintrc',
				'.eslintrc.js',
				'.eslintrc.cjs',
				'.eslintrc.json',
				'.eslintrc.yaml',
				'.eslintrc.yml',
				'eslint.config.js',
				'eslint.config.mjs',
				'eslint.config.cjs',
				'package.json', -- monorepo: attach at sub-package level
			}
			local root = vim.fs.root(bufnr, eslint_markers)
			if root then on_dir(root) end
		end,
		settings = {
			workingDirectories = { mode = 'auto' }, -- monorepo: server resolves eslint lib per file
		},
	},
	on_attach = function(_, bufnr)
		vim.api.nvim_create_autocmd('BufWritePre', {
			buffer  = bufnr,
			command = 'EslintFixAll',
		})
	end,
}
