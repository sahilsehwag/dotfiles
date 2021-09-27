return Funk.curry(function(path, dict)
  local value = dict
  for i = 1, #path do
    value = value[path[i]]
    if value == nil then
      return nil
    end
  end
  return value
end)
