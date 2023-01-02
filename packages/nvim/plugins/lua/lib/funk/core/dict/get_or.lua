return Funk.curry(function(key, default, dict)
  return dict[key] or default
end)
