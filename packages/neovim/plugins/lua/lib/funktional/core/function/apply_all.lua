return function(fns)
  return function(...)
    return Funk.map(Funk.apply_to(...), fns)
  end
end
