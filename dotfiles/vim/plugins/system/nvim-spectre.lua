--CONFIGURATION
	require('spectre').setup({
		line_sep = '──────────────────────────────────────────────────────────────────────────',
		result_padding = '	 ',
		replace_vim_cmd = "cfdo",
		is_open_target_win = false,
		is_insert_mode = false,
		highlight = {
			ui = "String",
			search = "DiffChange",
			replace = "DiffDelete",
		},
		mapping = {
			['delete_line'] = {
					map = "dd",
					cmd = "<cmd>lua require('spectre').delete()<CR>",
					desc = "delete current item",
			},
			['enter_file'] = {
					map = "<CR>",
					cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
					desc = "goto current file",
			},
			['send_to_qf'] = {
					map = "rq",
					cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
					desc = "send all item to quickfix",
			},
			['replace_cmd'] = {
					map = "rc",
					cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
					desc = "input replace vim command",
			},
			['show_option_menu'] = {
					map = "to",
					cmd = "<cmd>lua require('spectre').show_options()<CR>",
					desc = "show option",
			},
			['run_replace'] = {
					map = "rS",
					cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
					desc = "replace all",
			},
			['toggle_ignore_case'] = {
				map = "ti",
				cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
				desc = "toggle ignore case",
			},
			['toggle_ignore_hidden'] = {
				map = "th",
				cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
				desc = "toggle search hidden",
			},
		},
		find_engine = {
			-- rg is map wiht finder_cmd
			['rg'] = {
				cmd = "rg",
				args = {
					'--color=never',
					'--no-heading',
					'--with-filename',
					'--line-number',
					'--column',
				} ,
				options = {
					['ignore-case'] = {
						value= "--ignore-case",
						icon="[I]",
						desc="ignore case",
					},
					['hidden'] = {
						value="--hidden",
						desc="hidden file",
						icon="[H]",
					},
				},
			},
		},
		replace_engine={
			['sed']={
				cmd = "sed",
				args = nil,
			},
		},
		default = {
			find = {
				--pick one of item that find_engine
				cmd = "rg",
				options = {"ignore-case"},
			},
			replace={
				--pick one of item that replace_engine
				cmd = "sed",
			},
		},
	})
--MAPPINGS
	vim.cmd [[ nnoremap <silent> <leader>ft :lua require('spectre').open()<CR> ]]
