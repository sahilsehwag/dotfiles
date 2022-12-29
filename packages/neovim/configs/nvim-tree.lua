--SETUP
	vim.cmd [[ set termguicolors ]]
	local tree_cb = require('nvim-tree.config').nvim_tree_callback
	require('nvim-tree').setup({
		--disables netrw completely
		disable_netrw				= true,
		--hijack netrw window on startup
		hijack_netrw				= true,
		--open the tree when running this setup function
		open_on_setup				= false,
		--will not open on setup if the filetype is in this list
		ignore_ft_on_setup	= {},
		--opens the tree when changing/opening a new tab if the tree wasn't previously opened
		open_on_tab					= true,
		--hijacks new directory buffers when they are opened.
  	hijack_directories = {
			--enable the feature
			enable = false, -- disabling for dirbuf.nvim
			--allow to open the tree if it was previously closed
			--auto_open = true,
		},
		--hijack the cursor in the tree to put it at the start of the filename
		hijack_cursor				= true,
		--updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
		update_cwd					= true,
		live_filter = {
			prefix = "[FILTER]: ",
			always_show_folders = true,
		},
		--show lsp diagnostics in the signcolumn
		diagnostics = {
			enable = false,
			show_on_dirs = false,
			debounce_delay = 50,
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			},
		},
		--update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
		actions = {
			open_file = {
				--if true the tree will resize itself after opening a file
				resize_window = true,
			},
		},
		update_focused_file = {
			--enables the feature
			enable			= true,
			--update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
			--only relevant when `update_focused_file.enable` is true
			update_cwd	= false,
			--list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
			--only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
			ignore_list = {}
		},
		--configuration options for the system open command (`s` in the tree by default)
		system_open = {
			--the command to run this, leaving nil should work in most cases
			cmd  = nil,
			--the command arguments as a list
			args = {}
		},
		view = {
			--width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
			width = 40,
			--side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
			side = 'left',
			mappings = {
				--custom only false will merge the list with the default mappings
				--if true, it will only use your list to set the mappings
				custom_only = false,
				--list of mappings to set on the tree manually
				list = {
					{ key = '<CR>',  cb = tree_cb('cd') },
					{ key = '<BS>',  cb = tree_cb('dir_up') },
					{ key = 'l',		 cb = tree_cb('edit') },
					{ key = 'h',		 cb = tree_cb('close_node') },
					{ key = 'P',		 cb = tree_cb('parent_node') },
					{ key = '<',		 cb = tree_cb('prev_sibling') },
					{ key = '>',		 cb = tree_cb('next_sibling') },
					{ key = 'K',		 cb = tree_cb('first_sibling') },
					{ key = 'J',		 cb = tree_cb('last_sibling') },
					{ key = '<C-v>', cb = tree_cb('vsplit') },
					{ key = '<C-h>', cb = tree_cb('split') },
					{ key = '<C-t>', cb = tree_cb('tabnew') },
					{ key = '<Tab>', cb = tree_cb('preview') },
					{ key = '<C-.>', cb = tree_cb('toggle_dotfiles') },
					{ key = '<C-i>', cb = tree_cb('toggle_ignored') },
					{ key = '<LocalerLeader>.', cb = tree_cb('toggle_dotfiles') },
					{ key = '<LocalerLeader>i', cb = tree_cb('toggle_ignored') },
					{ key = 'o',		 cb = tree_cb('create') },
					{ key = 'D',		 cb = tree_cb('remove') },
					{ key = 'x',		 cb = tree_cb('cut') },
					{ key = 'y',		 cb = tree_cb('copy') },
					{ key = 'gy',		 cb = tree_cb('copy_path') },
					{ key = 'gY',		 cb = tree_cb('copy_absolute_path') },
					{ key = 'p',		 cb = tree_cb('paste') },
					{ key = 'r',		 cb = tree_cb('rename') },
					{ key = 'R',		 cb = tree_cb('full_rename') },
					{ key = '[g',		 cb = tree_cb('prev_git_item') },
					{ key = ']g',		 cb = tree_cb('next_git_item') },
					{ key = '<C-r>', cb = tree_cb('refresh') },
					{ key = 'q',		 cb = tree_cb('close') },
					{ key = 'g?',		 cb = tree_cb('toggle_help') },
					{ key = 's',		 cb = tree_cb('system') },
					{ key = 'zR',		 cb = tree_cb('expand_all') },
					{ key = 'zM',		 cb = tree_cb('collapse_all') },
				},
			},
		},
	})
--CONFIGURATION
	--vim.g.nvim_tree_disable_keybindings = true
	vim.g.nvim_tree_ignore = {
		--'.git',
		--'node_modules',
		'.cache',
	}
	vim.g.nvim_tree_auto_ignore_ft = {
		'startify',
		'dashboard',
	}
	vim.g.nvim_tree_quit_on_open = 0
	vim.g.nvim_tree_indent_markers = 1
	vim.g.nvim_tree_hide_dotfiles = 0
	vim.g.nvim_tree_git_hl = 1
	vim.g.nvim_tree_root_folder_modifier = ':~'
	vim.g.nvim_tree_width_allow_resize	= 1
	vim.g.nvim_tree_add_trailing = 1
	vim.g.nvim_tree_gitignore = 1
	vim.g.nvim_tree_highlight_opened_files = 1
	vim.g.nvim_tree_disable_window_picker = 0
	vim.g.nvim_tree_icon_padding = ' '
	vim.g.nvim_tree_respect_buf_cwd = 1
	vim.g.nvim_tree_group_empty = 1
	--List of filenames that gets highlighted with NvimTreeSpecialFile
	vim.g.nvim_tree_special_files = {
		['README.md'] = 1,
		Makefile = 1,
		MAKEFILE = 1,
	}
	vim.g.nvim_tree_window_picker_exclude = {
		filetype = {
			'notify',
			'packer',
			'qf',
		},
		buftype = {
			'terminal',
		},
	}
--ICONS
	vim.g.nvim_tree_show_icons = {
		git = 1,
		folders = 1,
		files = 1,
		folder_arrows = 1,
	};
	vim.g.nvim_tree_icons = {
		git = {
			untracked = "",
			unstaged	= "",
			staged		= "",
			renamed		= "➜",
			unmerged	= "",
			deleted = "",
			ignored = "◌",
		},
		default = '',
		symlink = '',
		folder = {
			arrow_open = "",
			arrow_closed = "",
			default = "",
			open = "",
			empty = "",
			empty_open = "",
			symlink = "",
			symlink_open = "",
		},
		lsp = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	};
--MAPPPINGS
	F.vim.nmap('<Leader>pt', '<cmd>NvimTreeToggle<cr>')
