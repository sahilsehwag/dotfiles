return Funk.curry(function(predicate, list)
  return Funk.fold(function(acc, x, i)
    if not predicate(x) then
      acc[i] = x
    end
    return acc
  end, {}, list)
end)

