"PATHS
	let g:jaat_tmp_path = glob('~/.config/nvim/tmp/')
	let g:jaat_lists_path = g:jaat_tmp_path . 'lists/'

	let g:jaat_home_path = expand('~')
	let g:jaat_root_path =
		\ IsNix()
		\ ? shellescape(expand('/'))
		\ : shellescape(expand('D:'))
	let g:jaat_drive_path =
		\ IsNix()
		\ ? shellescape(expand('~/Google Drive'))
		\ : shellescape(expand('~/Google Drive'))
	let g:jaat_nvim_path =
		\ IsNix()
		\ ? fnameescape(expand('~/.config/nvim/init.vim'))
		\ : fnameescape(expand('~/AppData/Local/nvim/init.vim'))
	let g:jaat_vim_path = expand('~/.vimrc')
	let g:jaat_config_path =
		\ has('vim')
		\ ? g:jaat_vim_path
		\ : g:jaat_nvim_path
"COMMANDS
	"SHELL
	"GREPISH
		let g:jaat_grep_command = 'grep -rHnas --color --exclude-dir=".git" --exclude-dir="node_modules" -i . *'
			"TODO:FIX
		let g:jaat_ag_command	= 'ag --nogroup -s .+'
		let g:jaat_rg_command = 'rg --hidden --follow --no-ignore-vcs --ignore -g "!{node_modules/*,.git/*}"'
	"FINDISH
		let g:jaat_fd_command_files			= "fd -tf --hidden --exclude .git --exclude node_modules '.*'"
		let g:jaat_fd_command_directories = "fd -td --hidden --exclude .git --exclude node_modules '.*'"

		let g:jaat_find_command_files		= 'find -type f -iname'
		let g:jaat_find_command_directories = 'find -type d -iname'
	"EXPLORER
		let g:jaat_vifm_command = 'vifm'
		let g:jaat_ranger_command = 'ranger'
	let g:jaat_shell_command =
		\ IsWindows()
		\ ? "cmd"
		\ : executable('zsh')
		\ ? "zsh"
		\ : executable('fish')
		\ ? "fish"
		\ : executable('bash')
		\ ? "bash"
		\ : "sh"
	let g:jaat_explorer_command =
		\ executable('vifm')
		\ ? g:jaat_vifm_command
		\ : executable('ranger')
		\ ? g:jaat_ranger_command
		\ : ''
	let g:jaat_find_lines_command =
		\ executable('rg')
		\ ? g:jaat_rg_command
		\ : executable('ag')
		\ ? g:jaat_ag_command
		\ : g:jaat_grep_command
	let g:jaat_find_files_command =
		\ executable('fd')
		\ ? g:jaat_fd_command_files
		\ : g:jaat_find_command_files
	let g:jaat_find_directories_command =
		\ executable('fd')
		\ ? g:jaat_fd_command_directories
		\ : g:jaat_find_command_directories
"CONFIGURATION
	let g:jaat_small_window_height	= 10
	let g:jaat_medium_window_height = 15
	let g:jaat_large_window_height	= 20
