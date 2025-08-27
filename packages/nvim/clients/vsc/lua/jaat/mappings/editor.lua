-- window
vim.cmd [[
  nnoremap <Leader>wh <CMD>call VSCodeNotify('workbench.action.splitEditorLeft')<CR>
  nnoremap <Leader>wj <CMD>call VSCodeNotify('workbench.action.splitEditorDown')<CR>
  nnoremap <Leader>wk <CMD>call VSCodeNotify('workbench.action.splitEditorUp')<CR>
  nnoremap <Leader>wl <CMD>call VSCodeNotify('workbench.action.splitEditorRight')<CR>

  nnoremap <C-h> <CMD>call VSCodeNotify('workbench.action.navigateLeft')<CR>
  nnoremap <C-j> <CMD>call VSCodeNotify('workbench.action.navigateDown')<CR>
  nnoremap <C-k> <CMD>call VSCodeNotify('workbench.action.navigateUp')<CR>
  nnoremap <C-l> <CMD>call VSCodeNotify('workbench.action.navigateRight')<CR>

  nnoremap <Leader>wH <CMD>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
  nnoremap <Leader>wJ <CMD>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
  nnoremap <Leader>wK <CMD>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
  nnoremap <Leader>wL <CMD>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>

  nnoremap <C-S-h> <CMD>call VSCodeNotify('workbench.action.decreaseViewSize')<CR>
  nnoremap <C-S-l> <CMD>call VSCodeNotify('workbench.action.increaseViewSize')<CR>
  nnoremap <Leader>w= <CMD>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>
  nnoremap <Leader>wm <CMD>call VSCodeNotify('workbench.action.toggleMaximizeEditorGroup')<CR>

  nnoremap <Leader>wo <CMD>call VSCodeNotify('workbench.action.closeEditorsInOtherGroups')<CR>
  nnoremap <Leader>wc <CMD>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>

  nnoremap <Leader>wb <CMD>call VSCodeNotify('workbench.action.moveEditorToNewWindow')<CR>
  nnoremap <Leader>wp <CMD>call VSCodeNotify('workbench.action.quickSwitchWindow')<CR>
]]

-- buffers
vim.cmd [[
  nnoremap <C-[> <CMD>call VSCodeNotify('workbench.action.previousEditor')<CR>
  nnoremap <C-]> <CMD>call VSCodeNotify('workbench.action.nextEditor')<CR>

  nnoremap <Leader>bl <CMD>call VSCodeNotify('workbench.action.showAllEditorsByMostRecentlyUsed')<CR>

  nnoremap <Leader>bcc <CMD>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
  nnoremap <Leader>bca <CMD>call VSCodeNotify('workbench.action.closeAllEditors')<CR>
  nnoremap <Leader>bco <CMD>call VSCodeNotify('workbench.action.closeOtherEditors')<CR>
  nnoremap <Leader>bcu <CMD>call VSCodeNotify('workbench.action.closeUnmodifiedEditors')<CR>

  nnoremap <Leader>bwf <CMD>call VSCodeNotify('workbench.action.files.saveWithoutFormatting')<CR>
  nnoremap <Leader>bwa <CMD>call VSCodeNotify('workbench.action.files.saveAll')<CR>

  nnoremap <Leader>br <CMD>call VSCodeNotify('workbench.action.reopenClosedEditor')<CR>

  nnoremap <Leader>bch <CMD>call VSCodeNotify('workbench.action.closeEditorsToTheLeft')<CR>
  nnoremap <Leader>bcl <CMD>call VSCodeNotify('workbench.action.closeEditorsToTheRight')<CR>
  nnoremap <Leader>bco <CMD>call VSCodeNotify('workbench.action.closeOtherEditors')<CR>

  nnoremap <Leader>bn <CMD>call VSCodeNotify('workbench.action.nextEditor')<CR>
  nnoremap <Leader>bp <CMD>call VSCodeNotify('workbench.action.previousEditor')<CR>

  nnoremap <C-1> <CMD>call VSCodeNotify('workbench.action.openEditorAtIndex1')<CR>
  nnoremap <C-2> <CMD>call VSCodeNotify('workbench.action.openEditorAtIndex2')<CR>
  nnoremap <C-3> <CMD>call VSCodeNotify('workbench.action.openEditorAtIndex3')<CR>
  nnoremap <C-4> <CMD>call VSCodeNotify('workbench.action.openEditorAtIndex4')<CR>
  nnoremap <C-5> <CMD>call VSCodeNotify('workbench.action.openEditorAtIndex5')<CR>
  nnoremap <C-6> <CMD>call VSCodeNotify('workbench.action.openEditorAtIndex6')<CR>
  nnoremap <C-7> <CMD>call VSCodeNotify('workbench.action.openEditorAtIndex7')<CR>
  nnoremap <C-8> <CMD>call VSCodeNotify('workbench.action.openEditorAtIndex8')<CR>
  "nnoremap <C-9> <CMD>call VSCodeNotify('workbench.action.openEditorAtIndex9')<CR>
  "nnoremap <C-0> <CMD>call VSCodeNotify('workbench.action.lastEditorInGroup')<CR>
]]

-- tabs
vim.cmd [[
  nnoremap <Leader>tn <CMD>call VSCodeNotify('workbench.action.newWindow')<CR>
  nnoremap <Leader>tr <CMD>call VSCodeNotify('workbench.action.reloadWindow')<CR>
  nnoremap <Leader>tc <CMD>call VSCodeNotify('workbench.action.closeWindow')<CR>
  nnoremap <Leader>tl <CMD>call VSCodeNotify('workbench.action.switchWindow')<CR>
  nnoremap <Leader>t. <CMD>call VSCodeNotify('workbench.action.quickSwitchWindow')<CR>
]]

-- groups
vim.cmd [[
]]

-- folds
vim.cmd [[
  nnoremap za <CMD>call VSCodeNotify('editor.toggleFold')<CR>
  nnoremap zc <CMD>call VSCodeNotify('editor.fold')<CR>
  nnoremap zo <CMD>call VSCodeNotify('editor.unfold')<CR>
  nnoremap zM <CMD>call VSCodeNotify('editor.foldAll')<CR>
  nnoremap zR <CMD>call VSCodeNotify('editor.unfoldAll')<CR>
]]
