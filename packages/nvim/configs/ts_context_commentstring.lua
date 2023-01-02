require('ts_context_commentstring').setup {
	enable = true,
	config = {
		css = '// %s',
		javascript = {
			__default = '// %s',
			jsx_element = '{/* %s */}',
			jsx_fragment = '{/* %s */}',
			jsx_attribute = '// %s',
			comment = '// %s'
		},
	},
}

