require("neo-tree").setup({
	sources = { "filesystem", "buffers", "git_status", "document_symbols" },
	open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
	filesystem = {
		bind_to_cwd = false,
		follow_current_file = { enabled = true },
		use_libuv_file_watcher = true,
    hijack_netrw_behavior = 'disabled',
	},
	window = {
		mappings = {
			["<space>"] = "none",
		},
	},
	default_component_configs = {
		indent = {
			with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
	},
})

vim.api.nvim_create_autocmd("TermClose", {
	pattern = "*lazygit",
	callback = function()
		if package.loaded["neo-tree.sources.git_status"] then
			require("neo-tree.sources.git_status").refresh()
		end
	end,
})

F.vim.nmap(
	"<leader>pt",
	function()
		require("neo-tree.command").execute({
			toggle = true,
			dir = F.git.get_root(),
		})
	end
)

F.vim.nmap(
	"<leader>pT",
	function()
		require("neo-tree.command").execute({
			toggle = true,
			dir = vim.loop.cwd(),
		})
	end
)
