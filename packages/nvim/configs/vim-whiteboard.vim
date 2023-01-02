"CONFIGURATION
	let g:whiteboard_temp_directory = g:jaat_tmp_path . 'whiteboard/'
	let g:whiteboard_interpreters = {
		\'python'     :{'extension': 'py'     ,'command': 'python3'  },
		\'r'          :{'extension': 'r'      ,'command': 'r'        },
		\'javascript' :{'extension': 'js'     ,'command': 'node'     },
		\'java'       :{'extension': 'java'   ,'command': 'jshell'   },
		\'lua'        :{'extension': 'lua'    ,'command': 'lua'      },
		\'php'        :{'extension': 'php'    ,'command': 'php'      },
		\'ruby'       :{'extension': 'rb'     ,'command': 'ruby'     },
		\'haskell'    :{'extension': 'hs'     ,'command': 'ghci'     },
		\'scala'      :{'extension': 'scala'  ,'command': 'scala'    },
		\'perl'       :{'extension': 'pl'     ,'command': 'perl'     },
		\'go'         :{'extension': 'go'     ,'command': 'gore'     },
		\'typescript' :{'extension': 'ts'     ,'command': 'ts-node'  },
		\'sh'         :{'extension': 'sh'     ,'command': 'bash'     },
		\'bash'       :{'extension': 'bash'   ,'command': 'bash'     },
		\'zsh'        :{'extension': 'zsh'    ,'command': 'zsh'      },
		\'fish'       :{'extension': 'fsh'    ,'command': 'fsh'      },
		\'pandoc'     :{'extension': 'pandoc' ,'command': 'pandoc'   },
		\'redis'      :{'extension': 'redis'  ,'command': 'redis-cli'},
		\'mongo'      :{'extension': 'mongo'  ,'command': 'mongo'    },
		\'mysql'      :{'extension': 'mysql'  ,'command': 'mysql'    },
		\'sqlite'     :{'extension': 'sqlite' ,'command': 'sqlite'   },
		\'dosbatch'   :{'extension': 'cmd'    ,'command': 'cmd'      },
		\'git'        :{'extension': 'git'    ,'command': 'gitsome'  },
		\'lisp'       :{'extension': 'lisp'   ,'command': 'sbcl'     }}
"MAPPINGS
	nnoremap <LocalLeader>cs :execute "Whiteboard! " . &filetype<CR>
	nnoremap <LocalLeader>cS :execute "Whiteboard "  . &filetype<CR>
