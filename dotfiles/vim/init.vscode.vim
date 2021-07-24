"LEADER
	let mapleader      = ' '
	let maplocalleader = ','

	let g:insert_leader   = ';'
	let g:terminal_leader = ';'

	let g:action_leader = 'A'
	let g:mode_leader   = 'C-A'
	let g:motion_leader = 'C-S'
"VIMSCRIPT
	"HELPERS
		"VIM
			"TEXT
				function! GetWordUnderCursor()
					execute 'normal! "ayiw'
					let value = @a
					return value
				endfunction

				function! GetWORDUnderCursor()
					execute 'normal! "ayiW'
					let value = @a
					return value
				endfunction

				function! GetSelectedText()
					let [lineStart, columnStart] = getpos("'<")[1:2]
					let [lineEnd, columnEnd] = getpos("'>")[1:2]
					let lines = getline(lineStart, lineEnd)
					if len(lines) == 0
						return ''
					endif
					let lines[-1] = lines[-1][: columnEnd - (&selection == 'inclusive' ? 1 : 2)]
					let lines[0] = lines[0][columnStart - 1:]

					if ExistsAndTrue('a:1')
						return join(lines, "\n")
					else
						return lines
					endif
				endfunction
			"META
				function! ExistsAndTrue(name)
					if exists(a:name)
						return eval(a:name)
					endif
					return 0
				endfunction

				function! IsNix()
					return has('unix') || has('macunix') || has('linux') || has('win32unix')
				endfunction

				function! IsWindows()
					return has('win32')
				endfunction
			"DYNAMIC
				function! DefineMap(type, map, action)
					execute a:type . ' ' . a:map . ' ' . a:action
				endfunction

				function! DefineAbbreviation(source, target)
					execute 'iabbrev' . ' ' . a:source . ' ' . a:target
				endfunction
	"PLUGINS
		"EDITING
			"OPERATOR
				"OPERATOR-EXRANGE
					function! OperatorExRange(visual)
						let [lineStart, columnStart] = getpos(a:0 ? "'<" : "'[")[1:2]
						let [lineEnd, columnEnd]	 = getpos(a:0 ? "'>" : "']")[1:2]
						let lines					 = getline(lineStart, lineEnd)

						if len(lines) == 0
							return
						endif

						if a:visual == 'block' || a:visual == "\<c-v>"
							call PEchoError('Operator not defined for VISUAL-BLOCK mode')
							return
						elseif a:visual == 'line' || a:visual ==# 'V'
							for line in lines
								execute line
							endfor
						elseif a:visual == 'char' || a:visual ==# 'v'
							let lines[-1] = lines[-1][: columnEnd - (&selection == 'inclusive' ? 1 : 2)]
							let lines[0]  = lines[0][columnStart - 1:]

							for line in lines
								execute line
							endfor
						endif
					endfunction

					"nnoremap <silent> g; :set opfunc=OperatorExRange<CR>g@
					"vnoremap <silent> g; :<C-U>call OperatorExRange(visualmode())<CR>

					"nnoremap <silent> g;; :execute getline('.')<CR>
					"vnoremap <silent> g;; :<C-U>execute getline('.')<CR>
			"OBJECT
				"LINE-OBJECTS
					"OBJECT-LINE
						vnoremap il :<C-u>normal! ^v$h<CR>
						onoremap il :<C-u>normal! ^v$h<CR>

						vnoremap al :<C-u>normal! Vh<CR>
						onoremap al :<C-u>normal! Vh<CR>
					"TODO:OBJECT-BEFORE
						vnoremap b= :<C-u>normal! ^vt=<CR>
						onoremap b= :<C-u>normal! ^vt=<CR>
						vnoremap b: :<C-u>normal! ^vt:<CR>
						onoremap b: :<C-u>normal! ^vt:<CR>
						vnoremap b- :<C-u>normal! ^vt-<CR>
						onoremap b- :<C-u>normal! ^vt-<CR>
						vnoremap B= :<C-u>normal! ^vf=<CR>
						onoremap B= :<C-u>normal! ^vf=<CR>
						vnoremap B: :<C-u>normal! ^vf:<CR>
						onoremap B: :<C-u>normal! ^vf:<CR>
						vnoremap B- :<C-u>normal! ^vf-<CR>
						onoremap B- :<C-u>normal! ^vf-<CR>
					"TODO:OBJECT-BETWEEN
					"TODO:OBJECT-AFTER
						"TEXT-OBJECT
							function! TextObjectAfter(targetChar)
								"GETTING COLUMN NUMBER OF CHARACTER AFTER THE targetChar
									execute 'normal! 0' . v:count . 'f' . a:targetChar
									let targetCharCol = virtcol('.')
									let targetCharNormCol = getpos('.')[2]
								"IF CHARACTER AFTER targetChar IS SPACE THEN SKIP OVER THE SPACE CHARACTER
									if getline('.')[targetCharNormCol] == ' '
										execute 'normal! ' . string(targetCharCol+2) . '|v$h'
									else
										execute 'normal! ' . string(targetCharCol+1) . '|v$h'
									endif
							endfunction

							function! TextObjectAfterAnyChar()
								"GETTING TARGET CHAR
									call inputsave()
									let targetChar = getchar()
									call inputrestore()
								"GETTING COLUMN NUMBER OF CHARACTER AFTER THE targetChar
									execute 'normal! 0' . v:count . 'f' . nr2char(targetChar)
									let targetCharCol = virtcol('.')
									let targetCharNormCol = getpos('.')[2]
								"IF CHARACTER AFTER targetChar IS SPACE THEN SKIP OVER THE SPACE CHARACTER
									if getline('.')[targetCharNormCol] == ' '
										execute 'normal! ' . string(targetCharCol+2) . '|v$h'
									else
										execute 'normal! ' . string(targetCharCol+1) . '|v$h'
									endif
							endfunction
						"MAPPINGS
							vnoremap <silent> a= :<C-u>call TextObjectAfter('=')<CR>
							onoremap <silent> a= :<C-u>call TextObjectAfter('=')<CR>

							vnoremap <silent> a: :<C-u>call TextObjectAfter(':')<CR>
							onoremap <silent> a: :<C-u>call TextObjectAfter(':')<CR>

							vnoremap <silent> a- :<C-u>call TextObjectAfter('-')<CR>
							onoremap <silent> a- :<C-u>call TextObjectAfter('-')<CR>

							onoremap <silent> ga :<C-u>call TextObjectAfterAnyChar()<CR>
					"TODO:OBJECT-AT
				"BLOCK-OBJECTS
					"OBJECT-ENTIRE
						vnoremap ie :<C-u>normal! ggVG<CR>
						onoremap ie :<C-u>normal! ggVG<CR>
				"RANDOM
					"OBJECT-VISUAL
						onoremap gv :<C-u>normal! gv<Enter>
		"SYSTEM
			"TODO:LINUX
				"VARIABLES
					let g:linuxing_enable_default_mappings = 1
				"DEFAULTS
					if ExistsAndTrue('g:linuxing_enable_default_mappings')
						vnoremap <Leader>lus :sort						   <CR>
						vnoremap <Leader>luu :<C-u>'<,'>sort \| '<,'>!uniq <CR>
						vnoremap <Leader>luc :<C-u>'<,'>!bc				   <CR>
					endif
		"PROGRAMMING
			"SPACE-WARRIOR
				"VARIABLES
					let g:space_warrior_enable_default_mappings          = 1
					let g:space_warrior_highlight_trailing_whitespaces   = 1
					let g:space_warrior_highlight_leading_spaces         = 1
					let g:space_warrior_highlight_leading_tabs           = 0
					let g:space_warrior_highlight_listchars              = 1
					let g:space_warrior_highlight_consecutive_blanklines = 1
				"FUNCTIONS
					function! ConvertSpaces2Tabs()
						let l:et = &expandtab
						setlocal noexpandtab
						%retab!
						if l:et
							setlocal expandtab
						else
							setlocal noexpandtab
						endif
					endfunction

					function! ConvertTabs2Spaces()
						let l:et = &expandtab
						setlocal expandtab
						%retab!
						if l:et
							setlocal expandtab
						else
							setlocal noexpandtab
						endif
					endfunction

					function! StripTrailingWhitespace()
						execute ':%s/\s\+$//e'
						execute ':%s/\t\+$//e'
					endfunction
				"COMMANDS
					command! SWSpaces2Tabs             :execute ConvertSpaces2Tabs()
					command! SWTabs2Spaces             :execute ConvertSpaces2Tabs()
					command! SWStripTrailingWhitespace :execute StripTrailingWhitespace()
				"AUTOCOMMANDS
					augroup SPACE_WARRIOR
						"TODO:DISABLE FOR LARGE-FILES
						autocmd!
						"autocmd BufWritePre *
							"\ call StripTrailingWhitespace() |
							"\ call ConvertTabs2Spaces()
					augroup end
				"MAPPINGS
					nmap <silent> <Plug>(sw-spaces-2-tab)              :SWSpaces2Tabs<CR>
					nmap <silent> <Plug>(sw-tabs-2-spaces)             :SWTabs2Spaces<CR>
					nmap <silent> <Plug>(sw-strip-trailing-whitespace) :SWStripTrailingWhitespace<CR>
				"DEFAULTS
					if ExistsAndTrue('g:space_warrior_enable_default_mappings')
						nmap <Leader>xt <Plug>(sw-spaces-2-tabs)
						nmap <Leader>xs <Plug>(sw-tabs-2-spaces)
						nmap <Leader>xw <Plug>(sw-strip-trailing-whitespace)
						vmap <Leader>xt <Plug>(sw-spaces-2-tabs)
						vmap <Leader>xs <Plug>(sw-tabs-2-spaces)
						vmap <Leader>xw <Plug>(sw-strip-trailing-whitespace)

						nmap <Leader>xb :g:^$\n\{3,}:d<CR>
						nmap <Leader>xr :%retab!<CR>
					endif
		"LIBRARIES
			"TODO:ECHOES
				"TODO:FIX HIGHLIGHTS
				function! PEcho(msg)
					echohl WildMenu
					echom "INFO: " . a:msg
					call getchar()
					echohl None
				endfunction

				function! PEchoSuccess(msg)
					echohl MoreMsg
					echom "SUCCESS: " . a:msg
					call getchar()
					echohl None
				endfunction

				function! PEchoWarning(msg)
					echohl WildMenu
					echom "WARNING: " . a:msg
					call getchar()
					echohl None
				endfunction

				function! PEchoError(msg)
					echohl ErrorMsg
					echomsg "ERROR: " . a:msg
					call getchar()
					echohl None
				endfunction
		"RANDOM
			"SYMBOLIC
				"VARIABLES
					let g:symbolic_leader =
						\ exists('g:insert_leader')
						\ ? g:insert_leader
						\ : ';'
					let g:symbolic_enable_default_mappings = 1
					let g:symbolic_use_imap = 1
					let g:symbolic_pairs = {}
						let g:symbolic_pairs.miscellanous = [
							\["chk"  , "✓" ],
							\["crs"  , "✖" ],
							\[".."	 , "…" ],
							\["..."  , "⋯" ],
							\["deg"  , "°" ],
							\["8"	 , "∞" ],
							\["-8"	 , "-∞"],
							\["-"	 , "―" ],
							\["tf"	 , "∴" ],
							\["ie"	 , "∵" ],
							\["ang"  , "∠" ],
							\["rang" , "∟" ],
							\["perp" , "⊥" ],
							\["cong" , "≅" ],
							\["&"	 , "∧" ],
							\["\\|"  , "∨" ],
							\["!"	 , "¬" ],
							\["'"	 , "′" ],
							\["''"	 , "″" ],
							\["T"	 , "⊤" ],
							\["iT"	 , "⊥" ],
							\["-\\|" , "⊣" ],
							\["\\|-" , "⊢" ],
							\["\\|=" , "⊨" ],
						\]
						let g:symbolic_pairs.arrows = [
							\["->u"   , "↑"],
							\["->d"   , "↓"],
							\["<-"	  , "←"],
							\["->"	  , "→"],
							\["<->"   , "↔"],
							\["<.."   , "⇠"],
							\["..>"   , "⇢"],
							\["..>u"  , "⇡"],
							\["..>d"  , "⇣"],
							\["<--"   , "⟵"],
							\["-->"   , "⟶"],
							\["<-->"  , "⟷"],
							\["<="	  , "⇐"],
							\["=>"	  , "⇒"],
							\["<=>"   , "⇔"],
							\["<=="   , "⟸"],
							\["==>"   , "⟹"],
							\["<==>"  , "⟺"],
							\["\\|>"  , "↦"],
							\["<\\|"  , "↤"],
							\["\\|->" , "⟼" ],
							\["<-\\|" , "⟻"],
							\["<=\\|" , "⟽"],
							\["\\|=>" , "⟾" ],
						\]
						let g:symbolic_pairs.operators = [
							\["<-"	  , "≤"],
							\["<<"	  , "≪"],
							\["<<<"   , "⋘"],
							\[">-"	  , "≥"],
							\[">>"	  , "≫"],
							\[">>>"   , "⋙"],
							\["!="	  , "≠"],
							\["*"	  , "×"],
							\["/"	  , "÷"],
							\["sum"   , "∑"],
							\["prod"  , "∏"],
							\["cprod" , "∐"],
							\["srt"   , "√"],
							\["crt"   , "∛"],
							\["qrt"   , "∜"],
							\["~"	  , "≈"],
							\["="	  , "≡"],
							\["prop"  , "∝"],
							\["floor" , "⌊⌋"],
							\["ceil"  , "⌈⌉"],
							\["+-"	  , "±"],
							\["-+"	  , "∓"],
							\["."	  , "∙"],
							\["<="	  , "≦"],
							\[">="	  , "≧"],
							\["ox"	  , "⨂"],
							\["o+"	  , "⨁"],
							\["o-"	  , "⊖"],
							\["o."	  , "⨀"],
							\["o*"	  , "⊛"],
						\]
						let g:symbolic_pairs.alphabets = [
							\["C", "ℂ"],
							\["E", "𝔼"],
							\["N", "ℕ"],
							\["P", "ℙ"],
							\["Q", "ℚ"],
							\["R", "ℝ"],
							\["U", "𝕌"],
							\["Z", "ℤ"],
						\]
						let g:symbolic_pairs.greek = [
							\["alpha"  , "𝛂"],
							\["beta"   , "𝛃"],
							\["gamma"  , "𝛄"],
							\["Gamma"  , "Γ"],
							\["delta"  , "𝛅"],
							\["Delta"  , "∆"],
							\["nabla"  , "∇"],
							\["epsi"   , "𝛆"],
							\["zeta"   , "ζ"],
							\["eta"    , "𝛈"],
							\["theta"  , "𝛉"],
							\["Theta"  , "Θ"],
							\["iota"   , "ι"],
							\["kappa"  , "𝛞"],
							\["lambda" , "𝛌"],
							\["Lambda" , "Λ"],
							\["mu"	   , "𝛍"],
							\["nu"	   , "𝛎"],
							\["xi"	   , "ξ"],
							\["Xi"	   , "Ξ"],
							\["pi"	   , "𝛑"],
							\["Pi"	   , "Π"],
							\["rho"    , "𝛒"],
							\["sigma"  , "𝛔"],
							\["Sigma"  , "Σ"],
							\["tau"    , "𝛕"],
							\["upsi"   , "𝛖"],
							\["Upsi"   , "ϒ"],
							\["phi"    , "φ"],
							\["Phi"    , "𝛟"],
							\["chi"    , "𝛘"],
							\["psi"    , "Ψ"],
							\["Psi"    , "𝛙"],
							\["omega"  , "𝛚"],
							\["Omega"  , "Ω"],
							\["a"	   , "𝛂"],
							\["b"	   , "𝛃"],
							\["e"	   , "𝛆"],
							\["E"	   , "Σ"],
							\["n"	   , "𝛈"],
							\["o"	   , "𝛉"],
							\["i"	   , "ι"],
							\["u"	   , "𝛍"],
							\["v"	   , "𝛎"],
							\["p"	   , "𝛒"],
							\["T"	   , "𝛕"],
							\["w"	   , "𝛚"],
							\["x"	   , "𝛞"],
						\]
						let g:symbolic_pairs.set = [
							\["uu"	 , "∪"],
							\["ud"	 , "∩"],
							\["ur="  , "⊆"],
							\["ur"	 , "⊂"],
							\["nur"  , "⊄"],
							\["ul="  , "⊇"],
							\["ul"	 , "⊃"],
							\["nul"  , "⊅"],
							\["sphi" , "∅"],
							\["bt"	 , "∈"],
							\["nbt"  , "∉"],
							\["fa"	 , "∀"],
							\["te"	 , "∃"],
							\["tne"  , "∄"],
						\]
						let g:symbolic_pairs.calculas = [
							\["f1"	, "∫"],
							\["f2"	, "∬"],
							\["f3"	, "∭"],
							\["f4"	, "⨌"],
							\["of1" , "∮"],
							\["of1" , "∯"],
							\["of1" , "∰"],
							\["pd"	, "𝛛"],
						\]
						let g:symbolic_pairs.relational_algebra = [
							\["lj", "⋉"],
							\["rj", "⋊"],
							\["fj", "⋈"],
						\]
						let g:symbolic_pairs.scripts = [
							\["0u"	   , "⁰"],
							\["1u"	   , "¹"],
							\["2u"	   , "²"],
							\["3u"	   , "³"],
							\["4u"	   , "⁴"],
							\["5u"	   , "⁵"],
							\["6u"	   , "⁶"],
							\["7u"	   , "⁷"],
							\["8u"	   , "⁸"],
							\["9u"	   , "⁹"],
							\["0d"	   , "₀"],
							\["1d"	   , "₁"],
							\["2d"	   , "₂"],
							\["3d"	   , "₃"],
							\["4d"	   , "₄"],
							\["5d"	   , "₅"],
							\["6d"	   , "₆"],
							\["7d"	   , "₇"],
							\["8d"	   , "₈"],
							\["9d"	   , "₉"],
							\["+u"	   , "⁺"],
							\["-u"	   , "⁻"],
							\["(u"	   , "⁽"],
							\[")u"	   , "⁾"],
							\["=u"	   , "⁼"],
							\["+d"	   , "₊"],
							\["-d"	   , "₋"],
							\["(d"	   , "₍"],
							\[")d"	   , "₎"],
							\["=d"	   , "₌"],
							\["au"	   , "ᵃ"],
							\["bu"	   , "ᵇ"],
							\["cu"	   , "ᶜ"],
							\["du"	   , "ᵈ"],
							\["eu"	   , "ᵉ"],
							\["fu"	   , "ᶠ"],
							\["gu"	   , "ᵍ"],
							\["hu"	   , "ʰ"],
							\["iu"	   , "ⁱ"],
							\["ju"	   , "ʲ"],
							\["ku"	   , "ᵏ"],
							\["lu"	   , "ˡ"],
							\["mu"	   , "ᵐ"],
							\["nu"	   , "ⁿ"],
							\["ou"	   , "ᵒ"],
							\["pu"	   , "ᵖ"],
							\["qu"	   , "⁺"],
							\["ru"	   , "ʳ"],
							\["su"	   , "ˢ"],
							\["tu"	   , "ᵗ"],
							\["uu"	   , "ᵘ"],
							\["vu"	   , "ᵛ"],
							\["wu"	   , "ʷ"],
							\["xu"	   , "ˣ"],
							\["yu"	   , "ʸ"],
							\["zu"	   , "ᶻ"],
							\["Au"	   , "ᴬ"],
							\["Bu"	   , "ᴮ"],
							\["Cu"	   , "⁺"],
							\["Du"	   , "ᴰ"],
							\["Eu"	   , "ᴱ"],
							\["Fu"	   , "⁺"],
							\["Gu"	   , "ᴳ"],
							\["Hu"	   , "ᴴ"],
							\["Iu"	   , "ᴵ"],
							\["Ju"	   , "ᴶ"],
							\["Ku"	   , "ᴷ"],
							\["Lu"	   , "ᴸ"],
							\["Mu"	   , "ᴹ"],
							\["Nu"	   , "ᴺ"],
							\["Ou"	   , "ᴼ"],
							\["Pu"	   , "ᴾ"],
							\["Qu"	   , "⁺"],
							\["Ru"	   , "ᴿ"],
							\["Su"	   , "⁺"],
							\["Tu"	   , "ᵀ"],
							\["Uu"	   , "ᵁ"],
							\["Vu"	   , "ⱽ"],
							\["Wu"	   , "ᵂ"],
							\["Xu"	   , "⁺"],
							\["Yu"	   , "⁺"],
							\["Zu"	   , "⁺"],
							\["ad"	   , "ₐ"],
							\["bd"	   , "⁺"],
							\["cd"	   , "⁺"],
							\["dd"	   , "⁺"],
							\["ed"	   , "ₑ"],
							\["fd"	   , "⁺"],
							\["gd"	   , "⁺"],
							\["hd"	   , "⁺"],
							\["id"	   , "ᵢ"],
							\["jd"	   , "ⱼ"],
							\["kd"	   , "⁺"],
							\["ld"	   , "⁺"],
							\["md"	   , "⁺"],
							\["nd"	   , "⁺"],
							\["od"	   , "ₒ"],
							\["pd"	   , "⁺"],
							\["qd"	   , "⁺"],
							\["rd"	   , "ᵣ"],
							\["sd"	   , "⁺"],
							\["td"	   , "⁺"],
							\["ud"	   , "ᵤ"],
							\["vd"	   , "ᵥ"],
							\["wd"	   , "⁺"],
							\["xd"	   , "ₓ"],
							\["yd"	   , "⁺"],
							\["zd"	   , "⁺"],
							\["Ad"	   , "⁺"],
							\["Bd"	   , "⁺"],
							\["Cd"	   , "⁺"],
							\["Dd"	   , "⁺"],
							\["Ed"	   , "⁺"],
							\["Fd"	   , "⁺"],
							\["Gd"	   , "⁺"],
							\["Hd"	   , "⁺"],
							\["Id"	   , "⁺"],
							\["Jd"	   , "⁺"],
							\["Kd"	   , "⁺"],
							\["Ld"	   , "⁺"],
							\["Md"	   , "⁺"],
							\["Nd"	   , "⁺"],
							\["Od"	   , "⁺"],
							\["Pd"	   , "⁺"],
							\["Qd"	   , "⁺"],
							\["Rd"	   , "⁺"],
							\["Sd"	   , "⁺"],
							\["Td"	   , "⁺"],
							\["Ud"	   , "⁺"],
							\["Vd"	   , "⁺"],
							\["Wd"	   , "⁺"],
							\["Xd"	   , "⁺"],
							\["Yd"	   , "⁺"],
							\["Zd"	   , "⁺"],
							\["alphau" , "ᵅ"],
							\["betau"  , "ᵝ"],
							\["epsiu"  , "ᵋ"],
							\["deltau" , "ᵟ"],
							\["thetau" , "ᶿ"],
							\["phiu"   , "ᶲ"],
							\["Phiu"   , "ᵠ"],
							\["betad"  , "ᵦ"],
							\["phid"   , "ᵩ"],
						\]
				"FUNCTIONS
					function! SymbolicDefineMaps()
						for group in values(g:symbolic_pairs)
							for pair in group
								call DefineMap('inoremap', g:symbolic_leader . pair[0], pair[1])
							endfor
						endfor
					endfunction

					"TODO:FIX
					function! SymbolicDefineAbbreviations()
						for group in values(g:symbolic_pairs)
							for pair in group
								call DefineAbbreviation(g:symbolic_leader . pair[0], pair[1])
							endfor
						endfor
					endfunction
				"DEFAULTS
					if ExistsAndTrue('g:symbolic_enable_default_mappings')
						if ExistsAndTrue('g:symbolic_use_imap')
							call SymbolicDefineMaps()
						else
							call SymbolicDefineAbbreviations()
						endif
					endif
