return Funk.curry(function(separator, list)
  return table.concat(list, separator)
end)
