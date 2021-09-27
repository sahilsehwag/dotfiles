-- BUG: handle nil values
return Funk.curry(function(fn, list)
  return Funk.fold(function(acc, x, i)
    acc[i] = fn(x)
    return acc
  end, {}, list)
end)

