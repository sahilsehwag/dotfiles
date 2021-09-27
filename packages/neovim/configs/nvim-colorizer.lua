vim.o.termguicolors = true

DEFAULT_OPTIONS = {
	mode     = 'background'; -- foreground/background
	RGB      = true;
	RRGGBB   = true;
	names    = true;
	RRGGBBAA = true;
	rgb_fn   = true;
	hsl_fn   = true;
	css      = true;
	css_fn   = true;
}

require'colorizer'.setup()

