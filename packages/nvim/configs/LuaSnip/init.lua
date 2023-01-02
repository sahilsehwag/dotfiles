--SETUP
	local merge = require('libs.utils').table.dict.merge
	local luasnip = require('luasnip')

	local FILETYPES = {
		'javascript',
		'typescript',
		'javascriptreact',
		'typescriptreact',
		'lua',
		'sh',
		'bash',
		'zsh',
		'spectre_panel',
	}

	local FILETYPE_X_SNIPPETS = {
		spectre_panel = 'regex',
		zsh = 'sh',
		bash = 'sh',
		javascriptreact = { 'javascript', 'javascriptreact' },
		typescriptreact = { 'typescript', 'typescriptreact' },
	}

	for _, filetype in ipairs(FILETYPES) do
		local configs = FILETYPE_X_SNIPPETS[filetype] or filetype
		local snippets = {}

		if type(configs) == 'table' then
			for _, config in ipairs(configs) do
				snippets = merge({snippets, require(vim.g.config.paths.configs .. '/LuaSnip/' .. config)})
			end
		else
			snippets = require(vim.g.config.paths.configs .. '/LuaSnip/' .. configs)
		end

		luasnip.add_snippets(filetype, snippets)
	end
--MAPPINGS
	vim.cmd [[nmap <silent>       <C-Tab>		<cmd>lua require('luasnip').jump(1)<cr>]]
	vim.cmd [[nmap <silent>       <C-S-Tab> <cmd>lua require('luasnip').jump(-1)<cr>]]
	vim.cmd [[smap <silent>       <C-Tab>		<cmd>lua require('luasnip').jump(1)<cr>]]
	vim.cmd [[smap <silent>       <C-S-Tab> <cmd>lua require('luasnip').jump(-1)<cr>]]
	vim.cmd [[imap <silent><expr> <C-Tab>		luasnip#jumpable(1)  ? '<Plug>luasnip-jump-next' : '<C-Tab>']]
	vim.cmd [[imap <silent><expr> <C-S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<C-S-Tab>']]

	vim.cmd [[nmap <silent><expr> <C-(> luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : '<C-(>']]
	vim.cmd [[nmap <silent><expr> <C-)> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-)>']]
	vim.cmd [[imap <silent><expr> <C-(> luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : '<C-(>']]
	vim.cmd [[imap <silent><expr> <C-)> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-)>']]
	vim.cmd [[smap <silent><expr> <C-(> luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : '<C-(>']]
	vim.cmd [[smap <silent><expr> <C-)> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-)>']]

	vim.cmd [[nmap <silent><expr> <C-S-Esc>   luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-S-Esc>']]
	vim.cmd [[imap <silent><expr> <C-S-Esc>   luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-S-Esc>']]
	vim.cmd [[smap <silent><expr> <C-S-Esc>   luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-S-Esc>']]
	--vim.cmd [[nmap <silent><expr> <C-Space>   luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-Space>']]
	--vim.cmd [[imap <silent><expr> <C-Space>   luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-Space>']]
	--vim.cmd [[smap <silent><expr> <C-Space>   luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-Space>']]
	--vim.cmd [[nmap <silent><expr> <C-S-Space> luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : '<C-S-Space']]
	--vim.cmd [[imap <silent><expr> <C-S-Space> luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : '<C-S-Space']]
	--vim.cmd [[smap <silent><expr> <C-S-Space> luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : '<C-S-Space>']]
--FRIENDLY-SNIPPETS
	--Beside defining your own snippets you can also load snippets from "vscode-like" packages
	--that expose snippets in json files, for example <https://github.com/rafamadriz/friendly-snippets>.
	--Mind that this will extend	`ls.snippets` so you need to do it after your own snippets or you
	--will need to extend the table yourself instead of setting a new one.

	--require("luasnip/loaders/from_vscode").load({ include = { "python" } }) -- Load only python snippets
	--require("luasnip/loaders/from_vscode").load({ paths = { "./my-snippets" } }) -- Load snippets from my-snippets folder

	--You can also use lazy loading so you only get in memory snippets of languages you use
	require("luasnip/loaders/from_vscode").lazy_load() -- You can pass { path = "./my-snippets/"} as well
--CHOICE-NODE-POPUP
	--local current_nsid = vim.api.nvim_create_namespace("LuaSnipChoiceListSelections")
	--local current_win = nil

	--local function window_for_choiceNode(choiceNode)
	--  local buf = vim.api.nvim_create_buf(false, true)
	--  local buf_text = {}
	--  local row_selection = 0
	--  local row_offset = 0
	--  local text
	--  for _, node in ipairs(choiceNode.choices) do
	--    text = node:get_docstring()
	--    -- find one that is currently showing
	--    if node == choiceNode.active_choice then
	--      -- current line is starter from buffer list which is length usually
	--      row_selection = #buf_text
	--      -- finding how many lines total within a choice selection
	--      row_offset = #text
	--    end
	--    vim.list_extend(buf_text, text)
	--  end

	--  vim.api.nvim_buf_set_text(buf, 0,0,0,0, buf_text)
	--  local w, h = vim.lsp.util._make_floating_popup_size(buf_text)

	--  -- adding highlight so we can see which one is been selected.
	--  local extmark = vim.api.nvim_buf_set_extmark(buf,current_nsid,row_selection ,0,
	--    {hl_group = 'incsearch',end_line = row_selection + row_offset})

	--  -- shows window at a beginning of choiceNode.
	--  local win = vim.api.nvim_open_win(buf, false, {
	--    relative = "win", width = w, height = h, bufpos = choiceNode.mark:pos_begin_end(), style = "minimal", border = 'rounded'})

	--  -- return with 3 main important so we can use them again
	--  return {win_id = win,extmark = extmark,buf = buf}
	--end

	--function choice_popup(choiceNode)
	--  -- build stack for nested choiceNodes.
	--  if current_win then
	--    vim.api.nvim_win_close(current_win.win_id, true)
	--    vim.api.nvim_buf_del_extmark(current_win.buf,current_nsid,current_win.extmark)
	--  end
	--  local create_win = window_for_choiceNode(choiceNode)
	--  current_win = {
	--    win_id = create_win.win_id,
	--    prev = current_win,
	--    node = choiceNode,
	--    extmark = create_win.extmark,
	--    buf = create_win.buf
	--  }
	--end

	--function update_choice_popup(choiceNode)
	--  vim.api.nvim_win_close(current_win.win_id, true)
	--  vim.api.nvim_buf_del_extmark(current_win.buf,current_nsid,current_win.extmark)
	--  local create_win = window_for_choiceNode(choiceNode)
	--  current_win.win_id = create_win.win_id
	--  current_win.extmark = create_win.extmark
	--  current_win.buf = create_win.buf
	--end

	--function choice_popup_close()
	--  vim.api.nvim_win_close(current_win.win_id, true)
	--  vim.api.nvim_buf_del_extmark(current_win.buf,current_nsid,current_win.extmark)
	--  -- now we are checking if we still have previous choice we were in after exit nested choice
	--  current_win = current_win.prev
	--  if current_win then
	--    -- reopen window further down in the stack.
	--    local create_win = window_for_choiceNode(current_win.node)
	--    current_win.win_id = create_win.win_id
	--    current_win.extmark = create_win.extmark
	--    current_win.buf = create_win.buf
	--  end
	--end

	--vim.cmd([[
	--  augroup choice_popup
	--  au!
	--  au User LuasnipChoiceNodeEnter lua choice_popup(require("luasnip").session.event_node)
	--  au User LuasnipChoiceNodeLeave lua choice_popup_close()
	--  au User LuasnipChangeChoice lua update_choice_popup(require("luasnip").session.event_node)
	--  augroup END
	--]])
--CHOICE-NODE-HINTS-VT
	local types = require("luasnip.util.types")

	require'luasnip'.config.setup({
		history = true,
		ext_opts = {
			[types.choiceNode] = {
				active = {
					virt_text = {{"●", "JatInfoFG"}}
				}
			},
			[types.insertNode] = {
				active = {
					virt_text = {{"●", "JatSuccessFG"}}
				}
			}
		},
	})
