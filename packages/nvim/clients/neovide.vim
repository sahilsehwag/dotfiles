if exists('neovide')
	set guifont=JetBrainsMono\ Nerd\ Font\ Mono:h12

	let g:neovide_transparency = 0.8
	let g:neovide_refresh_rate = 140
	let g:neovide_fullscreen = v:true
	let g:neovide_remember_window_size = v:true
	let g:neovide_no_idle = v:false
	let g:neovide_input_use_logo = v:true

	let g:neovide_cursor_animation_length = 0.13
	let g:neovide_cursor_trail_length = 0.8
	let g:neovide_cursor_antialiasing = v:true
	"let g:neovide_cursor_vfx_mode = 'pixiedust'
		"railgun|torpedo|pixiedust|sonicboom|ripple|wireframe

	let g:neovide_cursor_vfx_opacity = 200.0
	let g:neovide_cursor_vfx_particle_lifetime = 1.2
	let g:neovide_cursor_vfx_particle_density = 7.0
	let g:neovide_cursor_vfx_particle_speed = 10.0
	let g:neovide_cursor_vfx_particle_phase = 1.5
	let g:neovide_cursor_vfx_particle_curl = 1.0
endif
