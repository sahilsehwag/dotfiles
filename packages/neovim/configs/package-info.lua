require('package-info').setup({
	colors = {
		up_to_date = '#98C379',
		outdated = '#E5C07B',
	},
	icons = {
		enable = true,
		style = {
			up_to_date = ' ',
			outdated = ' ',
		},
	},
	autostart = true,
	hide_up_to_date = true,
	hide_unstable_versions = false,
	-- package_manager = 'npm',
})


vim.api.nvim_set_keymap('n', '<LocalLeader>s', ':lua require("package-info").show({force = true})<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<LocalLeader>h', ':lua require("package-info").hide()<CR>',               { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<LocalLeader>u', ':lua require("package-info").update()<CR>',             { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<LocalLeader>d', ':lua require("package-info").delete()<CR>',             { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<LocalLeader>i', ':lua require("package-info").install()<CR>',            { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<LocalLeader>r', ':lua require("package-info").reinstall()<CR>',          { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<LocalLeader>v', ':lua require("package-info").change_version()<CR>',     { silent = true, noremap = true })

