return Funk.curry(function(predicate, list)
  return Funk.fold(function(acc, x)
    if predicate(x) then
      acc[#acc + 1] = x
    end
    return acc
  end, {}, list)
end)

