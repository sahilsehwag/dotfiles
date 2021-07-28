--CONFIGURATION
	vim.g.nvim_tree_disable_keybindings = true
	vim.g.nvim_tree_side = 'left'
	vim.g.nvim_tree_width = 45
	vim.g.nvim_tree_ignore = {
		'.git',
		'node_modules',
		'.cache',
	}
	vim.g.nvim_tree_auto_open = 1
	vim.g.nvim_tree_auto_close = 0
	vim.g.nvim_tree_auto_ignore_ft = {
		'startify',
		'dashboard',
	}
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

	local tree_cb = require'nvim-tree.config'.nvim_tree_callback
	vim.g.nvim_tree_bindings = {
		{ key = "<CR>",  cb = tree_cb("cd") },
		{ key = "<BS>",  cb = tree_cb("dir_up") },
		{ key = "l",     cb = tree_cb("edit") },
		{ key = "h",     cb = tree_cb("close_node") },
		{ key = "<C-v>", cb = tree_cb("vsplit") },
		{ key = "<C-h>", cb = tree_cb("split") },
		{ key = "<C-t>", cb = tree_cb("tabnew") },
		{ key = "<Tab>", cb = tree_cb("preview") },
		{ key = ".",     cb = tree_cb("toggle_dotfiles") },
		{ key = "I",     cb = tree_cb("toggle_ignored") },
		{ key = "a",     cb = tree_cb("create") },
		{ key = "D",     cb = tree_cb("remove") },
		{ key = "d",     cb = tree_cb("cut") },
		{ key = "y",     cb = tree_cb("copy") },
		{ key = "p",     cb = tree_cb("paste") },
		{ key = "r",     cb = tree_cb("full_rename") },
		{ key = "R",     cb = tree_cb("rename") },
		{ key = "[g",    cb = tree_cb("prev_git_item") },
		{ key = "]g",    cb = tree_cb("next_git_item") },
		{ key = "<C-r>", cb = tree_cb("refresh") },
		{ key = "q",     cb = tree_cb("close") },
	}
