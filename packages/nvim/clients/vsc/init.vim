"RUNTIMEPATH
execute 'set rtp+=' . globpath(&rtp, 'custom')
execute 'set rtp+=' . globpath(&rtp, 'custom/vim')
execute 'set rtp+=' . globpath(&rtp, 'clients')
execute 'set rtp+=' . globpath(&rtp, 'clients/vsc')

"vscode calls and mappings
runtime vsc/mappings/init.vim

runtime better-defaults/init.vim

"LIBS
if has('nvim-0.5')
  lua require('lib.funk')
  lua require('lib.func')
  lua require('lib.cmds')
  lua require('lib.grammar')
  lua require('lib.modal')
  lua require('lib.buf')
  lua require('lib.win')
  lua require('lib.list')
  lua require('lib.api')
  lua require('lib.cli')
  lua require('lib.tui')
  lua require('lib.cui')
  lua require('lib.ui')
end

runtime libs/init.vim

runtime object-at.vim
runtime object-before.vim
runtime object-between.vim
runtime object-after.vim
runtime object-line.vim
runtime object-entire.vim
runtime object-last-selected.vim

runtime space-warrior.vim
runtime ivim/init.vim

"GENERAL
lua require('sahilsehwag.general.variables')
lua require('sahilsehwag.general.settings')
lua require('sahilsehwag.general.highlights')
lua require('sahilsehwag.general.autocmds')
lua require('sahilsehwag.general.specification')

lua require('sahilsehwag.mappings.filetype.markdown')

if has('nvim-0.5')
  "runtime configs/executioner.lua
  "runtime configs/projectinator.lua
  "runtime configs/npm_scripts.lua
  "runtime configs/worktree.lua
  "runtime configs/git_workspace.lua
  "runtime configs/mani.lua
  "runtime configs/fasd.lua
  "runtime configs/nix.lua
end

"SPECIFICATION
  "b = buffer
  "w = buffer
  "t = terminal
  "T = tabs
  "g = git
  "p = project
  "l = lsp
  "ld = debug
  "f = finding/searching
"LEADERS
  let mapleader = " "
  let maplocalleader = ","
"TEXT
  nnoremap gS <CMD>call VSCodeNotify('splitjoin-vscode.split')<CR>
  nnoremap gJ <CMD>call VSCodeNotify('splitjoin-vscode.join')<CR>
  nnoremap gT <CMD>call VSCodeNotify('splitjoin-vscode.toggle')<CR>
"WINDOW MANAGEMENT
  "Split window
  nnoremap <Leader>wh <CMD>call VSCodeNotify('workbench.action.splitEditorLeft')<CR>
  nnoremap <Leader>wj <CMD>call VSCodeNotify('workbench.action.splitEditorDown')<CR>
  nnoremap <Leader>wk <CMD>call VSCodeNotify('workbench.action.splitEditorUp')<CR>
  nnoremap <Leader>wl <CMD>call VSCodeNotify('workbench.action.splitEditorRight')<CR>

  "Window navigation
  nnoremap <C-h> <CMD>call VSCodeNotify('workbench.action.navigateLeft')<CR>
  nnoremap <C-j> <CMD>call VSCodeNotify('workbench.action.navigateDown')<CR>
  nnoremap <C-k> <CMD>call VSCodeNotify('workbench.action.navigateUp')<CR>
  nnoremap <C-l> <CMD>call VSCodeNotify('workbench.action.navigateRight')<CR

  "Window movement
  nnoremap <Leader>wH <CMD>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<CR>
  nnoremap <Leader>wJ <CMD>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<CR>
  nnoremap <Leader>wK <CMD>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<CR>
  nnoremap <Leader>wL <CMD>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<CR>

  "Window resizing
  "nnoremap <C-S-h> <CMD>call VSCodeNotify('workbench.action.decreaseViewSize')<CR>
  "nnoremap <C-S-l> <CMD>call VSCodeNotify('workbench.action.increaseViewSize')<CR>
  nnoremap <Leader>w= <CMD>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>
  nnoremap <Leader>wm <CMD>call VSCodeNotify('workbench.action.toggleMaximizeEditorGroup')<CR>

  "Window closing
  nnoremap <Leader>wo <CMD>call VSCodeNotify('workbench.action.closeEditorsInOtherGroups')<CR>
  nnoremap <Leader>wc <CMD>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>

  "Window operations
  nnoremap <Leader>wbt <CMD>call VSCodeNotify('workbench.action.moveEditorToNewWindow')<CR>
