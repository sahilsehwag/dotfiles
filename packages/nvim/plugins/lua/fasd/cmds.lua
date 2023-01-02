return {
	files = F.always('fasd -flR'),
	dirs  = F.always('fasd -dlR'),
	paths = F.always('fasd -alR'),

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
