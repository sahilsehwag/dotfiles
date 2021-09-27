return F.pipe(
	F.rf('fasd.utilities.get_files'),
	F.nvim.select_file({})
)