"BUFFER MANAGEMENT
  "Buffer navigation
  nnoremap <C-[> <CMD>call VSCodeNotify('workbench.action.previousEditor')<CR>
  nnoremap <C-]> <CMD>call VSCodeNotify('workbench.action.nextEditor')<CR>

  "BUFFER OPERATIONS
  nnoremap <Leader>bl <CMD>call VSCodeNotify('workbench.action.showAllEditorsByMostRecentlyUsed')<CR>

  "Buffer creation
  "Buffer deletion
  nnoremap <Leader>bcc <CMD>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
  nnoremap <Leader>bca <CMD>call VSCodeNotify('workbench.action.closeAllEditors')<CR>
  nnoremap <Leader>bco <CMD>call VSCodeNotify('workbench.action.closeOtherEditors')<CR>
  nnoremap <Leader>bcu <CMD>call VSCodeNotify('workbench.action.closeUnmodifiedEditors')<CR>

  "Buffer writing
  nnoremap <Leader>bwf <CMD>call VSCodeNotify('workbench.action.files.saveWithoutFormatting')<CR>
  nnoremap <Leader>bwa <CMD>call VSCodeNotify('workbench.action.files.saveAll')<CR>

  "Buffer reload
  nnoremap <Leader>br <CMD>call VSCodeNotify('workbench.action.reopenClosedEditor')<CR>

  "Buffer closing
  nnoremap <Leader>bch <CMD>call VSCodeNotify('workbench.action.closeEditorsToTheLeft')<CR>
  nnoremap <Leader>bcl <CMD>call VSCodeNotify('workbench.action.closeEditorsToTheRight')<CR>
  nnoremap <Leader>bco <CMD>call VSCodeNotify('workbench.action.closeOtherEditors')<CR>

  "Buffer navigation
  nnoremap <Leader>bn <CMD>call VSCodeNotify('workbench.action.nextEditor')<CR>
  nnoremap <Leader>bp <CMD>call VSCodeNotify('workbench.action.previousEditor')<CR>

  "Buffer navigation with numbers
  nnoremap <C-1> <CMD>call VSCodeNotify('workbench.action.openEditorAtIndex1')<CR>
  nnoremap <C-2> <CMD>call VSCodeNotify('workbench.action.openEditorAtIndex2')<CR>
  nnoremap <C-3> <CMD>call VSCodeNotify('workbench.action.openEditorAtIndex3')<CR>
  nnoremap <C-4> <CMD>call VSCodeNotify('workbench.action.openEditorAtIndex4')<CR>
  nnoremap <C-5> <CMD>call VSCodeNotify('workbench.action.openEditorAtIndex5')<CR>
  nnoremap <C-6> <CMD>call VSCodeNotify('workbench.action.openEditorAtIndex6')<CR>
  nnoremap <C-7> <CMD>call VSCodeNotify('workbench.action.openEditorAtIndex7')<CR>
  nnoremap <C-8> <CMD>call VSCodeNotify('workbench.action.openEditorAtIndex8')<CR>
  " nnoremap <C-9> <CMD>call VSCodeNotify('workbench.action.openEditorAtIndex9')<CR>
  " nnoremap <C-0> <CMD>call VSCodeNotify('workbench.action.lastEditorInGroup')<CR>
"TAB MANAGEMENT
  nnoremap <Leader>tn <CMD>call VSCodeNotify('workbench.action.newWindow')<CR>
  nnoremap <Leader>tr <CMD>call VSCodeNotify('workbench.action.reloadWindow')<CR>
  nnoremap <Leader>tc <CMD>call VSCodeNotify('workbench.action.closeWindow')<CR>
  nnoremap <Leader>tl <CMD>call VSCodeNotify('workbench.action.switchWindow')<CR>
  nnoremap <Leader>t. <CMD>call VSCodeNotify('workbench.action.quickSwitchWindow')<CR>

