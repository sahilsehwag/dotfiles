-- TODO:
local get_base = Funk.always('tmux')

local get_layout = Funk.pipe(
  Funk.get('layout'),
  Funk.switch(
    { Funk.equals('popup'),      Funk.always('display-popup')   },
    { Funk.equals('window'),     Funk.always('new-window')      },
    { Funk.equals('vertical'),   Funk.always('split-window -h') },
    { Funk.equals('horizontal'), Funk.always('split-window -v') },
    { Funk.T,                    Funk.always('new-window')      }
  ),
  F.tap(F.p)
)

local get_pwd = Funk.pipe(
  Funk.get('pwd'),
  Funk.concat('-d ')
)

local get_cmd = Funk.pipe(
  Funk.fn(Funk.join(' '), {
    Funk.get('cmd'),
    Funk.get('autoclose') and '' or ' ;read'
  }),
  Funk.sh.quote
)

-- FIX:
return Funk.fn(Funk.join(' '), {
	get_base,
	get_layout,
	get_pwd,
	get_cmd,
})
