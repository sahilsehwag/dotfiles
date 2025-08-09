"SETTINGS
	let g:Mac_DefaultRegister = 'r'
	let g:Mac_PlayByNameRegister = 'n'
	let g:Mac_NamedMacrosDirectory = expand(g:config.paths.tmp . '/macrobatics')
	let g:Mac_SavePersistently = 1
	let g:Mac_MaxItems = 10
	let g:Mac_DisplayMacroMaxWidth = 80
	let g:Mac_NamedMacroFileExtension = '.macro'
	let g:Mac_NamedMacroFuzzySearcher = v:null
	let g:Mac_NamedMacroParameters = {}
	let g:Mac_NamedMacroParametersByFileType = {}
	let g:Mac_FzfOptions = {'window': {'width': 0.75, 'height': 0.6}}
"MAPPINGS
	nmap q <nop>

	nmap <silent> <nowait> qr <plug>(Mac_RecordNew)
	nmap <silent> <nowait> qp <plug>(Mac_Play)

	nmap <silent> <nowait> qi <plug>(Mac_Prepend)
	nmap <silent> <nowait> qa <plug>(Mac_Append)

	nmap <silent> <nowait> qh :DisplayMacroHistory<cr>

	nmap <silent> <nowait> q[ <plug>(Mac_RotateBack)
	nmap <silent> <nowait> q] <plug>(Mac_RotateForward)

	nmap <silent> <nowait> qng <plug>(Mac_NameCurrentMacro)
	nmap <silent> <nowait> qnf <plug>(Mac_NameCurrentMacroForFileType)
	nmap <silent> <nowait> qns <plug>(Mac_NameCurrentMacroForCurrentSession)

	nmap <silent> <nowait> qsp <plug>(Mac_SearchForNamedMacroAndPlay)
	nmap <silent> <nowait> qss <plug>(Mac_SearchForNamedMacroAndSelect)
	nmap <silent> <nowait> qsd <plug>(Mac_SearchForNamedMacroAndDelete)
	nmap <silent> <nowait> qsr <plug>(Mac_SearchForNamedMacroAndRename)
	nmap <silent> <nowait> qso <plug>(Mac_SearchForNamedMacroAndOverwrite)
