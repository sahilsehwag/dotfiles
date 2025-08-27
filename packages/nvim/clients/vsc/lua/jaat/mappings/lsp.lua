vim.cmd [[
  nnoremap gd <CMD>call VSCodeNotify('editor.action.revealDefinition')<CR>
  nnoremap gi <CMD>call VSCodeNotify('editor.action.goToImplementation')<CR>
  nnoremap gt <CMD>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>
  nnoremap gr <CMD>call VSCodeNotify('editor.action.goToReferences')<CR>

  nnoremap K <CMD>call VSCodeNotify('editor.action.showHover')<CR>
  nnoremap gp <CMD>call VSCodeNotify('editor.action.triggerParameterHints')<CR>

  nnoremap [e <CMD>call VSCodeNotify('editor.action.marker.prev')<CR>
  nnoremap ]e <CMD>call VSCodeNotify('editor.action.marker.next')<CR>

  nnoremap <Leader>lq <CMD>call VSCodeNotify('editor.action.quickFix')<CR>
  nnoremap <Leader>lr <CMD>call VSCodeNotify('editor.action.rename')<CR>
  nnoremap <Leader>lf <CMD>call VSCodeNotify('editor.action.formatDocument')<CR>

  "nnoremap <Leader>lsd <CMD>call VSCodeNotify('workbench.action.gotoSymbol')<CR>
  "nnoremap <Leader>lsw <CMD>call VSCodeNotify('workbench.action.showAllSymbols')<CR>
  "nnoremap <Leader>lsi <CMD>call VSCodeNotify('editor.action.referenceSearch.trigger')<CR>

  nnoremap <Leader>ltf <CMD>call VSCodeNotify('testing.runCurrentFile')<CR>
  nnoremap <Leader>ltp <CMD>call VSCodeNotify('testing.runAll')<CR>
  nnoremap <Leader>ltc <CMD>call VSCodeNotify('testing.runAtCursor')<CR>
  nnoremap <Leader>ltr <CMD>call VSCodeNotify('testing.reRunLastRun')<CR>

  nnoremap <Leader>lbb <CMD>call VSCodeNotify('editor.debug.action.toggleBreakpoint')<CR>
  nnoremap <Leader>lbq <CMD>call VSCodeNotify('workbench.debug.action.showDebugHover')<CR>
  nnoremap <Leader>lbc <CMD>call VSCodeNotify('editor.debug.action.conditionalBreakpoint')<CR>
  nnoremap <Leader>lbl <CMD>call VSCodeNotify('editor.debug.action.toggleLogPoint')<CR>
  nnoremap <Leader>lbC <CMD>call VSCodeNotify('workbench.debug.viewlet.action.removeAllBreakpoints')<CR>

  nnoremap <Leader>lds <CMD>call VSCodeNotify('workbench.action.debug.start')<CR>
  nnoremap <Leader>ldt <CMD>call VSCodeNotify('workbench.action.debug.stop')<CR>
  nnoremap <Leader>ldr <CMD>call VSCodeNotify('workbench.action.debug.restart')<CR>
  nnoremap <Leader>ld. <CMD>call VSCodeNotify('workbench.action.debug.run')<CR>
  nnoremap <Leader>ldh <CMD>call VSCodeNotify('workbench.debug.action.showDebugHover')<CR>
  nnoremap <Leader>ldj <CMD>call VSCodeNotify('editor.debug.action.stepInto')<CR>
  nnoremap <Leader>ldk <CMD>call VSCodeNotify('editor.debug.action.stepOut')<CR>
  nnoremap <Leader>ldl <CMD>call VSCodeNotify('editor.debug.action.stepOver')<CR>
]]
