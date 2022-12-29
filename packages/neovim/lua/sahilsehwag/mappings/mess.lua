vim.cmd [[
	"MARKUP
		"MARKDOWN
			"@TODO:FIX
			augroup MARKDOWN
				au!
				"au FileType markdown nmap <buffer> <LocalLeader>ch :call RunNpmCommand('', "%", 'gh-markdown-cli')<CR>
				"au FileType markdown vmap <buffer> <LocalLeader>ch :call RunNpmCommand('mdown', '', "'<,'>", 'gh-markdown-cli')<CR>
			augroup END
		"XML
			augroup XML
				au!
				au FileType xml nmap <buffer> <LocalLeader>cj :call RunNpmCommand('x2j', '', '%', 'x2j-cli')<CR>
				au FileType xml vmap <buffer> <LocalLeader>cj :call RunNpmCommand('x2j', '', "'<,'>", 'x2j-cli')<CR>
			augroup END
		"MATH
			augroup MATH
				au!
				"OPERATORS
					"ALGEBRIC
						au FileType math iabbrev <buffer> is =
							au FileType math iabbrev <buffer> equal =
							au FileType math iabbrev <buffer> equals =
							au FileType math iabbrev <buffer> equalsto =
						au FileType math iabbrev <buffer> add +
						au FileType math iabbrev <buffer> sub -
						au FileType math iabbrev <buffer> lt <
						au FileType math iabbrev <buffer> gt >
						au FileType math iabbrev <buffer> le ≤
							au FileType math iabbrev <buffer> <= ≤
						au FileType math iabbrev <buffer> ge ≥
							au FileType math iabbrev <buffer> >= ≥
						au FileType math iabbrev <buffer> ne ≠
							au FileType math iabbrev <buffer> != ≠
						au FileType math iabbrev <buffer> == ⇔
						au FileType math iabbrev <buffer> . ∙
						au FileType math iabbrev <buffer> \ ÷
							au FileType math iabbrev <buffer> div ÷
					"SET
						au FileType math iabbrev <buffer> su ∪
						au FileType math iabbrev <buffer> si ∩
				"FUNCTIONS
					"CALCULAS
						au FileType math iabbrev <buffer> int ∫
						au FileType math iabbrev <buffer> int2 ∬
						au FileType math iabbrev <buffer> int3 ∭
						au FileType math iabbrev <buffer> int4 ⨌
						au FileType math iabbrev <buffer> diff 𝛛
					"ALGEBRIC
						au FileType math iabbrev <buffer> sqrt √
						au FileType math iabbrev <buffer> cbrt ∛
						au FileType math iabbrev <buffer> qdrt ∜
				"SYMBOLS
					"MATH
						au FileType math iabbrev <buffer> inf ∞
						au FileType math iabbrev <buffer> ninf -∞
						au FileType math iabbrev <buffer> pm ±
						au FileType math iabbrev <buffer> mp ∓
					"NUMBERS
						au FileType math iabbrev <buffer> 0u ⁰<ESC>F<SPACE>xa
						au FileType math iabbrev <buffer> 1u ¹<ESC>F<SPACE>xa
						au FileType math iabbrev <buffer> 2u ²<ESC>F<SPACE>xa
						au FileType math iabbrev <buffer> 3u ³<ESC>F<SPACE>xa
						au FileType math iabbrev <buffer> 4u ⁴<ESC>F<SPACE>xa
						au FileType math iabbrev <buffer> 5u ⁵<ESC>F<SPACE>xa
						au FileType math iabbrev <buffer> 6u ⁶<ESC>F<SPACE>xa
						au FileType math iabbrev <buffer> 7u ⁷<ESC>F<SPACE>xa
						au FileType math iabbrev <buffer> 8u ⁸<ESC>F<SPACE>xa
						au FileType math iabbrev <buffer> 9u ⁹<ESC>F<SPACE>xa
						au FileType math iabbrev <buffer> 0d ₀<ESC>F<SPACE>xa
						au FileType math iabbrev <buffer> 1d ₁<ESC>F<SPACE>xa
						au FileType math iabbrev <buffer> 2d ₂<ESC>F<SPACE>xa
						au FileType math iabbrev <buffer> 3d ₃<ESC>F<SPACE>xa
						au FileType math iabbrev <buffer> 4d ₄<ESC>F<SPACE>xa
						au FileType math iabbrev <buffer> 5d ₅<ESC>F<SPACE>xa
						au FileType math iabbrev <buffer> 6d ₆<ESC>F<SPACE>xa
						au FileType math iabbrev <buffer> 7d ₇<ESC>F<SPACE>xa
						au FileType math iabbrev <buffer> 8d ₈<ESC>F<SPACE>xa
						au FileType math iabbrev <buffer> 9d ₉<ESC>F<SPACE>xa
					"LATIN
						au FileType math iabbrev <buffer> alpha 𝛂
						au FileType math iabbrev <buffer> beta 𝛃
						au FileType math iabbrev <buffer> gamma 𝛄
						au FileType math iabbrev <buffer> delta 𝛅
						au FileType math iabbrev <buffer> epsi 𝛆
						au FileType math iabbrev <buffer> eta 𝛈
						au FileType math iabbrev <buffer> theta 𝛉
						au FileType math iabbrev <buffer> lambda 𝛌
						au FileType math iabbrev <buffer> mu 𝛍
						au FileType math iabbrev <buffer> nu 𝛎
						au FileType math iabbrev <buffer> pi 𝛑
						au FileType math iabbrev <buffer> rho 𝛒
						au FileType math iabbrev <buffer> sigma 𝛔
						au FileType math iabbrev <buffer> tau 𝛕
						au FileType math iabbrev <buffer> upsi 𝛖
						au FileType math iabbrev <buffer> phi 𝛟
						au FileType math iabbrev <buffer> chi 𝛘
						au FileType math iabbrev <buffer> psi 𝛙
						au FileType math iabbrev <buffer> omega 𝛚
						au FileType math iabbrev <buffer> kpi 𝛞
				"RANDOM
					au FileType math iabbrev <buffer> tf ∴
						au FileType math iabbrev <buffer> therefore ∴
					au FileType math iabbrev <buffer> ie ∵
					au FileType math iabbrev <buffer> ... ⋯
			augroup END
	"FRONTEND
		"PUG|JADE
			"FUNCTIONS
				function! Pug(range)
					call RunNpmCommand('pug', '-P', a:range, 'pug-cli')
				endfunction
			"MAPPINGS
				augroup PUG
					au!
					au FileType jade,pug map  <buffer> <LocalLeader>cw :JadeWatch html vertical<CR>
					au FileType jade,pug nmap <buffer> <LocalLeader>cc :<C-u> call Pug('')<CR>
					au FileType jade,pug vmap <buffer> <LocalLeader>cc :<C-u> call Pug("'<,'>")<CR>
					au FileType jade,pug nmap <buffer> <LocalLeader>cb :<C-u> call Pug('%')<CR>
				augroup END
		"HTML
			"FUNCTIONS
				function! Html2Pug(range)
					call RunNpmCommand('html2pug', '-f', a:range, 'html2pug')
				endfunction
			"MAPPINGS
				augroup HTML
					au!
					au FileType html nmap <buffer> <LocalLeader>cj :call Html2Pug('%')<CR>
					au FileType html vmap <buffer> <LocalLeader>cj :call Html2Pug("'<,'>")<CR>
				augroup END
	"WORDPRESS
		augroup WORDPRESS
			au!
			au BufEnter wordpress set filetype=jade
			au BufEnter wordpress map <buffer> <LocalLeader>ch :<C-u>call Pug('12,$')<CR>
			au BufEnter wordpress map <buffer> <LocalLeader>cj :<C-u>call Html2Pug('12,$')<CR>
		augroup END
]]
