return F.pipe(
	F.rf('fasd.utilities.get_git_dirs'),
	F.nvim.select_directory({})
)
