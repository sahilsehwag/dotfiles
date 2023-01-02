local get_runner_from_vim_cmd = function(runner)
	return function(cmd)
		vim.api.nvim_command(runner .. ' ' .. cmd)
	end
end

local get_runner = Funk.if_else(
	Funk.is_function,
	Funk.id,
	get_runner_from_vim_cmd
)

return Funk.curry(function(runner, cmd)
	return Funk.pipe(
		Funk.sh.get_cmd,
		Funk.if_else(
			Funk.is_nil,
			Funk.noop,
			get_runner(runner)
		)
	)(cmd)
end)
