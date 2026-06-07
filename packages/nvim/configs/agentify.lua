require('agentify').setup({
	sdk = 'omp',
})

-- <Leader>ca — ask AI about current line (normal) or selection (visual)
F.vim.nmap('<Leader>ca', function() require('agentify').act_line() end, { desc = 'Agentify: ask about line' })
F.vim.vmap('<Leader>ca', ":<C-u>lua require('agentify').act_visual()<CR>", { desc = 'Agentify: ask about selection' })

-- <Leader>cA — ask AI about entire file
F.vim.nmap('<Leader>cA', function() require('agentify').act_file() end, { desc = 'Agentify: ask about file' })

-- <Leader>cs — send context to existing session (line / selection / file)
F.vim.nmap('<Leader>cs', function() require('agentify').act_context_line() end, { desc = 'Agentify: context line → session' })
F.vim.vmap('<Leader>cs', ":<C-u>lua require('agentify').act_context_visual()<CR>", { desc = 'Agentify: context selection → session' })
F.vim.nmap('<Leader>cS', function() require('agentify').act_context_file() end, { desc = 'Agentify: context file → session' })