"VARIABLES
	"PATHS
		let g:jaat_tmp_path = glob('~/.config/nvim/tmp/')
		let g:jaat_lists_path = g:jaat_tmp_path . 'lists/'

		let g:jaat_home_path = expand('~')
		let g:jaat_root_path =
			\ IsNix()
			\ ? shellescape(expand('/'))
			\ : shellescape(expand('D:'))
		let g:jaat_drive_path =
			\ IsNix()
			\ ? shellescape(expand('~/Google Drive'))
			\ : shellescape(expand('~/Google Drive'))
		let g:jaat_nvim_path =
			\ IsNix()
			\ ? fnameescape(expand('~/.config/nvim/init.vscode.vim'))
			\ : fnameescape(expand('~/AppData/Local/nvim/init.vscode.vim'))
		let g:jaat_vim_path = expand('~/.vimrc')
		let g:jaat_config_path =
			\ has('vim')
			\ ? g:jaat_vim_path
			\ : g:jaat_nvim_path
	"COMMANDS
		"SHELL
		"GREPISH
			let g:jaat_grep_command = 'grep -rHnas --color --exclude-dir=".git" --exclude-dir="node_modules" -i . *'
				"TODO:FIX
			let g:jaat_ag_command	= 'ag --nogroup -s .+'
			let g:jaat_rg_command = 'rg --hidden --follow --no-ignore-vcs --ignore -g "!{node_modules/*,.git/*}"'
		"FINDISH
			let g:jaat_fd_command_files			= "fd -tf --hidden --exclude .git --exclude node_modules '.*'"
			let g:jaat_fd_command_directories = "fd -td --hidden --exclude .git --exclude node_modules '.*'"

			let g:jaat_find_command_files		= 'find -type f -iname'
			let g:jaat_find_command_directories = 'find -type d -iname'
		"EXPLORER
			let g:jaat_vifm_command = 'vifm'
			let g:jaat_ranger_command = 'ranger'
		let g:jaat_shell_command =
			\ IsWindows()
			\ ? "cmd"
			\ : executable('zsh')
			\ ? "zsh"
			\ : executable('fish')
			\ ? "fish"
			\ : executable('bash')
			\ ? "bash"
			\ : "sh"
		let g:jaat_explorer_command =
			\ executable('vifm')
			\ ? g:jaat_vifm_command
			\ : executable('ranger')
			\ ? g:jaat_ranger_command
			\ : ''
		let g:jaat_find_lines_command =
			\ executable('rg')
			\ ? g:jaat_rg_command
			\ : executable('ag')
			\ ? g:jaat_ag_command
			\ : g:jaat_grep_command
		let g:jaat_find_files_command =
			\ executable('fd')
			\ ? g:jaat_fd_command_files
			\ : g:jaat_find_command_files
		let g:jaat_find_directories_command =
			\ executable('fd')
			\ ? g:jaat_fd_command_directories
			\ : g:jaat_find_command_directories
	"CONFIGURATION
		let g:jaat_small_window_height	= 10
		let g:jaat_medium_window_height = 15
		let g:jaat_large_window_height	= 20
