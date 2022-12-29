require('dressing').setup({
	input = {
		enabled = false,
		default_prompt = 'Input:',
		prompt_align = 'left', -- left|right|center
		insert_only = false, -- when true, <esc> will close the modal

		--anchor = 'SW',
		border = 'rounded',
		relative = 'editor', -- editor|cursor|win

		-- these can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
		prefer_width = 40,
		width = nil,
		-- min_width and max_width can be a list of mixed types.
		-- min_width = {20, 0.2} means 'the greater of 20 columns or 20% of total'
		max_width = { 140, 0.9 },
		min_width = { 20, 0.2 },

		win_options = {
			winhighlight = '',
			winblend = 0, -- transparency=0-100
		},

		override = function(conf)
			-- This is the config that will be passed to nvim_open_win.
			-- Change values here to customize the layout
			return conf
		end,

		get_config = nil,
	},
	select = {
		enabled = true,
		backend = {
      'telescope',
      'fzf_lua',
      'fzf',
      'builtin',
      'nui',
    },

    --telescope = require('telescope.themes').get_ivy(),
		telescope = {
			layout_strategy = 'center',
			layout_config = {
				vertical = {
					width = 0.5,
					height = 0.5,
				},
				center = {
					width = 0.5,
					--height = 0.5,
				},
			},
		},
		fzf = {
			window = { width = 0.5, height = 0.4 },
		},
		fzf_lua = {
			winopts = { width = 0.5, height = 0.4 },
		},
		nui = {
			position = '50%',
			size = nil,
			relative = 'editor',
			border = { style = 'rounded' },
			max_width = 80,
			max_height = 40,
		},
		builtin = {
			anchor = 'NW',
			border = 'rounded',
			relative = 'editor',

			width = nil,
			max_width = { 140, 0.8 },
			min_width = { 40, 0.2 },
			height = nil,
			max_height = 0.9,
			min_height = { 10, 0.2 },

			win_options = {
				winblend = 10,
				winhighlight = '',
			},

			override = function(conf)
				return conf
			end,
		},

		format_item_override = {},
		get_config = nil,
	},
})
