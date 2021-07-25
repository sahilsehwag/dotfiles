"CONFIGURATION
	let g:firenvim_config = {
		\'globalSettings': {
			\'alt': 'all',
		\},
		\'localSettings': {
			\'.*': {
				\'cmdline': 'firenvim',
				\'priority': 0,
				\'selector': 'textarea',
				\'takeover': 'never',
			\},
		\}
	\}
"PLUGINS
	let g:startify_disable_at_vimenter = 0
