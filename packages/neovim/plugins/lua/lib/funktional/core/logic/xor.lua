return Funk.curry(function(a, b)
  return (a and not b) or (b and not a)
end)
