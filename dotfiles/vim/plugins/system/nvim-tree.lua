--CONFIGURATION
	vim.g.nvim_tree_disable_keybindings = true
	vim.g.nvim_tree_side = 'left'
	vim.g.nvim_tree_width = 40
	vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' }
	vim.g.nvim_tree_auto_open = 1
	vim.g.nvim_tree_auto_close = 0
	vim.g.nvim_tree_auto_ignore_ft = { 'startify', 'dashboard' }
	vim.g.nvim_tree_quit_on_open = 0
	vim.g.nvim_tree_follow = 1
	vim.g.nvim_tree_indent_markers = 0
	vim.g.nvim_tree_hide_dotfiles = 0
	vim.g.nvim_tree_git_hl = 1
	vim.g.nvim_tree_root_folder_modifier = ':~'
	vim.g.nvim_tree_tab_open = 1
	vim.g.nvim_tree_width_allow_resize	= 1
	vim.g.nvim_tree_disable_netrw = 0
	vim.g.nvim_tree_hijack_netrw = 0
	vim.g.nvim_tree_add_trailing = 1
--ICONS
	vim.g.nvim_tree_show_icons = {
		git = 1;
		folders = 1;
		files = 1;
	};
	vim.g.nvim_tree_icons = {
		git = {
			untracked = "";
			unstaged	= "";
			staged		= "";
			renamed		= "➜";
			unmerged	= "";
		};
	};
--MAPPPINGS
	vim.cmd [[ nnoremap <silent> <Leader>pe :NvimTreeToggle<CR> ]]
	vim.cmd [[ nnoremap <silent> <Leader>pE :NvimTreeFindFile<CR> ]]

	local tree_cb = require'nvim-tree.config'.nvim_tree_callback
	vim.g.nvim_tree_bindings = {
		["<CR>"]	= tree_cb("cd"),
		["<BS>"]	= tree_cb("dir_up"),

		["l"]			= tree_cb("edit"),
		["h"]			= tree_cb("close_node"),
		["<C-v>"] = tree_cb("vsplit"),
		["<C-h>"] = tree_cb("split"),
		["<C-t>"] = tree_cb("tabnew"),

		["<Tab>"] = tree_cb("preview"),

		["."]			= tree_cb("toggle_dotfiles"),
		["I"]			= tree_cb("toggle_ignored"),

		["a"]			= tree_cb("create"),
		["D"]			= tree_cb("remove"),
		["d"]			= tree_cb("cut"),
		["y"]			= tree_cb("copy"),
		["p"]			= tree_cb("paste"),
		["r"]			= tree_cb("rename"),
		["R"]			= tree_cb("full_rename"),

		["[g"]		= tree_cb("prev_git_item"),
		["]g"]		= tree_cb("next_git_item"),

		["<C-r>"] = tree_cb("refresh"),
		["q"]			= tree_cb("close"),
	}
