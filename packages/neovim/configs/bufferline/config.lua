require'bufferline'.setup{
	options = {
		mode = "buffers", -- set to "tabs" to only show tabpages instead
		numbers = "none", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
		close_command = "bdelete! %d",			 -- can be a string | function, see "Mouse actions"
		right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
		left_mouse_command = "buffer %d",		 -- can be a string | function, see "Mouse actions"
		middle_mouse_command = nil,					 -- can be a string | function, see "Mouse actions"
		-- NOTE: this plugin is designed with this icon in mind,
		-- and so changing this is NOT recommended, this is intended
		-- as an escape hatch for people who cannot bear it for whatever reason
		indicator = {
			icon = '▎', -- this should be omitted if indicator style is not 'icon'
			style =  'icon' --'icon' | 'underline' | 'none',
		},
		buffer_close_icon = '',
		modified_icon = '●',
		close_icon = '',
		left_trunc_marker = '',
		right_trunc_marker = '',
		--- name_formatter can be used to change the buffer's label in the bufferline.
		--- Please note some names can/will break the
		--- bufferline so use this at your discretion knowing that it has
		--- some limitations that will *NOT* be fixed.
		name_formatter = function(buf)	-- buf contains a "name", "path" and "bufnr"
			-- remove extension from markdown files for example
			if buf.name:match('%.md') then
				return vim.fn.fnamemodify(buf.name, ':t:r')
			end
		end,
		max_name_length = 18,
		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		tab_size = 18,
		diagnostics = false, -- false | "nvim_lsp" | "coc",
		diagnostics_update_in_insert = false,
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			return "("..count..")"
		end,
    --diagnostics_indicator = function(count, level, diagnostics_dict, context)
		--  local s = " "
		--  for e, n in pairs(diagnostics_dict) do
		--    local sym = e == "error" and " "
		--      or (e == "warning" and " " or "" )
		--    s = s .. n .. sym
		--  end
		--  return s
		--end
    --diagnostics_indicator = function(count, level, diagnostics_dict, context)
		--  local icon = level:match("error") and " " or " "
		--  return " " .. icon .. count
		--end
		-- NOTE: this will be called a lot so don't do any heavy processing here
		custom_filter = function(buf_number, buf_numbers)
			-- filter out filetypes you don't want to see
			if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
				return true
			end
			-- filter out by buffer name
			if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
				return true
			end
			-- filter out based on arbitrary rules
			-- e.g. filter out vim wiki buffer from tabline in your work repo
			if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
				return true
			end
			-- filter out by it's index number in list (don't show first buffer)
			if buf_numbers[1] ~= buf_number then
				return true
			end
		end,
		offsets = {
			{ filetype = "NvimTree", text = "File Explorer" },
		}, -- {{filetype = "NvimTree", text = "File Explorer" | function , text_align = "left" | "center" | "right"}},
		color_icons = true, -- true | false, -- whether or not to add the filetype icon highlights
		show_buffer_icons = true, -- disable filetype icons for buffers
		show_buffer_close_icons = false,
		show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
		show_close_icon = false,
		show_tab_indicators = true,
		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
		-- can also be a table containing 2 custom separators
		-- [focused and unfocused]. eg: { '|', '|' }
		separator_style = "slant", --"slant" | "thick" | "thin" | { 'any', 'any' },
		enforce_regular_tabs = false,
		always_show_bufferline = true,
		sort_by = 'insert_after_current', --'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b) return buffer_a.modified > buffer_b.modified end
		hover = {
			enabled = false,
			delay = 200,
			reveal = {'close'}
		},
		custom_areas = {
			left = function()
				return {}
			end,
			right = function()
				local result = {}
				--local seve = vim.diagnostic.severity
				--local error = #vim.diagnostic.get(0, {severity = seve.ERROR})
				--local warning = #vim.diagnostic.get(0, {severity = seve.WARN})
				--local info = #vim.diagnostic.get(0, {severity = seve.INFO})
				--local hint = #vim.diagnostic.get(0, {severity = seve.HINT})

				--if error ~= 0 then
				--	table.insert(result, {text = "  " .. error, guifg = "#EC5241"})
				--end

				--if warning ~= 0 then
				--	table.insert(result, {text = "  " .. warning, guifg = "#EFB839"})
				--end

				--if hint ~= 0 then
				--	table.insert(result, {text = "  " .. hint, guifg = "#A3BA5E"})
				--end

				--if info ~= 0 then
				--	table.insert(result, {text = "  " .. info, guifg = "#7EA9A7"})
				--end
				return result
			end,
		}
	},
  --groups = {
	--  options = {
	--    toggle_hidden_on_enter = true -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
	--  },
	--  items = {
	--    {
	--      name = "Tests", -- Mandatory
	--      highlight = {gui = "underline", guisp = "blue"}, -- Optional
	--      priority = 2, -- determines where it will appear relative to other groups (Optional)
	--      icon = "", -- Optional
	--      matcher = function(buf) -- Mandatory
	--        return buf.name:match('%_test') or buf.name:match('%_spec')
	--      end,
	--    },
	--    {
	--      name = "Docs",
	--      highlight = {gui = "undercurl", guisp = "green"},
	--      auto_close = false,  -- whether or not close this group if it doesn't contain the current buffer
	--      matcher = function(buf)
	--        return buf.name:match('%.md') or buf.name:match('%.txt')
	--      end,
	--      separator = { -- Optional
	--        style = require('bufferline.groups').separator.tab
	--      },
	--    }
	--  },
	--},
}
