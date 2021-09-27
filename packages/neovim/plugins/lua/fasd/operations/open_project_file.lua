return F.pipe(
	F.rf('fasd.utilities.get_project_files'),
	F.nvim.select_file({})
)
