"CONFIGURATION
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
