if ! exists("g:wheel_loaded")
	" Init
	let g:wheel_config={}
	let g:wheel_config.maxim={}

	" The file where toruses and circles will be stored and read
	let g:wheel_config.file = '~/.local/share/wheel/auto.vim'
	" Auto read torus file on startup if > 0
	let g:wheel_config.autoread = 1
	" Auto write torus file on exit if > 0
	let g:wheel_config.autowrite = 1
	" Number of backups for the wheel file
	let g:wheel_config.backups = 5
	" The bigger it is, the more mappings available
	let g:wheel_config.mappings = 10
	" Prefix for mappings
	let g:wheel_config.prefix = '<M-w>'
	" Auto cd to project root if > 0
	let g:wheel_config.cd_project = 1
	" Marker of project root
	"let g:wheel_config.project_markers = '.git'
	"let g:wheel_config.project_markers = '.racine-projet'
	" List of markers
	" The project dir is found as soon as one marker is found in it
	let g:wheel_config.project_markers = ['.git', '.racine-projet']
	" Locate database ; default one if left empty
	let g:wheel_config.locate_db = '~/racine/index/locate/racine.db'
	" Grep command : :grep or :vimpgrep
	let g:wheel_config.grep = 'grep'

	" Maximum number of elements in history
	let g:wheel_config.maxim.history = 50
	" Maximum number of elements in input history
	let g:wheel_config.maxim.input = 100

	" Maximum number of elements in mru
	let g:wheel_config.maxim.mru = 120

	" Maximum number of elements in yank wheel
	let g:wheel_config.maxim.yanks = 300
	" Maximum size of elements in yank wheel
	let g:wheel_config.maxim.yank_size = 3000

	" Maximum size of layer stack
	let g:wheel_config.maxim.layers = 10

	" Maximum number of tabs in layouts
	let g:wheel_config.maxim.tabs = 12
	" Maximum number of horizontal splits
	let g:wheel_config.maxim.horizontal = 3
	" Maximum number of vertical splits
	let g:wheel_config.maxim.vertical = 4

	let g:wheel_config.debug = 0
endif
