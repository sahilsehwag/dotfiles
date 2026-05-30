-- MAPPINGS
	F.vim.nmap('<Leader>l.s', '<cmd>lua vim.lsp.enable(vim.bo.filetype)<cr>')
	F.vim.nmap('<Leader>l.r', '<cmd>lua for _,c in ipairs(vim.lsp.get_clients({bufnr=0})) do vim.lsp.start(c.config) end<cr>')
	F.vim.nmap('<Leader>l.k', '<cmd>lua vim.lsp.stop_client(vim.lsp.get_clients({bufnr=0}))<cr>')
	F.vim.nmap('<Leader>l.i', '<cmd>checkhealth vim.lsp<cr>')

-- LOADER (loads sibling servers/ and linters/ files by name)
	local _dir = debug.getinfo(1, 'S').source:sub(2):match('(.+)/[^/]+$')
	local function load_mod(rel)
		local path = _dir .. '/' .. rel .. '.lua'
		if vim.fn.filereadable(path) == 1 then
			local ok, m = pcall(dofile, path)
			return ok and m or nil
		end
	end

-- SERVERS
	local SERVERS = {
		'vimls',
		'lua_ls',

		'html',
		'cssls',
		'eslint',
		'ts_ls',
		--'tailwindcss',

		--'pyright',

		--'hls',

		--'clangd',
		--'gopls',
		--'rust_analyzer',
		'protols',

		--'solargraph',

		--'jdtls',

		'sqlls',
		'bashls',
		'jsonls',
		'yamlls',
		'dockerls',
		'lemminx',
	}

	for _, server in ipairs(SERVERS) do
		local mod = load_mod('servers/' .. server)
		if mod and mod.config then
			vim.lsp.config(server, mod.config)
		end
		vim.lsp.enable(server)
	end

-- ATTACH
	vim.api.nvim_create_autocmd('LspAttach', {
		callback = function(ev)
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			if not client then return end
			local bufnr = ev.buf

			require('nvim-navbuddy').attach(client, bufnr)

			if client.supports_method('textDocument/inlayHint') then
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end

			local mod = load_mod('servers/' .. client.name)
			if mod and mod.on_attach then
				mod.on_attach(client, bufnr)
			end
		end,
	})

-- LINTERS
	local protolint  = load_mod('linters/protolint')
	if protolint  then protolint.setup()  end
	local shellcheck = load_mod('linters/shellcheck')
	if shellcheck then shellcheck.setup() end
