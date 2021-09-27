local list_len = function(l)
  return #l
end

local dict_len = Funk.fold(Funk.add(1), 0)

local str_len = function(s)
  return #s
end

return Funk.switch(
  { Funk.is_list, Funk.curry(list_len) },
  { Funk.is_dict, Funk.curry(dict_len) },
  { Funk.is_string, Funk.curry(str_len) }
)
