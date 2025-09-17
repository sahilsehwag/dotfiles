vim.cmd [[
  nnoremap gd <CMD>call VSCodeNotify('editor.action.revealDefinition')<CR>
  nnoremap gD <CMD>call VSCodeNotify('editor.action.revealDefinitionAside')<CR>
  nnoremap gt <CMD>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>
  nnoremap gi <CMD>call VSCodeNotify('editor.action.goToImplementation')<CR>
  nnoremap gr <CMD>call VSCodeNotify('editor.action.goToReferences')<CR>

  nnoremap K <CMD>call VSCodeNotify('editor.action.showHover')<CR>
  nnoremap gp <CMD>call VSCodeNotify('editor.action.triggerParameterHints')<CR>

  nnoremap [e <CMD>call VSCodeNotify('editor.action.marker.prev')<CR>
  nnoremap ]e <CMD>call VSCodeNotify('editor.action.marker.next')<CR>

  nnoremap <Leader>la. <CMD>call VSCodeNotify('editor.action.sourceAction')<CR>
  nnoremap <Leader>laq <CMD>call VSCodeNotify('editor.action.quickFix')<CR>
  nnoremap <Leader>laf <CMD>call VSCodeNotify('editor.action.formatDocument')<CR>
  vnoremap <Leader>laf <CMD>call VSCodeNotify('editor.action.formatSelection')<CR>
  nnoremap <Leader>laF <CMD>call VSCodeNotify('editor.action.formatChanges')<CR>
  nnoremap <Leader>lar <CMD>call VSCodeNotify('editor.action.refactor')<CR>

  nnoremap <Leader>ltf <CMD>call VSCodeNotify('testing.runCurrentFile')<CR>
  nnoremap <Leader>ltp <CMD>call VSCodeNotify('testing.runAll')<CR>
  nnoremap <Leader>ltc <CMD>call VSCodeNotify('testing.runAtCursor')<CR>
  nnoremap <Leader>ltr <CMD>call VSCodeNotify('testing.reRunLastRun')<CR>

  nnoremap <Leader>lbb <CMD>call VSCodeNotify('editor.debug.action.toggleBreakpoint')<CR>
  nnoremap <Leader>lbq <CMD>call VSCodeNotify('workbench.debug.action.showDebugHover')<CR>
  nnoremap <Leader>lbc <CMD>call VSCodeNotify('editor.debug.action.conditionalBreakpoint')<CR>
  nnoremap <Leader>lbl <CMD>call VSCodeNotify('editor.debug.action.toggleLogPoint')<CR>
  nnoremap <Leader>lbC <CMD>call VSCodeNotify('workbench.debug.viewlet.action.removeAllBreakpoints')<CR>

  nnoremap <Leader>lsr <CMD>call VSCodeNotify('editor.action.rename')<CR>
  nnoremap <Leader>lsf <CMD>call VSCodeNotify('workbench.action.gotoSymbol')<CR>
  nnoremap <Leader>lsp <CMD>call VSCodeNotify('workbench.action.showAllSymbols')<CR>
  nnoremap <Leader>lsi <CMD>call VSCodeNotify('references-view.showIncomingCalls')<CR>
  nnoremap <Leader>lso <CMD>call VSCodeNotify('references-view.showOutgoingCalls')<CR>
  nnoremap <Leader>lsh <CMD>call VSCodeNotify('references-view.showCallHierarchy')<CR>

  "nnoremap [r <CMD>call VSCodeNotify('references-view.prev')<CR>
  "nnoremap ]r <CMD>call VSCodeNotify('references-view.next')<CR>

  nnoremap <Leader>lgd <CMD>call VSCodeNotify('editor.action.revealDefinition')<CR>
  nnoremap <Leader>lgD <CMD>call VSCodeNotify('editor.action.revealDefinitionAside')<CR>
  nnoremap <Leader>lgt <CMD>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>
  nnoremap <Leader>lgi <CMD>call VSCodeNotify('editor.action.goToImplementation')<CR>
  nnoremap <Leader>lgr <CMD>call VSCodeNotify('references-view.findReferences')<CR>
  nnoremap <Leader>lgR <CMD>call VSCodeNotify('editor.action.goToReferences')<CR>

  nnoremap <Leader>lpd <CMD>call VSCodeNotify('editor.action.peekDefinition')<CR>
  nnoremap <Leader>lpt <CMD>call VSCodeNotify('editor.action.peekTypeDefinition')<CR>
  nnoremap <Leader>lpi <CMD>call VSCodeNotify('editor.action.peekImplementation')<CR>
  nnoremap <Leader>lpr <CMD>call VSCodeNotify('editor.action.peekReferences')<CR>
  nnoremap <Leader>lph <CMD>call VSCodeNotify('editor.showCallHierarchy')<CR>

  nnoremap <Leader>lds <CMD>call VSCodeNotify('workbench.action.debug.start')<CR>
  nnoremap <Leader>ldt <CMD>call VSCodeNotify('workbench.action.debug.stop')<CR>
  nnoremap <Leader>ldr <CMD>call VSCodeNotify('workbench.action.debug.restart')<CR>
  nnoremap <Leader>ld. <CMD>call VSCodeNotify('workbench.action.debug.run')<CR>
  nnoremap <Leader>ldh <CMD>call VSCodeNotify('workbench.debug.action.showDebugHover')<CR>
  nnoremap <Leader>ldj <CMD>call VSCodeNotify('editor.debug.action.stepInto')<CR>
  nnoremap <Leader>ldk <CMD>call VSCodeNotify('editor.debug.action.stepOut')<CR>
  nnoremap <Leader>ldl <CMD>call VSCodeNotify('editor.debug.action.stepOver')<CR>
]]
