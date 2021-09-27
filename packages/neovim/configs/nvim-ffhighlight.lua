require'fFHighlight'.setup()

vim.cmd [[
	hi default fFHintChar   ctermfg=yellow    cterm=bold guifg=yellow gui=bold
	hi default fFHintNumber ctermfg=yellow    cterm=bold guifg=yellow gui=bold
	hi default fFHintWords  cterm=underline   gui=underline
	hi default fFPromptSign ctermfg=yellow    cterm=bold guifg=yellow gui=bold
	hi default link         fFHintCurrentWord fFHintWords
]]
