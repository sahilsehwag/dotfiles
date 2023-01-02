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
		preview = 'MarkdownPreview',
    markmap = 'MarkmapOpen',
	},
}
