return function(fn)
  return Funk.curry_with(fn,
    function(...)
      return not fn(...)
    end
  )
end
