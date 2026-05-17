F.vim.nmap('<Leader>b;', ':bufdo norm<space>', { silent = false })
F.vim.nmap('<Leader>b:', ':bufdo<space>',      { silent = false })

F.vim.nmap('<Leader>ban', ':enew<CR>')
F.vim.nmap('<Leader>bas', ':call ScratchBuffer("e")<CR>')
F.vim.nmap('<Leader>baS', ':call ScratchBuffer("e", 1)<CR>')

F.vim.nmap('<Leader>bcc', ':bprevious<bar>split<bar>bnext<bar>bdelete<CR>')
F.vim.nmap('<Leader>bcC', ':bprevious<bar>split<bar>bnext<bar>bdelete!<CR>')
--F.vim.nmap('<Leader>bca', ':bufdo bp<bar>sp<bar>bn<bar>bd<CR>')
--F.vim.nmap('<Leader>bcA', ':bufdo bp<bar>sp<bar>bn<bar>bd!<CR>')
--F.vim.nmap('<Leader>bco', ':%bp<bar>sp<bar>bn<bar>bd<bar>e#<CR>')
--F.vim.nmap('<Leader>bcO', ':%bp<bar>sp<bar>bn<bar>bd!<bar>e#<CR>')

F.vim.nmap('<Leader>bdc', ':bdelete<CR>')
F.vim.nmap('<Leader>bdC', ':bdelete!<CR>')
F.vim.nmap('<Leader>bda', ':%bdelete<CR>')
F.vim.nmap('<Leader>bdA', ':%bdelete!<CR>')
F.vim.nmap('<Leader>bdo', ':%bdelete<bar>edit#<bar>bnext<bar>bdelete<CR>')
F.vim.nmap('<Leader>bdO', ':%bdelete!<bar>edit#<bar>bnext<bar>bdelete!<CR>')

F.vim.nmap('<Leader>bwc', ':write<CR>')
F.vim.nmap('<Leader>bwC', ':write!<CR>')
F.vim.nmap('<Leader>bwa', ':wall<CR>')
F.vim.nmap('<Leader>bwA', ':wall!<CR>')

F.vim.nmap('<Leader>bl', ':buffers<CR>')

F.vim.nmap('<Leader>br', ':e<CR>')
F.vim.nmap('<Leader>bR', ':e!<CR>')

--SHORTCUTS
F.vim.nmap('<Leader>`', '<C-^>')
F.vim.nmap('<C-p>',     ':bprevious<CR>')
F.vim.nmap('<C-n>',     ':bnext<CR>')

F.vim.nmap('<C-s>',   ':write<CR>')
F.vim.nmap('<C-S-s>', ':wall<CR>')
F.vim.imap('<C-s>',   '<escape>:write<CR>')
F.vim.imap('<C-S-s>', '<escape>:wall<CR>')

F.vim.nmap('<C-S-d>',           ':bp<bar>sp<bar>bn<bar>bd<CR>')
F.vim.nmap('<Leader><Leader>d', ':bp<bar>sp<bar>bn<bar>bd<CR>')

--COPY FILE PATH
local function copy_path(opts)
	local abs = vim.fn.expand('%:p')
	if abs == '' then
		vim.notify('No file in current buffer', vim.log.levels.WARN)
		return
	end

	local path = abs
	if opts.relative then
		local dir  = vim.fn.fnamemodify(abs, ':h')
		local root = vim.fn.systemlist({ 'git', '-C', dir, 'rev-parse', '--show-toplevel' })[1]
		if vim.v.shell_error == 0 and root and root ~= '' then
			path = abs:sub(#root + 2)
		else
			vim.notify('Not in a git repo; copied absolute path', vim.log.levels.INFO)
		end
	end

	if opts.with_pos then
		local pos = vim.api.nvim_win_get_cursor(0)
		path = string.format('%s:%d:%d', path, pos[1], pos[2] + 1)
	end

	vim.fn.setreg('+', path)
	vim.fn.setreg('"', path)
	vim.notify('Copied: ' .. path)
end

F.vim.nmap('<Leader>bya', function() copy_path({ relative = false, with_pos = true  }) end)
F.vim.nmap('<Leader>byA', function() copy_path({ relative = false, with_pos = false }) end)
F.vim.nmap('<Leader>byr', function() copy_path({ relative = true,  with_pos = true  }) end)
F.vim.nmap('<Leader>byR', function() copy_path({ relative = true,  with_pos = false }) end)
