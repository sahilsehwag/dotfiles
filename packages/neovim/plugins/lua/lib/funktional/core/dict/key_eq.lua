return Funk.curry(function(key, value, dict)
  return Funk.pipe(
    Funk.key(key),
    Funk.eq(value)
  )(dict)
end)
