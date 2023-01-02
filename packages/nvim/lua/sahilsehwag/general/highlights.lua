--HIGHLIGHTS
	--INTERFACE
		vim.cmd [[
			highlight VertSplit ctermbg=None guibg=None
		]]
	--SEARCH
		vim.cmd [[
			highlight Search ctermfg=49 cterm=NONE gui=NONE
			highlight IncSearchMatch ctermfg=black ctermbg=186
		]]
	--COMPLETION
		vim.cmd [[
			"highlight Pmenu ctermbg=232 ctermfg=7
			"highlight PmenuSel ctermfg=15
			highlight Pmenu ctermbg=238 gui=bold
		]]
	--DIFFING
		vim.cmd [[
			highlight JatAddFG          ctermfg=114 guifg=#98C379
			highlight JatDeleteFG       ctermfg=204 guifg=#E06C75
			highlight JatChangeFG       ctermfg=180 guifg=#E5C07B
			highlight JatChangeDeleteFG ctermfg=180 guifg=#61AFEF

			highlight JatAddBG          ctermbg=114 guibg=#98C379
			highlight JatDeleteBG       ctermbg=204 guibg=#E06C75
			highlight JatChangeBG       ctermbg=180 guibg=#E5C07B
			highlight JatChangeDeleteBG ctermbg=180 guibg=#61AFEF
		]]
	--STATUS
		vim.cmd [[
			highlight JatSuccessFG ctermfg=114 guifg=#98C379
			highlight JatErrorFG   ctermfg=204 guifg=#E06C75
			highlight JatWarningFG ctermfg=180 guifg=#E5C07B
			highlight JatInfoFG    ctermfg=180 guifg=#61AFEF
			highlight JatHintFG    ctermfg=180 guifg=#61AFEF

			highlight JatSuccessBG ctermbg=114 guibg=#98C379
			highlight JatErrorBG   ctermbg=204 guibg=#E06C75
			highlight JatWarningBG ctermbg=180 guibg=#E5C07B
			highlight JatInfoBG    ctermbg=180 guibg=#61AFEF
			highlight JatHintBG    ctermbg=180 guibg=#61AFEF

			highlight JatErrorBGTransparent   guibg=#2B2736
			highlight JatWarningBGTransparent ctermbg=180 guibg=#2C3337
			highlight JatInfoBGTransparent    ctermbg=180 guibg=#222F41
			highlight JatHintBGTransparent    ctermbg=180 guibg=#203440
		]]
	--COLORS
		vim.cmd [[
			highlight JatCyanFG  ctermfg=235 ctermbg=39 guifg=#61AFEF guibg=#282C34
			highlight JatCyanBG ctermfg=235 ctermbg=39 guifg=#282C34 guibg=#61AFEF
		]]
  --SPELL
		vim.cmd [[
			highlight SpellBad gui=undercurl guibg=#E06C75 ctermbg=204
		]]
	--RANDOM
		vim.cmd [[
			highlight! link SignColumn LineNr
		]]
