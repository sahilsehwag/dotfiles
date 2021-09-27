return {
	files = F.always('fasd -fl'),
	dirs  = F.always('fasd -dl'),
	paths = F.always('fasd -al'),

	add = F.pipe(
		F.map(F.sh.quote),
		F.join(' '),
		F.concat('fasd -A ')
	),

	delete = F.pipe(
		F.map(F.sh.quote),
		F.join(' '),
		F.concat('fasd -D ')
	),
}
