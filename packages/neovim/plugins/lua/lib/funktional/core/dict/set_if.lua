return Funk.curry(function(predicate, key, value, dict)
  if predicate(dict[key], value) then
    dict[key] = value
  end
  return dict
end)
