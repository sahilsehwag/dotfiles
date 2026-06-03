return {
	config = {
		filetypes = {
			'javascript',
			'javascriptreact',
			'javascript.jsx',
			'typescript',
			'typescriptreact',
			'typescript.tsx',
		},
		-- Override root_dir: only attach when a real project config exists.
		-- The built-in only searches for lock files and falls back to cwd,
		-- causing ts_ls to run in implicit-project mode (no tsconfig) where
		-- it treats even .ts files as JS and fires 8016 on type assertions.
		root_dir = function(bufnr, on_dir)
			-- Prefer tsconfig/jsconfig so ts_ls gets proper project context.
			-- Fall back to package.json so it still attaches in projects where
			-- tsconfig lives at a monorepo root above the package boundary.
			local root = vim.fs.root(bufnr, { 'tsconfig.json', 'jsconfig.json' })
				or vim.fs.root(bufnr, { 'package.json' })
			if root then
				on_dir(root)
			end
		end,
		init_options = {
			hostInfo = 'neovim',
			maxTsServerMemory = 16384, -- MB; raised for large monorepos (default ~3072)
		},
	},
	on_attach = function(client, bufnr)
		-- lsp-format-modifications.nvim is currently disabled (see plugins.lua --FIX:broken).
		-- Guard with pcall so a missing module does not break ts_ls attach.
		local ok, lsp_fmt = pcall(require, 'lsp-format-modifications')
		if ok then
			lsp_fmt.attach(client, bufnr, { format_on_save = false })
		end
	end,
}
