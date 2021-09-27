F.rt'fasd'.setup()

F.nvim.nmap('<leader>po', F.rt'fasd'.open_project)

local open_nvim = function(dir)
	if dir then
		F.nvim.open_nvim_in_tmux{pwd=dir}
	end
end

F.nvim.nmap(' mo', function()
	require'fasd'.open_project(open_nvim)
end)