"FILE OPERATIONS
  "File navigation
  nnoremap <Leader>fr <CMD>call VSCodeNotify('editor.action.startFindReplaceAction')<CR>

  "File operations
  nnoremap <Leader>ff <CMD>call VSCodeNotify('explorer.newFile')<CR>
  nnoremap <Leader>fn <CMD>call VSCodeNotify('workbench.action.files.newUntitledFile')<CR>
  nnoremap <Leader>fd <CMD>call VSCodeNotify('explorer.newFolder')<CR>
  nnoremap <Leader>fw <CMD>call VSCodeNotify('workbench.action.files.showOpenedFileInNewWindow')<CR>
  nnoremap <Leader>fs <CMD>call VSCodeNotify('workbench.action.files.saveAs')<CR>
  nnoremap <Leader>fF <CMD>call VSCodeNotify('workbench.action.files.openFile')<CR>
  nnoremap <Leader>fD <CMD>call VSCodeNotify('workbench.action.files.openFolder')<CR>
  nnoremap <Leader>fqo <CMD>call VSCodeNotify('workbench.action.closeFolder')<CR>
  nnoremap <Leader>fe <CMD>call VSCodeNotify('workbench.view.explorer')<CR>
  nnoremap <Leader>fr <CMD>call VSCodeNotify('workbench.files.action.refreshFilesExplorer')<CR>
  nnoremap <Leader>fc <CMD>call VSCodeNotify('workbench.files.action.collapseExplorerFolders')<CR>
