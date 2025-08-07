local has_key = Funk.flip(Funk.has_key)

return function(keys, dict)
  return Funk.pipe(
    Funk.map(has_key(dict)),
    Funk.all
  )(keys)
end
