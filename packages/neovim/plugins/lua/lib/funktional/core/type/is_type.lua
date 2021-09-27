return Funk.curry(function(typ, value)
  return type(value) == typ
end)
