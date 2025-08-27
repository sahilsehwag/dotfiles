local vscode = require('vscode')

local M = {}

M.runInEditor = function(cmd)
	vscode.action('workbench.action.createTerminalEditor')
  vscode.action('workbench.action.terminal.sendSequence', {
		args = { text = cmd .. '\n' },
	})
end

return M