"LSP FEATURES
  "Go to shortcuts
  nnoremap gd <CMD>call VSCodeNotify('editor.action.revealDefinition')<CR>
  nnoremap gi <CMD>call VSCodeNotify('editor.action.goToImplementation')<CR>
  nnoremap gt <CMD>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>
  nnoremap gr <CMD>call VSCodeNotify('editor.action.goToReferences')<CR>

  "Documentation
  nnoremap K <CMD>call VSCodeNotify('editor.action.showHover')<CR>
  nnoremap gp <CMD>call VSCodeNotify('editor.action.triggerParameterHints')<CR>

  "Diagnostics
  nnoremap [e <CMD>call VSCodeNotify('editor.action.marker.prev')<CR>
  nnoremap ]e <CMD>call VSCodeNotify('editor.action.marker.next')<CR>

  "Code actions
  nnoremap <Leader>lq <CMD>call VSCodeNotify('editor.action.quickFix')<CR>
  nnoremap <Leader>lr <CMD>call VSCodeNotify('editor.action.rename')<CR>
  "Formatting
  nnoremap <Leader>lf <CMD>call VSCodeNotify('editor.action.formatDocument')<CR>

  "Symbols
  " nnoremap <Leader>lsd <CMD>call VSCodeNotify('workbench.action.gotoSymbol')<CR>
  " nnoremap <Leader>lsw <CMD>call VSCodeNotify('workbench.action.showAllSymbols')<CR>
  " nnoremap <Leader>lsi <CMD>call VSCodeNotify('editor.action.referenceSearch.trigger')<CR>

  "Testing
  nnoremap <Leader>ltf <CMD>call VSCodeNotify('testing.runCurrentFile')<CR>
  nnoremap <Leader>ltp <CMD>call VSCodeNotify('testing.runAll')<CR>
  nnoremap <Leader>ltc <CMD>call VSCodeNotify('testing.runAtCursor')<CR>
  nnoremap <Leader>ltr <CMD>call VSCodeNotify('testing.reRunLastRun')<CR>

  "Debugging (using <Leader>ld namespace instead of <Leader>d)
  nnoremap <Leader>lbb <CMD>call VSCodeNotify('editor.debug.action.toggleBreakpoint')<CR>
  nnoremap <Leader>lbq <CMD>call VSCodeNotify('workbench.debug.action.showDebugHover')<CR>
  nnoremap <Leader>lbc <CMD>call VSCodeNotify('editor.debug.action.conditionalBreakpoint')<CR>
  nnoremap <Leader>lbl <CMD>call VSCodeNotify('editor.debug.action.toggleLogPoint')<CR>
  nnoremap <Leader>lbC <CMD>call VSCodeNotify('workbench.debug.viewlet.action.removeAllBreakpoints')<CR>

  "DEBUG OPERATIONS
    "nnoremap <Leader>d00 <CMD>call VSCodeNotify('workbench.action.debug.continue')<CR>
    "nnoremap <Leader>d00 <CMD>call VSCodeNotify('workbench.action.debug.pause')<CR>
    "nnoremap <Leader>d00 <CMD>call VSCodeNotify('workbench.action.debug.configure')<CR>
    "nnoremap <Leader>d00 <CMD>call VSCodeNotify('workbench.debug.action.toggleRepl')<CR>
    "nnoremap <Leader>d00 <CMD>call VSCodeNotify('workbench.debug.action.focusRepl')<CR>
    "nnoremap <Leader>d00 <CMD>call VSCodeNotify('workbench.debug.action.focusCallStackView')<CR>
    "nnoremap <Leader>d00 <CMD>call VSCodeNotify('workbench.debug.action.focusWatchView')<CR>
    "nnoremap <Leader>d00 <CMD>call VSCodeNotify('workbench.debug.action.focusVariablesView')<CR>
    "nnoremap <Leader>d00 <CMD>call VSCodeNotify('workbench.debug.action.focusBreakpointsView')<CR>
    "nnoremap <Leader>d00 <CMD>call VSCodeNotify('workbench.debug.viewlet.action.enableAllBreakpoints')<CR>
    "nnoremap <Leader>d00 <CMD>call VSCodeNotify('workbench.debug.viewlet.action.disableAllBreakpoints')<CR>
  nnoremap <Leader>lds <CMD>call VSCodeNotify('workbench.action.debug.start')<CR>
  nnoremap <Leader>ldt <CMD>call VSCodeNotify('workbench.action.debug.stop')<CR>
  nnoremap <Leader>ldr <CMD>call VSCodeNotify('workbench.action.debug.restart')<CR>
  nnoremap <Leader>ld. <CMD>call VSCodeNotify('workbench.action.debug.run')<CR>
  nnoremap <Leader>ldh <CMD>call VSCodeNotify('workbench.debug.action.showDebugHover')<CR>
  nnoremap <Leader>ldj <CMD>call VSCodeNotify('editor.debug.action.stepInto')<CR>
  nnoremap <Leader>ldk <CMD>call VSCodeNotify('editor.debug.action.stepOut')<CR>
  nnoremap <Leader>ldl <CMD>call VSCodeNotify('editor.debug.action.stepOver')<CR>
"PROJECT MANAGEMENT
  " nnoremap <Leader>po <CMD>call VSCodeNotify('workbench.action.openProject')<CR>
  nnoremap <Leader>pr <CMD>call VSCodeNotify('workbench.action.openRecent')<CR>
"UI MANAGEMENT
  nnoremap <C-9> <CMD>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>
  nnoremap <C-0> <CMD>call VSCodeNotify('workbench.action.togglePanel')<CR>

  nnoremap <Leader>v. <CMD>call VSCodeNotify('workbench.action.openView')<CR>
  nnoremap <Leader>ve <CMD>call VSCodeNotify('workbench.view.explorer')<CR>
  nnoremap <Leader>vo <CMD>call VSCodeNotify('workbench.action.output.toggleOutput')<CR>
  nnoremap <Leader>vt <CMD>call VSCodeNotify('workbench.action.terminal.toggleTerminal')<CR>
  nnoremap <Leader>vd <CMD>call VSCodeNotify('workbench.view.debug')<CR>
  nnoremap <Leader>vp <CMD>call VSCodeNotify('workbench.actions.view.problems')<CR>
  nnoremap <Leader>vz <CMD>call VSCodeNotify('workbench.action.toggleZenMode')<CR>
