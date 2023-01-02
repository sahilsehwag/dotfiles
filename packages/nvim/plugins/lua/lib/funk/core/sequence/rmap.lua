return Funk.curry(function(fn, list)
  return Funk.rfold(function(acc, x, i)
    acc[i] = fn(x)
    return acc
  end, {}, list)
end)