"MAPPINGS
	"NOPS
		map Q <nop>
		map <C-r> <nop>
	"REMAPS
		nnoremap U <C-r>
		nnoremap ' "
		nnoremap " '
	"LEADER
		nnoremap <silent> <expr> <Leader>vs ':source ' . g:jaat_config_path . '<CR>'
"PLUGINS
	"INSTALLED
		call plug#begin()
			"EDITING
				"GENERAL
					"BETTER-CAPSLOCK
						Plug 'tpope/vim-capslock'
							nmap <silent> <LocalLeader><LocalLeader> <Plug>CapsLockToggle
							imap ;; <Plug>CapsLockToggle
					"BETTER-REPEAT
						"BETTER-DOT
							Plug 'tpope/vim-repeat'
						"BETTER-;,
							if v:false
								Plug 'Houl/repmo-vim'
							else
								Plug 'vim-scripts/repmo.vim'
									let repmo_key = ";"
									let repmo_revkey = ","
							endif
				"OPERATORS
					Plug 'JRasmusBm/vim-peculiar'
						nmap g<space> <Plug>PeculiarN
						nmap g; <Plug>PeculiarG
						nmap g, <Plug>PeculiarV
						nmap g. <Plug>PeculiarR
					Plug 'haya14busa/vim-operator-flashy'
						"CONFIGURATION
							let g:operator#flashy#group = 'Visual'
						"MAPPINGS
							map y <Plug>(operator-flashy)
							map Y <Plug>(operator-flashy)$
					Plug 'tpope/vim-surround'
					Plug 'junegunn/vim-easy-align'
						xmap gl <Plug>(EasyAlign)
						nmap gl <Plug>(EasyAlign)
					Plug 'svermeulen/vim-subversive'
						nmap gs <plug>(SubversiveSubstituteRange)
						xmap gs <plug>(SubversiveSubstituteRange)
					Plug 'tommcdo/vim-exchange'
						let g:exchange_no_mappings = 1
						nmap gx  <Plug>(Exchange)
						nmap gxx <Plug>(ExchangeLine)
						xmap X	 <Plug>(Exchange)
						nmap gxc <Plug>(ExchangeClear)
					Plug 'arthurxavierx/vim-caser'
						"CONFIGURATIONS
							let g:caser_no_mappings = 1
							let g:caser_prefix = 'gc'
						"MAPPINGS
							nmap <silent> gcc <Plug>CaserCamelCase
							vmap <silent> gcc <Plug>CaserVCamelCase

							nmap <silent> gcp <Plug>CaserMixedCase
							vmap <silent> gcp <Plug>CaserVMixedCase

							nmap <silent> gc. <Plug>CaserDotCase
							vmap <silent> gc. <Plug>CaserVDotCase

							nmap <silent> gc- <Plug>CaserKebabCase
							vmap <silent> gc- <Plug>CaserVKebabCase

							nmap <silent> gc_ <Plug>CaserSnakeCase
							vmap <silent> gc_ <Plug>CaserVSnakeCase

							nmap <silent> gc<space> <Plug>CaserSpaceCase
							vmap <silent> gc<space> <Plug>CaserVMixSpaceCase

							nmap <silent> gcT <Plug>CaserTitleKebabCase
							vmap <silent> gcT <Plug>CaserVTitleKebabCase

							nmap <silent> gct <Plug>CaserTitleCase
							vmap <silent> gct <Plug>CaserVTitleCase

							nmap <silent> gcs <Plug>CaserSentenceCase
							vmap <silent> gcs <Plug>CaserVSentenceCase

							nnoremap <silent> gcl gu
							vnoremap <silent> gcl gu

							nmap <silent> gcu <Plug>CaserUpperCase
							vmap <silent> gcu <Plug>CaserVUpperCase
					Plug 'gustavo-hms/vim-duplicate'
						map gy <Plug>(operator-duplicate)
					"TODO:DECIDE
						Plug 'rjayatilleka/vim-operator-goto'
							map g[ <Plug>(operator-gotostart)
							map g] <Plug>(operator-gotoend)
						Plug 'deris/vim-operator-insert'
							"TODO:FIX|DECIDE
							nmap gi <Plug>(operator-insert-i)
							nmap ga <Plug>(operator-insert-a)
				"OBJECTS
					Plug 'wellle/targets.vim'
					Plug 'michaeljsmith/vim-indent-object'
					Plug 'Julian/vim-textobj-variable-segment'
					Plug 'saaguero/vim-textobj-pastedtext'
						let g:pastedtext_select_key = 'gp'
					Plug 'rhysd/vim-textobj-lastinserted'
					Plug 'coderifous/textobj-word-column.vim'
					Plug 'rhysd/vim-textobj-anyblock'
					Plug 'thinca/vim-textobj-between'
					Plug 'sgur/vim-textobj-parameter'
						let g:vim_textobj_parameter_mapping = 'a'
					Plug 'glts/vim-textobj-comment'
						let g:textobj_comment_no_default_mappings = 1
						xmap ak <Plug>(textobj-comment-a)
						xmap ik <Plug>(textobj-comment-i)
						omap ak <Plug>(textobj-comment-a)
						omap ik <Plug>(textobj-comment-i)
				"MOTIONS
					Plug 'chaoren/vim-wordmotion'
					Plug 'haya14busa/vim-edgemotion'
						"map <C-j> <Plug>(edgemotion-j)
						"map <C-k> <Plug>(edgemotion-k)
				"SEARCH
					Plug 'haya14busa/vim-asterisk'
						"CONFIGURATION
							"TODO:NOT-WORKING
							let g:asterisk#keeppos = 1
						"MAPPINGS
							map *  <Plug>(asterisk-z*)
							map #  <Plug>(asterisk-z#)
							map g* <Plug>(asterisk-gz*)
							map g# <Plug>(asterisk-gz#)
					Plug 'bronson/vim-visual-star-search'
					Plug 'rhysd/clever-f.vim'
						let g:clever_f_ignore_case           = 1
						let g:clever_f_smart_case            = 1
						let g:clever_f_across_no_line        = 0
						let g:clever_f_chars_match_any_signs = '['
					Plug 'justinmk/vim-sneak'
						"CONFIGURATION
							let g:sneak#label	   = 0
							let g:sneak#s_next	   = 1
							let g:sneak#use_ic_scs = 1
						"MAPPINGS
							"map f <Plug>Sneak_s
							"map F <Plug>Sneak_S
							"map t <Plug>Sneak_t
								"not-working"
							"map T <Plug>Sneak_T
								"not-working"
					Plug 'haya14busa/incsearch.vim'
						"CONFIGURATION
						"MAPPINGS
							"SEARCH
								map / <Plug>(incsearch-forward)
									"map / <Plug>(incsearch-stay)
								map ? <Plug>(incsearch-backward)
							"NOHL
								""using "vim-cool"
								"set hlsearch
								"let g:incsearch#auto_nohlsearch = 1
								"map n	<Plug>(incsearch-nohl-n)
								"map N	<Plug>(incsearch-nohl-N)
								"map *	<Plug>(incsearch-nohl-*)
								"map #	<Plug>(incsearch-nohl-#)
								"map g* <Plug>(incsearch-nohl-g*)
								"map g# <Plug>(incsearch-nohl-g#)
						"EXTENSIONS
							Plug 'haya14busa/incsearch-fuzzy.vim'
								map <Leader>/ <Plug>(incsearch-fuzzy-/)
									"map <Leader>/ <Plug>(incsearch-fuzzy-stay)
								map <Leader>? <Plug>(incsearch-fuzzy-?)
					Plug 'lambdalisue/reword.vim'
					if v:version >= 740
						Plug 'andymass/vim-matchup'
					endif
				"RANDOM
					Plug 'machakann/vim-swap'
						let g:swap_no_default_key_mappings = 1
						nmap g<			<Plug>(swap-prev)
						nmap g>			<Plug>(swap-next)
						nmap <Leader>zs <Plug>(swap-interactive)

						onoremap id <Plug>(swap-textobject-i)
						onoremap ad <Plug>(swap-textobject-a)
					Plug 'AndrewRadev/splitjoin.vim'
					Plug 'jiangmiao/auto-pairs'
						let g:AutoPairsShortcutToggle = ''
						let g:AutoPairsShortcutJump = ''
						let g:AutoPairsFastWrap = ''
						let g:AutoPairsShortcutBackInsert = ''
					Plug 'terryma/vim-multiple-cursors'
						let g:multi_cursor_use_default_mapping = 0
						let g:multi_cursor_quit_key            = '<Esc>'
						let g:multi_cursor_start_word_key      = '<C-n>'
						let g:multi_cursor_start_key           = 'g<C-n>'
						let g:multi_cursor_next_key            = '<C-n>'
						let g:multi_cursor_prev_key            = '<C-p>'
						let g:multi_cursor_skip_key            = '<C-x>'
						let g:multi_cursor_select_all_word_key = '<A-a>'
						let g:multi_cursor_select_all_key      = 'g<A-a>'
					Plug 'dkarter/bullets.vim'
						let g:bullets_set_mappings = 0
						let g:bullets_enabled_file_types = [
							\ 'markdown',
							\ 'text',
							\ 'gitcommit',
							\ 'scratch',
						\]
						let g:bullets_delete_last_bullet_if_empty = 1
						let g:bullets_pad_right = 1
						let g:bullets_max_alpha_characters = 2
			"PROGRAMMING
				"LSP
					if has('nvim-0.5')
						luafile ~/.config/nvim/general/lsp.lua
						Plug 'neovim/nvim-lspconfig'
						Plug 'folke/lua-dev.nvim'
					elseif has('node') && (v:version >= 800 || has('nvim-0.4'))
						Plug 'neoclide/coc.nvim', {'branch': 'release'}
							"PLUGINS
								Plug 'Shougo/neco-vim'
								Plug 'neoclide/coc-neco'
							"EXTENSIONS
								"META
									let g:coc_global_extensions = [
										\ 'coc-marketplace',
										\ 'coc-explorer',
										\ 'coc-floatinput',
										\ 'coc-yank',
									\]
								"LSP
									let g:coc_global_extensions += [
										\ 'coc-vimlsp',
										\ 'coc-lua',
										\ 'coc-clangd',
										\ 'coc-html',
										\ 'coc-svg',
										\ 'coc-css',
										\ 'coc-cssmodules',
										\ 'coc-tsserver',
										\ 'coc-rome',
										\ 'coc-pyright',
										\ 'coc-java',
										\ 'coc-omnisharp',
										\ 'coc-sh',
										\ 'coc-sql',
										\ 'coc-graphql',
										\ 'coc-metals',
										\ 'coc-fsharp',
										\ 'coc-go',
										\ 'coc-r-lsp',
										\ 'coc-xml',
										\ 'coc-json',
										\ 'coc-yaml',
										\ 'coc-toml',
										\ 'coc-styled-components',
										\ 'coc-docker',
									\]
								"TOOLING
									let g:coc_global_extensions += [
										\ 'coc-git',
										\ 'coc-gitignore',
										\ 'coc-github',
										\ 'coc-gist',
										\ 'coc-flow',
										\ 'coc-eslint',
										\ 'coc-tslint-plugin',
										\ 'coc-stylelint',
										\ 'coc-stylelintplus',
										\ 'coc-diagnostic',
										\ 'coc-style-helper',
										\ 'coc-jest',
										\ 'coc-inline-jest',
										\ 'coc-markdownlint',
										\ 'coc-prettier',
										\ 'coc-react-refactor',
										\ 'coc-format-json',
										\ 'coc-import-cost',
										\ 'coc-docthis',
										\ 'coc-snippets',
										\ 'coc-zi',
										\ 'coc-pairs',
										\ 'coc-emmet',
										\ 'coc-tabnine',
										\ 'coc-syntax',
										\ 'coc-highlight',
										\ 'coc-restclient',
										\ 'coc-db',
									\]
								"RANDOM
									let g:coc_global_extensions += [
										\ 'coc-lists',
										\ 'coc-markmap',
										\ 'coc-template',
										\ 'coc-leetcode',
										\ 'coc-browser',
										\ 'coc-spell-checker',
										\ 'coc-emoji',
										\ 'coc-emoji-shortcodes',
										\ 'coc-calc',
									\]
							"FUNCTIONS
								function! s:checkBackspace() abort
									let col = col('.') - 1
									return !col || getline('.')[col - 1]	=~# '\s'
								endfunction

								function! s:showDocumentation()
									if (index(['vim','help'], &filetype) >= 0)
										execute 'h '.expand('<cword>')
									else
										call CocAction('doHover')
									endif
								endfunction
							"COMMANDS
								command! -nargs=0 COCFormat          :call CocAction('format')
								command! -nargs=? COCFold            :call CocAction('fold', <f-args>)
								command! -nargs=0 COCOrganizeImports :call CocAction('runCommand', 'editor.action.organizeImport')
							"AUTOCOMMANDS
								augroup COC
									autocmd!
									autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
									autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
								augroup end

								autocmd CursorHold * silent call CocActionAsync('highlight')
							"MAPPINGS
								"COC-GOTO
									nmap <silent> <Leader>lgd <Plug>(coc-definition)
									nmap <silent> <Leader>lgD <Plug>(coc-type-definition)
									nmap <silent> <Leader>lgi <Plug>(coc-implementation)
									nmap <silent> <Leader>lgr <Plug>(coc-references)
								"COC-COMPLETION
									inoremap <silent> <expr> <C-SPACE> coc#refresh()
									inoremap <silent> <expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
									inoremap <silent> <expr> <TAB>
										\ pumvisible() ? "\<C-n>" :
										\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
										\ <SID>checkBackspace() ? "\<TAB>" :
										\ coc#refresh()
									inoremap <silent> <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
								"COC-SNIPPETS
									"imap <C-l>     <Plug>(coc-snippets-expand)
									"imap <C-j>     <Plug>(coc-snippets-select)
									"imap <C-j>     <Plug>(coc-snippets-expand-jump)
									"xmap <leader>x <Plug>(coc-convert-snippet)
								"COC-DIAGNOSTICS
									nmap <silent> [e <Plug>(coc-diagnostic-prev)
									nmap <silent> ]e <Plug>(coc-diagnostic-next)
								"COC-ACTIONS
									nmap <leader>lac <Plug>(coc-codeaction)
									nmap <leader>laq <Plug>(coc-fix-current)
									xmap <leader>laf <Plug>(coc-format-selected)
									nmap <leader>laf <Plug>(coc-format-selected)
									nmap <leader>laF :COCFormat<CR>
									nmap <leader>lao :COCOrganizeImports<CR>

									nmap <C-A-a>  <Plug>(coc-codeaction-selected)
									xmap <C-A-a>  <Plug>(coc-codeaction-selected)
								"COC-DOCUMENTATION
									nnoremap <silent> K :call s:showDocumentation()<CR>
								"COC-OBJECTS
									"NOTE: Requires 'textDocument.documentSymbol' support from the language server.
									xmap <LocalLeader>if <Plug>(coc-funcobj-i)
									omap <LocalLeader>if <Plug>(coc-funcobj-i)
									xmap <LocalLeader>af <Plug>(coc-funcobj-a)
									omap <LocalLeader>af <Plug>(coc-funcobj-a)
									xmap <LocalLeader>ic <Plug>(coc-classobj-i)
									omap <LocalLeader>ic <Plug>(coc-classobj-i)
									xmap <LocalLeader>ac <Plug>(coc-classobj-a)
									omap <LocalLeader>ac <Plug>(coc-classobj-a)
								"COC-LIST
									nnoremap <silent><nowait> <Leader>lL  :<C-u>CocList<CR>
									nnoremap <silent><nowait> <Leader>ll  :<C-u>CocListResume<CR>
									nnoremap <silent><nowait> <Leader>le  :<C-u>CocList diagnostics<CR>
									nnoremap <silent><nowait> <Leader>lc  :<C-u>CocList commands<CR>
									nnoremap <silent><nowait> <Leader>lso  :<C-u>CocList outline<CR>
									nnoremap <silent><nowait> <Leader>lsl  :<C-u>CocList -I symbols<CR>

									nnoremap <silent><nowait> <Leader>ln  :<C-u>CocNext<CR>
									nnoremap <silent><nowait> <Leader>lp  :<C-u>CocPrev<CR>
								"RANDOM
									nmap          <Leader>lsr <Plug>(coc-rename)
									nmap <silent> <C-s>      <Plug>(coc-range-select)
									xmap <silent> <C-s>      <Plug>(coc-range-select)
					endif
				"TREESITTER
					if has('nvim-0.5')
						Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
						Plug 'nvim-treesitter/nvim-treesitter-textobjects'
						Plug 'singlexyz/treesitter-frontend-textobjects'
						Plug 'nvim-treesitter/nvim-treesitter-refactor'
						Plug 'windwp/nvim-ts-autotag'
						Plug 'JoosepAlviste/nvim-ts-context-commentstring'
					endif
				"COMMENTS
					if has('nvim-0.5')
						Plug 's1n7ax/nvim-comment-frame'
					endif
					Plug 'scrooloose/nerdcommenter'
						"CONFIGURATION
							let g:NERDCreateDefaultMappings  = 0
							let g:NERDSpaceDelims            = 1
							let g:NERDCompactSexyComs        = 1
							let g:NERDDefaultAlign           = 'left'
							let g:NERDAltDelims_java         = 1
							let g:NERDCustomDelimiters       = { 'c': { 'left': '/**','right': '*/' } }
							let g:NERDCommentEmptyLines      = 0
							let g:NERDTrimTrailingWhitespace = 1
							let g:NERDToggleCheckAllLines    = 1
						"MAPPINGS
							nmap gkt <plug>NERDCommenterToggle
							xmap gkt <plug>NERDCommenterToggle

							nmap gkc <plug>NERDCommenterComment
							xmap gkc <plug>NERDCommenterComment

							nmap gku <plug>NERDCommenterUncomment
							xmap gku <plug>NERDCommenterUncomment

							xmap gkn <plug>NERDCommenterNested
							xmap gki <plug>NERDCommenterInvert
							xmap gky <plug>NERDCommenterYank

							"xmap gkm <plug>NERDCommenterAltDelims
							xmap gkm <plug>NERDCommenterMinimal
							xmap gks <plug>NERDCommenterSexy

							nmap gk9 <plug>NERDCommenterToEOL
							nmap gka <plug>NERDCommenterAppend

							nmap <silent> <A-c> <plug>NERDCommenterToggle
							xmap <silent> <A-c> <plug>NERDCommenterToggle
			"RANDOM
				Plug 'tyru/open-browser.vim'
					"CONFIGURATION
						"if something' not working run :VimProcInstall"
						let g:netrw_nogx = 1
						let g:openbrowser_search_engines = {
							\'askubuntu'   : 'http://askubuntu.com/search?q={query}',
							\'duckduckgo'  : 'http://duckduckgo.com/?q={query}',
							\'github'	   : 'http://github.com/search?q={query}',
							\'google'	   : 'http://google.com/search?q={query}',
							\'vim'		   : 'http://www.google.com/cse?cx=partner-pub-3005259998294962%3Abvyni59kjr1&ie=ISO-8859-1&q={query}&sa=Search&siteurl=www.vim.org%2F#gsc.tab=0&gsc.q={query}&gsc.page=1',
							\'flipkart'    : 'https://www.flipkart.com/search?q={query}&otracker=start&as-show=off&as=off',
							\'wikipedia'   : 'http://en.wikipedia.org/wiki/{query}',
							\'wikivoyage'  : 'https://en.wikivoyage.org/wiki/{query}',
							\'wiktionary'  : 'https://en.wiktionary.org/wiki/{query}',
							\'wikinews'    : 'https://en.wikinews.org/wiki/{query}',
							\'wikisource'  : 'https://en.wikisource.org/wiki/{query}',
							\'wikibooks'   : 'https://en.wikibooks.org/wiki/{query}',
							\'wikidata'    : 'https://en.wikidata.org/wiki/{query}',
							\'wikispecies' : 'https://species.wikimedia.org/wiki/{query}',
							\'wikiquote'   : 'https://en.wikiquote.org/wiki/{query}',
						\ }
					"FUNCTIONS
						function! OpenUnderCursor()
							let l:word = GetWORDUnderCursor()

							if l:word !~  '^http'
								let l:word = 'https://' . l:word
							endif

							execute 'OpenBrowser ' . l:word
						endfunction
					"OPERATORS
						"OPERATOR-BROWSER
							function! OperatorOpenBrowser(visual, ...)
								let [lineStart, columnStart] = getpos(a:0 ? "'<" : "'[")[1:2]
								let [lineEnd, columnEnd]	 = getpos(a:0 ? "'>" : "']")[1:2]
								let lines					 = getline(lineStart, lineEnd)

								if len(lines) == 0
									return
								endif

								if a:visual == 'block' || a:visual == "\<c-v>"
									call PEchoError('Operator not defined for VISUAL-BLOCK mode')
									return
								elseif a:visual == 'line' || a:visual ==# 'V'
									execute 'OpenBrowserSmartSearch ' . join(lines, '\n')
								elseif a:visual == 'char' || a:visual ==# 'v'
									let lines[-1] = lines[-1][: columnEnd - (&selection == 'inclusive' ? 1 : 2)]
									let lines[0]  = lines[0][columnStart - 1:]
									execute 'OpenBrowserSmartSearch ' . join(lines, '\n')
								endif
							endfunction

							nnoremap <silent> gb :set opfunc=OperatorOpenBrowser<CR>g@
							vnoremap <silent> gb :<C-U>call OperatorOpenBrowser(visualmode(), 1)<CR>

							nnoremap <silent> gbb :call OpenUnderCursor()<CR>
					"MAPPINGS
						"CUSTOM
							nmap <Leader>og :execute ":OpenBrowserSearch -github " GetWordUnderCursor() <CR>
							vmap <Leader>og :<C-w>execute ":OpenBrowserSearch -github " GetSelectedText() <CR>

							nmap <Leader>od :execute ":OpenBrowserSearch -duckduckgo " GetWordUnderCursor() <CR>
							vmap <Leader>od :<C-w>execute ":OpenBrowserSearch -duckduckgo " GetSelectedText() <CR>

							nmap <Leader>ow :execute ":OpenBrowserSearch -wikipedia " GetWordUnderCursor() <CR>
							vmap <Leader>ow :<C-w>execute ":OpenBrowserSearch -wikipedia " GetSelectedText() <CR>
			"LIBRARIES
				"EDITING
					Plug 'kana/vim-operator-user'
					Plug 'kana/vim-textobj-user'
			"DEPENDENCIES
				Plug 'Shougo/vimproc.vim'
		call plug#end()
	"POST-LOADING
		"LUA
			if has('nvim-0.5')
				"editing
				lua require('plugins/comment-frame')

				"treesitter
				lua require('plugins/treesitter/treesitter')

				"lsp
				lua require('plugins/lsp/lspconfig')
				"lua require('plugins/lsp/lsp-ts-utils')
				"lua require('plugins/lsp/lua-dev')

				"editor
				"lua require('numb').setup()
			endif
