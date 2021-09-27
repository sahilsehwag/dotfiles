return Funk.curry(function(key, dict)
  return dict[key] ~= nil
end)
