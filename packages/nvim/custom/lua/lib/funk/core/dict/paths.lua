return Funk.curry(function(paths, dict)
  return Funk.map(
    Funk.flip(Funk.path)(dict),
    paths
  )
end)
