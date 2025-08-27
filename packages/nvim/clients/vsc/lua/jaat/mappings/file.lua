vim.cmd [[
  nnoremap <Leader>ff <CMD>call VSCodeNotify('explorer.newFile')<CR>
  nnoremap <Leader>fF <CMD>call VSCodeNotify('workbench.action.files.openFile')<CR>

  nnoremap <Leader>fd <CMD>call VSCodeNotify('explorer.newFolder')<CR>
  nnoremap <Leader>fn <CMD>call VSCodeNotify('workbench.action.files.newUntitledFile')<CR>

  nnoremap <Leader>fw <CMD>call VSCodeNotify('workbench.action.files.showOpenedFileInNewWindow')<CR>

  nnoremap <Leader>fs <CMD>call VSCodeNotify('workbench.action.files.saveAs')<CR>

  nnoremap <Leader>fD <CMD>call VSCodeNotify('workbench.action.files.openFolder')<CR>
  nnoremap <Leader>fqo <CMD>call VSCodeNotify('workbench.action.closeFolder')<CR>
  nnoremap <Leader>fe <CMD>call VSCodeNotify('workbench.view.explorer')<CR>
  nnoremap <Leader>fr <CMD>call VSCodeNotify('workbench.files.action.refreshFilesExplorer')<CR>
  nnoremap <Leader>fc <CMD>call VSCodeNotify('workbench.files.action.collapseExplorerFolders')<CR>
]]
