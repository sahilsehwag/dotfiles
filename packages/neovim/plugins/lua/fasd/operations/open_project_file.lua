return F.pipe(
	F.rf('fasd.utilities.get_project_files'),
	F.vim.select_file({})
)
