return {
	config = {
		defaults = {
			runners = 'preview',
		},
	},
	--TODO: for other languages as well
  type = 'internal',
	extenisons = { 'md' },
	filetypes = {
    'markdown',
    'mkdc',
  },
	runners = {
		-- TODO: type not supported yet
		preview = { cmd = 'MarkdownPreview', type = 'command' },
    markmap = 'MarkmapOpen',
	},
}
