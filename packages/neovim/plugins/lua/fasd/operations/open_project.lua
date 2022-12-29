return function(on_select)
  local opts = {}

	if on_select then
		opts.on_select = on_select
	end

	return F.pipe(
		F.rf('fasd.utilities.get_dirs'),
		F.vim.select_directory(opts)
	)()
end
