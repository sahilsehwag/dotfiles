F.vim.nmap("<Leader>lbb", require("dap").toggle_breakpoint)
F.vim.nmap("<Leader>lbq", require("dap").list_breakpoints)

F.vim.nmap("<Leader>lbc", function()
	require("dap").set_breakpoint(vim.fn.input("Condition :> "), nil, nil)
end)

F.vim.nmap("<Leader>lbl", function()
	require("dap").set_breakpoint(nil, nil, vim.fn.input("LogPoint :> "))
end)

F.vim.nmap("<Leader>lbC", require("dap").clear_breakpoints)

F.vim.nmap("<Leader>lds", require("dap").continue)
F.vim.nmap("<Leader>ldt", require("dap").terminate)
F.vim.nmap("<Leader>ldr", require("dap").restart)
F.vim.nmap("<Leader>ld.", require("dap").run_last)

--F.vim.nmap('<Leader>ldh', require'dap'.step_back)
--F.vim.nmap('<Leader>ldj', require'dap'.step_into)
--F.vim.nmap('<Leader>ldk', require'dap'.step_out)
--F.vim.nmap('<Leader>ldl', require'dap'.step_over)

--F.vim.nmap('<Leader>ldr', require'dap'.repl.open)

vim.keymap.set({ "n", "v" }, "<Leader>ldh", require("dap.ui.widgets").hover)

--vim.keymap.set(
--  {'n', 'v'},
--  '<Leader>ldp',
--  require'dap.ui.widgets'.preview
--)

--vim.keymap.set('n', '<Leader>ldf', function()
--  local widgets = require('dap.ui.widgets')
--  widgets.centered_float(widgets.frames)
--end)

--vim.keymap.set('n', '<Leader>lds', function()
--  local widgets = require('dap.ui.widgets')
--  widgets.centered_float(widgets.scopes)
--end)

vim.cmd [[
	hi DapBreakpoint guifg=#f01a1a
	hi DapBreakpointCondition guifg=#0a9ff0
	hi DapBreakpointRejected guifg=#f01a1a
	hi DapLogPoint guifg=#72f27c
	hi DapStopped guifg=#62d5f5
]]

vim.fn.sign_define("DapBreakpoint", {
	text = "●",
	texthl = "DapBreakpoint",
})

vim.fn.sign_define("DapBreakpointCondition", {
	text = "●",
	texthl = "DapBreakpointCondition",
})

vim.fn.sign_define("DapBreakpointRejected", {
	text = "◌",
	texthl = "DapBreakpointRejected",
})

vim.fn.sign_define("DapLogPoint", {
	text = "",
	texthl = "DapLogPoint",
})

vim.fn.sign_define("DapStopped", {
	text = "⮕",
	texthl = "DapStopped",
})
