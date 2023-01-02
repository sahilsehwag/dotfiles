return Funk.curry(function(fn, fns)
  return function(...)
    return Funk.apply(
      fn,
      Funk.apply_all(fns, {...})
    )
  end
end)