"GIT INTEGRATION
  nnoremap <Leader>g. <CMD>call VSCodeNotify('workbench.view.scm')<CR>
  nnoremap <Leader>gC <CMD>call VSCodeNotify('git.commitAll')<CR>
  nnoremap <Leader>gB <CMD>call VSCodeNotify('git.branch')<CR>
"EASYMOTION INTEGRATION
  "These are already mapped in VSCode settings.json
  "Just keeping them here for reference
  "nnoremap <Leader>jw <CMD>call VSCodeNotify('editor.action.wordHighlight.next')<CR>
  "nnoremap <Leader>jf <CMD>call VSCodeNotify('editor.action.wordHighlight.next')<CR>
"MISC
  "Command palette

  "Commenting
  nnoremap <Leader>cc <CMD>call VSCodeNotify('editor.action.commentLine')<CR>
  vnoremap <Leader>cc <CMD>call VSCodeNotify('editor.action.commentLine')<CR>
  nnoremap <Leader>cu <CMD>call VSCodeNotify('editor.action.removeCommentLine')<CR>
  vnoremap <Leader>cu <CMD>call VSCodeNotify('editor.action.removeCommentLine')<CR>

  "Folding
  nnoremap za <CMD>call VSCodeNotify('editor.toggleFold')<CR>
  nnoremap zc <CMD>call VSCodeNotify('editor.fold')<CR>
  nnoremap zo <CMD>call VSCodeNotify('editor.unfold')<CR>
  nnoremap zM <CMD>call VSCodeNotify('editor.foldAll')<CR>
  nnoremap zR <CMD>call VSCodeNotify('editor.unfoldAll')<CR>

  "Indentation
  nnoremap > <CMD>call VSCodeNotify('editor.action.indentLines')<CR>
  nnoremap < <CMD>call VSCodeNotify('editor.action.outdentLines')<CR>
  vnoremap > <CMD>call VSCodeNotify('editor.action.indentLines')<CR>
  vnoremap < <CMD>call VSCodeNotify('editor.action.outdentLines')<CR>

  "FZF-like mappings
  nnoremap <Leader><TAB> <CMD>call VSCodeNotify('workbench.action.showCommands')<CR>
  nnoremap <Leader>gCp <CMD>call VSCodeNotify('git.commitAll')<CR>
  nnoremap <Leader>gCb <CMD>call VSCodeNotify('git.commitAll')<CR>
  nnoremap <Leader>pg <CMD>call VSCodeNotify('workbench.view.scm')<CR>

  "Programming
  nnoremap <Leader>lfm <CMD>call VSCodeNotify('workbench.action.tasks.build')<CR>

  "Window picker
  nnoremap <Leader>wp <CMD>call VSCodeNotify('workbench.action.quickSwitchWindow')<CR>

  "Window picker

  "Additional view/UI commands (commented)
  "nnoremap <Leader>v00 <CMD>call VSCodeNotify('workbench.action.toggleZenMode')<CR>
  "nnoremap <Leader>v00 <CMD>call VSCodeNotify('workbench.action.toggleFullScreen')<CR>
  "nnoremap <Leader>v00 <CMD>call VSCodeNotify('workbench.action.toggleStatusbarVisibility')<CR>
  "nnoremap <Leader>v00 <CMD>call VSCodeNotify('workbench.action.toggleActivityBarVisibility')<CR>
  "nnoremap <Leader>v00 <CMD>call VSCodeNotify('workbench.action.toggleTabsVisibility')<CR>
  "nnoremap <Leader>v00 <CMD>call VSCodeNotify('workbench.action.toggleMenuBar')<CR>
  "nnoremap <Leader>v00 <CMD>call VSCodeNotify('workbench.action.toggleCenteredLayout')<CR>
  "nnoremap <Leader>v00 <CMD>call VSCodeNotify('workbench.action.increaseViewSize')<CR>
  "nnoremap <Leader>v00 <CMD>call VSCodeNotify('workbench.action.decreaseViewSize')<CR>
  "nnoremap <Leader>v00 <CMD>call VSCodeNotify('workbench.action.zoomIn')<CR>
  "nnoremap <Leader>v00 <CMD>call VSCodeNotify('workbench.action.zoomOut')<CR>
  "nnoremap <Leader>v00 <CMD>call VSCodeNotify('workbench.action.zoomReset')<CR>
  "nnoremap <Leader>v00 <CMD>call VSCodeNotify('workbench.action.toggleSidebarPosition')<CR>
  "nnoremap <Leader>v00 <CMD>call VSCodeNotify('workbench.action.togglePanelPosition')<CR>
  "nnoremap <Leader>v00 <CMD>call VSCodeNotify('workbench.action.toggleEditorVisibility')<CR>

  "nnoremap <Leader>s00 <CMD>call VSCodeNotify('workbench.action.terminal.new')<CR>
  "nnoremap <Leader>s00 <CMD>call VSCodeNotify('workbench.action.terminal.split')<CR>
  "nnoremap <Leader>s00 <CMD>call VSCodeNotify('workbench.action.terminal.kill')<CR>
  "nnoremap <Leader>s00 <CMD>call VSCodeNotify('workbench.action.terminal.clear')<CR>
  "nnoremap <Leader>s00 <CMD>call VSCodeNotify('workbench.action.terminal.focus')<CR>
  "nnoremap <Leader>s00 <CMD>call VSCodeNotify('workbench.action.terminal.focusNext')<CR>
  "nnoremap <Leader>s00 <CMD>call VSCodeNotify('workbench.action.terminal.focusPrevious')<CR>
  "nnoremap <Leader>s00 <CMD>call VSCodeNotify('workbench.action.terminal.selectAll')<CR>
  "nnoremap <Leader>s00 <CMD>call VSCodeNotify('workbench.action.terminal.runSelectedText')<CR>
  "nnoremap <Leader>s00 <CMD>call VSCodeNotify('workbench.action.terminal.scrollDown')<CR>
  "nnoremap <Leader>s00 <CMD>call VSCodeNotify('workbench.action.terminal.scrollUp')<CR>
  "nnoremap <Leader>s00 <CMD>call VSCodeNotify('workbench.action.terminal.scrollToTop')<CR>
  "nnoremap <Leader>s00 <CMD>call VSCodeNotify('workbench.action.terminal.scrollToBottom')<CR>
  "nnoremap <Leader>s00 <CMD>call VSCodeNotify('workbench.action.terminal.navigationModeExit')<CR>
  "nnoremap <Leader>s00 <CMD>call VSCodeNotify('workbench.action.terminal.navigationModeFocusNext')<CR>
  "nnoremap <Leader>s00 <CMD>call VSCodeNotify('workbench.action.terminal.navigationModeFocusPrevious')<CR>

  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.clone')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.init')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.refresh')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.openFile')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.openChange')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.stage')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.stageAll')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.unstage')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.unstageAll')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.clean')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.cleanAll')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.commit')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.commitStaged')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.commitStagedSigned')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.commitStagedAmend')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.commitAll')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.commitAllSigned')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.undoCommit')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.checkout')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.branch')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.branchFrom')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.deleteBranch')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.merge')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.rebase')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.cherryPick')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.fetch')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.pull')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.pullRebase')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.push')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.pushTo')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.sync')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.publish')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.showOutput')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.ignore')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.stash')<CR>
  "nnoremap <Leader>g00 <CMD>call VSCodeNotify('git.stashPop')<CR>

  "nnoremap <Leader>w00 <CMD>call VSCodeNotify('workbench.action.closeWindow')<CR>
  "nnoremap <Leader>w00 <CMD>call VSCodeNotify('workbench.action.maximizeEditor')<CR>
  "nnoremap <Leader>w00 <CMD>call VSCodeNotify('workbench.action.minimizeOtherEditors')<CR>
  "nnoremap <Leader>w00 <CMD>call VSCodeNotify('workbench.action.resetEditorGroupSizes')<CR>
  "nnoremap <Leader>w00 <CMD>call VSCodeNotify('workbench.action.focusFirstEditorGroup')<CR>
  "nnoremap <Leader>w00 <CMD>call VSCodeNotify('workbench.action.focusLastEditorGroup')<CR>
  "nnoremap <Leader>w00 <CMD>call VSCodeNotify('workbench.action.joinAllGroups')<CR>
  "nnoremap <Leader>w00 <CMD>call VSCodeNotify('workbench.action.toggleEditorGroupLayout')<CR>
  "nnoremap <Leader>w00 <CMD>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>
  "nnoremap <Leader>w00 <CMD>call VSCodeNotify('workbench.action.toggleMaximizedPanel')<CR>
  "nnoremap <Leader>w00 <CMD>call VSCodeNotify('workbench.action.togglePanel')<CR>
  "nnoremap <Leader>w00 <CMD>call VSCodeNotify('workbench.action.moveEditorToPreviousGroup')<CR>
  "nnoremap <Leader>w00 <CMD>call VSCodeNotify('workbench.action.moveEditorToNextGroup')<CR>

  "nnoremap <Leader>b00 <CMD>call VSCodeNotify('workbench.action.pinEditor')<CR>
  "nnoremap <Leader>b00 <CMD>call VSCodeNotify('workbench.action.unpinEditor')<CR>
  "nnoremap <Leader>b00 <CMD>call VSCodeNotify('workbench.action.splitEditorInGroup')<CR>
  "nnoremap <Leader>b00 <CMD>call VSCodeNotify('workbench.action.joinEditorInGroup')<CR>
  "nnoremap <Leader>b00 <CMD>call VSCodeNotify('workbench.action.copyPathOfActiveFile')<CR>
  "nnoremap <Leader>b00 <CMD>call VSCodeNotify('workbench.action.files.revealActiveFileInWindows')<CR>
  "nnoremap <Leader>b00 <CMD>call VSCodeNotify('workbench.action.files.showOpenedFileInNewWindow')<CR>
  "nnoremap <Leader>b00 <CMD>call VSCodeNotify('workbench.action.compareEditor.previousChange')<CR>
  "nnoremap <Leader>b00 <CMD>call VSCodeNotify('workbench.action.compareEditor.nextChange')<CR>
  "nnoremap <Leader>b00 <CMD>call VSCodeNotify('workbench.action.openPreviousRecentlyUsedEditor')<CR>
  "nnoremap <Leader>b00 <CMD>call VSCodeNotify('workbench.action.openNextRecentlyUsedEditor')<CR>
  "nnoremap <Leader>b00 <CMD>call VSCodeNotify('workbench.action.files.revert')<CR>
  "nnoremap <Leader>b00 <CMD>call VSCodeNotify('workbench.action.compareEditor.nextChange')<CR>
  "nnoremap <Leader>b00 <CMD>call VSCodeNotify('workbench.action.files.revert')<CR>

  "TASKS OPERATIONS
    "nnoremap <Leader>k00 <CMD>call VSCodeNotify('workbench.action.tasks.runTask')<CR>
    "nnoremap <Leader>k00 <CMD>call VSCodeNotify('workbench.action.tasks.configureTaskRunner')<CR>
    "nnoremap <Leader>k00 <CMD>call VSCodeNotify('workbench.action.tasks.build')<CR>
    "nnoremap <Leader>k00 <CMD>call VSCodeNotify('workbench.action.tasks.test')<CR>
    "nnoremap <Leader>k00 <CMD>call VSCodeNotify('workbench.action.tasks.restartTask')<CR>
    "nnoremap <Leader>k00 <CMD>call VSCodeNotify('workbench.action.tasks.terminate')<CR>
    "nnoremap <Leader>k00 <CMD>call VSCodeNotify('workbench.action.tasks.showLog')<CR>
    "nnoremap <Leader>k00 <CMD>call VSCodeNotify('workbench.action.tasks.showTasks')<CR>
