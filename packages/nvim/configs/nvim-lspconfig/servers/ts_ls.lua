--utilities
local rootPattern = require("lspconfig").util.root_pattern

return function(config)
	require("lspconfig").ts_ls.setup({
		on_attach = config.on_attach,
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		root_dir = rootPattern(
			"package.json",
			"tsconfig.json",
			"jsconfig.json",
			"node_modules",
			".git"
		),
		handlers = {
			--'davidosomething/format-ts-errors.nvim',
			--  ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
			--    if result.diagnostics == nil then
			--      return
			--    end
			--
			--    -- ignore some tsserver diagnostics
			--    local idx = 1
			--    while idx <= #result.diagnostics do
			--      local entry = result.diagnostics[idx]
			--
			--      local formatter = require("format-ts-errors")[entry.code]
			--      entry.message = formatter and formatter(entry.message) or entry.message
			--
			--      -- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
			--      if entry.code == 80001 then
			--        -- { message = "File is a CommonJS module; it may be converted to an ES module.", }
			--        table.remove(result.diagnostics, idx)
			--      else
			--        idx = idx + 1
			--      end
			--    end
			--
			--    vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
			--  end,
		},
	})
end
