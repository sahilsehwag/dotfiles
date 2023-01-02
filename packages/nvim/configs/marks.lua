require('marks').setup({
	default_mappings = true, -- whether to map keybinds or not. default true
	--builtin_marks = { ".", "<", ">", "^" }, -- which builtin marks to show. default {}
	cyclic = true, -- whether movements cycle back to the beginning/end of buffer. default true
	force_write_shada = false, -- whether the shada file is updated after modifying uppercase marks. default false
	bookmark_0 = { -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own sign/virttext
    sign = '⚑',
		virt_text = 'CodeReferences',
	},
	mappings = {
		--leader               = '',
		--set_next             = '',
		--toggle               = '',
		--delete_line          = '',
		--delete_buf           = '',
		--next                 = '',
		--prev                 = '',
		--preview              = '',
		--set                  = '',
		--delete               = '',
		--set_bookmark[0-9]    = '',
		--delete_bookmark[0-9] = '',
		--delete_bookmark      = '',
		--next_bookmark        = '',
		--prev_bookmark        = '',
	},
})
