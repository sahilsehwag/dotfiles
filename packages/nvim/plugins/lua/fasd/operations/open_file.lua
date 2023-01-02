return F.pipe(
	F.rf('fasd.utilities.get_files'),
	F.vim.select_file({})
)
