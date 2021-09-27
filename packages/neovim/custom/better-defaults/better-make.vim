augroup BETTER_MAKE
	autocmd!
	"COMPILED
		autocmd Filetype c setl makeprg=gcc\ %:S\ &&\ %:h:S/a.out
		autocmd Filetype cpp setl makeprg=g++\ -std=c++14\ %:S\ &&\ %:h:S/a.out
		autocmd Filetype scala setl makeprg=scalac\ %:S\ &&\ scala\ %:r:S
		autocmd Filetype java setl makeprg=javac\ %:S\ &&\ java\ %:r:S
		autocmd Filetype haskell setl makeprg=ghc\ -Wno-tabs\ %:S\ &&\ %:r:S
		autocmd Filetype processing setl makeprg=processing-java\ --output=/tmp/processing/\ --force\ --sketch=%:h:S\ --run
		autocmd Filetype typescript setl makeprg=tsc\ %:S\ &&\ node\ %:r:S
		autocmd Filetype csx setl makeprg=scriptcs\ %:r:S.csx
		autocmd Filetype go setl makeprg=go\ run\ %:S
		if has('macunix')
			autocmd Filetype cs setl makeprg=csc\ %:p:S\ &&\ mono\ %:r:S.exe
		elseif has('win32')
			autocmd Filetype cs setl makeprg=csc\ %:p:S\ &&\ %:r:S.exe
		endif
	"INTERPRETED
		autocmd Filetype python setl makeprg=python3\ %:S
		autocmd Filetype javascript setl makeprg=node\ %:S
		autocmd Filetype ruby setl makeprg=ruby\ %:S
		autocmd Filetype perl setl makeprg=perl\ %:S
		autocmd Filetype php setl makeprg=php\ %:S
		autocmd Filetype typescript setl makeprg=tsc\ %:S
		autocmd Filetype lua setl makeprg=lua\ %:S
	"SHELL
		autocmd Filetype sh setl makeprg=sh\ %:S
		autocmd Filetype bash setl makeprg=bash\ %:S
		autocmd Filetype zsh setl makeprg=zsh\ %:S
augroup END
