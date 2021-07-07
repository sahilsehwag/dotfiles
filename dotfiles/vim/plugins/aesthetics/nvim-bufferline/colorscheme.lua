return {
	highlights = {
		fill = {
			guifg = {attribute = "fg", highlight="Normal"},
			guibg = {attribute = "bg", highlight = "StatusLineNC"},
		},
		background = {
			guifg = {attribute = "fg", highlight = "Normal"},
			guibg = {attribute = "bg", highlight = "StatusLine"},
		},
		separator = {
			guifg = {attribute = "bg", highlight = "Normal"},
			guibg = {attribute = "bg", highlight = "StatusLine"},
		},
		separator_visible = {
			guifg = {attribute = "fg", highlight = "Normal"},
			guibg = {attribute = "bg", highlight = "StatusLineNC"},
		},
		separator_selected = {
			gui = 'bold',
			guifg = colors.darkblue,
			guibg = colors.blue,
		},
		--indicator_selected = {
			-- --guifg = '<color-value-here>',
			--guibg = {attribute = "bg", highlight = "Search"},
		--},
		buffer_visible = {
			gui = "",
			guifg = {attribute = "fg", highlight="Normal"},
			guibg = {attribute = "bg", highlight = "Normal"},
		},
		buffer_selected = {
			gui = "bold,italic",
			guifg = {attribute = "fg", highlight="Normal"},
			guibg = {attribute = "bg", highlight = "Normal"},
		},
		--tab = {
		--  --guifg = '<color-value-here>',
		--  --guibg = '<color-value-here>',
		--},
		--tab_selected = {
		--  guifg = tabline_sel_bg,
		--  --guibg = '<color-value-here>'
		--},
		--tab_close = {
		--  --guifg = '<color-value-here>',
		--  --guibg = '<color-value-here>',
		--},
		modified = {
			guifg = {attribute = "fg", highlight = "Normal"},
			guibg = {attribute = "bg", highlight = "StatusLine"},
		},
		modified_visible = {
			guifg = {attribute = "fg", highlight="Normal"},
			guibg = {attribute = "bg", highlight = "Normal"},
		},
		modified_selected = {
			guifg = {attribute = "fg", highlight="Normal"},
			guibg = {attribute = "bg", highlight = "Normal"},
		},
		duplicate_selected = {
			gui = "bold",
		},
		duplicate_visible = {
			gui = "italic",
		},
		duplicate = {
			gui = "italic",
		},
		pick = {
			gui = "bold,italic",
		},
		pick_visible = {
			gui = "bold,italic",
		},
		pick_selected = {
			gui = "bold,italic",
		},
		close_button = {
			guifg = {attribute = "fg", highlight = "Normal"},
			guibg = {attribute = "bg", highlight = "StatusLine"},
		},
		close_button_visible = {
			guifg = {attribute = "fg", highlight="Normal"},
			guibg = {attribute = "bg", highlight = "Normal"},
		},
		close_button_selected = {
			guifg = {attribute = "fg", highlight="Normal"},
			guibg = {attribute = "bg", highlight = "Normal"},
		},
		--diagnostic = {
		--  --guifg = <color-value-here>,
		--  --guibg = <color-value-here>,
		--},
		--diagnostic_visible = {
		--  --guifg = <color-value-here>,
		--  --guibg = <color-value-here>,
		--},
		diagnostic_selected = {
			gui = "bold,italic",
			--guifg = <color-value-here>,
			--guibg = <color-value-here>,
		},
		--info = {
		--  --guifg = <color-value-here>,
		--  --guisp = <color-value-here>,
		--  --guibg = <color-value-here>,
		--},
		--info_visible = {
		--  --guifg = <color-value-here>,
		--  --guibg = <color-value-here>,
		--},
		info_selected = {
			gui = "bold,italic",
			--guifg = <color-value-here>,
			--guibg = <color-value-here>,
			--guisp = <color-value-here>
		},
		--info_diagnostic = {
		--  --guifg = <color-value-here>,
		--  --guisp = <color-value-here>,
		--  --guibg = <color-value-here>
		--},
		--info_diagnostic_visible = {
		--  --guifg = <color-value-here>,
		--  --guibg = <color-value-here>
		--},
		info_diagnostic_selected = {
			gui = "bold,italic",
			--guifg = <color-value-here>,
			--guibg = <color-value-here>,
			--guisp = <color-value-here>,
		},
		--warning = {
		--  --guifg = <color-value-here>,
		--  --guisp = <color-value-here>,
		--  --guibg = <color-value-here>,
		--},
		--warning_visible = {
		--  --guifg = <color-value-here>,
		--  --guibg = <color-value-here>,
		--},
		warning_selected = {
			gui = "bold,italic",
			--guifg = <color-value-here>,
			--guibg = <color-value-here>,
			--guisp = <color-value-here>,
		},
		--warning_diagnostic = {
		--  --guifg = <color-value-here>,
		--  --guisp = <color-value-here>,
		--  --guibg = <color-value-here>,
		--},
		--warning_diagnostic_visible = {
		--  --guifg = <color-value-here>,
		--  --guibg = <color-value-here>,
		--},
		warning_diagnostic_selected = {
			gui = "bold,italic",
			--guifg = <color-value-here>,
			--guibg = <color-value-here>,
			guisp = warning_diagnostic_fg,
		},
		--error = {
		--  --guifg = <color-value-here>,
		--  --guibg = <color-value-here>,
		--  --guisp = <color-value-here>,
		--},
		--error_visible = {
		--  --guifg = <color-value-here>,
		--  --guibg = <color-value-here>,
		--},
		error_selected = {
			gui = "bold,italic",
			--guifg = <color-value-here>,
			--guibg = <color-value-here>,
			--guisp = <color-value-here>,
		},
		--error_diagnostic = {
		--  --guifg = <color-value-here>,
		--  --guibg = <color-value-here>,
		--  --guisp = <color-value-here>,
		--},
		--error_diagnostic_visible = {
		--  --guifg = <color-value-here>,
		--  --guibg = <color-value-here>,
		--},
		error_diagnostic_selected = {
			gui = "bold,italic",
			--guifg = <color-value-here>,
			--guibg = <color-value-here>,
			--guisp = <color-value-here>,
		},
	},
}
