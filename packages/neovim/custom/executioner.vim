let g:executioner_enabled = 1
if ExistsAndTrue('g:executioner_enabled')
	"CONFIGURATION
		let g:executioner_enable_default_mappings = 1
		let g:languages = {}
			"LANGUAGE
				"INTERPRETED
					let g:languages.python = {
						\'extension' : 'py',
						\'repl'		 : 'ipython',
						\'execute'	 : 'python3 %:p:S',
						\'init'		 : [
							\'import os',
							\'import sys',
							\'import re',
							\'from collections import *',
							\'import pprint',
							\'import time',
							\'import datetime',
							\'import itertools',
							\'import functools',
							\'import datetime',
							\'import numpy as np',
							\'import pandas as pd',
							\'import matplotlib.pyplot as plt',
						\],
					\}
					let g:languages.r = {
						\'extension' : 'r',
						\'repl'		 : 'r',
					\}
					let g:languages.javascript = {
						\'extension' : 'js',
						\'repl'		 : 'node',
						\'execute'	 : 'node %:p:S',
					\}
					let g:languages.ruby = {
						\'extension' : 'rb',
						\'repl'		 : 'irb',
						\'execute'	 : 'ruby %:p:S',
					\}
					let g:languages.perl = {
						\'extension' : 'pl',
						\'repl'		 : 'perl',
						\'execute'	 : 'perl %:p:S',
					\}
					let g:languages.php = {
						\'extension' : 'php',
						\'repl'		 : 'php',
						\'execute'	 : 'php %:p:S',
					\}
					let g:languages.lisp = {
						\'extension' : 'lsp',
						\'repl'		 : 'sbcl',
					\}
					let g:languages.lua = {
						\'extension' : 'lua',
						\'repl'		 : 'lua',
						\'execute'	 : 'lua %:p:S',
					\}
				"COMPILED
					let g:languages.c = {
						\'extension'		 : 'c',
						\'repl'				 : 'cling',
						\'compile'			 : 'gcc %:p:S -o %:p:r:S.out',
						\'execute'			 : '%:p:r:S.out',
						\'compile-execute' : 'gcc %:p:S -o %:p:r:S.out && %:p:r:S.out',
						\'init'		 : [
								\'#include <stdio.h>',
								\'#include <math.h>',
						\],
					\}
					let g:languages.cpp = {
						\'extension'		 : 'cpp',
						\'repl'				 : 'cling',
						\'compile'			 : 'g++ -std=c++14 %:p:S -o %:p:r:S.out',
						\'execute'			 : '%:p:r:S.out',
						\'compile-execute' : 'g++ -std=c++14 %:p:S -o %:p:r:S.out && %:p:r:S.out',
						\'init'				 : [
							\'#include <iostream>',
							\'#include <string>',
							\'using namespace std;',
						\],
					\}
					let g:languages.cs = {
						\'extension'		 : 'cs',
						\'repl'				 : 'csharp',
						\'compile'			 : 'csc %:p:s',
						\'execute'			 : 'mono %:p:r:s.exe',
						\'compile-execute' : 'csc %:p:s && mono %:p:r:s.exe',
					\}
					let g:languages.csx = {
						\'extension' : 'csx',
						\'repl'		 : 'scriptcs',
						\'execute'	 : 'scriptcs %:p:r:S.csx',
					\}
					let g:languages.java = {
						\'extension'		 : 'java',
						\'repl'				 : 'jshell',
						\'compile'			 : 'javac %:p:S',
						\'execute'			 : 'java %:p:r:S',
						\'compile-execute' : 'javac %:p:S && java %:p:r:S',
					\}
					let g:languages.scala = {
						\'extension'		 : 'scala',
						\'repl'				 : 'scala',
						\'compile'			 : 'scalac %:p:S',
						\'execute'			 : 'scala %:p:r:S',
						\'compile-execute' : 'scalac %:p:S && scala %:p:r:S',
					\}
					let g:languages.haskell = {
						\'extension'			 : 'hs',
						\'repl'						 : 'ghci',
						\'compile'				 : 'ghc -Wno-tabs %:p:S',
						\'execute'				 : '%:p:r:S',
						\'compile-execute' : 'ghc -Wno-tabs %:p:S && %:p:r:S',
					\}
					let g:languages.typescript = {
						\'extension'			 : 'ts',
						\'repl'						 : 'ts-node',
						\'compile'				 : 'tsc %:p:S',
						\'execute'				 : 'node %:p:r:S.js',
						\'compile-execute' : 'tsc %:p:S && node %:p:r:S.js',
					\}
					let g:languages.processing = {
						\'extension'			 : 'pde',
						\'compile'				 : 'processing-java --output=/tmp/processing/ --force --sketch=%:p:h:S --build',
						\'execute'				 : 'processing-java --output=/tmp/processing/ --force --sketch=%:p:h:S --run',
						\'compile-execute' : 'processing-java --output=/tmp/processing/ --force --sketch=%:p:h:S --run',
					\}
			"REPL
				"SHELL
					let g:languages.sh = {
						\'extension' : 'sh',
						\'repl'		 : 'sh',
						\'execute'	 : 'sh %:p:S',
					\}
					let g:languages.bash = {
						\'extension' : 'bash',
						\'repl'		 : 'bash',
						\'execute'	 : 'bash %:p:S',
					\}
					let g:languages.zsh = {
								\'extension' : 'zsh',
								\'repl'		 : 'zsh',
								\'execute'	 : 'zsh %:p:S',
								\}
					let g:languages.fish = {
						\'extension' : 'fsh',
						\'repl'		 : 'fsh',
						\'execute'	 : 'fsh',
					\}
					let g:languages.batch = {
						\'extension' : 'cmd',
						\'repl'		 : 'cmd',
					\}
				"DATABASE
					let g:languages.sqlite = {
						\'extension' : 'sql',
						\'repl'		 : 'sqlite',
					\}
					let g:languages.mysql = {
						\'extension' : 'mysql',
						\'repl'		 : 'mysql',
					\}
					let g:languages.redis = {
						\'extension' : 'redis',
						\'repl'		 : 'redis-cli',
					\}
					let g:languages.mongo = {
						\'extension' : 'mongo',
						\'repl'		 : 'mongo',
					\}
			"FRAMEWORKS
	"FUNCTIONS
		if has('nvim')
			"FUNCTIONS
				function! ExecutionerCommand(type, ...) abort
					if exists('a:1') && len(a:1) > 0
						let l:filetype = a:1
					else
						let l:filetype = &filetype
					endif

					if has_key(g:languages, l:filetype) == 1
						let l:lang = g:languages[l:filetype]

						if has_key(l:lang, a:type) == 1
							if a:type == 'repl'
								let s:executioner_last_repl_filetype = l:filetype
							endif

							let l:command = substitute(l:lang[a:type], '%\(:\w\)\+', '\=expand(submatch(0))', 'g')
							return l:command
						else
							call PEchoError(l:filetype . ' does not support ' . a:type . ' operation')
							return
						endif
					else
						call PEchoError(l:filetype . ' filetype is not supported')
						return
					endif
				endfunction

				function! ExecutionerInitREPL()
					let l:filetype = s:executioner_last_repl_filetype

					if has_key(g:languages, l:filetype) == 1
						let l:lang = g:languages[l:filetype]

						if has_key(l:lang, 'init') == 1
							call TerminalSend(l:lang['init'])
						endif
					else
						call PEchoError(l:filetype . ' filetype is not supported')
						return
					endif
				endfunction
		endif
	"COMMANDS
		command! -narg=? ExecutionerREPL	 :execute 'VRTerm '	 . ExecutionerCommand('repl', <q-args>) | :call ExecutionerInitREPL()
		command! ExecutionerCompile				 :execute '10HBTerm '  . ExecutionerCommand('compile')
		command! ExecutionerExecute				 :execute '20HBTerm! ' . ExecutionerCommand('execute')
		command! ExecutionerCompileExecute :execute '20HBTerm! ' . ExecutionerCommand('compile-execute')
	"MAPPINGS
		nmap <silent> <Plug>(executioner-repl)				:ExecutionerREPL<CR>
		nmap <silent> <Plug>(executioner-compile)			:ExecutionerCompile<CR>
		nmap <silent> <Plug>(executioner-execute)			:ExecutionerExecute<CR>
		nmap <silent> <Plug>(executioner-compile-execute) :ExecutionerCompileExecute<CR>
		nmap <silent> <Plug>(executioner-fzf-repl)			:call fzf#run(fzf#wrap({'source': getcompletion('', 'filetype'), 'sink': 'ExecutionerREPL'}))<CR>
	"DEFAULTS
		if ExistsAndTrue('g:executioner_enable_default_mappings')
			nmap <LocalLeader>cr <Plug>(executioner-repl)
			nmap <LocalLeader>cb <Plug>(executioner-compile)
			nmap <LocalLeader>ce <Plug>(executioner-execute)

			nmap <LocalLeader>cR <Plug>(executioner-fzf-repl)
			nmap <LocalLeader>cq <Plug>(executioner-compile-execute)
		endif
endif
