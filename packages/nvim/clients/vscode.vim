if exists('g:vscode')
	"WINDOW
		nnoremap <Leader>wh <CMD>call VSCodeNotify('workbench.action.splitEditorLeft')<CR>
		nnoremap <Leader>wj <CMD>call VSCodeNotify('workbench.action.splitEditorDown')<CR>
		nnoremap <Leader>wk <CMD>call VSCodeNotify('workbench.action.splitEditorUp')<CR>
		nnoremap <Leader>wl <CMD>call VSCodeNotify('workbench.action.splitEditorRight')<CR>
	"BUFFER
endif
