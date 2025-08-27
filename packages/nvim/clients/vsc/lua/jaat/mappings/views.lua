vim.cmd [[
	nnoremap <C-9> <CMD>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>
	nnoremap <C-0> <CMD>call VSCodeNotify('workbench.action.togglePanel')<CR>

	nnoremap <Leader>v. <CMD>call VSCodeNotify('workbench.action.openView')<CR>

	"LEFT
	nnoremap <Leader>vf <CMD>call VSCodeNotify('workbench.view.explorer')<CR>
	nnoremap <Leader>vd <CMD>call VSCodeNotify('workbench.view.debug')<CR>
	nnoremap <Leader>vg <CMD>call VSCodeNotify('workbench.view.scm')<CR>
	nnoremap <Leader>ve <CMD>call VSCodeNotify('workbench.view.extensions')<CR>
	nnoremap <Leader>vs <CMD>call VSCodeNotify('workbench.view.search')<CR>

	"BOTTOM
	nnoremap <Leader>vt <CMD>call VSCodeNotify('workbench.action.terminal.toggleTerminal')<CR>
	nnoremap <Leader>vo <CMD>call VSCodeNotify('workbench.action.output.toggleOutput')<CR>
	nnoremap <Leader>vp <CMD>call VSCodeNotify('workbench.actions.view.toggleProblems')<CR>

	"RANDOM
	nnoremap <Leader>vz <CMD>call VSCodeNotify('workbench.action.toggleZenMode')<CR>
]]
