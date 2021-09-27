return Funk.curry(function(keys, dict)
  return Funk.map(
    Funk.flip(Funk.get)(dict),
    keys
  )
end)
