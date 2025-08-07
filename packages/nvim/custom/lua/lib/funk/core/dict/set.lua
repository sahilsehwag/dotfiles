return Funk.curry(function(key, value, dict)
  dict[key] = value
  return dict
end)