"CONFIGURATION
	"PYTHON-BINARIES
		let g:loaded_python_provider  = 1
		let g:loaded_python3_provider = 1

		if IsNix()
			let g:python_host_prog	= '/usr/bin/python'
			let g:python3_host_prog = '/usr/local/bin/python3'
		elseif IsWindows()
			"TODO:FIX
			let g:python_host_prog	= "C:/Users/138100/scoop/apps/anaconda3/current/envs/pynvim2/python.exe"
			let g:python3_host_prog = "C:/Users/138100/scoop/apps/anaconda3/current/envs/pynvim/python.exe"
		endif
	"MSWIN
		if IsWindows()
			nnoremap <Leader>mm :source $VIMRUNTIME/mswin.vim<CR>
		endif
"SETTINGS
	"FOLDING
		if has('folding')
			set foldlevel=0
			set foldignore=
			set foldlevelstart=99
		endif
	"INDENTATION
		set autoindent
		set smartindent
		set smarttab
		set shiftwidth=4
		set tabstop=4
		set noexpandtab
	"LINES
		set number
		set relativenumber
	"SWAP|BACKUP|UNDO
		set undofile
		set nobackup
		set nowritebackup
		set undodir=~/.config/nvim/tmp/undofiles
		set directory=~/.config/nvim/tmp/swapfiles
	"SEARCH
		set nohls
		set incsearch
		set ignorecase
		set smartcase
		set gdefault
	"SEARCH-FILES
		set path+=.,,**
			"using ":find" to find files recursively in current "cd", by using patterns
		if has('wildmenu')
			set wildmenu
			set wildmode=longest:full,full
			set wildignore+=*.a,*.o
			set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
			set wildignore+=.DS_Store,.git,.hg,.svn
			set wildignore+=*~,*.swp,*.tmp
			set wildignore+=node_modules,package-lock.json,yarn-lock.json
			set wildignorecase
		endif
	"COMMANDS
		set ttimeout
		set ttimeoutlen=100
		set timeoutlen=500
	"INTERFACE
		"BTW
			"BUFFER
				set nowrap
				set hidden
				set fileformats=unix,mac,dos
				set noruler
				"TODO:FIX
					"set colorcolumn=120
					"DAMIAN-CONVAY
					"highlight ColorColumn ctermbg=magenta
					"call matchadd('ColorColumn', '\%81v', 100)
		"CURSOR
			set nocursorcolumn
			set cursorline
			set nostartofline
	"FILESYSTEM
		"FILETYPE
			augroup CONFIGURATIONS
				au!
				au Filetype python set tabstop=4 | set shiftwidth=4 | set noexpandtab
				au Filetype scala set tabstop=4 | set shiftwidth=4 | set noexpandtab
				au BufEnter *.csx set filetype=csx | set syntax=cs

				"FILETYPE=jproperties FOR TEXT FILES
				autocmd BufNewFile,BufRead *.txt set syntax=jproperties
				autocmd Filetype text set syntax=jproperties
			augroup END
	"RANDOM
		let loaded_netrwPlugin = 0
		set scrolloff=10
		set nocompatible
			"disabling vi compatibility features|mappings…
		set mouse=a
		set clipboard=unnamed
		set nf="alpha,octal,hex,bin"
		set updatetime=50
			"mainly used coc.nvim
			"default is 4000ms(4s) which leads to noticeable delays and poor user experience.
"CLIENTS
	source ~/.config/nvim/clients/vscode.vim
