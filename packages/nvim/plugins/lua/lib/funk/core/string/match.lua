return Funk.curry(function(pattern, str)
  return string.match(str, pattern)
end)
