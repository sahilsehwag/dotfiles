local colors = {
	bg			 = '#202328',
	blue		 = '#51afef';
	cyan		 = '#008080',
	darkblue = '#081633',
	fg			 = '#bbc2cf',
	green		 = '#98be65',
	magenta  = '#c678dd',
	orange	 = '#FF8800',
	red			 = '#ec5f67';
	violet	 = '#a9a1e1',
	yellow	 = '#fabd2f',
}

return {
	highlights = {
		fill = {
			guifg = {attribute = 'fg', highlight='Normal'},
			guibg = {attribute = 'bg', highlight = 'StatusLineNC'},
		},
		background = {
			guifg = {attribute = 'fg', highlight = 'Normal'},
			guibg = {attribute = 'bg', highlight = 'StatusLine'},
		},
		separator = {
			guifg = {attribute = 'bg', highlight = 'Normal'},
			guibg = {attribute = 'bg', highlight = 'StatusLine'},
		},
		separator_visible = {
			guifg = {attribute = 'fg', highlight = 'Normal'},
			guibg = {attribute = 'bg', highlight = 'StatusLineNC'},
		},
		separator_selected = {
			gui = 'bold',
			guifg = colors.darkblue,
			guibg = colors.blue,
		},
		indicator_selected = {
			gui = 'bold',
			guifg = colors.darkblue,
			guibg = colors.blue,
		},
		buffer_visible = {
			gui = 'bold',
			guifg = {attribute = 'fg', highlight='Normal'},
			guibg = {attribute = 'bg', highlight = 'Normal'},
		},
		buffer_selected = {
			gui = 'bold',
			guifg = colors.darkblue,
			guibg = colors.blue,
		},
		--tab = {
		--	--guifg = '<color-value-here>',
		--	--guibg = '<color-value-here>',
		--},
		tab_selected = {
			--guifg = tabline_sel_bg,
			gui = 'bold',
			guifg = colors.darkblue,
			guibg = colors.blue,
		},
		--tab_close = {
		--	--guifg = '<color-value-here>',
		--	--guibg = '<color-value-here>',
		--},
		modified = {
			guifg = {attribute = 'fg', highlight = 'Normal'},
			guibg = {attribute = 'bg', highlight = 'StatusLine'},
		},
		modified_visible = {
			guifg = {attribute = 'fg', highlight='Normal'},
			guibg = {attribute = 'bg', highlight = 'Normal'},
		},
		modified_selected = {
			gui = 'bold',
			guifg = colors.darkblue,
			guibg = colors.blue,
		},
		duplicate = {
			gui = '',
			guifg = colors.magenta,
			guibg = {attribute = 'bg', highlight = 'Normal'},
		},
		duplicate_visible = {
			gui = '',
			guifg = {attribute = 'fg', highlight = 'Normal'},
			guibg = {attribute = 'bg', highlight = 'Normal'},
		},
		duplicate_selected = {
			gui = 'bold',
			guifg = colors.darkblue,
			guibg = colors.blue,
		},
		pick = {
			gui = 'bold',
			guifg = colors.red,
			guibg = {attribute = 'bg', highlight = 'StatusLine'},
		},
		pick_visible = {
			gui = 'bold',
			guifg = colors.red,
			guibg = {attribute = 'bg', highlight = 'StatusLine'},
		},
		pick_selected = {
			gui = 'bold',
			guifg = colors.blue,
			guibg = colors.blue,
		},
		close_button = {
			guifg = {attribute = 'fg', highlight = 'Normal'},
			guibg = {attribute = 'bg', highlight = 'StatusLine'},
		},
		close_button_visible = {
			guifg = {attribute = 'fg', highlight='Normal'},
			guibg = {attribute = 'bg', highlight = 'Normal'},
		},
		close_button_selected = {
			gui = 'bold',
			guifg = colors.darkblue,
			guibg = colors.blue,
		},
		--diagnostic = {
		--	--guifg = <color-value-here>,
		--	--guibg = <color-value-here>,
		--},
		--diagnostic_visible = {
		--	--guifg = <color-value-here>,
		--	--guibg = <color-value-here>,
		--},
		diagnostic_selected = {
			gui = 'bold',
			--guifg = <color-value-here>,
			--guibg = <color-value-here>,
		},
		--info = {
		--	--guifg = <color-value-here>,
		--	--guisp = <color-value-here>,
		--	--guibg = <color-value-here>,
		--},
		--info_visible = {
		--	--guifg = <color-value-here>,
		--	--guibg = <color-value-here>,
		--},
		info_selected = {
			gui = 'bold',
			--guifg = <color-value-here>,
			--guibg = <color-value-here>,
			--guisp = <color-value-here>
		},
		--info_diagnostic = {
		--	--guifg = <color-value-here>,
		--	--guisp = <color-value-here>,
		--	--guibg = <color-value-here>
		--},
		--info_diagnostic_visible = {
		--	--guifg = <color-value-here>,
		--	--guibg = <color-value-here>
		--},
		info_diagnostic_selected = {
			gui = 'bold',
			--guifg = <color-value-here>,
			--guibg = <color-value-here>,
			--guisp = <color-value-here>,
		},
		--warning = {
		--	--guifg = <color-value-here>,
		--	--guisp = <color-value-here>,
		--	--guibg = <color-value-here>,
		--},
		--warning_visible = {
		--	--guifg = <color-value-here>,
		--	--guibg = <color-value-here>,
		--},
		warning_selected = {
			gui = 'bold',
			--guifg = <color-value-here>,
			--guibg = <color-value-here>,
			--guisp = <color-value-here>,
		},
		--warning_diagnostic = {
		--	--guifg = <color-value-here>,
		--	--guisp = <color-value-here>,
		--	--guibg = <color-value-here>,
		--},
		--warning_diagnostic_visible = {
		--	--guifg = <color-value-here>,
		--	--guibg = <color-value-here>,
		--},
		--warning_diagnostic_selected = {
		--  gui = 'bold',
		--  guisp = warning_diagnostic_fg,
		--},
		error = {
			guifg = colors.red,
			guibg = {attribute = 'bg', highlight = 'Normal'},
		},
		error_visible = {
			guifg = colors.red,
			guibg = {attribute = 'bg', highlight = 'Normal'},
		},
		error_selected = {
			gui = 'bold',
			guifg = colors.red,
			guibg = colors.blue,
		},
		error_diagnostic = {
			guifg = colors.red,
			guibg = {attribute = 'bg', highlight = 'Normal'},
		},
		error_diagnostic_visible = {
			guifg = colors.red,
			guibg = {attribute = 'bg', highlight = 'Normal'},
		},
		error_diagnostic_selected = {
			gui = 'bold',
			guifg = colors.red,
			guibg = colors.blue,
		},
	},
}
