#INIT
	eval "$(fasd --init auto)"
#ALIAS
	alias v="fasd -fe nvim"
	alias e="fasd -de vifm"
	alias j='fasd_cd -d'
	unalias sd
	unalias sf
	unalias z
	unalias zz
	unalias a
	unalias s
