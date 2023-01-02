return function(fn)
  return Funk.curry_n(
    Funk.arg_count_or(2, fn),
    function(first, second, ...)
      return fn(second, first, ...)
    end
  )
end
