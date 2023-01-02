return function(fn)
  return Funk.curry_with(fn,
    function(...)
      return fn(...)
    end
  )
end
