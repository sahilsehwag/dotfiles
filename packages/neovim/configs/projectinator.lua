local projectinator = require('projectinator')

local get_js_default = projectinator.helpers.get_operation_default(
	{
		{'mt%-react%-dashboard', {'mt_dashboard', 'npm'}},
		{'governance%-ui', 'mt_governance_ui'},
		{'mt%-shell', 'mt_shell'},
		{'design%-library', 'design_library'},
		{'ui%-containers', 'ui_containers'},
		{'learner%-certifications', 'learner_certifications'},
	},
	'yarn'
)

projectinator.setup({
	cmds = {
		internal = 'e',
		external = (
			((vim.fn.exists('neovide') == 1 or os.getenv('TMUX') == nil) and 'AsyncRun -mode=term')
				or (os.getenv('TMUX') ~= nil and 'T lh.h20%')
				or 'AsyncRun -mode=term'
		)
	},
	projects = {
		javascript = {
			name = 'javascript',
			type = 'language',
      default = get_js_default,
			operations = {
				init = { },
				install = {
					commands = {
					},
				},
				lint = { },
				format = { },
				test = {
					commands = {
						mt_dashboard = 'npm run test-prod',
					},
				},
				run = {
					commands = {
						mt_dashboard = 'npm run start',
						design_library = 'yarn run start:storybook',
						learner_certifications = 'nvm use 14.18.0 && yarn run start',
					},
				},
				build = {
				},
				release = {
					commands = {
						mt_dashboard = 'npm run sentry-release',
					},
				},
				publish = { },
				deploy = { },
			},
		},
	},
})

vim.cmd [[
	nnoremap <silent> <Leader>lpI <cmd>lua require('projectinator').run_operation('init')<cr>
	nnoremap <silent> <Leader>lpi <cmd>lua require('projectinator').run_operation('install')<cr>
	nnoremap <silent> <Leader>lpf <cmd>lua require('projectinator').run_operation('format')<cr>
	nnoremap <silent> <Leader>lpl <cmd>lua require('projectinator').run_operation('lint')<cr>
	nnoremap <silent> <Leader>lpd <cmd>lua require('projectinator').run_operation('debug')<cr>
	nnoremap <silent> <Leader>lpt <cmd>lua require('projectinator').run_operation('test')<cr>
	nnoremap <silent> <Leader>lpr <cmd>lua require('projectinator').run_operation('run')<cr>
	nnoremap <silent> <Leader>lpb <cmd>lua require('projectinator').run_operation('build')<cr>
	nnoremap <silent> <Leader>lpR <cmd>lua require('projectinator').run_operation('release')<cr>
	nnoremap <silent> <Leader>lpp <cmd>lua require('projectinator').run_operation('publish')<cr>
	nnoremap <silent> <Leader>lpD <cmd>lua require('projectinator').run_operation('deploy')<cr>
	nnoremap <silent> <Leader>lps <cmd>lua require('projectinator').run_operation('scaffold')<cr>
]]
