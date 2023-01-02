return Funk.curry(function(fn, dicts)
  local result = {}
  for _, dict in ipairs(dicts) do
    for k, v in pairs(dict) do
      result[k] = fn(result[k], v)
    end
  end
  return result
end)
