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
				\["->u"		, "↑"],
				\["->d"		, "↓"],
				\["<-"		, "←"],
				\["->"		, "→"],
				\["<->"		, "↔"],
				\["<.."		, "⇠"],
				\["..>"		, "⇢"],
				\["..>u"	, "⇡"],
				\["..>d"	, "⇣"],
				\["<--"		, "⟵"],
				\["-->"		, "⟶"],
				\["<-->"	, "⟷"],
				\["<="		, "⇐"],
				\["=>"		, "⇒"],
				\["<=>"		, "⇔"],
				\["<=="		, "⟸"],
				\["==>"		, "⟹"],
				\["<==>"	, "⟺"],
				\["\\|>"	, "↦"],
				\["<\\|"	, "↤"],
				\["\\|->" , "⟼" ],
				\["<-\\|" , "⟻"],
				\["<=\\|" , "⟽"],
				\["\\|=>" , "⟾" ],
			\]
			let g:symbolic_pairs.operators = [
				\["<-"		, "≤"],
				\["<<"		, "≪"],
				\["<<<"		, "⋘"],
				\[">-"		, "≥"],
				\[">>"		, "≫"],
				\[">>>"		, "⋙"],
				\["!="		, "≠"],
				\["*"		, "×"],
				\["/"		, "÷"],
				\["sum"		, "∑"],
				\["prod"	, "∏"],
				\["cprod" , "∐"],
				\["srt"		, "√"],
				\["crt"		, "∛"],
				\["qrt"		, "∜"],
				\["~"		, "≈"],
				\["="		, "≡"],
				\["prop"	, "∝"],
				\["floor" , "⌊⌋"],
				\["ceil"	, "⌈⌉"],
				\["+-"		, "±"],
				\["-+"		, "∓"],
				\["."		, "∙"],
				\["<="		, "≦"],
				\[">="		, "≧"],
				\["ox"		, "⨂"],
				\["o+"		, "⨁"],
				\["o-"		, "⊖"],
				\["o."		, "⨀"],
				\["o*"		, "⊛"],
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
				\["beta"	 , "𝛃"],
				\["gamma"  , "𝛄"],
				\["Gamma"  , "Γ"],
				\["delta"  , "𝛅"],
				\["Delta"  , "∆"],
				\["nabla"  , "∇"],
				\["epsi"	 , "𝛆"],
				\["zeta"	 , "ζ"],
				\["eta"		 , "𝛈"],
				\["theta"  , "𝛉"],
				\["Theta"  , "Θ"],
				\["iota"	 , "ι"],
				\["kappa"  , "𝛞"],
				\["lambda" , "𝛌"],
				\["Lambda" , "Λ"],
				\["mu"		 , "𝛍"],
				\["nu"		 , "𝛎"],
				\["xi"		 , "ξ"],
				\["Xi"		 , "Ξ"],
				\["pi"		 , "𝛑"],
				\["Pi"		 , "Π"],
				\["rho"		 , "𝛒"],
				\["sigma"  , "𝛔"],
				\["Sigma"  , "Σ"],
				\["tau"		 , "𝛕"],
				\["upsi"	 , "𝛖"],
				\["Upsi"	 , "ϒ"],
				\["phi"		 , "φ"],
				\["Phi"		 , "𝛟"],
				\["chi"		 , "𝛘"],
				\["psi"		 , "Ψ"],
				\["Psi"		 , "𝛙"],
				\["omega"  , "𝛚"],
				\["Omega"  , "Ω"],
				\["a"		 , "𝛂"],
				\["b"		 , "𝛃"],
				\["e"		 , "𝛆"],
				\["E"		 , "Σ"],
				\["n"		 , "𝛈"],
				\["o"		 , "𝛉"],
				\["i"		 , "ι"],
				\["u"		 , "𝛍"],
				\["v"		 , "𝛎"],
				\["p"		 , "𝛒"],
				\["T"		 , "𝛕"],
				\["w"		 , "𝛚"],
				\["x"		 , "𝛞"],
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
				\["0u"		 , "⁰"],
				\["1u"		 , "¹"],
				\["2u"		 , "²"],
				\["3u"		 , "³"],
				\["4u"		 , "⁴"],
				\["5u"		 , "⁵"],
				\["6u"		 , "⁶"],
				\["7u"		 , "⁷"],
				\["8u"		 , "⁸"],
				\["9u"		 , "⁹"],
				\["0d"		 , "₀"],
				\["1d"		 , "₁"],
				\["2d"		 , "₂"],
				\["3d"		 , "₃"],
				\["4d"		 , "₄"],
				\["5d"		 , "₅"],
				\["6d"		 , "₆"],
				\["7d"		 , "₇"],
				\["8d"		 , "₈"],
				\["9d"		 , "₉"],
				\["+u"		 , "⁺"],
				\["-u"		 , "⁻"],
				\["(u"		 , "⁽"],
				\[")u"		 , "⁾"],
				\["=u"		 , "⁼"],
				\["+d"		 , "₊"],
				\["-d"		 , "₋"],
				\["(d"		 , "₍"],
				\[")d"		 , "₎"],
				\["=d"		 , "₌"],
				\["au"		 , "ᵃ"],
				\["bu"		 , "ᵇ"],
				\["cu"		 , "ᶜ"],
				\["du"		 , "ᵈ"],
				\["eu"		 , "ᵉ"],
				\["fu"		 , "ᶠ"],
				\["gu"		 , "ᵍ"],
				\["hu"		 , "ʰ"],
				\["iu"		 , "ⁱ"],
				\["ju"		 , "ʲ"],
				\["ku"		 , "ᵏ"],
				\["lu"		 , "ˡ"],
				\["mu"		 , "ᵐ"],
				\["nu"		 , "ⁿ"],
				\["ou"		 , "ᵒ"],
				\["pu"		 , "ᵖ"],
				\["qu"		 , "⁺"],
				\["ru"		 , "ʳ"],
				\["su"		 , "ˢ"],
				\["tu"		 , "ᵗ"],
				\["uu"		 , "ᵘ"],
				\["vu"		 , "ᵛ"],
				\["wu"		 , "ʷ"],
				\["xu"		 , "ˣ"],
				\["yu"		 , "ʸ"],
				\["zu"		 , "ᶻ"],
				\["Au"		 , "ᴬ"],
				\["Bu"		 , "ᴮ"],
				\["Cu"		 , "⁺"],
				\["Du"		 , "ᴰ"],
				\["Eu"		 , "ᴱ"],
				\["Fu"		 , "⁺"],
				\["Gu"		 , "ᴳ"],
				\["Hu"		 , "ᴴ"],
				\["Iu"		 , "ᴵ"],
				\["Ju"		 , "ᴶ"],
				\["Ku"		 , "ᴷ"],
				\["Lu"		 , "ᴸ"],
				\["Mu"		 , "ᴹ"],
				\["Nu"		 , "ᴺ"],
				\["Ou"		 , "ᴼ"],
				\["Pu"		 , "ᴾ"],
				\["Qu"		 , "⁺"],
				\["Ru"		 , "ᴿ"],
				\["Su"		 , "⁺"],
				\["Tu"		 , "ᵀ"],
				\["Uu"		 , "ᵁ"],
				\["Vu"		 , "ⱽ"],
				\["Wu"		 , "ᵂ"],
				\["Xu"		 , "⁺"],
				\["Yu"		 , "⁺"],
				\["Zu"		 , "⁺"],
				\["ad"		 , "ₐ"],
				\["bd"		 , "⁺"],
				\["cd"		 , "⁺"],
				\["dd"		 , "⁺"],
				\["ed"		 , "ₑ"],
				\["fd"		 , "⁺"],
				\["gd"		 , "⁺"],
				\["hd"		 , "⁺"],
				\["id"		 , "ᵢ"],
				\["jd"		 , "ⱼ"],
				\["kd"		 , "⁺"],
				\["ld"		 , "⁺"],
				\["md"		 , "⁺"],
				\["nd"		 , "⁺"],
				\["od"		 , "ₒ"],
				\["pd"		 , "⁺"],
				\["qd"		 , "⁺"],
				\["rd"		 , "ᵣ"],
				\["sd"		 , "⁺"],
				\["td"		 , "⁺"],
				\["ud"		 , "ᵤ"],
				\["vd"		 , "ᵥ"],
				\["wd"		 , "⁺"],
				\["xd"		 , "ₓ"],
				\["yd"		 , "⁺"],
				\["zd"		 , "⁺"],
				\["Ad"		 , "⁺"],
				\["Bd"		 , "⁺"],
				\["Cd"		 , "⁺"],
				\["Dd"		 , "⁺"],
				\["Ed"		 , "⁺"],
				\["Fd"		 , "⁺"],
				\["Gd"		 , "⁺"],
				\["Hd"		 , "⁺"],
				\["Id"		 , "⁺"],
				\["Jd"		 , "⁺"],
				\["Kd"		 , "⁺"],
				\["Ld"		 , "⁺"],
				\["Md"		 , "⁺"],
				\["Nd"		 , "⁺"],
				\["Od"		 , "⁺"],
				\["Pd"		 , "⁺"],
				\["Qd"		 , "⁺"],
				\["Rd"		 , "⁺"],
				\["Sd"		 , "⁺"],
				\["Td"		 , "⁺"],
				\["Ud"		 , "⁺"],
				\["Vd"		 , "⁺"],
				\["Wd"		 , "⁺"],
				\["Xd"		 , "⁺"],
				\["Yd"		 , "⁺"],
				\["Zd"		 , "⁺"],
				\["alphau" , "ᵅ"],
				\["betau"  , "ᵝ"],
				\["epsiu"  , "ᵋ"],
				\["deltau" , "ᵟ"],
				\["thetau" , "ᶿ"],
				\["phiu"	 , "ᶲ"],
				\["Phiu"	 , "ᵠ"],
				\["betad"  , "ᵦ"],
				\["phid"	 , "ᵩ"],
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
