return Funk.curry(function(element, list)
  for _, v in ipairs(list) do
    if v == element then
      return true
    end
  end
  return false
end)
