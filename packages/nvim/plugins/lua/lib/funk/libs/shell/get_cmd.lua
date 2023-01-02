local get_cmd_from_dict = Funk.pipe(
   Funk.get_all({'cmd', 'args'}),
   Funk.join(' ')
)

local get_cmd_from_fn = function(fn)
   return fn()
end

return Funk.switch(
  { Funk.is_string,   Funk.id           },
  { Funk.is_dict,     get_cmd_from_dict },
  { Funk.is_function, get_cmd_from_fn   },
  { Funk.T,           Funk.always(nil)  }
)
