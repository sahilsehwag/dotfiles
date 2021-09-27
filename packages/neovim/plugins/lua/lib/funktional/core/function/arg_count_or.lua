return Funk.curry(function(default, fn)
  if Funk.is_vararg(fn) and Funk.arg_count(fn) == 0 then
    return default
  else
    return Funk.arg_count(fn)
  end
end)
