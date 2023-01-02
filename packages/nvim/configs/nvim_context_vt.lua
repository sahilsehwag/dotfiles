require('nvim_context_vt').setup({
	custom_text_handler = function (node)
		-- if node:type() == 'function' then
		--   return nil
		-- end
		-- return ts_utils.get_node_text(node)[1]
		-- return "custom virtual text
	end
})
