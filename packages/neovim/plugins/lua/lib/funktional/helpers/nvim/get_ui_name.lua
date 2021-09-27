return function()
  if vim.fn.exists('neovide') == 1 then
		return 'neovide'
	elseif vim.fn.exists('goneovim') == 1 then
		return 'goneovim'
	else
		return 'terminal'
	end
end
